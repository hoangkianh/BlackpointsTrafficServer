<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>

<html:html lang="true">
    <!DOCTYPE HTML>
    <head>
        <title><bean:message key="welcome.title"/></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="includeCSS.jsp" %>
    </head>
    <body>
        <div class="navbar-wrapper">
            <div class="navbar navbar-inverse navbar-static-top">
                <div class="navbar-inner">
                    <div class="container">
                        <a class="btn btn-navbar"  data-toggle="collapse" data-target=".nav-collapse">
                            <i class="fa fa-bars"></i>
                        </a>
                        <h1 class="brand"><a href="#top"><bean:message key="navbar.weblogo"/></a></h1>
                        <nav class="pull-right nav-collapse collapse">
                            <ul id="menu-main" class="nav">                                
                                <li>
                                    <a class="first-link" href="#top"><bean:message key="navbar.home"/></a>
                                    <a class="second-link" href="#top"><bean:message key="navbar.home"/></a>
                                </li>
                                <li>
                                    <a class="first-link" href="#map"><bean:message key="navbar.map"/></a>
                                    <a class="second-link" href="#map"><bean:message key="navbar.map"/></a>
                                </li>
                                <li>
                                    <a class="first-link" href="#login"><i class="fa fa-lock"></i> <bean:message key="navbar.login"/></a>
                                    <a class="second-link" href="#login"><i class="fa fa-lock"></i> <bean:message key="navbar.login"/></a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
        <section id="map-wrapper">
            <div class="container">
                <div class="row">
                    <div class="span4">
                        <p><bean:message key="map.intro"/></p>
                        <div class="well">
                            <bean:message key="map.address"/>&nbsp;&nbsp;
                            <small> 
                                (<a id='find_me' href='#' title="<bean:message key='map.findme'/>">
                                    <i class="fa fa-map-marker fa-2x"></i> <bean:message key="map.where"/>
                                </a>)
                            </small>
                            <p>
                                <input id="search_address" placeholder="<bean:message key='map.enteraddress'/>" type="text" />
                            </p>
                            <p>
                                <label>
                                    <bean:message key="map.within"/>
                                    <select id='search_radius'>
                                        <option value='500'>500 m</option>
                                        <option value='1000'>1 km</option>
                                        <option value='2000'>2 km</option>
                                        <option value='5000'>5 km</option>
                                        <option value='10000'>10 km</option>
                                        <option value='15000'>15 km</option>                  
                                        <option value='20000'>20 km</option>
                                        <option value='25000'>25 km</option>
                                        <option value='30000'>30 km</option>                  
                                        <option value='35000'>35 km</option>
                                        <option value='40000'>40 km</option>
                                        <option value='45000'>45 km</option>
                                        <option value='50000'>50 km</option>
                                    </select>
                                </label>
                            </p>
                        </div>                                
                    </div>
                    <div class="span8">
                        <div id="map-canvas" style="height: 80%;"></div>
                    </div>
                </div>
            </div>
        </section>
        <%@include file="includeJS.jsp" %>
    </body>
</html:html>