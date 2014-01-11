google.maps.visualRefresh = true;

var MapsLib = {
    map_centroid: new google.maps.LatLng(21.0333330, 105.8500000),
    searchRadius: 500,
    defaultZoom: 16,
    addrMarkerImage: "img/marker.png",
    initialize: function() {
        geocoder = new google.maps.Geocoder();

        var mapOptions = {
            scaleControl: true,
            zoom: MapsLib.defaultZoom,
            center: MapsLib.map_centroid,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

        // reset
        $("#search_address").val(MapsLib.convertToPlainString($.address.parameter('address')));
        var loadRadius = MapsLib.convertToPlainString($.address.parameter('radius'));
        if (loadRadius != "") {
            $("#search_radius").val(loadRadius);
        }
        else {
            $("#search_radius").val(MapsLib.searchRadius);
        }
        MapsLib.findMe();
        MapsLib.doSearch();
    },
    handleNoGeolocation: function(errorFlag) {
        var content;
        if (errorFlag) {
            content = 'Error: The Geolocation service failed.';
        } else {
            content = 'Error: Your browser doesn\'t support geolocation.';
        }

        var options = {
            map: map,
            position: MapsLib.map_centroid,
            content: content
        };

        new google.maps.InfoWindow(options);
        map.setCenter(options.position);
    },
    doSearch: function() {

        MapsLib.clearSearch();
        MapsLib.address = $("#search_address").val();
        MapsLib.searchRadius = $("#search_radius").val();

        if (MapsLib.address == undefined && MapsLib.searchRadius == undefined) {
            return;
        }

        if (MapsLib.oldaddress != MapsLib.address) {
            MapsLib.newPinpoint = null;
        }

        if (MapsLib.address != "") {
            geocoder.geocode({'address': MapsLib.address}, function(results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    MapsLib.currentPinpoint = results[0].geometry.location;

                    if (MapsLib.newPinpoint != null) {
                        MapsLib.currentPinpoint = MapsLib.newPinpoint;
                        MapsLib.newPinpoint = null;
                    }

                    $.address.parameter('address', encodeURIComponent(MapsLib.address));
                    $.address.parameter('radius', encodeURIComponent(MapsLib.searchRadius));
                    map.setCenter(MapsLib.currentPinpoint);
                    map.setZoom(MapsLib.caculateZoom());

                    MapsLib.addrMarker = new google.maps.Marker({
                        position: MapsLib.currentPinpoint,
                        map: map,
                        draggable: true,
                        icon: MapsLib.addrMarkerImage,
                        animation: google.maps.Animation.DROP,
                        title: MapsLib.address
                    });
                    google.maps.event.addListener(MapsLib.addrMarker, 'drag', function() {
                        MapsLib.searchRadiusCircle.setMap(null);
                        MapsLib.newPinpoint = MapsLib.addrMarker.getPosition();
                        MapsLib.drawSearchRadiusCircle(MapsLib.newPinpoint);
                    });

                    MapsLib.drawSearchRadiusCircle(MapsLib.currentPinpoint);
//                        MapsLib.submitSearch(whereClause, map, MapsLib.currentPinpoint);
                }
                else {
                    alert("We could not find your address: " + status);
                }
            });
        }
        else {
//                MapsLib.submitSearch(whereClause, map);
        }
    },
    submitSearch: function(whereClause, map, location) {
        MapsLib.searchrecords = new google.maps.FusionTablesLayer({
            query: {
                from: MapsLib.fusionTableId,
                select: MapsLib.locationColumn,
                where: whereClause
            },
            styleId: 2,
            templateId: 2
        });
        MapsLib.searchrecords.setMap(map);
        MapsLib.getCount(whereClause);
    },
    clearSearch: function() {
        MapsLib.oldaddress = MapsLib.address;

//        if (MapsLib.searchrecords != null)
//            MapsLib.searchrecords.setMap(null);
        if (MapsLib.addrMarker != null)
            MapsLib.addrMarker.setMap(null);
        if (MapsLib.searchRadiusCircle != null)
            MapsLib.searchRadiusCircle.setMap(null);
    },
    findMe: function() {
        var foundLocation;
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                foundLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
                MapsLib.addrFromLatLng(foundLocation);
            }, function() {
                MapsLib.handleNoGeolocation(true);
            });
        }
        else {
            MapsLib.handleNoGeolocation(false);
        }
    },
    addrFromLatLng: function(latLngPoint) {
        geocoder.geocode({'latLng': latLngPoint}, function(results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                if (results[1]) {
                    $('#search_address').val(results[1].formatted_address);
                    MapsLib.doSearch();
                }
            } else {
                alert("Geocoder failed due to: " + status);
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
    //converts a slug or query string in to readable text
    convertToPlainString: function(text) {
        if (text == undefined)
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
};