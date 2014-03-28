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
        <title><bean:message key="admin.title.usergroup" /></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="../includes/includeCSS.jsp" %>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
        <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="js/jquery.dataTables.extend.js"></script>
        <script type="text/javascript">
            var oTable;

            $(function() {
                $('[rel=tooltip]').tooltip(); 
                oTable = $('#myTable').dataTable({
                    "bProcessing": true,
                    "aaSorting": [[4, 'asc']],
                    "sDom": "<'row-fluid'<'span3'l><'span5'f>r>t<'row-fluid'<'span3'i><'span9'p>>",
                    "sPaginationType": "bootstrap",
                    "aoColumnDefs": [{'bSortable': false, 'bSearchable': false, 'aTargets': ['sorting_disabled']}, {'bVisible': false, 'aTargets': ['invisible']}],
                    "oLanguage": {
                        "sProcessing": "<bean:message key='admin.table.processing'/>",
                        "sLengthMenu": "<bean:message key='admin.table.show' /> _MENU_ <bean:message key='admin.table.usergroup'/>",
                                        "sZeroRecords": "<bean:message key='admin.table.zeroRecords'/>",
                                        "sInfo": "_START_ <bean:message key='admin.table.to'/> _END_ <bean:message key='admin.table.of'/> _TOTAL_ <bean:message key='admin.table.usergroup'/>",
                                        "sInfoEmpty": "0 <bean:message key='admin.table.to'/> 0 <bean:message key='admin.table.of'/> 0 <bean:message key='admin.table.blackpoints'/>",
                                        "sInfoFiltered": "(<bean:message key='admin.table.filtered'/> <bean:message key='admin.table.from'/> _MAX_  <bean:message key='admin.table.usergroup'/>)",
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
        <c:if test="${userStr[3] eq 1}">
            <div id="delete-confirm" class="modal fade hide">
                <html:form styleId="deleteForm" method="POST" action="/DeleteUserGroupAction" styleClass="form-horizontal my-form">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h3><bean:message key="admin.usergroup.delete.h3" /></h3>
                    </div>
                    <div class="modal-body">
                        <html:hidden styleId="groupID" name="UserForm" property="groupID"/>
                        <div class="alert alert-holder">
                            <span><bean:message key="admin.usergroup.delete.warning" /></span>
                        </div>
                        <ul>
                            <li><bean:message key="admin.usergroup.delete.warningMSG1" /></li>
                            <li><bean:message key="admin.usergroup.delete.warningMSG2" /></li>
                        </ul>
                        <div class="control-group">
                            <label class="control-label" for="name">
                                <bean:message key="admin.usergroup.delete.password" />
                                <span class="asterisk">*</span>
                            </label>
                            <div class="controls">
                                <input type="password" id="password" name="password" placeholder="<bean:message key="admin.usergroup.delete.password" />"/>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="submit" class="btn btn-primary pull-right" value="<bean:message key="admin.usergroup.form.delete" />" />
                    </div>
                </html:form>
            </div>
        </c:if>
        <%@include file="../includes/navbar-alter.jsp" %>
        <%@include  file="../includes/navbar-admin-alter.jsp" %>
        <section>
            <div class="container">
                <div class="row-fluid">
                    <div class="span12 table-list border-red">
                        <c:if test="${userStr[3] eq 1}">
                            <a href="newgroup.do" class="btn btn-primary"><bean:message key="admin.usergroup.list.addNewBtn" /></a>
                        </c:if>
                        <table id="myTable" class="table table-striped table-bordered table-hover table-condensed">
                            <caption><bean:message key="admin.usergroup.list.caption" /></caption>
                            <thead>
                                <tr>
                                    <th class="sorting_disabled"></th>
                                    <th class="sorting_disabled"></th>
                                    <th><bean:message key="admin.usergroup.list.groupName" /></th>
                                    <th><bean:message key="admin.usergroup.list.level" /></th>
                                    <th><bean:message key="admin.usergroup.list.createdDate" /></th>
                                    <th><bean:message key="admin.usergroup.list.createdByUser" /></th>
                                    <th><bean:message key="admin.usergroup.list.updatedDate" /></th>
                                    <th><bean:message key="admin.usergroup.list.updatedByUser" /></th>
                                    <th><bean:message key="admin.usergroup.list.description" /></th>
                                </tr>
                            </thead>
                            <tbody>
                                <logic:iterate id="row" name="UserGroupForm" property="userGroupList">
                                    <tr>
                                        <td class="center">
                                            <c:choose>
                                                <c:when test="${userStr[3] eq 1  and row.userGroupID ne 1 and row.userGroupID ne 2 and row.userGroupID ne 3}">
                                                    <html:link action="editgroup.do" paramId="id" paramName="row" paramProperty="userGroupID">
                                                        <i class="fa fa-pencil" rel="tooltip" data-toggle="tooltip" data-placement="top" title="<bean:message key="admin.table.edit"/>"></i>
                                                    </html:link>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fa fa-pencil muted" rel="tooltip" data-toggle="tooltip" data-placement="top" title="<bean:message key="admin.table.editDisable"/>"></i>
                                                </c:otherwise>
                                            </c:choose>

                                        </td>
                                        <td class="center delete">
                                            <c:choose>
                                                <c:when test="${userStr[3] eq 1 and row.userGroupID ne 1 and row.userGroupID ne 2 and row.userGroupID ne 3}">
                                                    <a href="#delete-confirm" id="<bean:write name="row" property="userGroupID"/>" class="delete">
                                                        <i class="fa fa-times-circle" rel="tooltip" data-toggle="tooltip" data-placement="top" title="<bean:message key="admin.table.delete"/>"></i>
                                                    </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                    <i class="fa fa-times-circle muted" rel="tooltip" data-toggle="tooltip" data-placement="top" title="<bean:message key="admin.table.deleteDisable"/>"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><bean:write name="row" property="name"/></td>
                                        <td><bean:write name="row" property="level"/></td>
                                        <td><bean:write name="row" property="createdOnDate"/></td>
                                        <td><bean:write name="row" property="userCreated"/></td>
                                        <td><bean:write name="row" property="updatedOnDate"/></td>
                                        <td><bean:write name="row" property="userUpdated"/></td>
                                        <td><bean:write name="row" property="description"/></td>
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
                $("a.delete").click(function() {
                    // remove messageDiv
                    $("#messageDiv").remove();
                    // reset password input
                    $("#password").val('');
                    $('#delete-confirm').modal();

                    var id = $(this).attr('id');
                    $("#groupID").val(id);
                    return false;
                });

                $("#deleteForm").submit(function(event) {
                    $.ajax({
                        type: "POST",
                        url: "DeleteUserGroupAction.do",
                        data: $("#deleteForm").serialize(),
                        success: function(data) {
                            if ($("#messageDiv").length === 0) {
                                $(".modal-header").append('<bean:message key="message.messageDiv"/>');
                            }
                            switch (data.trim())
                            {
                                case "success":
                                    $("#messageDiv").addClass("alert-success").removeClass("alert-error");
                                    $("#message").html('<bean:message key="admin.usergroup.delete.success"/>');
                                    // redirect
                                    setTimeout(function() {
                                        window.location.href = "usergroup.do";
                                    }, 1000);
                                    break;
                                case "cannotDelete":
                                    $("#messageDiv").addClass("alert-error").removeClass("alert-success");
                                    $("#message").html('<bean:message key="admin.usergroup.delete.cannotDelete"/>');
                                    break;
                                case "passwordNotCorrect":
                                    $("#messageDiv").addClass("alert-error").removeClass("alert-success");
                                    $("#message").html('<bean:message key="admin.usergroup.delete.passwordNotCorrect"/>');
                                    break;
                                default:
                                    $("#messageDiv").addClass("alert-error").removeClass("alert-success");
                                    $("#message").html('<bean:message key="admin.usergroup.delete.failure"/>');
                                    break;
                            }
                        },
                        error: function(e) {
                            if ($("#messageDiv").length === 0) {
                                $(".modal-header").append('<bean:message key="message.messageDiv"/>');
                            }
                            $("#messageDiv").addClass("alert-error").removeClass("alert-success");
                            $("#message").html('<bean:message key="admin.usergroup.delete.failure"/>');
                        }
                    });
                    event.preventDefault();
                });
            });
        </script>
    </body>
</html>