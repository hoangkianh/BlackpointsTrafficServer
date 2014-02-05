$(function() {
    $.localScroll();

    /*** MapsLib ***/
    MapsLib.initialize();
    MapsLib.findMe();
    MapsLib.doSearch(false);
    $("#search_address").geocomplete({
        country: "vn",
        markerOptions: {
            draggable: true
        }
    });
    $('#search').click(function() {
        MapsLib.doSearch(false);
    });
    $('#search_radius').change(function() {
        MapsLib.doSearch(false);
    });
    $("#search_address").keydown(function(e) {
        var key = e.keyCode ? e.keyCode : e.which;
        if (key === 13) {
            $('#search').click();
            return false;
        }
    });
}); 