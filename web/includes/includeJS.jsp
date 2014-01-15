<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="js/jquery.localscroll-1.2.7-min.js"></script>        
<script type="text/javascript" src="js/jquery.scrollTo-1.4.3.1-min.js"></script>
<script type="text/javascript" src="js/jquery.address.js"></script>
<script type="text/javascript" src="js/site.js"></script>
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?libraries=places&sensor=true&language=vi"></script>
<script type="text/javascript" src="js/jquery.geocomplete.min.js"></script>
<script type="text/javascript" src="js/map.js"></script>
<script type="text/javascript">
    jQuery(document).ready(function($) {
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
        })
        $("#search_address").keydown(function(e) {
            var key = e.keyCode ? e.keyCode : e.which;
            if (key == 13) {
                $('#search').click();
                return false;
            }
        });
        MapsLib.submitSearch();
    });
</script>