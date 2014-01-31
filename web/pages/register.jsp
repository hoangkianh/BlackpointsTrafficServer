<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:if test="${not empty sessionScope.blackpoints or not empty cookie.blackpoints}">
    <c:if test="${not empty sessionScope.blackpoints}">
        <c:set var="userStr" value="${fn:split(sessionScope.blackpoints, '~')}"/>        
    </c:if>
    <c:if test="${not empty cookie.blackpoints}">
        <c:set var="userStr" value="${fn:split(cookie.blackpoints.value, '~')}"/>
    </c:if>
    <c:choose>
            <c:when test="${userStr[3] ne 3}">
                <c:redirect url="/admin.do" />                
            </c:when>
            <c:otherwise>
                <c:redirect url="/" />                
            </c:otherwise>
    </c:choose>
</c:if>

<!DOCTYPE html>
<html>
    <head>
        <title><bean:message key="welcome.title"/> - <bean:message key="register.header" /></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="../includes/includeCSS.jsp" %>
    </head>
    <body>
        <%-- ***************** REGISTER FORM ***************** --%>
        <div class="modal">
            <html:form action="/RegisterAction" method="POST" styleClass="form-horizontal my-form" styleId="registerForm">
                <div class="modal-header">
                    <h3><i class='fa fa-check'></i> <bean:message key="register.header" /></h3>
                </div>
                <div class="modal-body">
                    <div class="alert-holder">
                        <div class="alert alert-block alert-holder fade in">
                            <bean:message key="warning.javascript"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="userName">
                            <bean:message key="register.userName" />
                            <span class="asterisk">*</span>
                        </label>
                        <div class="controls">
                            <input type="text" id="userName" name="userName" placeholder="<bean:message key="register.userName" />"
                                   value="<bean:write name="RegisterForm" property="userName" />" />
