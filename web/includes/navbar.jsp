<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="navbar-wrapper">    
    <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container">
                <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                    <i class="fa fa-bars"></i>
                </a>
                <h1 class="brand"><a href="#top"><bean:message key="navbar.webLogo"/></a></h1>
                <nav class="pull-right nav-collapse collapse">
                    <ul id="menu-main" class="nav">                                
                        <li>
                            <a href="#top"><bean:message key="navbar.home"/></a>
                        </li>
                        <li>
                            <a href="#map"><bean:message key="navbar.map"/></a>                                
                        </li>
                        <c:choose>
                            <c:when test="${empty sessionScope.BPT_userName and empty cookie.BPT_userName}">
                                <li>
                                    <html:link action="login"><i class="fa fa-sign-in"></i> <bean:message key="navbar.login"/></html:link>
                                    </li>
                            </c:when>
                            <c:otherwise>
                                <li>
                                    <a href="#">
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.BPT_userName}">
                                                ${sessionScope.BPT_displayName}
                                            </c:when>
                                            <c:otherwise>
                                                <c:if test="${not empty cookie.BPT_userName}">
                                                    ${cookie.BPT_displayName.value}
                                                </c:if>
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                </li>
                                <logic:notEqual name="LoginForm" property="level" value="3">
                                    <li>
                                        <a href="#"><i class="fa fa-gear"></i> <bean:message key="navbar.controlPanel"/></a>
                                    </li>
                                </logic:notEqual>
                                <li>
                                    <html:link action="LogoutAction"><i class="fa fa-sign-out"></i> <bean:message key="logout" /></html:link>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</div>