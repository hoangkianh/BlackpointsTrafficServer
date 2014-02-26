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
        <c:set var="userStr" value="${fn:split(cookie.blackpoints.value, '~')}"/>
    </c:if>
    <c:choose>
        <c:when test="${userStr[3] eq 3}">
            <jsp:forward page="/failure.do">
                <jsp:param name="f" value="6" />
            </jsp:forward>
        </c:when>
    </c:choose>
</c:if>

<!DOCTYPE html>
<html>
    <head>
        <title><bean:message key="admin.title.usergroup" /> | <bean:message key="admin.usergroup.new.title" /></title>
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
                            <h3><bean:message key="admin.usergroup.new.caption" /></h3>
                            <html:form styleId="userGroupForm" method="POST" action="/AddNewUserGroupAction" styleClass="form-horizontal my-form">
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
                                <a href="usergroup.do" title="<bean:message key="admin.usergroup.form.back"/>"><bean:message key="admin.usergroup.form.back"/></a>
                                <input type="reset" id="reset" class="btn pull-right" value="<bean:message key="admin.usergroup.form.reset"/>" />
                                <input id="step4" type="submit" class="btn btn-primary pull-right" value="<bean:message key="admin.usergroup.new.submit"/>" />
                            </html:form>
                            <div id="loading"></div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <script type="text/javascript" src="//code.jquery.com/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
        <script type="text/javascript" src="js/jquery.validate.min.js"></script>
        <script type="text/javascript">
            $(function() {
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
                        $("#userGroupForm").fadeOut();
                        $('#loading').html('<img src="img/loading.GIF">' + '<bean:message key="admin.loading"/>');
                        $.ajax({
                            type: "POST",
                            url: "AddNewUserGroupAction.do",
                            data: $("#userGroupForm").serialize(),
                            success: function(data) {
                                setTimeout(function() {
                                    if (data.trim() === "success") {
                                        $('#loading').html('<p><i class="fa fa-check"></i> ' + '<bean:message key="admin.usergroup.new.success"/>' + '</p>');
                                    } else {
                                        $('#loading').html('<p class="error">' + '<bean:message key="admin.usergroup.new.failure"/>' + '</p>');
                                    }
                                }, 2000);
                            },
                            error: function(e) {
                                setTimeout(function() {
                                    $('#loading').html('<p class="error">' + '<bean:message key="admin.usergroup.new.failure"/>' + '</p>');
                                }, 2000);
                            }
                        });
                        // redirect
                        setTimeout(function() {
                            window.location.href = "usergroup.do";
                        }, 3000);
                    }
                });
            });
        </script>
    </body>
</html>