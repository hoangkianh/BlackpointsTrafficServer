<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title><bean:message key="welcome.title"/> - <bean:message key="register.header" /></title>
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
                                <li><html:link action="/home" ><bean:message key="navbar.home"/></html:link></li>
                                <li>
                                <html:link action="login"><i class="fa fa-sign-in"></i> <bean:message key="navbar.login"/></html:link>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
        <div id="headerwrap">
            <header class="clearfix">
                <div class="container">
                    <h1><i class="fa fa-check fa-2x valid"></i></h1>
                    <c:if test="${param.s eq 1}">
                        <h1><bean:message key="register.success" /></h1>
                        <h3><bean:message key="success.1" /></h3>
                    </c:if>
                    <c:if test="${param.s eq 2}">
                        <h1><bean:message key="activate.success" /></h1>
                        <h3><bean:message key="success.2" /></h3>
                    </c:if>
                </div>
            </header>
        </div>
    </body>
</html>
