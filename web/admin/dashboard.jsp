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
        <title><bean:message key="admin.title.dashboard" /></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="../includes/includeCSS.jsp" %>
        <link type="text/css" rel="stylesheet" href="css/morris.css">
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
        <script type="text/javascript" src="js/highcharts.js"></script>
        <script type="text/javascript" src="js/data.js"></script>
        <script type="text/javascript" src="js/drilldown.js"></script>
    </head>
    <body>
        <%@include file="../includes/navbar-alter.jsp" %>
        <%@include  file="../includes/navbar-admin.jsp" %>
        <section id="statistic">
            <div class="container">
                <div class="row-fluid">
                    <div class="span12">
                        <a class="span3 tile" href="poilist.do">
                            <div class="tile-header"><bean:message key="admin.tile.header.poicount" /></div>
                            <div class="tile-content-wrapper">
                                <i class="fa fa-map-marker"></i>
                                <div class="tile-content">
                                    <bean:write name="StatisticForm" property="countPOI"/>
                                </div>
                                <small>
                                    <c:choose>
                                        <c:when test="${StatisticForm.countNewPOI gt 0}">
                                            <bean:write name="StatisticForm" property="countNewPOI"/>
                                            <bean:message key="admin.tile.content.newpoi"/>
                                        </c:when>
                                        <c:otherwise>&nbsp;</c:otherwise>
                                    </c:choose>
                                </small>
                            </div>
                            <div class="tile-footer">
                                <bean:message key="admin.tile.footer.viewdetails" />
                                <i class="fa fa-arrow-right"></i>
                            </div>
                        </a>
                        <a class="span3 tile" href="fromuser.do">
                            <div class="tile-header"><bean:message key="admin.tile.header.tempcount" /></div>
                            <div class="tile-content-wrapper">
                                <i class="fa fa-spinner"></i>
                                <div class="tile-content">
                                    <bean:write name="StatisticForm" property="countTempPOI"/>
                                </div>
                                <small>
                                    <c:choose>
                                        <c:when test="${StatisticForm.countNewTempPOI gt 0}">
                                            <bean:write name="StatisticForm" property="countNewTempPOI"/>
                                            <bean:message key="admin.tile.content.newpoi"/>
                                        </c:when>
                                        <c:otherwise>&nbsp;</c:otherwise>
                                    </c:choose>
                                </small>
                            </div>
                            <div class="tile-footer">
                                <bean:message key="admin.tile.footer.viewdetails" />
                                <i class="fa fa-arrow-right"></i>
                            </div>
                        </a>
                        <a class="span3 tile" href="deletedlist.do">
                            <div class="tile-header"><bean:message key="admin.tile.header.deletecount" /></div>
                            <div class="tile-content-wrapper">
                                <i class="fa fa-times-circle-o"></i>
                                <div class="tile-content">
                                    <bean:write name="StatisticForm" property="countDeletedPOI"/>
                                </div>
                                <small>
                                    <c:choose>
                                        <c:when test="${StatisticForm.countNewDeletedPOI gt 0}">
                                            <bean:write name="StatisticForm" property="countNewDeletedPOI"/>
                                            <bean:message key="admin.tile.content.deletepoi"/>
                                        </c:when>
                                        <c:otherwise>&nbsp;</c:otherwise>
                                    </c:choose>
                                </small>
                            </div>
                            <div class="tile-footer">
                                <bean:message key="admin.tile.footer.viewdetails" />
                                <i class="fa fa-arrow-right"></i>
                            </div>
                        </a>
                        <a class="span3 tile" href="user.do">
                            <div class="tile-header"><bean:message key="admin.tile.header.usercount" /></div>
                            <div class="tile-content-wrapper">
                                <i class="fa fa-users"></i>
                                <div class="tile-content">
                                    <bean:write name="StatisticForm" property="countUser"/>
                                </div>
                                <small>
                                    <c:choose>
                                        <c:when test="${StatisticForm.countNewUser gt 0}">
                                            <bean:write name="StatisticForm" property="countNewUser"/>
                                            <bean:message key="admin.tile.content.newuser"/>
                                        </c:when>
                                        <c:otherwise>&nbsp;</c:otherwise>
                                    </c:choose>
                                </small>
                            </div>
                            <div class="tile-footer">
                                <bean:message key="admin.tile.footer.viewdetails" />
                                <i class="fa fa-arrow-right"></i>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="row-fluid">
                    <div class="span12 chart border-red">
                        <div class="chart-content-wrapper">
                            <div id="data-for-bar-chart">
                            </div>
                            <div class="chart-content" id="bar-chart" style="height: 450px;"></div>
                        </div>
                    </div>
                </div>
                <div class="row-fluid">
                    <div class="span12 chart border-green">
                        <div class="chart-content-wrapper">
                            <div class="chart-content" id="pie-chart" style="height: 450px;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <script type="text/javascript">
            $(function() {
                var data = "";
                $.ajax({
                    type: "GET",
                    async: false,
                    url: "service/POI/countPOIByDistrict",
                    dataType: "text",
                    success: function(text) {
                        data = text;
                    }
                });
                Highcharts.setOptions({
                    lang: {
                        drillUpText: '◁ <bean:message key="admin.barchart.back" />'
                    }
                });
                Highcharts.data({
                    csv: data,
                    itemDelimiter: '-',
                    parsed: function(columns) {
                        var totalPOI = 0,
                            brandsBarChart = {},
                                brandsDataBarChart = [],
                                districtsBarChart = {},
                                drilldownSeriesBarChart = [],
                                brandsPieChart = {},
                                brandsDataPieChart = [],
                                districtsPieChart = {},
                                drilldownSeriesPieChart = [];

                        $.each(columns[0], function(idx, city) {
                            var district;
                            city = columns[0][idx];
                            district = columns[1][idx];

                            if (!brandsBarChart[city]) {
                                brandsBarChart[city] = columns[2][idx];
                            } else {
                                brandsBarChart[city] += columns[2][idx];
                            }

                            if (!brandsPieChart[city]) {
                                brandsPieChart[city] = columns[2][idx];
                            } else {
                                brandsPieChart[city] += columns[2][idx];
                            }

                            if (district !== null) {
                                if (!districtsBarChart[city]) {
                                    districtsBarChart[city] = [];
                                }
                                if (!districtsPieChart[city]) {
                                    districtsPieChart[city] = [];
                                }
                                districtsBarChart[city].push([district, columns[2][idx]]);
                                districtsPieChart[city].push([district, columns[3][idx]]);
                            }
                        });
                        
                        $.each(brandsBarChart, function(city, y) {
                            totalPOI += brandsBarChart[city];
                            brandsDataBarChart.push({
                                name: city,
                                y: y,
                                drilldown: districtsBarChart[city] ? city : null
                            });
                        });

                        $.each(brandsPieChart, function(city, y) {
                            y = (brandsPieChart[city]/totalPOI)*100;
                            brandsDataPieChart.push({
                                name: city,
                                y: y,
                                drilldown: districtsPieChart[city] ? city : null
                            });
                        });

                        $.each(districtsBarChart, function(key, value) {
                            drilldownSeriesBarChart.push({
                                name: key,
                                id: key,
                                data: value
                            })
                        });

                        $.each(districtsPieChart, function(key, value) {
                            drilldownSeriesPieChart.push({
                                name: key,
                                id: key,
                                data: value
                            })
                        });

                        $('#bar-chart').highcharts({
                            chart: {type: 'column'},
                            title: {text: '<bean:message key="admin.barchart.title"/>'},
                            subtitle: {text: '<bean:message key="admin.barchart.subtitle"/>'},
                            xAxis: {
                                type: 'category',
                                labels: {
                                    rotation: -45,
                                    align: 'right',
                                    style: {fontSize: '13px'}
                                }
                            },
                            yAxis: {
                                min: 0,
                                title: {text: '<bean:message key="admin.barchart.title" />'},
                                tickPositioner: function() {
                                    var positions = [],
                                            tick = Math.floor(this.dataMin),
                                            increment = 1;
                                    for (; tick - increment <= this.dataMax; tick += increment) {
                                        positions.push(tick);
                                    }
                                    return positions;
                                }
                            },
                            legend: {enabled: false},
                            tooltip: {
                                pointFormat: '<span style="font-size:10px">{point.key}</span><b>{point.y}</b>'
                            },
                            plotOptions: {
                                series: {
                                    borderWidth: 0,
                                    dataLabels: {
                                        enabled: true,
                                        format: '{point.y}'
                                    }
                                }
                            },
                            series: [{
                                    name: '<bean:message key="admin.barchart.title" />',
                                    colorByPoint: true,
                                    data: brandsDataBarChart
                                }],
                            drilldown: {
                                series: drilldownSeriesBarChart
                            }
                        });
                        $('#pie-chart').highcharts({
                            chart: {type: 'pie'},
                            title: {text: '<bean:message key="admin.piechart.title"/>'},
                            subtitle: {text: '<bean:message key="admin.piechart.subtitle"/>'},
                            plotOptions: {
                                series: {
                                    dataLabels: {
                                        enabled: true,
                                        format: '{point.name}: {point.y:.1f}%'
                                    }
                                }
                            },
                            tooltip: {
                                headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
                                pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}%</b><br/>'
                            },
                            series: [{
                                    name: '<bean:message key="admin.piechart.title"/>',
                                    colorByPoint: true,
                                    data: brandsDataPieChart
                                }],
                            drilldown: {
                                series: drilldownSeriesPieChart
                            }
                        });
                    }
                });
            });
        </script>
    </body>
</html>
