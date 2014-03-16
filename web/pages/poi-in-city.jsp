<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
    <head>
        <title><bean:write name="POIForm" property="cityName"/> | <bean:message key="welcome.title"/></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="../includes/includeCSS.jsp" %>
        <link rel="stylesheet" href="css/jquery.fancybox.css" type="text/css"/>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="js/jquery-ui.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?libraries=places&sensor=false&language=vi"></script>
        <script type="text/javascript" src="js/infobubble.min.js"></script>
        <script type="text/javascript" src="js/map.js"></script>
        <script type="text/javascript" src="js/jquery.fancybox.pack.js"></script>
        <script type="text/javascript">
            $(function() {
                $("a[rel^='fancybox']").fancybox();
                MapsLib.initialize();
                MapsLib.getPOIInCity(<bean:write name="POIForm" property="city"/>, '<bean:write name="POIForm" property="cityName"/>');

                $('body').removeClass('noscript');
                $('.disable').remove();
                $('#tabs').tabs();

                $('#city').change(function() {
                    var city = $(this).val();
                    window.location.href = "poi-in-city.do?id=" + city;
                });
            });
        </script>
    </head>
    <body class="noscript">
        <div class="disable">
            <p><bean:message key="warning.javascript" /></p>
            <p><bean:message key="warning.javascript2" /></p>
        </div>
        <%@include file="../includes/navbar-alter.jsp" %>
        <section>
            <div class="container">
                <div class="row">
                    <div class="info-box span12">
                        <html:select style="margin:10px;" name="POIForm" property="city" styleId="city">
                            <html:optionsCollection name="POIForm" property="cityList" label="name" value="id"/>
                        </html:select>
                        <a href="poi.do" target="_blank" class="btn btn-primary" title="Thêm điểm đen mới" style="width: auto;"><bean:message key="detail.addnewPOI" /></a>
                    </div>
                    <div class="span12">
                        <div id="map-canvas" style="height: 550px;"></div>
                    </div>
                </div>
            </div>
        </section>
        <%@include file="../includes/footer.jsp" %>
    </body>
</html>