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
        <title><bean:message key="welcome.title"/> - <bean:message key="login.header" /></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="../includes/includeCSS.jsp" %>
    </head>
    <body>
        <%-- ************* **** LOGIN FORM ***************** --%>
        <div class="modal">
            <html:form action="/LoginAction" method="POST" styleClass="form-horizontal my-form">
                <div class="modal-header">
                    <h3><i class='fa fa-sign-in'></i> <bean:message key="login.header" /></h3>
                </div>
                <div class="modal-body">
                    <div class="alert-holder">
                        <logic:notEmpty name="LoginForm" property="error">
                            <div class="alert alert-block alert-error fade in">
                                <button type="button" class="close" data-dismiss="alert">×</button>
                                <bean:write name="LoginForm" property="error" filter="false" />                            
                            </div>
                        </logic:notEmpty>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="userName"><bean:message key="register.userName" /></label>
                        <div class="controls">
                        <input type="text" id="userName" name="userName" placeholder="<bean:message key="login.userName" />"
                               value="<bean:write name="LoginForm" property="userName" />"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="password"><bean:message key="register.userName" /></label>
                        <div class="controls">
                        <input type="password" id="password" name="password" placeholder="<bean:message key="login.password" />" />
                        </div>
                    </div>
                    <label class="checkbox">
                        <input type="checkbox" name="rememberMe" >
                        <bean:message key="login.remember" />
                    </label>
                    <a href="#" class="pull-right"><bean:message key="login.forgotpass"/></a>
                </div>
                <div class="modal-footer">
                    <html:link action="register" styleClass="pull-left"><bean:message key="login.registerLabel" /></html:link>
                    <input type="submit" class="btn btn-primary" value="<bean:message key="login.btnLogin" />"/>
                </div>
            </html:form>
        </div>
        <script type="text/javascript" src="//code.jquery.com/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
    </body>
</html>
