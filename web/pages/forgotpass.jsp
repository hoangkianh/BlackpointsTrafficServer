<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:if test="${not empty sessionScope.blackpoints or not empty cookie.blackpoints}">
    <c:if test="${not empty sessionScope.blackpoints}">
        <c:set var="userStr" value="${fn:split(sessionScope.blackpoints, '~')}"/>        
    </c:if>
    <c:if test="${not empty cookie.blackpoints}">
        <c:set var="userStr" value="${fn:split(cookie.blackpoints.value, '%7E')}"/>
    </c:if>
    <c:choose>
        <c:when test="${userStr[3] ne 3}">
            <c:redirect url="/dashboard.do" />
        </c:when>
        <c:otherwise>
            <c:redirect url="/" />                
        </c:otherwise>
    </c:choose>
</c:if>
<!DOCTYPE html>
<html>
    <head>
        <title><bean:message key="welcome.title"/> - <bean:message key="forgotpass.header" /></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="../includes/includeCSS.jsp" %>
    </head>
    <body>
        <%@include file="../includes/navbar.jsp" %>
        <div id="headerwrap">
            <header class="clearfix">
                <div class="container">
                    <div class="modal modal-alt">
                        <html:form action="/ForgotPassAction" method="POST" styleClass="form-horizontal my-form" styleId="forgotpassForm">
                            <div class="modal-header">
                                <bean:message key="forgotpass.header" />
                            </div>
                            <div class="modal-body">
                                <div class="control-group">
                                    <input type="text" id="email" name="email" placeholder="<bean:message key="forgotpass.email" />"/>
                                    <label for="email" class="error"><html:errors property="email" /></label>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <a href="/BlackpointsTrafficServer" class="pull-left"><i class="fa fa-arrow-circle-left"></i><bean:message key="navbar.home" /></a>
                                <input type="submit" class="btn btn-primary" value="<bean:message key="forgotpass.btnSend" />"/>
                            </div>
                        </html:form>
                    </div>
                </div>
            </header>
        </div>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
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

            $("#forgotpassForm").validate({
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