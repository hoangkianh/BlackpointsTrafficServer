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
        <title><bean:message key="admin.title.useradmin" /></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="../includes/includeCSS.jsp" %>
        <script type="text/javascript" src="//code.jquery.com/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
        <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="js/jquery.dataTables.extend.js"></script>
        <script type="text/javascript">
            var oTable;
            $(function() {
                $('[rel=tooltip]').tooltip();
                oTable = $('#myTable').dataTable({
                    "bProcessing": true,
                    "aaSorting": [[5, 'asc']],
                    "sDom": "<'row-fluid'<'span3'l><'span5'f>r>t<'row-fluid'<'span3'i><'span9'p>>",
                    "sPaginationType": "bootstrap",
                    "aoColumnDefs": [{'bSortable': false, 'bSearchable': false, 'aTargets': ["sorting_disabled"]}],
                    "oLanguage": {
                        "sProcessing": "<bean:message key='admin.table.processing'/>",
                        "sLengthMenu": "<bean:message key='admin.table.show' /> _MENU_ <bean:message key='admin.table.admin'/>",
                                        "sZeroRecords": "<bean:message key='admin.table.zeroRecords'/>",
                                        "sInfo": "_START_ <bean:message key='admin.table.to'/> _END_ <bean:message key='admin.table.of'/> _TOTAL_ <bean:message key='admin.table.user'/>",
                                        "sInfoEmpty": "0 <bean:message key='admin.table.to'/> 0 <bean:message key='admin.table.of'/> 0 <bean:message key='admin.table.blackpoints'/>",
                                        "sInfoFiltered": "(<bean:message key='admin.table.filtered'/> <bean:message key='admin.table.from'/> _MAX_  <bean:message key='admin.table.user'/>)",
                                        "sInfoPostFix": "",
                                        "sSearch": "<bean:message key='admin.table.search'/>",
                                        "sUrl": "",
                                        "oPaginate": {
                                            "sFirst": "<bean:message key='admin.table.first'/>",
                                            "sPrevious": "<bean:message key='admin.table.pre'/>",
                                            "sNext": "<bean:message key='admin.table.next'/>",
                                            "sLast": "<bean:message key='admin.table.last'/>"
                                        }
                                    }
                                });
                            });
        </script>
    </head>
    <body>
        <div id="update-confirm" class="modal fade hide">
            <html:form styleId="updateForm" method="POST" action="/UpdateAminAction" styleClass="form-horizontal my-form">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h3><bean:message key="admin.useradmin.update.h3" /></h3>
                </div>
                <div class="modal-body">
                    <html:hidden styleId="userID" name="UserForm" property="userID"/>
                    <div class="alert alert-holder">
                        <span><bean:message key="admin.useradmin.update.warning" /></span>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="userGroup">
                            <bean:message key="admin.useradmin.update.usergroup" />
                        </label>
                        <div class="controls">
                            <html:select styleId="userGroup" name="UserForm" property="groupID">
                                <html:option value="0"><bean:message key="admin.useradmin.update.select"/></html:option>
                                <logic:iterate id="g" name="UserForm" property="adminGroup">
                                    <option value="<bean:write name="g" property="userGroupID"/>"><bean:write name="g" property="name"/> </option>
                                </logic:iterate>
                            </html:select>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="name">
                            <bean:message key="admin.useradmin.update.password" />
                            <span class="asterisk">*</span>
                        </label>
                        <div class="controls">
                            <input type="password" id="password" name="password" placeholder="<bean:message key="admin.useradmin.update.password" />"/>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <input id="step4" type="submit" class="btn btn-primary pull-right" value="<bean:message key="admin.useradmin.update.update" />" />
                </div>
            </html:form>
        </div>
        <div id="remove-admin-confirm" class="modal fade hide">
            <html:form styleId="removeAdminForm" method="POST" action="/RemoveAdminAction" styleClass="form-horizontal my-form">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h3><bean:message key="admin.useradmin.delete.h3" /></h3>
                </div>
                <div class="modal-body">
                    <html:hidden styleId="userID" name="UserForm" property="userID"/>
                    <div class="alert alert-holder">
                        <span><bean:message key="admin.useradmin.delete.warning" /></span>
                    </div>
                    <ul>
                        <li><bean:message key="admin.useradmin.delete.warningMSG1" /></li>
                        <li><bean:message key="admin.useradmin.delete.warningMSG2" /></li>
                    </ul>
                    <div class="control-group">
                        <label class="control-label" for="userGroup">
                            <bean:message key="admin.useradmin.delete.usergroup" />
                        </label>
                        <div class="controls">
                            <html:select styleId="userGroup" name="UserForm" property="groupID">
                                <html:option value="0"><bean:message key="admin.useradmin.delete.select"/></html:option>
                                <logic:iterate id="g" name="UserForm" property="normalUserGroup">
                                    <option value="<bean:write name="g" property="userGroupID"/>"><bean:write name="g" property="name"/> </option>
                                </logic:iterate>
                            </html:select>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="name">
                            <bean:message key="admin.useradmin.delete.password" />
                            <span class="asterisk">*</span>
                        </label>
                        <div class="controls">
                            <input type="password" id="password" name="password" placeholder="<bean:message key="admin.useradmin.delete.password" />"/>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <input id="step4" type="submit" class="btn btn-primary pull-right" value="<bean:message key="admin.useradmin.delete.remove" />" />
                </div>
            </html:form>
        </div>
        <%@include file="../includes/navbar-alter.jsp" %>
        <%@include  file="../includes/navbar-admin-alter.jsp" %>
        <section>
            <div class="container">
                <div class="row-fluid">
                    <div class="span12 table-list border-red">
                        <c:if test="${userStr[3] eq 1}">
                            <a href="newadmin.do" class="btn btn-primary"><bean:message key="admin.useradmin.list.addNewAdmin"/></a>
                        </c:if>
                        <table id="myTable" class="table table-striped table-bordered table-hover table-condensed">
                            <caption><bean:message key="admin.useradmin.list.caption"/></caption>
                            <thead>
                                <tr>
                                    <th class="sorting_disabled"></th>
                                    <th class="sorting_disabled"></th>
                                    <th><bean:message key="admin.user.list.username"/></th>
                                    <th><bean:message key="admin.usergroup.list.level"/></th>
                                    <th><bean:message key="admin.usergroup.list.groupName" /></th>
                                    <th><bean:message key="admin.user.list.displayname"/></th>
                                    <th><bean:message key="admin.user.list.email"/></th>
                                    <th><bean:message key="admin.user.list.description"/></th>
                                    <th><bean:message key="admin.user.list.lastLogin"/></th>
                                    <th><bean:message key="admin.user.list.registerDate"/></th>
                                    <th><bean:message key="admin.user.list.updatedDate"/></th>
                                </tr>
                            </thead>
                            <tbody>
                                <logic:iterate id="row" name="UserForm" property="userList">                                    
                                    <tr>
                                        <td class="center">
                                            <c:choose>
                                                <c:when test="${(userStr[3] ne 1) or (userStr[0] eq row.userID) or (row.userID eq 1)}">
                                                    <i class="fa fa-pencil muted" rel="tooltip" data-toggle="tooltip" data-placement="top" title="<bean:message key="admin.table.editDisable"/>"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="#update-confirm" class="update" id="<bean:write name="row" property="userID"/>">
                                                        <i class="fa fa-pencil" rel="tooltip" data-toggle="tooltip" data-placement="top" title="<bean:message key="admin.table.edit"/>"></i>
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="center delete">
                                            <c:choose>
                                                <c:when test="${(userStr[3] ne 1) or (userStr[0] eq row.userID) or (row.userID eq 1)}">
                                                    <i class="fa fa-times muted" rel="tooltip" data-toggle="tooltip" data-placement="top" title="<bean:message key="admin.table.removeAdminDisable"/>"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="#remove-admin-confirm" class="delete">
                                                        <i class="fa fa-times" rel="tooltip" data-toggle="tooltip" data-placement="top" title="<bean:message key="admin.table.removeAdmin"/>"></i>
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><bean:write name="row" property="userName"/></td>
                                        <td><bean:write name="row" property="level"/></td>
                                        <td>
                                            <html:link action="group.do" paramId="id" paramName="row" paramProperty="groupID">
                                                <bean:write name="row" property="groupName"/>
                                            </html:link>
                                        </td>
                                        <td><bean:write name="row" property="displayName"/></td>
                                        <td><bean:write name="row" property="email"/></td>
                                        <td><bean:write name="row" property="description"/></td>
                                        <td><bean:write name="row" property="lastLogin"/></td>
                                        <td><bean:write name="row" property="createdOnDate"/></td>
                                        <td><bean:write name="row" property="updatedOnDate"/></td>
                                    </tr>
                                </logic:iterate>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>
        <script type="text/javascript">
            $(function() {
                $('.update').click(function() {
                    // remove messageDiv
                    $('#messageDiv').remove();
                    // reset password input
                    $('#password').val('');
                    // reset select box
                    $('#userGroup').val('0');
                    $('#update-confirm').modal();

                    var id = $(this).attr('id');
                    $("#userID").val(id);
                    return false;
                });

                $('#updateForm').submit(function(event) {
                    $.ajax({
                        type: "POST",
                        url: "UpdateAminAction.do",
                        data: $("#updateForm").serialize(),
                        success: function(data) {
                            if ($("#messageDiv").length === 0) {
                                $("#updateForm .modal-header").append('<bean:message key="message.messageDiv"/>');
                            }
                            switch (data.trim())
                            {
                                case "success":
                                    $("#messageDiv").addClass("alert-success").removeClass("alert-error");
                                    $("#message").html('<bean:message key="admin.usergroup.update.success"/>');
                                    // redirect
                                    setTimeout(function() {
                                        window.location.href = "admin.do";
                                    }, 1000);
                                    break;
                                case "notSelectGroup":
                                    $("#messageDiv").addClass("alert-error").removeClass("alert-success");
                                    $("#message").html('<bean:message key="admin.usergroup.update.notSelectGroup"/>');
                                    break;
                                case "passwordNotCorrect":
                                    $("#messageDiv").addClass("alert-error").removeClass("alert-success");
                                    $("#message").html('<bean:message key="admin.usergroup.update.passwordNotCorrect"/>');
                                    break;
                                default:
                                    $("#messageDiv").addClass("alert-error").removeClass("alert-success");
                                    $("#message").html('<bean:message key="admin.usergroup.update.failure"/>');
                                    break;
                            }
                        },
                        error: function(e) {
                            if ($("#messageDiv").length === 0) {
                                $("#updateForm .modal-header").append('<bean:message key="message.messageDiv"/>');
                            }
                            $("#messageDiv").addClass("alert-error").removeClass("alert-success");
                            $("#message").html('<bean:message key="admin.usergroup.update.failure"/>');
                        }
                    });
                    event.preventDefault();
                });

                $('a.delete').click(function() {
                    // remove messageDiv
                    $('#messageDiv-alt').remove();
                    // reset password input
                    $('#password').val('');
                    // reset select box
                    $('#userGroup').val('0');
                    $('#remove-admin-confirm').modal();

                    var id = $(this).attr('id');
                    $("#userID").val(id);
                    return false;
                });

                $('#removeAdminForm').submit(function(event) {
                    $.ajax({
                        type: "POST",
                        url: "RemoveAdminAction.do",
                        data: $("#removeAdminForm").serialize(),
                        success: function(data) {
                            if ($("#messageDiv-alt").length === 0) {
                                $("#removeAdminForm .modal-header").append('<bean:message key="message.messageDivAlt"/>');
                            }
                            switch (data.trim())
                            {
                                case "success":
                                    $("#messageDiv-alt").addClass("alert-success").removeClass("alert-error");
                                    $("#message").html('<bean:message key="admin.usergroup.delete.success"/>');
                                    // redirect
                                    setTimeout(function() {
                                        window.location.href = "admin.do";
                                    }, 1000);
                                    break;
                                case "notSelectGroup":
                                    $("#messageDiv-alt").addClass("alert-error").removeClass("alert-success");
                                    $("#message").html('<bean:message key="admin.usergroup.delete.notSelectGroup"/>');
                                    break;
                                case "passwordNotCorrect":
                                    $("#messageDiv-alt").addClass("alert-error").removeClass("alert-success");
                                    $("#message").html('<bean:message key="admin.usergroup.delete.passwordNotCorrect"/>');
                                    break;
                                default:
                                    $("#messageDiv-alt").addClass("alert-error").removeClass("alert-success");
                                    $("#message").html('<bean:message key="admin.usergroup.delete.failure"/>');
                                    break;
                            }
                        },
                        error: function(e) {
                            if ($("#messageDiv-alt").length === 0) {
                                $("#removeAdminForm .modal-header").append('<bean:message key="message.messageDivAlt"/>');
                            }
                            $("#messageDiv-alt").addClass("alert-error").removeClass("alert-success");
                            $("#message").html('<bean:message key="admin.usergroup.delete.failure"/>');
                        }
                    });
                    event.preventDefault();
                });
            });
        </script>
    </body>
</html>
