<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:if test="${empty sessionScope.blackpoints and empty cookie.blackpoints}">
    <c:redirect url="/login.do" />
</c:if>
<c:if test="${not empty sessionScope.blackpoints or not empty cookie.blackpoints}">
    <c:if test="${not empty sessionScope.blackpoints}">
        <c:set var="userStr" value="${fn:split(sessionScope.blackpoints, '~')}"/>        
    </c:if>
    <c:if test="${not empty cookie.blackpoints}">
        <c:set var="userStr" value="${fn:split(cookie.blackpoints.value, '%7E')}"/>
    </c:if>
    <c:choose>
        <c:when test="${userStr[3] ne 1}">
            <jsp:forward page="/failure.do">
                <jsp:param name="f" value="6" />
            </jsp:forward>
        </c:when>
    </c:choose>
</c:if>

<!DOCTYPE html>
<html>
    <head>
        <title><bean:message key="admin.title.usergroup" /> | <bean:message key="admin.usergroup.edit.title" /></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="../includes/includeCSS.jsp" %>
    </head>
    <body>
        <%@include file="../includes/navbar-alter.jsp" %>
        <%@include  file="../includes/navbar-admin-alter.jsp" %>
        <section>
            <div class="container">
                <div class="row-fluid">
                    <div class="span12 form-admin border-red">
                        <div class="span8 offset2">
                            <div class="alert-holder">
                                <div class="alert alert-block alert-holder fade in">
                                    <bean:message key="warning.javascript"/>
                                </div>
                            </div>
                            <div class="message-holder"></div>
                            <h3><bean:message key="admin.usergroup.edit.caption" /></h3>
                            <html:form styleId="userGroupForm" method="POST" action="/UpdateUserGroupAction" styleClass="form-horizontal my-form">
                                <html:hidden name="UserGroupForm" property="userGroupID"/>
                                <div class="control-group">
                                    <label class="control-label" for="name">
                                        <bean:message key="admin.usergroup.form.name" />
                                        <span class="asterisk">*</span>
                                    </label>
                                    <div class="controls">
                                        <input type="text" id="name" name="name" placeholder="<bean:message key="admin.usergroup.form.name" />"
                                               value="<bean:write name="UserGroupForm" property="name" />"/>
                                        <label for="name" class="error"><html:errors property="name" /></label>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="level">
                                        <bean:message key="admin.usergroup.form.level" />
                                        <span class="asterisk">*</span>
                                    </label>
                                    <div class="controls">
                                        <html:select styleId="level" name="UserGroupForm" property="level">
                                            <html:option value="0"><bean:message key="admin.usergroup.form.selectLevel"/></html:option>
                                            <html:option value="1"><bean:message key="admin.usergroup.form.level1"/></html:option>
                                            <html:option value="2"><bean:message key="admin.usergroup.form.level2"/></html:option>
                                            <html:option value="3"><bean:message key="admin.usergroup.form.level3"/></html:option>
                                        </html:select>
                                        <label for="level" class="error"><html:errors property="level" /></label>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="description"><bean:message key="admin.usergroup.form.description"/></label>
                                    <div class="controls">
                                        <textarea id="description" name="description" placeholder="<bean:message key="admin.usergroup.form.description" />"><bean:write name="UserGroupForm" property="description" /></textarea>
                                        <label for="description" class="error"><html:errors property="description" /></label>
                                    </div>
                                </div>
                                <a href="usergroup.do" rel="tooltip" data-toggle="tooltip" data-placement="top" title="<bean:message key="admin.usergroup.form.back"/>"><bean:message key="admin.usergroup.form.back"/></a>
                                <input type="reset" id="reset" class="btn pull-right" value="<bean:message key="admin.usergroup.form.reset"/>" />
                                <input type="submit" class="btn btn-primary pull-right" value="<bean:message key="admin.usergroup.edit.submit"/>" />
                            </html:form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
        <script type="text/javascript" src="js/jquery.validate.min.js"></script>
        <script type="text/javascript">
            $(function() {
                $('[rel=tooltip]').tooltip();
                $(".alert-holder").remove();

                $.validator.addMethod("checkSelectLevel", function(value, element) {
                    return this.optional(element) || value !== "0";
                }, "<bean:message key="errors.select" arg0="level cho nhóm" />");

                $("#userGroupForm").validate({
                    errorClass: "error",
                    rules: {
                        name: {
                            required: true,
                            minlength: 4,
                            maxlength: 30
                        },
                        level: {
                            checkSelectLevel: true
                        },
                        description: {
                            maxlength: 200
                        }
                    },
                    messages: {
                        name: {
                            required: "<bean:message key="errors.required" arg0="Tên nhóm" />",
                            minlength: "<bean:message key="errors.minlength" arg0="Tên nhóm" arg1="4" />",
                            maxlength: "<bean:message key="errors.maxlength" arg0="Tên nhóm" arg1="30" />"
                        },
                        level: {
                            checkSelectLevel: "<bean:message key="errors.required" arg0="Level" />"
                        },
                        description: {
                            maxlength: "<bean:message key="errors.maxlength" arg0="Thông tin thêm" arg1="200" />"
                        }
                    },
                    submitHandler: function(form) {
                        $.ajax({
                            type: "POST",
                            url: "UpdateUserGroupAction.do",
                            data: $("#userGroupForm").serialize(),
                            success: function(data) {
                                if ($("#messageDiv").length === 0) {
                                    $(".message-holder").append('<bean:message key="message.messageDiv"/>');
                                }
                                if (data.trim() === "success") {
                                    $("#messageDiv").addClass("alert-success").removeClass("alert-error");
                                    $("#message").html('<bean:message key="admin.usergroup.edit.success"/>');
                                } else {
                                    $("#messageDiv").addClass("alert-error").removeClass("alert-success");
                                    $("#message").html('<bean:message key="admin.usergroup.edit.failure"/>');
                                }
                            },
                            error: function(e) {
                                if ($("#messageDiv").length === 0) {
                                    $(".message-holder").append('<bean:message key="message.messageDiv"/>');
                                }
                                $("#messageDiv").addClass("alert-error").removeClass("alert-success");
                                    $("#message").html('<bean:message key="admin.usergroup.edit.failure"/>');
                            }
                        });
                    }
                });
            });
        </script>
    </body>
</html>