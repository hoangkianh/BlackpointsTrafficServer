google.maps.visualRefresh = true;

var MapsLib = {
    map_centroid: new google.maps.LatLng(21.0333330, 105.8500000),
    searchRadius: 5000,
    defaultZoom: 16,
    poiMarkerImage: "img/marker.png",
    tempPOIMarkderImage: "img/temp-marker.png",
    TYPE_POINT: "POINT",
    TYPE_LINE: "LINESTRING",
    TYPE_POLYGON: "POLYGON",
    markerArr: [],
    polyLineArr: [],
    polygonArr: [],
    initialize: function() {
        geocoder = new google.maps.Geocoder();

        var mapOptions = {
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
        MapsLib.reset();
    },
    reset: function() {
        $("#search_address").val(MapsLib.convertToPlainString($.address.parameter('address')));
        var loadRadius = MapsLib.convertToPlainString($.address.parameter('radius'));
        if (loadRadius !== "") {
            $("#search_radius").val(loadRadius);
        }
        else {
            $("#search_radius").val(MapsLib.searchRadius);
        }
    },
    doSearch: function(withTempPOI) {
        MapsLib.clearSearch();

        MapsLib.address = $("#search_address").val();
        MapsLib.searchRadius = withTempPOI === true ? 5000 : $("#search_radius").val();

        if (MapsLib.address === undefined && MapsLib.searchRadius === undefined) {
            MapsLib.submitSearch(withTempPOI);
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

                    $.address.parameter('address', encodeURIComponent(MapsLib.address));
                    $.address.parameter('radius', encodeURIComponent(MapsLib.searchRadius));
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
                    MapsLib.submitSearch(withTempPOI);
                }
                else {
                    alert("Không tìm thấy địa chỉ của bạn: " + status);
                }
            });
        }
    },
    submitSearch: function(withTempPOI) {
        var lat;
        var lng;
        var url;
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
            url: "service/POI/getPOIinRadius/" + lat + "/" + lng + "/" + radius,
            dataType: "json",
            success: function(json) {
                $.each(json, function(idx, obj) {
                    var name = obj.name;
                    var address = obj.address;
                    var description = obj.description;
                    if (description === undefined) {
                        description = "Chưa có mô tả";
                    }
                    var rating = obj.rating;
                    var createdOnDate = obj.createdOnDate;
                    var geometry = obj.geometry;
                    var parsed_geometry = MapsLib.parseGeomString(geometry);
                    var type = MapsLib.TYPE_POINT;
                    if (geometry.indexOf(MapsLib.TYPE_LINE) !== -1) {
                        type = MapsLib.TYPE_LINE;
                    } else {
                        if (geometry.indexOf(MapsLib.TYPE_POLYGON) !== -1) {
                            type = MapsLib.TYPE_POLYGON;
                        }
                    }
                    MapsLib.drawPOI(false, type, parsed_geometry, name, address, description, rating, createdOnDate);
                });
            }
        });

        if (withTempPOI === true) {
            $.ajax({
                type: "GET",
                url: "service/POI/getAllTempPOI/" + lat + "/" + lng + "/" + radius,
                dataType: "json",
                success: function(json) {
                    $.each(json, function(idx, obj) {
                        var name = obj.name;
                        var address = obj.address;
                        var description = obj.description;
                        if (description === undefined) {
                            description = "Chưa có mô tả";
                        }
                        var rating = obj.rating;
                        var createdOnDate = obj.createdOnDate;
                        var geometry = obj.geometry;
                        var parsed_geometry = MapsLib.parseGeomString(geometry);
                        var type = MapsLib.TYPE_POINT;
                        if (geometry.indexOf(MapsLib.TYPE_LINE) !== -1) {
                            type = MapsLib.TYPE_LINE;
                        } else {
                            if (geometry.indexOf(MapsLib.TYPE_POLYGON) !== -1) {
                                type = MapsLib.TYPE_POLYGON;
                            }
                        }
                        MapsLib.drawPOI(true, type, parsed_geometry, name, address, description, rating, createdOnDate);
                    });
                }
            });
        }

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
    drawPOI: function(drawTempPOI, type, geometry, name, address, description, rating, createdOnDate) {
        var content = "<div id='content'>" +
                "<h2>" + name + "</h2>" +
                "<p><ul><li><b>Địa chỉ: </b>" + address + "</li>" +
                "<li><b>Mô tả: </b>" + description + "</li>" +
                "<li><b>Mức độ nguy hiểm: </b>" + rating + "</li>" +
                "<li><b>Thêm vào từ ngày: </b>" + createdOnDate + "</li>" +
// TODO:                "<li><a href='home.do'> Chi tiết </a></li>" +
                "</ul></p>" +
                "</div>";
        var info = new google.maps.InfoWindow({
            content: content,
            maxWidth: 400
        });

        switch (type) {
            case MapsLib.TYPE_POINT:
                var marker;
                if (drawTempPOI === false) {
                    marker = new google.maps.Marker({
                        position: geometry[0][0],
                        map: map,
                        title: name,
                        icon: MapsLib.poiMarkerImage
                    });
                } else {
                    marker = new google.maps.Marker({
                        position: geometry[0][0],
                        map: map,
                        title: name,
                        icon: MapsLib.tempPOIMarkderImage
                    });
                }
                google.maps.event.addListener(marker, 'click', function() {
                    if (info.getMap() === undefined || info.getMap() === null) {
                        info.open(map, marker);
                    }
                    else {
                        info.close();
                    }
                });
                MapsLib.markerArr.push(marker);
                break;
            case MapsLib.TYPE_LINE:
                var polyLine = new google.maps.Polyline({
                    path: geometry[0],
                    geodesic: true,
                    strokeColor: '#FF0000',
                    strokeOpacity: 0.5,
                    strokeWeight: 8,
                    map: map,
                    title: name
                });

                google.maps.event.addListener(polyLine, 'click', function(event) {
                    info.setPosition(event.latLng);
                    info.open(map);
                });
                MapsLib.polyLineArr.push(polyLine);
                break;
            case MapsLib.TYPE_POLYGON:
                var polygon = new google.maps.Polygon({
                    paths: geometry,
                    strokeColor: '#FF0000',
                    strokeOpacity: 0.0,
                    strokeWeight: 2,
                    fillColor: '#FF0000',
                    fillOpacity: 0.35,
                    map: map,
                    title: name
                });

                google.maps.event.addListener(polygon, 'click', function(event) {
                    info.setPosition(event.latLng);
                    info.open(map);
                });
                MapsLib.polygonArr.push(polygon);
                break;
        }
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
        for (i = 0; i < MapsLib.polyLineArr.length; i++) {
            MapsLib.polyLineArr[i].setMap(null);
        }
        for (i = 0; i < MapsLib.polygonArr.length; i++) {
            MapsLib.polygonArr[i].setMap(null);
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
    }
};