google.maps.visualRefresh = true;

var MapsLib = {
    map_centroid: new google.maps.LatLng(21.0333330, 105.8500000),
    searchRadius: 5000,
    defaultZoom: 16,
    markerArr: [],
    initialize: function() {
        geocoder = new google.maps.Geocoder();

        var mapOptions = {
            mapTypeControl: false,
            scaleControl: true,
            zoomControl: true,
            zoomControlOptions: {
                style: google.maps.ZoomControlStyle.LARGE
            },
            zoom: MapsLib.defaultZoom,
            center: MapsLib.map_centroid,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

        // reset
        $("#search_radius").val(MapsLib.searchRadius);
    },
    doSearch: function(withTempPOI) {
        MapsLib.clearSearch();

        MapsLib.address = $("#search_address").val();
        MapsLib.searchRadius = withTempPOI === true ? 5000 : $("#search_radius").val();

        if (MapsLib.address === undefined && MapsLib.searchRadius === undefined) {
            MapsLib.getPOIInRadius(withTempPOI);
            return;
        }

        if (MapsLib.oldaddress !== MapsLib.address) {
            MapsLib.newPinpoint = null;
        }

        if (MapsLib.address !== "") {
            geocoder.geocode({'address': MapsLib.address}, function(results, status) {
                if (status === google.maps.GeocoderStatus.OK) {
                    MapsLib.currentPinpoint = results[0].geometry.location;

                    if (MapsLib.newPinpoint !== null) {
                        MapsLib.currentPinpoint = MapsLib.newPinpoint;
                    }

                    map.setCenter(MapsLib.currentPinpoint);
                    map.setZoom(MapsLib.caculateZoom());

                    MapsLib.addrMarker = new google.maps.Marker({
                        position: MapsLib.currentPinpoint,
                        map: map,
                        draggable: true,
                        title: MapsLib.address
                    });

                    var info = new google.maps.InfoWindow({
                        content: "<h1>Bạn đang ở đây</h1>" + MapsLib.address
                    });
                    google.maps.event.addListener(MapsLib.addrMarker, 'drag', function() {
                        MapsLib.newPinpoint = MapsLib.addrMarker.getPosition();
                        if (withTempPOI === false) {
                            MapsLib.searchRadiusCircle.setMap(null);
                            MapsLib.drawSearchRadiusCircle(MapsLib.newPinpoint);
                        }
                    });
                    google.maps.event.addListener(MapsLib.addrMarker, 'dragend', function() {
                        MapsLib.addrFromLatLng(MapsLib.newPinpoint, withTempPOI);
                    });
                    google.maps.event.addListener(MapsLib.addrMarker, 'click', function() {
                        if (info.getMap() === undefined || info.getMap() === null) {
                            info.open(map, MapsLib.addrMarker);
                        } else {
                            info.close();
                        }
                    });

                    if (withTempPOI === false) {
                        MapsLib.drawSearchRadiusCircle(MapsLib.currentPinpoint);
                    }
                    MapsLib.getPOIInRadius(withTempPOI);
                    MapsLib.findCityAndDistrict(function(district, city) {
                        MapsLib.getPOIInDistrict(district, city);
                    });
                }
                else {
                    alert("Không tìm thấy địa chỉ của bạn: " + status);
                }
            });
        }
    },
    getPOIInRadius: function(withTempPOI) {
        var lat;
        var lng;
        var radius = 5000;

        if (MapsLib.currentPinpoint !== undefined) {
            lat = MapsLib.currentPinpoint.lat();
            lng = MapsLib.currentPinpoint.lng();
        } else {
            lat = MapsLib.map_centroid.lat();
            lng = MapsLib.map_centroid.lng();
        }

        if (MapsLib.searchRadius !== undefined) {
            radius = MapsLib.searchRadius;
        }

        $.ajax({
            type: "GET",
            url: "service/POI/getPOIInRadius/" + lat + "/" + lng + "/" + radius,
            dataType: "json",
            success: function(json) {
                // empty #list
                $("#list").empty();

                $.each(json, function(idx, obj) {
                    MapsLib.drawPOI(obj);
                    MapsLib.appendPOIToDiv(obj);
                });
            }
        });

        if (withTempPOI === true) {
            $.ajax({
                type: "GET",
                url: "service/POI/getTempPOIInRadius/" + lat + "/" + lng + "/" + radius,
                dataType: "json",
                success: function(json) {
                    $.each(json, function(idx, obj) {
                        MapsLib.drawTempPOI(obj);
                    });
                }
            });
        }
    },
    getPOIInDistrict: function(district, city) {
        $.ajax({
            type: "GET",
            url: "service/POI/getPOIInDistrict/" + district + "/" + city,
            dataType: "json",
            success: function(json) {
                $("#inDistrict").empty().append("Các điểm đen ở "+ district);

                // empty div
                $("#tabs").children("div").empty();

                $.each(json, function(idx, obj) {
                    MapsLib.appendPOIInDistrict(obj);
                });
                
                $("#tabs").children("div").each(function(){
                    if ($(this).is(":empty")) {
                        $(this).html("<p>Chưa có dữ liệu</p>")
                    }
                });
            }
        });
    },
    parseGeomString: function(geomString) {
        var i, j, lat, lng, tmp, tmpArr;
        latLngArr = [];
        m = geomString.match(/\([^\(\)]+\)/g);
        if (m !== null) {
            for (i = 0; i < m.length; i++) {
                tmp = m[i].match(/-?\d+\.?\d*/g);

                if (tmp !== null) {
                    for (j = 0, tmpArr = []; j < tmp.length; j += 2) {
                        lng = Number(tmp[j]);
                        lat = Number(tmp[j + 1]);
                        tmpArr.push(new google.maps.LatLng(lat, lng));
                    }
                    latLngArr.push(tmpArr);
                }
            }
        }
        return latLngArr;
    },
    drawPOI: function(obj) {
        var content = "<div id='content'>" +
                "<img src='" + obj.image + "' height='100' width='100'" +
                "<h2>" + obj.name + "</h2>" +
                "<p><ul><li><b>Địa chỉ: </b>" + obj.address + "</li>" +
                "<li><b>Mô tả: </b>" + obj.description + "</li>" +
                "<li><b>Mức độ nguy hiểm: </b>" + obj.rating + "</li>" +
                "<li><b>Thêm vào từ ngày: </b>" + obj.createdOnDate + "</li>" +
// TODO:                "<li><a href='home.do'> Chi tiết </a></li>" +
                "</ul></p>" +
                "</div>";
        var info = new google.maps.InfoWindow({
            content: content,
            maxWidth: 400
        });

        var marker = new google.maps.Marker({
            position: MapsLib.parseGeomString(obj.geometry)[0][0],
            map: map,
            title: obj.name,
            icon: obj.markerIcon
        });
        google.maps.event.addListener(marker, 'click', function() {
            if (info.getMap() === undefined || info.getMap() === null) {
                info.open(map, marker);
            }
            else {
                info.close();
            }
        });
        MapsLib.markerArr.push(marker);
    },
    drawTempPOI: function(obj) {
        var content = "<div id='content'>" +
                "<img src='" + obj.image + "'" +
                "<h2>" + obj.name + "</h2>" +
                "<p>Địa điểm này chưa được xác nhận, </p>" +
                "<p><ul><li><b>Địa chỉ: </b>" + obj.address + "</li>" +
                "<li><b>Mô tả: </b>" + obj.description + "</li>" +
                "<li><b>Mức độ nguy hiểm: </b>" + obj.rating + "</li>" +
                "<li><b>Thêm vào từ ngày: </b>" + obj.createdOnDate + "</li>" +
// TODO:                "<li><a href='home.do'> Chi tiết </a></li>" +
                "</ul></p>" +
                "</div>";
        var info = new google.maps.InfoWindow({
            content: content,
            maxWidth: 400
        });
        var marker = new google.maps.Marker({
            position: MapsLib.parseGeomString(obj.geometry)[0][0],
            map: map,
            title: obj.name,
            icon: obj.markerIcon
        });
        google.maps.event.addListener(marker, 'click', function() {
            if (info.getMap() === undefined || info.getMap() === null) {
                info.open(map, marker);
            }
            else {
                info.close();
            }
        });
        MapsLib.markerArr.push(marker);
    },
    clearSearch: function() {
        MapsLib.oldaddress = MapsLib.address;

        if (MapsLib.addrMarker !== undefined) {
            MapsLib.addrMarker.setMap(null);
        }
        if (MapsLib.searchRadiusCircle !== undefined) {
            MapsLib.searchRadiusCircle.setMap(null);
        }
        for (i = 0; i < MapsLib.markerArr.length; i++) {
            MapsLib.markerArr[i].setMap(null);
        }
    },
    handleNoGeolocation: function(errorFlag) {
        var content;
        if (errorFlag) {
            content = 'Lỗi: Dịch vụ geolocation gặp lỗi.';
        } else {
            content = 'Lỗi: Trình duyệt của bạn không hỗ trợ geolocation.';
        }

        var options = {
            map: map,
            position: MapsLib.map_centroid,
            content: content
        };

        new google.maps.InfoWindow(options);
        map.setCenter(options.position);
    },
    findMe: function() {
        var foundLocation;
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                foundLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
                MapsLib.addrFromLatLng(foundLocation, false);
            }, function() {
                MapsLib.handleNoGeolocation(true);
            });
        }
        else {
            MapsLib.handleNoGeolocation(false);
        }
    },
    findCityAndDistrict: function(callback) {
        var district = "";
        var city = "";
        geocoder.geocode({'latLng': MapsLib.currentPinpoint}, function(results, status) {
            if (status === google.maps.GeocoderStatus.OK) {
                if (results[1]) {
                    for (i = 0; i < results[1].address_components.length; i++) {
                        if (results[1].address_components[i].types[0] === "administrative_area_level_2"
                                && results[1].address_components[i].types[1] === "political") {
                            district = results[1].address_components[i].long_name;
                            break;
                        }
                    }
                    if (district === "") {
                        for (i = 0; i < results[1].address_components.length; i++) {
                            if (results[1].address_components[i].types[0] === "locality"
                                    && results[1].address_components[i].types[1] === "political") {
                                district = results[1].address_components[i].long_name;
                            }
                        }
                    }

                    for (i = 0; i < results[1].address_components.length; i++) {
                        if (results[1].address_components[i].types[0] === "administrative_area_level_1"
                                && results[1].address_components[i].types[1] === "political") {
                            city = results[1].address_components[i].long_name;
                            break;
                        }
                    }
                    callback(district, city);
                }
            } else {
                alert("Có lỗi xảy ra: " + status);
            }
        });
    },
    addrFromLatLng: function(latLngPoint, withTempPOI) {
        geocoder.geocode({'latLng': latLngPoint}, function(results, status) {
            if (status === google.maps.GeocoderStatus.OK) {
                if (results[1]) {
                    $('#search_address').val(results[1].formatted_address);

                    MapsLib.doSearch(withTempPOI);
                }
            } else {
                alert("Không tìm thấy địa chi này: " + status);
            }
        });
    },
    drawSearchRadiusCircle: function(point) {
        var circleOptions = {
            strokeColor: "#ff0000",
            strokeOpacity: 0.3,
            strokeWeight: 1,
            fillColor: "#ff0000",
            fillOpacity: 0.05,
            map: map,
            center: point,
            clickable: false,
            zIndex: -1,
            radius: parseInt(MapsLib.searchRadius)
        };
        MapsLib.searchRadiusCircle = new google.maps.Circle(circleOptions);
    },
    calculateCenter: function() {
        center = map.getCenter();
    },
    convertToPlainString: function(text) {
        if (text === undefined)
            return '';
        return decodeURIComponent(text);
    },
    caculateZoom: function() {
        var zoom = MapsLib.defaultZoom;
        switch (MapsLib.searchRadius) {
            case '1000':
                zoom = 15;
                break;
            case '2000':
                zoom = 14;
                break;
            case '5000':
                zoom = 13;
                break;
            case '10000':
            case '15000':
                zoom = 12;
                break;
            case '20000':
            case '25000':
            case '30000':
                zoom = 11;
                break;
            case '35000':
            case '40000':
            case '45000':
            case '50000':
                zoom = 10;
                break;
        }
        return zoom;
    },
    appendPOIToDiv: function(obj) {
        var liToAppend = "";
        liToAppend += "<li>";
        liToAppend += "<div class='item-img'>";
        liToAppend += "<a href='details.do?id=" + obj.id + "' title='" + obj.name + "'>";
        liToAppend += "<img alt='" + obj.name + "' src='" + obj.image + "' />";
        liToAppend += "</a>";
        liToAppend += "</div>";
        liToAppend += "<div class='item-content'>";
        liToAppend += "<div class='item-name'>";
        liToAppend += "<a href='details.do?id=" + obj.id + "' title='" + obj.name + "'>";
        liToAppend += obj.name;
        liToAppend += "</a>";
        liToAppend += "</div>";
        liToAppend += "<div class='item-add'>" + obj.address + "</div>";
        if (obj.description !== undefined) {
            liToAppend += "<div class='item-desc'>" + obj.description + "</div>";
        } else {
            liToAppend += "<div class='item-desc'>---</div>";
        }
        liToAppend += "</div>";
        liToAppend += "</li>";

        $("#list").append(liToAppend);
    },
    appendPOIInDistrict: function(obj) {
        $("#tabs").children("div").each(function() {
            var id = $(this).attr("id");

            var divToAppend = "";
            if (obj.categoryID == id.substring(5)) {
                divToAppend += "<div class='district-item'>";
                divToAppend += "<div class='district-image'>";
                divToAppend += "<a href='details.do?id=" + obj.id + "' title='" + obj.name + "'>";
                divToAppend += "<img alt='" + obj.name + "' src='" + obj.image + "'/>";
                divToAppend += "</a>";
                divToAppend += "</div>";
                divToAppend += "<div class='district-info'>";
                divToAppend += "<h3><a href='details.do?id=" + obj.id + "' title='" + obj.name + "'>" + obj.name + "</a></h3><br/>";
                divToAppend += "<h4>" + obj.address + "</h4>";
                if (obj.description !== undefined) {
                    divToAppend += "<p>" + obj.description + "</p>";
                } else {
                    divToAppend += "<p'>---</p>";
                }
                divToAppend += "</div>";
                divToAppend += "</div>";
            }
            if (divToAppend !== "") {
                $("#" + id).append(divToAppend);
            }
        });
    }
};