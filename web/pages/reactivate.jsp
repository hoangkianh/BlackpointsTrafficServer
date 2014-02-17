<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
    <head>
        <title><bean:message key="reactivate.header" /> | <bean:message key="welcome.title"/></title>
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
                                            <a href="updateinfo.do">
                                                <c:choose>
                                                    <c:when test="${not empty sessionScope.blackpoints}">
                                                        <c:set var="userStr" value="${fn:split(sessionScope.blackpoints, '~')}"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:if test="${not empty cookie.blackpoints}">
                                                            <c:set var="userStr" value="${fn:split(cookie.blackpoints.value, '~')}"/>
                                                        </c:if>
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
        <div id="headerwrap">
            <header class="clearfix">
                <div class="container">
                    <div class="modal">
                        <html:form action="/ReActivateAction" method="POST" styleClass="form-horizontal my-form" styleId="reactiveForm">
                            <div class="modal-header">
                                <bean:message key="reactivate.header" />
                            </div>
                            <div class="modal-body">
                                <div class="control-group">
                                    <c:choose>
                                        <c:when test="${empty sessionScope.blackpoints and empty cookie.blackpoints}">
                                            <input type="text" id="email" name="email" placeholder="<bean:message key="reactivate.email" />" />
                                        </c:when>
                                        <c:otherwise>
                                            <html:hidden name="ReActivateAction" property="email" value="${userStr[4]}" />
                                            <input type="text" id="email" name="email" value="${userStr[4]}" disabled />
                                        </c:otherwise>
                                    </c:choose>                                    
                                    <label for="email" class="error"><html:errors property="email" /></label>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <html:link action="home" styleClass="pull-left"><i class="fa fa-arrow-circle-left"></i><bean:message key="navbar.home" /></html:link>
                                <input type="submit" class="btn btn-primary" value="<bean:message key="reactivate.btnSend" />"/>
                            </div>
                        </html:form>
                    </div>
                </div>
            </header>
        </div>
        <script type="text/javascript" src="//code.jquery.com/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
        <script type="text/javascript" src="js/jquery.validate.min.js"></script>        
        <script type="text/javascript">
            $.validator.addMethod("checkEmailExist", function(value, element) {
                var exist;
                $.ajax({
                    type: 'POST',
                    url: "service/checkExist/checkEmailExist/" + value,
                    dataType: "text",
                    async: false,
                    success: function(data) {
                        if (data === "false") {
                            exist = true;
                        } else {
                            exist = false;
                        }
                    }
                });
                return this.optional(element) || exist;
            }, "<bean:message key="errors.notExist" arg0="Email" />");

            $("#reactiveForm").validate({
                rules: {
                    email: {
                        required: true,
                        email: true,
                        checkEmailExist: true
                    }
                },
                messages: {
                    email: {
                        required: "<bean:message key="errors.required" arg0="Email" />",
                        email: "<bean:message key="errors.email" />"
                    }
                }
            });
        </script>
    </body>
</html>