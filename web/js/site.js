jQuery(document).ready(function($) {
    $.localScroll();
    
    /*** MapsLib ***/
    MapsLib.initialize();
    $("#search_address").geocomplete();
    $('#search').click(function() {
        MapsLib.doSearch();
    });
    $('#reset').click(function() {
        $.address.parameter('address', '');
        MapsLib.initialize();
        return false;
    });
    $('#find_me').click(function() {
        MapsLib.findMe();
        return false;
    });
    $('#search_radius').change(function() {
        MapsLib.doSearch();
    });
    $("#search_address").keydown(function(e) {
        var key = e.keyCode ? e.keyCode : e.which;
        if (key === 13) {
            $('#search').click();
            return false;
        }
    });
    MapsLib.doSearch();
}); 