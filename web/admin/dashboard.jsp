<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:if test="${empty sessionScope.blackpoints and empty cookie.blackpoints}">
    <c:redirect url="/login.do" />
</c:if>
<c:if test="${not empty sessionScope.blackpoints or not empty cookie.blackpoints}">
    <c:if test="${not empty sessionScope.blackpoints}">
        <c:set var="userStr" value="${fn:split(sessionScope.blackpoints, '~')}"/>        
    </c:if>
    <c:if test="${not empty cookie.blackpoints}">
        <c:set var="userStr" value="${fn:split(cookie.blackpoints.value, '~')}"/>
    </c:if>
    <c:choose>
        <c:when test="${userStr[3] eq 3}">
            <jsp:forward page="/failure.do">
                <jsp:param name="f" value="6" />
            </jsp:forward>
        </c:when>
    </c:choose>
</c:if>

<!DOCTYPE html>
<html>
    <head>
        <title><bean:message key="admin.header" /></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="../includes/includeCSS.jsp" %>
        <link type="text/css" rel="stylesheet" href="css/morris.css">
        <script type="text/javascript" src="//code.jquery.com/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>        
        <script type="text/javascript" src="js/morris.min.js"></script>
        <script type="text/javascript" src="js/raphael.min.js"></script>
    </head>
    <body>
        <%@include file="../includes/navbar-alter.jsp" %>
        <%@include  file="../includes/navbar-admin.jsp" %>
        <section id="statistic">
            <div class="container">
                <div class="row-fluid">
                    <div class="span12">
                        <a class="span3 tile" href="poilist.do">
                            <div class="tile-header">Số điểm đen</div>
                            <div class="tile-content-wrapper">
                                <i class="fa fa-map-marker"></i>
                                <div class="tile-content">
                                    35
                                </div>
                                <small>5 điểm đen mới</small>
                            </div>
                            <div class="tile-footer">
                                xem chi tiết
                                <i class="fa fa-arrow-right"></i>
                            </div>
                        </a>
                        <a class="span3 tile" href="#">
                            <div class="tile-header">Số điểm đen</div>
                            <div class="tile-content-wrapper">
                                <i class="fa fa-map-marker"></i>
                                <div class="tile-content">
                                    35
                                </div>
                                <small>5 điểm đen mới</small>
                            </div>
                            <div class="tile-footer">
                                xem chi tiết
                                <i class="fa fa-arrow-right"></i>
                            </div>
                        </a>
                        <a class="span3 tile" href="#">
                            <div class="tile-header">Số điểm đen</div>
                            <div class="tile-content-wrapper">
                                <i class="fa fa-map-marker"></i>
                                <div class="tile-content">
                                    35
                                </div>
                                <small>5 điểm đen mới</small>
                            </div>
                            <div class="tile-footer">
                                xem chi tiết
                                <i class="fa fa-arrow-right"></i>
                            </div>
                        </a>
                        <a class="span3 tile" href="#">
                            <div class="tile-header">Số điểm đen</div>
                            <div class="tile-content-wrapper">
                                <i class="fa fa-map-marker"></i>
                                <div class="tile-content">
                                    35
                                </div>
                                <small>5 điểm đen mới</small>
                            </div>
                            <div class="tile-footer">
                                xem chi tiết
                                <i class="fa fa-arrow-right"></i>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="row-fluid">
                    <div class="span12">
                        <div class="span8 chart bar-chart">
                            <div class="chart-header clearfix">
                                <h3 class="pull-left">Số lượng điểm đen <small>trên toàn quốc</small></h3>
                            </div>
                            <div class="chart-content-wrapper">
                                <div class="chart-content" id="bar-chart"></div>
                            </div>
                        </div>
                        <div class="span4 chart donut-chart">
                            <div class="chart-header clearfix">
                                <h3 class="pull-left">Tỉ lệ điểm đen <small>theo các tỉnh thành</small></h3>
                            </div>
                            <div class="chart-content-wrapper">
                                <div class="chart-content" id="donut-chart"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <script type="text/javascript">
            Morris.Bar({
                element: 'bar-chart',
                data: [
                    {y: '2006', a: 100},
                    {y: '2007', a: 75},
                    {y: '2008', a: 50},
                    {y: '2009', a: 75},
                    {y: '2010', a: 50},
                    {y: '2011', a: 75},
                    {y: '2012', a: 100}
                ],
                xkey: 'y',
                ykeys: ['a'],
                labels: ['Series A']
            });
            Morris.Donut({
                element: 'donut-chart',
                data: [
                    {label: "Download Sales", value: 12},
                    {label: "In-Store Sales", value: 30},
                    {label: "Mail-Order Sales", value: 20}
                ]
            });
        </script>
    </body>
</html>
