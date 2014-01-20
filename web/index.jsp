<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>

<html:html lang="true">
    <!DOCTYPE HTML>
    <head>
        <title><bean:message key="welcome.title"/></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="includes/includeCSS.jsp" %>
    </head>
    <body>
        <%-- ****************** NAV BAR ****************** --%>
        <%@include file="includes/navbar.jsp" %>
        <div id="top"></div>
        <%-- ******************** HeaderWrap ********************--%>
        <%@include file="includes/header.jsp" %>        
        <%-- ******************** About ********************--%>
        <%@include file="includes/about.jsp" %>        
        <%-- ******************** Map Section ********************--%>
        <section id="map" class="single-page scrollblock">
            <div class="container">
                <div class="align"><i class="fa fa-map-marker"></i></div>
                <h1><bean:message key="map.title"/></h1>
                <div class="row">
                    <div class="span12">
                        <html:link action="viewMap">
                            <i class="fa fa-arrows-alt"></i>
                            <bean:message key="map.largemap"/>
                        </html:link>
                    </div>
                </div>
                <div id="map-canvas"></div>
            </div>
        </section>
        <hr>
        <%@include file="includes/includeJS.jsp" %>
    </body>
</html:html>
