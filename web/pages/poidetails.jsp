<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
    <head>
        <title><bean:message  key="detail.title"/> | <bean:message key="welcome.title"/></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="../includes/includeCSS.jsp" %>
        <script type="text/javascript" src="//code.jquery.com/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="//code.jquery.com/ui/1.10.0/jquery-ui.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?libraries=places&sensor=false&language=vi"></script>
        <script type="text/javascript" src="http://google-maps-utility-library-v3.googlecode.com/svn/trunk/infobubble/src/infobubble-compiled.js"></script>
        <script type="text/javascript" src="js/map.js"></script>
        <script type="text/javascript">
            $(function() {
                MapsLib.initialize();
                MapsLib.getPOIByID(<bean:write name="POIForm" property="id" />);

                $('body').removeClass('noscript');
                $('.disable').remove();
                $("#tabs").tabs();
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
                        <ul class="breadcrumb">
                            <li><a href="#"><bean:write name="POIForm" property="cityName"/></a><span class="divider">/</span></li>
                            <li class="active"><bean:write name="POIForm" property="districtName"/></li>
                        </ul>
                        <a href="poi.do" target="_blank" class="btn btn-primary" title="Thêm điểm đen mới" style="position: absolute; top: 15px; right: 0; width: auto;"><bean:message key="detail.addnewPOI" /></a>
                    </div>
                    <div class="poi-details span12">
                        <div class="main-image">
                            <img src="<bean:write name="POIForm" property="image" />" width="220" height="280" />
                        </div>
                        <div class="info-wrapper span9">
                            <div class="main-info span4">
                                <div class="main-info-title">
                                    <h1><bean:write name="POIForm" property="name" /></h1>
                                    <h3><bean:write name="POIForm" property="categoryName" /> - <bean:write name="POIForm" property="ratingName" /></h3>
                                </div>
                                <div class="main-info-content">
                                    <ul>
                                        <li><span><bean:message key="detail.address" />: </span> <bean:write name="POIForm" property="address" /></li>
                                        <li><span><bean:message key="detail.createdOnDate" />: </span> <bean:write name="POIForm" property="createdOnDate" /></li>
                                            <logic:notEmpty name="POIForm" property="description">
                                            <li><span><bean:message key="detail.description" />: </span><p><bean:write name="POIForm" property="description" /></p></li>
                                            </logic:notEmpty>
                                    </ul>
                                </div>
                            </div>
                            <div class="geo-info span4">
                                <div id="map-canvas" style="height: 400px;"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section>
            <div class="container">
                <div class="row">
                    <div class="span12 tabs-wrapper">
                        <h2><bean:message key="detail.inDistrictHeader"/> <bean:write name="POIForm" property="districtName" /></h2>
                        <div id="tabs">
                            <ul>
                                <logic:iterate id="c" name="POIForm" property="categoryList">
                                    <li><a href="#tabs-${c.categoryID}">${c.name}</a></li>
                                    </logic:iterate>
                            </ul>
                            <logic:iterate id="c" name="POIForm" property="categoryList">
                                <div id="tabs-${c.categoryID}">
                                    <logic:iterate id="p" name="POIForm" property="poiListInDistrict">
                                        <logic:equal name="p" property="categoryID" value="${c.categoryID}">
                                            <div class="district-item">
                                                <div class="district-image">
                                                    <a href="details.do?id=<bean:write name="p" property="id"/>" title="<bean:write name="p" property="name"/>">
                                                        <img alt="<bean:write name="p" property="name" />" src="<bean:write name="p" property="image" />" />
                                                    </a>
                                                </div>
                                                <div class="district-info">
                                                    <h3>
                                                        <a href="details.do?id=<bean:write name="p" property="id"/>" title="<bean:write name="p" property="name"/>">
                                                            <bean:write name="p" property="name" />
                                                        </a>
                                                    </h3><br/>
                                                    <h4><bean:write name="p" property="address"/></h4>
                                                    <logic:notEmpty name="p" property="description">
                                                        <li><span></span><p><bean:write name="p" property="description" /></p></li>
                                                            </logic:notEmpty>
                                                </div>
                                            </div>
                                        </logic:equal>
                                    </logic:iterate>
                                </div>
                            </logic:iterate>
                        </div>
                    </div>
                </div>
        </section>
        <%@include file="../includes/footer.jsp" %>
    </body>
</html>