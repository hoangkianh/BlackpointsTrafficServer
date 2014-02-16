<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:if test="${empty sessionScope.blackpoints and empty cookie.blackpoints}">
    <c:redirect url="/login.do" />
</c:if>

<!DOCTYPE html>
<html>
    <head>
        <title><bean:message key="updateinfo.header" /> | <bean:message key="welcome.title"/></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="../includes/includeCSS.jsp" %>
    </head>
    <body>
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
        <div class="modal">
            <div class="modal-header">
                <h3>
                    <bean:message key="updateinfo.header" /> - <bean:write name="UserForm" property="userName" />
                    <logic:equal name="UserForm" property="activated" value="true">
                        <i class="fa fa-check-circle" title="<bean:message key="updateinfo.activated"/>"></i>
                    </logic:equal>
                </h3>
                <logic:equal name="UserForm" property="activated" value="false">
                    <div style="font-size:12px; color:#888;">
                        <bean:message key="updateinfo.notActivated"/>. 
                        <span><a href="reactivate.do" title="<bean:message key="updateinfo.clickToActivate"/>"><bean:message key="updateinfo.clickToActivate"/></a></span>
                    </div>
                </logic:equal>
                <span class="muted"><i class="fa fa-clock-o"></i> <bean:message key="updateinfo.joinedon" /> <bean:write name="UserForm" property="createdOnDate" /></span>
            </div>
            <div class="modal-body">
                <div class="alert-holder">
                    <div class="alert alert-block alert-holder fade in">
                        <bean:message key="warning.javascript"/>
                    </div>
                </div>
                <div id="tabs">
                    <ul>
                        <li><a href="#info"><bean:message key="updateinfo.infomation" /></a></li>
                        <li><a href="#change-pass"><bean:message key="updateinfo.changepassword" /></a></li>
                    </ul>
                    <div id="info">
                        <html:form action="/UpdateInfoAction" method="POST" styleClass="form-horizontal my-form" styleId="infoForm">
                            <div class="control-group">
                                <label class="control-label" for="displayName">
                                    <bean:message key="updateinfo.displayName" />
                                </label>
                                <div class="controls">
                                    <input type="text" id="displayName" name="displayName" placeholder="<bean:message key="updateinfo.displayName" />"
                                           value="<bean:write name="UserForm" property="displayName" />" />
                                    <label for="displayName" class="error"><html:errors property="displayName" /></label>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="description"><bean:message key="updateinfo.description" /></label>
                                <div class="controls">
                                    <textarea id="description" name="description" placeholder="<bean:message key="updateinfo.description" />"><bean:write name="UserForm" property="description" /></textarea>
                                    <label for="description" class="error"><html:errors property="description" /></label>
                                </div>
                            </div>
                            <input type="submit" class="btn btn-primary" value="<bean:message key="updateinfo.btnRegister" />"/>
                        </html:form>
                    </div>
                    <div id="change-pass"></div>
                </div>
            </div>
            <div class="modal-footer">

            </div>
        </div>
        <script type="text/javascript" src="//code.jquery.com/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="//code.jquery.com/ui/1.10.0/jquery-ui.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
        <script type="text/javascript" src="js/jquery.validate.min.js"></script>        
        <script type="text/javascript">
            $("#tabs").tabs();
            $(".alert-holder").remove();

            $("#infoForm").validate({
                rules: {
                    displayName: {
                        required: true,
                        maxlength: 30,
                        minlength: 6
                    },
                    description: {
                        maxlength: 200
                    }
                },
                messages: {
                    displayName: {
                        required: "<bean:message key="errors.required" arg0="Tên hiển thị" />",
                        maxlength: "<bean:message key="errors.maxlength" arg0="Tên hiển thị" arg1="30" />",
                        minlength: "<bean:message key="errors.minlength" arg0="Tên hiển thị" arg1="6" />"
                    },
                    description: {
                        maxlength: "<bean:message key="errors.maxlength" arg0="Thông tin thêm" arg1="200" />"
                    }
                },
                submitHandler: function(form) {
                    $.ajax({
                        type: "POST",
                        url: "UpdateInfoAction.do",
                        data: $("#infoForm").serialize(),
                        success: function(data) {
                            if ($("#messageDiv").length === 0) {
                                $(".modal-header").append('<bean:message key="updateinfo.messageDiv"/>');
                            }
                            msg = data.trim().split("~");
                            if (msg[0] === "success") {
                                $("#messageDiv").addClass("alert-success")
                                $("#message").html('<bean:message key="updateinfo.success"/>');
                                
                                $("#menu-main li:eq(1)").html('<a href="updateinfo.do">' + msg[1] + '</a>');
                            } else {
                                $("#messageDiv").addClass("alert-error")
                                $("#message").html('<bean:message key="updateinfo.error"/>');
                            }
                        }
                    });
                }
            });
        </script>
    </body>
</html>