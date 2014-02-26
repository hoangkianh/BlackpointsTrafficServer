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
        <%@include file="../includes/navbar-alter.jsp" %>
        <div class="modal modal-alt">
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
                            <input type="submit" class="btn btn-primary" value="<bean:message key="updateinfo.btnUpdate" />"/>
                        </html:form>
                    </div>
                    <div id="change-pass">
                        <html:form action="/ChangePassAction" method="POST" styleClass="form-horizontal my-form" styleId="changepassForm">
                            <html:hidden name="UserForm" property="userID" />
                            <div class="control-group">
                                <label class="control-label" for="oldPass">
                                    <bean:message key="updateinfo.oldPass" />
                                </label>
                                <div class="controls">
                                    <input type="password" id="oldPass" name="oldPass" placeholder="<bean:message key="updateinfo.oldPass" />" />
                                    <label for="oldPass" class="error"><html:errors property="oldPass" /></label>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="newPass">
                                    <bean:message key="updateinfo.newPass" />
                                </label>
                                <div class="controls">
                                    <input type="password" id="newPass" name="newPass" placeholder="<bean:message key="updateinfo.newPass" />" />
                                    <label for="newPass" class="error"><html:errors property="newPass" /></label>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="newPass2">
                                    <bean:message key="updateinfo.newPass2" />
                                </label>
                                <div class="controls">
                                    <input type="password" id="newPass2" name="newPass2" placeholder="<bean:message key="updateinfo.newPass2" />" />
                                    <label for="newPass2" class="error"><html:errors property="newPass2" /></label>
                                </div>
                            </div>
                            <input type="submit" class="btn btn-primary" value="<bean:message key="updateinfo.btnUpdate" />"/>
                        </html:form>
                    </div>
                </div>
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
                                $(".modal-header").append('<bean:message key="message.messageDiv"/>');
                            }
                            msg = data.trim().split("~");
                            if (msg[0] === "success") {
                                $("#messageDiv").addClass("alert-success").removeClass("alert-error");
                                $("#message").html('<bean:message key="updateinfo.success"/>');

                                $("#menu-main li:eq(2)").html('<a href="updateinfo.do">' + msg[1] + '</a>');
                            } else {
                                $("#messageDiv").addClass("alert-error").removeClass("alert-success");
                                $("#message").html('<bean:message key="updateinfo.failure"/>');
                            }
                        },
                        error: function(e) {
                            if ($("#messageDiv").length === 0) {
                                $(".modal-header").append('<bean:message key="message.messageDiv"/>');
                            }
                            $("#messageDiv").addClass("alert-error").removeClass("alert-success");
                            $("#message").html('<bean:message key="updateinfo.failure"/>');
                        }
                    });
                }
            });

            $("#changepassForm").validate({
                rules: {
                    oldPass: {
                        required: true
                    },
                    newPass: {
                        required: true,
                        maxlength: 30,
                        minlength: 6
                    },
                    newPass2: {
                        equalTo: "#newPass"
                    }
                },
                messages: {
                    oldPass: {
                        required: "<bean:message key="errors.required" arg0="Mật khẩu cũ" />"
                    },
                    newPass: {
                        required: "<bean:message key="errors.required" arg0="Mật khẩu mới" />",
                        maxlength: "<bean:message key="errors.maxlength" arg0="Mật khẩu mới" arg1="30" />",
                        minlength: "<bean:message key="errors.minlength" arg0="Mật khẩu mới" arg1="6" />"
                    },
                    newPass2: {
                        equalTo: "<bean:message key="errors.equal" arg0="Mật khẩu" arg1="mật khẩu nhập lại" />"
                    }
                },
                submitHandler: function(form) {
                    $.ajax({
                        type: "POST",
                        url: "ChangePassAction.do",
                        data: $("#changepassForm").serialize(),
                        success: function(data) {
                            if ($("#messageDiv").length === 0) {
                                $(".modal-header").append('<bean:message key="updateinfo.messageDiv"/>');
                            }

                            if (data.trim() === "success") {
                                $("#messageDiv").addClass("alert-success").removeClass("alert-error");
                                $("#message").html('<bean:message key="updateinfo.success"/>');

                                $("#oldPass").val("");
                                $("#newPass").val("");
                                $("#newPass2").val("");
                            } else {
                                $("#messageDiv").addClass("alert-error").removeClass("alert-success");
                                if (data.trim().indexOf("passNotCorrect") !== -1) {
                                    $("#message").html('<bean:message key="errors.notCorrect" arg0="Mật khẩu cũ"/>');
                                } else {
                                    $("#message").html('<bean:message key="updateinfo.failure"/>');
                                }
                            }
                        },
                        error: function(e) {
                            if ($("#messageDiv").length === 0) {
                                $(".modal-header").append('<bean:message key="message.messageDiv"/>');
                            }
                            $("#messageDiv").addClass("alert-error").removeClass("alert-success");
                            $("#message").html('<bean:message key="updateinfo.failure"/>');
                        }
                    });
                }
            });
        </script>
    </body>
</html>