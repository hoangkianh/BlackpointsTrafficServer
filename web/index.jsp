<%--<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<jsp:forward page="Welcome.do"/>--%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>

<html:html lang="true">
    <!DOCTYPE HTML>
    <head>
        <title><bean:message key="welcome.title"/></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!--Style-->
        <link rel="shortcut icon" href="img/favicon.png">
        <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800&subset=vietnamese" rel="stylesheet" type="text/css">
        <link type="text/css" rel="stylesheet" href="css/bootstrap.css">
        <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->
        <link type="text/css" rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" type="text/css" href="css/prettyPhoto.css">
        <link type="text/css" rel="stylesheet" href="css/bootstrap-responsive.css">
        <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
        <!--[if IE 7]>
            <link rel="stylesheet" href="css/font-awesome-ie7.min.css">
        <![endif]-->

        <!-- Script-->
        <script type="text/javascript" src="js/jquery.js"></script>
        <script type="text/javascript" src="js/jquery.localscroll-1.2.7-min.js"></script>        
        <script type="text/javascript" src="js/jquery.scrollTo-1.4.2-min.js"></script>
        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?v=3.14&key=AIzaSyDe8Ei4PYk28xZa4GfP-7ClfCvWxX4YB_8&sensor=true&language=vi"></script>
        <script type="text/javascript">


            var map;
            function initialize() {
                var mapOptions = {
                    zoom: 14,
                    mapTypeControlOptions: {
                        style: google.maps.MapTypeControlStyle.DROPDOWN_MENU
                    }
                };

                map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

                if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(function(position) {
                        var pos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
                        var infowindow = new google.maps.InfoWindow({
                            map: map,
                            position: pos,
                            content: 'Location found using HTML5.'
                        });
                        map.setCenter(pos);
                    }, function() {
                        handleNoGeolocation(true);
                    });
                } else {
                    handleNoGeolocation(false);
                }
            }

            function handleNoGeolocation(errorFlag) {
                if (errorFlag) {
                    var content = 'Error: The Geolocation service failed.';
                } else {
                    var content = 'Error: Your browser doesn\'t support geolocation.';
                }

                var options = {
                    map: map,
                    position: new google.maps.LatLng(21.0333330, 105.8500000),
                    content: content
                };

                var infowindow = new google.maps.InfoWindow(options);
                map.setCenter(options.position);
            }

            google.maps.event.addDomListener(window, 'load', initialize);</script>
    </head>
    <body>
        <!-- ****************** NAV BAR ****************** -->
        <div class="navbar-wrapper">
            <div class="navbar navbar-inverse navbar-fixed-top">
                <div class="navbar-inner">
                    <div class="container">
                        <a class="btn btn-navbar"  data-toggle="collapse" data-target=".nav-collapse">
                            <i class="fa fa-bars"></i>
                        </a>
                        <h1 class="brand"><a href="#top">Blackpoints.vn</a></h1>
                        <nav class="pull-right nav-collapse collapse">
                            <ul id="menu-main" class="nav">                                
                                <li>
                                    <a class="first-link">Home</a>
                                    <a class="second-link" href="#top">Home</a>
                                </li>
                                <li>
                                    <a class="first-link">Bản đồ</a>
                                    <a class="second-link" href="#map">Bản đồ</a>
                                </li>
                                <li>
                                    <a class="first-link"><i class="fa fa-lock"></i> Đăng nhập</a>
                                    <a class="second-link" href="#login"><i class="fa fa-lock"></i> Đăng nhập</a>
                                </li>
                                <li>
                                    <a class="first-link">Đăng kí</a>
                                    <a class="second-link" href="#login">Đăng kí</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
        <div id="top"></div>
        <!-- ******************** HeaderWrap ********************-->
        <div id="headerwrap">
            <header class="clearfix">
                <div class="container">
                    <h1><span>Đồ án tốt nghiệp</span></h1>
                    <h2>Hệ thống cảnh báo điểm đen tai nạn giao thông</h2>
                    <h2>trên nền điện toán đám mây <i class="fa fa-cloud"></i></h2>
                    <h3>Sinh viên: <span>Nguyễn Hoàng Anh</span> (1000321) - CNPM K51</h3>
                    <h3>GVHD: <span>ThS. Bùi Ngọc Dũng</span></h3>
                    <p id="p-arrow">
                        <a class="first-link" href="#map" title="Xem bản đồ điểm đen tai nạn giao thông"><i class="fa fa-arrow-circle-down fa-3x"></i></a>
                        <a class="second-link" href=""><i class="fa fa-arrow-circle-down fa-3x"></i></a>
                    </p>
                </div>
            </header>
        </div>
        <!-- ******************** About ********************-->
        <div class="scrollblock">
            <section id="about">
                <div class="container">
                    <div class="row">
                        <div class="span12">
                            <article>
                                <p><i class="fa fa-globe"></i> Đây là ứng dụng <span>phiên bản web</span> của hệ thống</p>
                                <p><i class="fa fa-map-marker"></i> Bạn có thể đăng nhập để <span>cập nhật</span> các điểm đen giao thông</p>
                                <p><i class="fa fa-shopping-cart"></i> Có webservice để bên thứ 3 có thể mua lại <span>(SaaS)</span></p>
                            </article>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <hr>
        <section id="map" class="single-page scrollblock">
            <div class="container">
                <div class="align"><i class="fa fa-map-marker"></i></div>
                <h1>Bản đồ điểm đen</h1>
                <div id="map-canvas"></div>
            </div>
        </section>
        <hr>
        <script type="text/javascript" src="js/bootstrap.min.js"></script>
        <script type="text/javascript" src="js/jquery.prettyPhoto.js"></script>        
        <script type="text/javascript" src="js/site.js"></script>        
        <script type="text/javascript">
            jQuery(document).ready(function($) {
                $("a[rel^="prettyPhoto"]").prettyPhoto();
            });
        </script>
    </body>
</html:html>
