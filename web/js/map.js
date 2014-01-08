google.maps.visualRefresh = true;

var MapsLib = MapsLib || {};
var MapsLib = {
    googleApiKey: "AIzaSyDe8Ei4PYk28xZa4GfP-7ClfCvWxX4YB_8",
    map_centroid: new google.maps.LatLng(21.0333330, 105.8500000),
    searchRadius: 500,
    defaultZoom: 16,
    addrMarkerImage: 'img/marker.png',
    initialize: function() {
        var mapOptions = {
            scaleControl: true,
            zoom: MapsLib.defaultZoom,
            center: MapsLib.map_centroid,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

        google.maps.event.addDomListener(window, 'load', function() {
            map.setCenter(MapsLib.calculateCenter());
        });
    },
    calculateCenter: function() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                var pos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
            }, function() {
                handleNoGeolocation(true);
            });
        } else {
            handleNoGeolocation(false);
        }
        return pos;
    },
    handleNoGeolocation: function(errorFlag) {
        if (errorFlag) {
            var content = 'Error: The Geolocation service failed.';
        } else {
            var content = 'Error: Your browser doesn\'t support geolocation.';
        }

        var options = {
            map: map,
            position: MapsLib.map_centroid,
            content: content
        };

        new google.maps.InfoWindow(options);
        map.setCenter(options.position);
    }
};