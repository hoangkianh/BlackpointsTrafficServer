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
        <title><bean:message key="admin.useradmin.newadmin.caption" /></title>
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
                oTable = $('#myTable').dataTable({
                    "bProcessing": true,
                    "aaSorting": [[6, 'asc']],
                    "sDom": "<'row-fluid'<'span3'l><'span5'f>r>t<'row-fluid'<'span3'i><'span9'p>>",
                    "sPaginationType": "bootstrap",
                    "aoColumnDefs": [{'bSortable': false, 'bSearchable': false, 'aTargets': ["sorting_disabled"]}],
                    "oLanguage": {
                        "sProcessing": "<bean:message key='admin.table.processing'/>",
                        "sLengthMenu": "<bean:message key='admin.table.show' /> _MENU_ <bean:message key='admin.table.user'/>",
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
        <div id="add-new-confirm" class="modal fade hide">
            <html:form styleId="addNewForm" method="POST" action="/AddNewAdminAction" styleClass="form-horizontal my-form">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h3><bean:message key="admin.useradmin.newadmin.h3" /></h3>
                </div>
                <div class="modal-body">
                    <html:hidden styleId="userID" name="UserForm" property="userID"/>
                    <div class="alert alert-holder">
                        <span><bean:message key="admin.useradmin.newadmin.warning" /></span>
                    </div>
                    <ul>
                        <li><bean:message key="admin.useradmin.newadmin.warningMSG1" /></li>
                        <li><bean:message key="admin.useradmin.newadmin.warningMSG2" /></li>
                    </ul>
                    <div class="control-group">
                        <label class="control-label" for="userGroup">
                            <bean:message key="admin.useradmin.newadmin.select" />
                        </label>
                        <div class="controls">
                            <html:select styleId="userGroup" name="UserForm" property="groupID">
                                <html:option value="0"><bean:message key="admin.useradmin.newadmin.select"/></html:option>
                                <logic:iterate id="g" name="UserForm" property="adminGroup">
                                    <option value="<bean:write name="g" property="userGroupID"/>"><bean:write name="g" property="name"/> </option>
                                </logic:iterate>
                            </html:select>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="name">
                            <bean:message key="admin.useradmin.newadmin.password" />
                            <span class="asterisk">*</span>
                        </label>
                        <div class="controls">
                            <input type="password" id="password" name="password" placeholder="<bean:message key="admin.useradmin.newadmin.password" />"/>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <input id="step4" type="submit" class="btn btn-primary pull-right" value="<bean:message key="admin.useradmin.newadmin.update" />" />
                </div>
            </html:form>
        </div>
        <%@include file="../includes/navbar-alter.jsp" %>
        <%@include  file="../includes/navbar-admin-alter.jsp" %>
        <section>
            <div class="container">
                <div class="row-fluid">
                    <div class="span12 table-list border-red">
                        <a href="admin.do"><bean:message key="admin.useradmin.newadmin.backToAdminList"/></a>
                        <table id="myTable" class="table table-striped table-bordered table-hover table-condensed">
                            <caption><bean:message key='admin.useradmin.newadmin.caption'/></caption>
                            <thead>
                                <tr>
                                    <th class="sorting_disabled"></th>
                                    <th><bean:message key='admin.user.list.username'/></th>
                                    <th><bean:message key='admin.user.list.displayname'/></th>
                                    <th><bean:message key='admin.user.list.email'/></th>
                                    <th><bean:message key="admin.usergroup.list.groupName" /></th>
                                    <th><bean:message key='admin.user.list.description'/></th>
                                    <th><bean:message key='admin.user.list.lastLogin'/></th>
                                    <th><bean:message key='admin.user.list.registerDate'/></th>
                                    <th><bean:message key='admin.user.list.updatedDate'/></th>
                                    <th><bean:message key='admin.user.list.activateddate'/></th>
                                </tr>
                            </thead>
                            <tbody>
                                <logic:iterate id="row" name="UserForm" property="userList">                                    
                                    <tr>
                                        <logic:equal name="row" property="activated" value="true">
                                            <td class="center">
                                                <a href="#add-new-confirm" class="add-new" id="<bean:write name="row" property="userID"/>">
                                                    <i class="fa fa-cog" rel="tooltip" data-toggle="tooltip" data-placement="top" title="<bean:message key="admin.table.addNewAdmin"/>"></i>
                                                </a>
                                            </td>
                                        </logic:equal>
                                        <logic:equal name="row" property="activated" value="false">
                                            <td class="center"><i class="fa fa-lock" rel="tooltip" data-toggle="tooltip" data-placement="top" title="<bean:message key="admin.table.addNewAdminDisable"/>"></i></td>
                                            </logic:equal>
                                        <td><bean:write name="row" property="userName"/></td>
                                        <td><bean:write name="row" property="displayName"/></td>
                                        <td><bean:write name="row" property="email"/></td>
                                        <td><bean:write name="row" property="groupName"/></td>
                                        <td><bean:write name="row" property="description"/></td>
                                        <td><bean:write name="row" property="lastLogin"/></td>
                                        <td><bean:write name="row" property="createdOnDate"/></td>
                                        <td><bean:write name="row" property="updatedOnDate"/></td>
                                        <td><bean:write name="row" property="activatedOnDate"/></td>
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
                $('[rel=tooltip]').tooltip();

                $('.add-new').click(function() {
                    // remove messageDiv
                    $('#messageDiv').remove();
                    // reset password input
                    $('#password').val('');
                    // reset select box
                    $('#userGroup').val('0');
                    $('#add-new-confirm').modal();
                    
                    var id = $(this).attr('id');
                    $("#userID").val(id);
                    return false;
                });

                $('#addNewForm').submit(function(event) {
                    $.ajax({
                        type: "POST",
                        url: "AddNewAdminAction.do",
                        data: $("#addNewForm").serialize(),
                        success: function(data) {
                            if ($("#messageDiv").length === 0) {
                                $(".modal-header").append('<bean:message key="message.messageDiv"/>');
                            }
                            switch (data.trim())
                            {
                                case "success":
                                    $("#messageDiv").addClass("alert-success").removeClass("alert-error");
                                    $("#message").html('<bean:message key="admin.usergroup.newadmin.success"/>');
                                    // redirect
                                    setTimeout(function() {
                                        window.location.href = "admin.do";
                                    }, 1000);
                                    break;
                                case "notSelectGroup":
                                    $("#messageDiv").addClass("alert-error").removeClass("alert-success");
                                    $("#message").html('<bean:message key="admin.usergroup.newadmin.notSelectGroup"/>');
                                    break;                                
                                case "passwordNotCorrect":
                                    $("#messageDiv").addClass("alert-error").removeClass("alert-success");
                                    $("#message").html('<bean:message key="admin.usergroup.newadmin.passwordNotCorrect"/>');
                                    break;
                                default:
                                    $("#messageDiv").addClass("alert-error").removeClass("alert-success");
                                    $("#message").html('<bean:message key="admin.usergroup.newadmin.failure"/>');
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
