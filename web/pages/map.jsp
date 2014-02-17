<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html:html lang="true">
    <!DOCTYPE HTML>
    <head>
        <title><bean:message key="map.title"/> | <bean:message key="welcome.title"/></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="../includes/includeCSS.jsp" %>
        <%@include file="../includes/includeJS.jsp" %>
        <script type="text/javascript">
            $(function() {
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
        <div class="navbar-wrapper">
            <div class="navbar navbar-inverse navbar-static-top">
                <div class="navbar-inner">
                    <div class="container">
                        <a class="btn btn-navbar"  data-toggle="collapse" data-target=".nav-collapse">
                            <i class="fa fa-bars"></i>
                        </a>
                        <h1 class="brand">
                            <html:link action="/home"><bean:message key="navbar.webLogo"/></html:link>
                            </h1>
                            <nav class="pull-right nav-collapse collapse">
                                <ul id="menu-main" class="nav">                                
                                    <li>
                                    <html:link action="/home" ><bean:message key="navbar.home"/></html:link>
                                    </li>
                                <c:choose>
                                    <c:when test="${empty sessionScope.blackpoints and empty cookie.blackpoints}">
                                        <li>
                                            <html:link action="login"><i class="fa fa-sign-in"></i> <bean:message key="navbar.login"/></html:link>
                                            </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li>
                                            <a href="updateinfo.do">
                                                <c:choose>
                                                    <c:when test="${not empty sessionScope.blackpoints}">
                                                        <c:set var="userStr" value="${fn:split(sessionScope.blackpoints, '~')}"/>
                                                    </c:when>
                                                    <c:otherwise>                                                        
                                                        <c:set var="userStr" value="${fn:split(cookie.blackpoints.value, '~')}"/>                                                            
                                                    </c:otherwise>
                                                </c:choose>
                                                ${userStr[2]}
                                            </a>
                                        </li>
                                        <c:if test="${userStr[3] ne 3}">
                                            <li>
                                                <a href="admin.do" title="<bean:message key="navbar.controlPanel"/>"><i class="fa fa-gear"></i> <bean:message key="navbar.controlPanel"/></a>
                                            </li>
                                        </c:if>
                                        <li>
                                            <html:link action="logout"><i class="fa fa-sign-out"></i> <bean:message key="logout" /></html:link>
                                            </li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
        <section class="enable">
            <div class="container">
                <div class="row">
                    <div class="span12">
                        <p style="margin: 0;">
                            <bean:message key="map.intro"/><br/>
                        </p>
                        <div class="offset2" style="margin-bottom: 1%;">
                            <div class="form-inline">
                                <div class="input-append">
                                    <input type="text" id="search_address" placeholder="<bean:message key='map.enterAddress'/>" 
                                           style="height: 30px; width: 300px;"/>
                                    <a class="btn btn-primary" id="search" href="#">
                                        <i class="fa fa-search"></i>
                                    </a>
                                </div>
                                <label class="controls-label" style="margin-left: 12%;"><bean:message key="map.within" /></label>
                                <select class="control-label" id="search_radius">
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
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section class="enable">
            <div id="map-canvas" style="height: 50%;"></div>
            <div id="inRadius-div">
                <div id="header"><bean:message key="map.near" /></div>
                <ul id="list"></ul>
            </div>
        </section>
        <section class="enable">
            <div class="container">
                <div class="row">
                    <div class="span12 tabs-wrapper">
                        <h2 id="inDistrict"></h2>
                        <p>
                            <c:choose>
                                <c:when test="${empty sessionScope.blackpoints and empty cookie.blackpoints}">
                                    <bean:message key="map.login" />
                                </c:when>
                                <c:otherwise>
                                    <bean:message key="map.addNewPOI" />
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <div id="tabs">
                            <ul>
                                <logic:iterate id="c" name="POIForm" property="categoryList">
                                    <li><a href="#tabs-${c.categoryID}">${c.name}</a></li>
                                    </logic:iterate>
                            </ul>
                            <logic:iterate id="c" name="POIForm" property="categoryList">
                                <div id="tabs-${c.categoryID}"></div>
                            </logic:iterate>
                        </div>
                    </div>
                </div>
        </section>
        <%@include file="../includes/footer.jsp" %>
    </body>
</html:html>