<!--                                   value="<bean:write name="RegisterForm" property="userName" />" onkeyup="checkUserExist()" />-->
                            <label for="userName" class="error"><html:errors property="userName" /></label>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="displayName">
                            <bean:message key="register.displayName" />
                            <span class="asterisk">*</span>
                        </label>
                        <div class="controls">
                            <input type="text" id="displayName" name="displayName" placeholder="<bean:message key="register.displayName" />"
                                   value="<bean:write name="RegisterForm" property="displayName" />" />
                            <label for="displayName" class="error"><html:errors property="displayName" /></label>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="email">
                            <bean:message key="register.email" />
                            <span class="asterisk">*</span>
                        </label>
                        <div class="controls">
                            <input type="text" id="email" name="email" placeholder="<bean:message key="register.email" />"
                                   value="<bean:write name="RegisterForm" property="email" />" />
                            <label for="email" class="error"><html:errors property="email" /></label>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="password">
                            <bean:message key="register.password" />
                            <span class="asterisk">*</span>
                        </label>
                        <div class="controls">
                            <input type="password" id="password" name="password" placeholder="<bean:message key="register.password" />"
                                   value="<bean:write name="RegisterForm" property="password" />" />
                            <label for="password" class="error"><html:errors property="password" /></label>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="password2">
                            <bean:message key="register.password2" />
                            <span class="asterisk">*</span>
                        </label>
                        <div class="controls">
                            <input type="password" id="password2" name="password2" placeholder="<bean:message key="register.password2" />"
                                   value="<bean:write name="RegisterForm" property="password2" />" />
                            <label for="password2" class="error"><html:errors property="password2" /></label>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="description"><bean:message key="register.description" /></label>
                        <div class="controls">
                            <textarea id="description" name="description" placeholder="<bean:message key="register.description" />"><bean:write name="RegisterForm" property="description" /></textarea>
                            <label for="description" class="error"><html:errors property="description" /></label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <html:link action="login" styleClass="pull-left"><bean:message key="register.loginLabel" /></html:link><br/><br/>
                    <html:link action="home" styleClass="pull-left"><i class="fa fa-arrow-circle-left"></i><bean:message key="navbar.home" /></html:link>
                    <input type="submit" class="btn btn-primary" value="<bean:message key="register.btnRegister" />"/>
                    <input type="reset" class="btn" value="<bean:message key="register.btnReset" />"/>
                </div>
            </html:form>
        </div>
        <script type="text/javascript" src="//code.jquery.com/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
        <script type="text/javascript" src="js/jquery.validate.min.js"></script>        
        <script type="text/javascript">
            $(".alert-holder").remove();

            $.validator.addMethod("userNameRegex", function(value, element, regex) {
                return this.optional(element) || regex.test(value);
            }, "<bean:message key="errors.userName" />");

            $.validator.addMethod("checkUserExist", function(value, element) {
                var exist;
                $.ajax({
                    type: 'POST',
                    url: "service/checkExist/checkUserExist/" + value,
                    dataType: "text",
                    async: false,
                    success: function(data) {
                        if (data === "true") {
                            exist = true;
                        } else {
                            exist = false;
                        }
                    }
                });
                return this.optional(element) || exist;
            }, "<bean:message key="errors.isExist" arg0="Tên đăng nhập" />");
            
            $.validator.addMethod("checkEmailExist", function(value, element) {
                var exist;
                $.ajax({
                    type: 'POST',
                    url: "service/checkExist/checkEmailExist/" + value,
                    dataType: "text",
                    async: false,
                    success: function(data) {
                        if (data === "true") {
                            exist = true;
                        } else {
                            exist = false;
                        }
                    }
                });
                return this.optional(element) || exist;
            }, "<bean:message key="errors.isExist" arg0="Email" />");

            $("#registerForm").validate({
                errorClass: "error",
                validClass: "valid",
                highlight: function(element, errorClass, validClass) {
                    $(element).addClass(errorClass);
                    $(element).parent().find("label[for=" + element.id + "]")
                            .removeClass(validClass)
                            .addClass(errorClass)
                            .css("display", "block");
                },
                unhighlight: function(element, errorClass, validClass) {
                    $(element).removeClass(errorClass);
                    $(element).parent().find("label[for=" + element.id + "]")
                            .removeClass(errorClass)
                            .addClass(validClass)
                            .html("<i class='fa fa-check valid'></i>")
                            .css("display", "block");
                },
                rules: {
                    userName: {
                        required: true,
                        maxlength: 30,
                        minlength: 6,
                        userNameRegex: /^[a-zA-Z0-9_]*$/,
                        checkUserExist: true
                    },
                    displayName: {
                        required: true,
                        maxlength: 30,
                        minlength: 6
                    },
                    email: {
                        required: true,
                        email: true,
                        checkEmailExist: true
                    },
                    password: {
                        required: true,
                        maxlength: 30,
                        minlength: 6
                    },
                    password2: {
                        equalTo: "#password"
                    },
                    description: {
                        maxlength: 200
                    }
                },
                messages: {
                    userName: {
                        required: "<bean:message key="errors.required" arg0="Tên đăng nhập" />",
                        maxlength: "<bean:message key="errors.maxlength" arg0="Tên đăng nhập" arg1="30" />",
                        minlength: "<bean:message key="errors.minlength" arg0="Tên đăng nhập" arg1="6" />"
                    },
                    displayName: {
                        required: "<bean:message key="errors.required" arg0="Tên hiển thị" />",
                        maxlength: "<bean:message key="errors.maxlength" arg0="Tên hiển thị" arg1="30" />",
                        minlength: "<bean:message key="errors.minlength" arg0="Tên hiển thị" arg1="6" />"
                    },
                    email: {
                        required: "<bean:message key="errors.required" arg0="Email" />",
                        email: "<bean:message key="errors.email" />"
                    },
                    password: {
                        required: "<bean:message key="errors.required" arg0="Mật khẩu" />",
                        maxlength: "<bean:message key="errors.maxlength" arg0="Mật khẩu" arg1="30" />",
                        minlength: "<bean:message key="errors.minlength" arg0="Mật khẩu" arg1="6" />"
                    },
                    password2: {
                        equalTo: "<bean:message key="errors.equal" arg0="Mật khẩu" arg1="mật khẩu nhập lại" />"
                    },
                    description: {
                        maxlength: "<bean:message key="errors.maxlength" arg0="Thông tin thêm" arg1="200" />"
                    }
                }
            });
        </script>
    </body>
</html>
