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
    initializeDisableDoubleClickZoom: function() {
        geocoder = new google.maps.Geocoder();

        var mapOptions = {
            mapTypeControl: false,
            disableDoubleClickZoom: true,
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
    doSearch: function() {
        MapsLib.clearSearch();

        MapsLib.address = $("#search_address").val();
        MapsLib.searchRadius = $("#search_radius").val();

        if (MapsLib.address === undefined && MapsLib.searchRadius === undefined) {
            MapsLib.getPOIInRadius();
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

                    google.maps.event.addListener(MapsLib.addrMarker, 'drag', function() {
                        MapsLib.newPinpoint = MapsLib.addrMarker.getPosition();
                        MapsLib.searchRadiusCircle.setMap(null);
                        MapsLib.drawSearchRadiusCircle(MapsLib.newPinpoint);
                    });
                    google.maps.event.addListener(MapsLib.addrMarker, 'dragend', function() {
                        MapsLib.addrFromLatLng(MapsLib.newPinpoint);
                    });
                    google.maps.event.addListener(MapsLib.addrMarker, 'click', function() {
                        if (MapsLib.infoWindow) {
                            MapsLib.infoWindow.close();
                        }
                        MapsLib.infoWindow = new InfoBubble({
                            content: "<h1>Bạn đang ở đây</h1>" + MapsLib.address
                        });
                        MapsLib.infoWindow.open(map, MapsLib.addrMarker);
                    });

                    MapsLib.drawSearchRadiusCircle(MapsLib.currentPinpoint);
                    MapsLib.getPOIInRadius();
                    MapsLib.findCityAndDistrict(function(district, city) {
                        MapsLib.getPOIInDistrict(district, city);
                    });
                }
                else {
                    console.log("Không tìm thấy địa chỉ của bạn: " + status);
                }
            });
        }
    },
    getPOIByID: function(id) {
        $.ajax({
            type: "GET",
            url: "service/POI/getPOIByID/" + id,
            dataType: "json",
            success: function(obj) {
                MapsLib.drawPOI(obj);
                map.setCenter(MapsLib.parseGeomString(obj.geometry)[0][0]);
            }
        });
    },
    getPOIInRadius: function() {
        var lat;
        var lng;
        var radius = 5000;

        if (MapsLib.currentPinpoint) {
            lat = MapsLib.currentPinpoint.lat();
            lng = MapsLib.currentPinpoint.lng();
        } else {
            lat = MapsLib.map_centroid.lat();
            lng = MapsLib.map_centroid.lng();
        }

        if (MapsLib.searchRadius) {
            radius = MapsLib.searchRadius;
        }

        $.ajax({
            type: "GET",
            url: "service/POI/getPOIInRadius/" + lat + "/" + lng + "/" + radius,
            dataType: "json",
            success: function(json) {
                // empty #list
                $("#list").empty();
                // empty array
                MapsLib.markerArr = [];

                $.each(json, function(idx, obj) {
                    MapsLib.drawPOI(obj);
                    MapsLib.appendPOIToDiv(idx, obj);
                });
            }
        });
    },
    getPOIInDistrict: function(district, city) {
        $.ajax({
            type: "GET",
            url: "service/POI/getPOIInDistrict/" + district + "/" + city,
            dataType: "json",
            success: function(json) {
                $("#inDistrict").empty().append("Các điểm đen ở " + district);

                // empty div
                $("#tabs").children("div").empty();

                $.each(json, function(idx, obj) {
                    MapsLib.appendPOIInDistrict(obj);
                });

                $("#tabs").children("div").each(function() {
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
        var infoContent = "<div class='content'>";
        infoContent += "<img src='" + obj.image + "' height='100' width='100' />";
        infoContent += "<h2>" + obj.name + "</h2>";
        infoContent += "<ul><li><b>Địa chỉ: </b>" + obj.address + "</li>";
        if (obj.description !== undefined) {
            infoContent += "<li><b>Mô tả: </b>" + obj.description + "</li>";
        }
        infoContent += "<li><b>Mức độ nguy hiểm: </b>" + obj.rating + "</li>";
        infoContent += "<li><b>Thêm vào từ ngày: </b>" + obj.createdOnDate + "</li>";
        infoContent += "</ul></div>";

        var marker = new google.maps.Marker({
            position: MapsLib.parseGeomString(obj.geometry)[0][0],
            map: map,
            title: obj.name,
            icon: obj.markerIcon
        });
        google.maps.event.addListener(marker, 'click', function() {
            if (MapsLib.infoWindow) {
                MapsLib.infoWindow.close();
            }
            MapsLib.infoWindow = new InfoBubble({
                content: infoContent,
                minWidth: 200,
                maxWidth: 400,
                minHeight: 100,
                maxHeight: 200
            });
            MapsLib.infoWindow.open(map, marker);
        });
        MapsLib.markerArr.push(marker);
    },
    clearSearch: function() {
        MapsLib.oldaddress = MapsLib.address;

        if (MapsLib.addrMarker) {
            MapsLib.addrMarker.setMap(null);
        }
        if (MapsLib.searchRadiusCircle) {
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
                console.log("Có lỗi xảy ra: " + status);
            }
        });
    },
    addrFromLatLng: function(latLngPoint) {
        geocoder.geocode({'latLng': latLngPoint}, function(results, status) {
            if (status === google.maps.GeocoderStatus.OK) {
                if (results[1]) {
                    $('#search_address').val(results[1].formatted_address);

                    MapsLib.doSearch();
                }
            } else {
                console.log("Không tìm thấy địa chi này: " + status);
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
    appendPOIToDiv: function(idx, obj) {
        var liToAppend = "";
        liToAppend += "<li onclick='MapsLib.openInfoWindow(" + idx + ");'>";
        liToAppend += "<div class='item-img'>";
        liToAppend += "<a href='javascript:void(0)' onclick='MapsLib.openInfoWindow(" + idx + ")' title='" + obj.name + "'>";
        liToAppend += "<img alt='" + obj.name + "' src='" + obj.image + "' />";
        liToAppend += "</a>";
        liToAppend += "</div>";
        liToAppend += "<div class='item-content'>";
        liToAppend += "<div class='item-name'>";
        liToAppend += "<a href='javascript:void(0)' onclick='MapsLib.openInfoWindow(" + idx + ")' title='" + obj.name + "'>";
        liToAppend += obj.name;
        liToAppend += "</a>";
        liToAppend += "</div>";
        liToAppend += "<div class='item-add'>" + obj.address + "</div>";
        if (obj.description) {
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
                if (obj.description) {
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
    },
    openInfoWindow: function(idx) {
        google.maps.event.trigger(MapsLib.markerArr[idx], 'click');
    },
    getLatLng: function(position) {
        map.panTo(position);
        if (MapsLib.markerToGetLatLng) {
            MapsLib.markerToGetLatLng.setPosition(position);
        } else {
            MapsLib.markerToGetLatLng = new google.maps.Marker({
                position: position,
                map: map,
                draggable: true
            });
        }
        var content = "<b>Kinh độ:</b> " + position.lng() + "<br/><b>Vĩ độ:</b> " + position.lat();
        if (!MapsLib.infoWindowToGetLatLng) {
            MapsLib.infoWindowToGetLatLng = new InfoBubble({
                content: content,
                minWidth: 150,
            });
        }
        MapsLib.infoWindowToGetLatLng.open(map, MapsLib.markerToGetLatLng);
        $("#longitude").val(position.lng());
        $("#latitude").val(position.lat());
    }
};