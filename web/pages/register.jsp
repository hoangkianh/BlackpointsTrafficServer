<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${not empty sessionScope.BPT_userName or not empty cookie.BPT_userName}">
    <logic:notEqual name="LoginForm" property="level" value="3">
        <c:redirect url="/admin.do" />
    </logic:notEqual>
    <logic:equal name="LoginForm" property="level" value="3">
        <c:redirect url="/" />
    </logic:equal>
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
                        <logic:notEmpty name="RegisterForm" property="error">
                            <div class="alert alert-block alert-error fade in">
                                <button type="button" class="close" data-dismiss="alert">×</button>
                                <bean:write name="RegisterForm" property="error" filter="false" />                            
                            </div>
                        </logic:notEmpty>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="userName">
                            <bean:message key="register.userName" />
                            <span class="asterisk">*</span>
                        </label>
                        <div class="controls">
                            <input type="text" id="userName" name="userName" placeholder="<bean:message key="register.userName" />"
                                   value="<bean:write name="RegisterForm" property="userName" />" />
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
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="password2">
                            <bean:message key="register.password2" />
                            <span class="asterisk">*</span>
                        </label>
                        <div class="controls">
                            <input type="password" id="password2" name="password2" placeholder="<bean:message key="register.password2" />"
                                   value="<bean:write name="RegisterForm" property="password" />" />
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="description"><bean:message key="register.description" /></label>
                        <div class="controls">
                            <textarea id="description" name="description" placeholder="<bean:message key="register.description" />"><bean:write name="RegisterForm" property="description" /></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <html:link action="login" styleClass="pull-left"><bean:message key="register.loginLabel" /></html:link>
                    <input type="submit" class="btn btn-primary" value="<bean:message key="register.btnRegister" />"/>
                    <input type="reset" class="btn" value="<bean:message key="register.btnReset" />"/>
                </div>
            </html:form>
        </div>
        <script type="text/javascript" src="//code.jquery.com/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
        <script type="text/javascript" src="js/jquery.validate.min.js"></script>        
        <script type="text/javascript">
            $.validator.addMethod("userNameRegex", function(value, element, regex) {
                return this.optional(element) || regex.test(value);
            }, "<bean:message key="register.regexValidation" arg0="Tên đăng nhập" />");

            $("#registerForm").validate({
                rules: {
                    userName: {
                        required: true,
                        maxlength: 30,
                        minlength: 6,
                        userNameRegex: /^[a-zA-Z0-9_]*$/,
                        remote: "CheckUserExistAction.do"
                    },
                    displayName: {
                        required: true,
                        maxlength: 30,
                        minlength: 6
                    },
                    email: {
                        required: true,
                        email: true,
                        remote: "CheckEmailExistAction.do"
                    },
                    password: {
                        required: true,
                        maxlength: 30,
                        minlength: 6
                    },
                    password2: {
                        equalTo: "#password"
                    }
                },
                messages: {
                    userName: {
                        required: "<bean:message key="errors.required" arg0="Tên đăng nhập" />",
                        maxlength: "<bean:message key="errors.maxlength" arg0="Tên đăng nhập" arg1="30" />",
                        minlength: "<bean:message key="errors.minlength" arg0="Tên đăng nhập" arg1="6" />",
                        remote: "<bean:message key="errors.isExist" arg0="Tên đăng nhập" />"
                    },
                    displayName: {
                        required: "<bean:message key="errors.required" arg0="Tên hiển thị" />",
                        maxlength: "<bean:message key="errors.maxlength" arg0="Tên hiển thị" arg1="30" />",
                        minlength: "<bean:message key="errors.minlength" arg0="Tên hiển thị" arg1="6" />"
                    },
                    email: {
                        required: "<bean:message key="errors.required" arg0="Email" />",
                        email: "<bean:message key="errors.email" />",
                        remote: "<bean:message key="errors.isExist" arg0="Email" />"
                    },
                    password: {
                        required: "<bean:message key="errors.required" arg0="Mật khẩu" />",
                        maxlength: "<bean:message key="errors.maxlength" arg0="Mật khẩu" arg1="30" />",
                        minlength: "<bean:message key="errors.minlength" arg0="Mật khẩu" arg1="6" />"
                    },
                    password2: {
                        equalTo: "<bean:message key="errors.equal" arg0="Mật khẩu" arg1="mật khẩu nhập lại" />"
                    }
                }
            });
        </script>
    </body>
</html>
