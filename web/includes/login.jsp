<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${not empty sessionScope.userName or not empty cookie.userName}">
    <c:redirect url="/" />
</c:if>

<!DOCTYPE html>
<html>
    <head>
        <title><bean:message key="welcome.title"/></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="includeCSS.jsp" %>
    </head>
    <body>
        <%-- ************* **** LOGIN FORM ***************** --%>
        <div class="modal">
            <html:form action="/LoginAction" method="POST" styleClass="form-horizontal" styleId="login-form">
                <div class="modal-header">
                    <h3><i class='fa fa-sign-in'></i> <bean:message key="login.header" /></h3>
                </div>
                <div class="modal-body">
                    <div class="alert-holder">
                        <div class="alert alert-block alert-error fade in">
                            <button type="button" class="close" data-dismiss="alert">×</button>
                            <bean:write name="UserForm" property="error" filter="false" />                            
                        </div>
                    </div>
                    <div class="control-group">
                        <input type="text" name="userName" placeholder="<bean:message key="login.userName" />"
                               value="<bean:write name="UserForm" property="userName" />" />
                    </div>
                    <div class="control-group">
                        <input type="password" name="password" placeholder="<bean:message key="login.password" />"
                               value="<bean:write name="UserForm" property="password" />" />
                    </div>
                    <label class="checkbox">
                        <input type="checkbox" name="rememberMe" >
                        <bean:message key="login.remember" />
                    </label>
                    <a href="#" class="pull-right"><bean:message key="login.forgotpass"/></a>
                </div>
                <div class="modal-footer">
                    <a href="#" class="pull-left"><bean:message key="register" /></a>
                    <input type="submit" class="btn btn-primary" value="<bean:message key="login.btnLogin" />"/>
                </div>
            </html:form>
        </div>
        <script type="text/javascript" src="//code.jquery.com/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
    </body>
</html>
