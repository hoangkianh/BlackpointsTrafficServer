<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@taglib  uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
                                    <html:link action="/backHome" styleClass="first-link"><bean:message key="navbar.home"/></html:link>
                                    <html:link action="/backHome" styleClass="second-link"><bean:message key="navbar.home"/></html:link>
                                    </li>
                                <c:choose>
                                    <c:when test="${empty sessionScope.userName}">
                                        <li>
                                            <a class="first-link" href="#login"><i class="fa fa-sign-in"></i> <bean:message key="navbar.login"/></a>
                                            <a class="second-link" href="#login"><i class="fa fa-sign-in"></i> <bean:message key="navbar.login"/></a>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li>
                                            <a class="first-link" href="#login"><i class="fa fa-sign-out"></i> <bean:message key="navbar.hello"/></a>
                                            <a class="second-link" href="#login"><i class="fa fa-sign-out"></i> <bean:message key="navbar.hello"/></a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
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
                        <p>
                            <bean:message key="map.intro"/><br/>
                        </p>
                        <h1><i class="fa fa-question-circle" title="<bean:message key="map.intro.note"/>"></i></h1>
                        <div class="well">
                            <span><bean:message key="map.address"/></span>
                            <small> 
                                (<a id="find_me" href="#" title="<bean:message key="map.findme"/>">
                                    <i class="fa fa-map-marker fa-2x"></i> <bean:message key="map.where"/>
                                </a>)
                            </small>
                            <p>
                                <input id="search_address" placeholder="<bean:message key='map.enteraddress'/>" type="text" />
                            </p>
                            <p>
                                <label>
                                    <bean:message key="map.within"/>
                                    <select id="search_radius">
                                        <option value='500'>500 m</option>
                                        <option value='1000'>1 km</option>
                                        <option value='2000'>2 km</option>
                                        <option value='5000' selected="selected">5 km</option>
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
                            <a class="btn" id="search" href="#">
                                <i class="fa fa-search"></i> <bean:message key="map.search"/>
                            </a>
                            <a class="btn" id="reset" href='#'>
                                <i class="fa fa-repeat"></i> <bean:message key="map.reset"/>
                            </a>
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