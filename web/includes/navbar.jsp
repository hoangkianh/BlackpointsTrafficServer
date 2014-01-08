<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="navbar-wrapper">
    <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container">
                <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
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