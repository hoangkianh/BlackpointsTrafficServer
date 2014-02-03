<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:if test="${empty param.f}">
    <c:redirect url="/"/>
</c:if>
<!DOCTYPE html>
<html>
    <head>
        <title><bean:message key="welcome.title"/> - <bean:message key="failure.header" /></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="../includes/includeCSS.jsp" %>
    </head>
    <body>
        <div class="navbar-wrapper">
            <div class="navbar navbar-inverse navbar-static-top">
                <div class="navbar-inner">
                    <div class="container">
                        <h1 class="brand"><html:link action="/home"><bean:message key="navbar.webLogo"/></html:link></h1>
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
                                            <a href="#">
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
                                                <a href="#"><i class="fa fa-gear"></i> <bean:message key="navbar.controlPanel"/></a>
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
        <div id="headerwrap">
            <header class="clearfix">
                <div class="container">
                    <h1><i class="fa fa-exclamation-triangle fa-2x error"></i></h1>
                    <c:if test="${param.f eq 1}">
                        <h1><bean:message key="register.sendingEmailFailure"/></h1>
                        <h3><bean:message key="failure.1" /></h3>
                    </c:if>
                    <c:if test="${param.f eq 2}">
                        <h1><bean:message key="register.failure" /></h1>
                        <h3><bean:message key="failure.2" /></h3>
                    </c:if>
                    <c:if test="${param.f eq 3}">
                        <h1><bean:message key="activate.failure" /></h1>
                        <h3><bean:message key="failure.3" /></h3>
                    </c:if>
                    <c:if test="${param.f eq 4}">
                        <h1><bean:message key="reactivate.failure" /></h1>
                        <h3><bean:message key="failure.4" /></h3>
                    </c:if>
                    <c:if test="${param.f eq 5}">
                        <h1><bean:message key="forgotpass.failure" /></h1>
                        <h3><bean:message key="failure.5" /></h3>
                    </c:if>
                    <c:if test="${param.f eq 6}">
                        <h1><bean:message key="permission.failure" /></h1>
                        <h3><bean:message key="failure.6" /></h3>
                    </c:if>
                </div>
            </header>
        </div>
    </body>
</html>