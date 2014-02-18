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
        <link type="text/css" rel="stylesheet" href="css/xcharts.min.css">
        <script type="text/javascript" src="//code.jquery.com/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>        
        <script type="text/javascript" src="js/d3.v3.min.js"></script>
        <script type="text/javascript" src="js/xcharts.min.js"></script>
    </head>
    <body>
        <%@include file="../includes/navbar.jsp" %>
        <%@include  file="../includes/navbar-admin.jsp" %>
        <section id="statistic">
            <div class="container">
                <div class="row-fluid">
                    <div class="span12">
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
                    <div class="span12 chart">
                        <div class="chart-header clearfix">
                            <h3 class="pull-left">Số lượng điểm đen <small>trên toàn quốc</small></h3>
                            <div class="btn-group pull-right">
                                <a href="#" class="btn active">Biểu đồ cột</a>
                                <a href="#" class="btn">Biểu đồ đường</a>
                            </div>
                        </div>
                        <div class="chart-content-wrapper">
                            <figure id="myChart" style="width: 98%; height: 300px"></figure>
                            <script type="text/javascript">
                                var tt = document.createElement('div'),
                                        leftOffset = -(~~$('html').css('padding-left').replace('px', '') + ~~$('body').css('margin-left').replace('px', '')),
                                        topOffset = 0;
                                tt.className = 'tooltip top fade in';
                                document.body.appendChild(tt);

                                var data = {
                                    "xScale": "time",
                                    "yScale": "linear",
                                    "main": [
                                        {
                                            "className": ".pizza",
                                            "data": [
                                                {
                                                    "x": "2012-11-05",
                                                    "y": 6
                                                },
                                                {
                                                    "x": "2012-11-06",
                                                    "y": 6
                                                },
                                                {
                                                    "x": "2012-11-07",
                                                    "y": 8
                                                },
                                                {
                                                    "x": "2012-11-08",
                                                    "y": 3
                                                },
                                                {
                                                    "x": "2012-11-09",
                                                    "y": 4
                                                },
                                                {
                                                    "x": "2012-11-10",
                                                    "y": 9
                                                },
                                                {
                                                    "x": "2012-11-11",
                                                    "y": 6
                                                }
                                            ]
                                        }
                                    ]
                                };
                                var opts = {
                                    "dataFormatX": function(x) {
                                        return d3.time.format('%Y-%m-%d').parse(x);
                                    },
                                    "tickFormatX": function(x) {
                                        return d3.time.format('%A')(x);
                                    },
                                    "mouseover": function(d, i) {
                                        var pos = $(this).offset();
                                        $(tt).html('<div class="arrow"></div><div class="tooltip-inner">' + d3.time.format('%A')(d.x) + ': ' + d.y + '</div>')
                                                .css({top: topOffset + pos.top, left: pos.left + leftOffset})
                                                .show();
                                    },
                                    "mouseout": function(x) {
                                        $(tt).hide();
                                    }
                                };
                                var myChart = new xChart('line-dotted', data, '#myChart', opts);
                            </script>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>
