<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib  uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="navbar-wrapper">
    <div class="navbar navbar-inverse navbar-static-top">
        <div class="navbar-inner">
            <div class="container">
                <a class="btn btn-navbar"  data-toggle="collapse" data-target=".nav-collapse">
                    <i class="fa fa-bars"></i>
                </a>
                <h1 class="brand">
                    <a href="/"><bean:message key="navbar.webLogo"/></a>
                    </h1>
                    <nav class="pull-right nav-collapse collapse">
                        <ul id="menu-main" class="nav">
                            <li>
                            <a href="/"><bean:message key="navbar.home"/></a>
                            </li>
                            <li>
                                <a href="map.do"><bean:message key="navbar.map"/></a>                                
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
                                                <c:set var="userStr" value="${fn:split(cookie.blackpoints.value, '%7E')}"/>                                                            
                                            </c:otherwise>
                                        </c:choose>
                                        ${userStr[2]}
                                    </a>
                                </li>
                                <li>
                                    <a href="my-poi.do">
                                        <bean:message key="navbar.mypoi"/>
                                    </a>
                                </li>
                                <c:if test="${userStr[3] ne 3}">
                                    <li>
                                        <a href="dashboard.do" title="<bean:message key="navbar.controlPanel"/>"><i class="fa fa-gear"></i> <bean:message key="navbar.controlPanel"/></a>
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