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
        <title><bean:message key="admin.title.category" /></title>
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
                    "aaSorting": [[2, 'desc']],
                    "sDom": "<'row-fluid'<'span3'l><'span5'f>r>t<'row-fluid'<'span3'i><'span9'p>>",
                    "sPaginationType": "bootstrap",
                    "aoColumnDefs": [{'bSortable': false, 'bSearchable': false, 'aTargets': ["sorting_disabled"]}],
                    "oLanguage": {
                        "sProcessing": "<bean:message key='admin.table.processing'/>",
                        "sLengthMenu": "<bean:message key='admin.table.show' /> _MENU_ <bean:message key='admin.table.blackpoints'/>",
                                        "sZeroRecords": "<bean:message key='admin.table.zeroRecords'/>",
                                        "sInfo": "_START_ <bean:message key='admin.table.to'/> _END_ <bean:message key='admin.table.of'/> _TOTAL_ <bean:message key='admin.table.category'/>",
                                        "sInfoEmpty": "0 <bean:message key='admin.table.to'/> 0 <bean:message key='admin.table.of'/> 0 <bean:message key='admin.table.blackpoints'/>",
                                        "sInfoFiltered": "(<bean:message key='admin.table.filtered'/> <bean:message key='admin.table.from'/> _MAX_  <bean:message key='admin.table.category'/>)",
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
                <html:form styleId="deleteForm" method="POST" action="/DeleteCategoryAction" styleClass="form-horizontal my-form">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h3><bean:message key="admin.category.delete.h3" /></h3>
                    </div>
                    <div class="modal-body">
                        <html:hidden styleId="categoryID" name="CategoryForm" property="categoryID"/>
                        <div class="alert alert-holder">
                            <span><bean:message key="admin.category.delete.warning" /></span>
                        </div>
                        <ul>
                            <li><bean:message key="admin.category.delete.warningMSG1" /></li>
                            <li><bean:message key="admin.category.delete.warningMSG2" /></li>
                        </ul>
                        <div class="control-group">
                            <label class="control-label" for="name">
                                <bean:message key="admin.category.delete.password" />
                                <span class="asterisk">*</span>
                            </label>
                            <div class="controls">
                                <input type="password" id="password" name="password" placeholder="<bean:message key="admin.category.delete.password" />"/>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input id="step4" type="submit" class="btn btn-primary pull-right" value="<bean:message key="admin.category.form.delete" />" />
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
                        <a href="newcategory.do" class="btn btn-primary"><bean:message key="admin.category.list.addNewBtn"/></a>
                        <table id="myTable" class="table table-striped table-bordered table-hover table-condensed">
                            <caption><bean:message key="admin.category.list.caption"/></caption>
                            <thead>
                                <tr>
                                    <th class="sorting_disabled"></th>
                                    <th class="sorting_disabled"></th>
                                    <th><bean:message key="admin.category.list.name"/></th>
                                    <th><bean:message key="admin.category.list.icon"/></th>
                                    <th><bean:message key="admin.category.list.description"/></th>
                                </tr>
                            </thead>
                            <tbody>
                                <logic:iterate id="row" name="CategoryForm" property="categoryList">                                    
                                    <tr>
                                        <td class="center">
                                            <html:link action="editcategory" paramId="id" paramName="row" paramProperty="categoryID">
                                                <i rel="tooltip" data-toggle="tooltip" data-placement="top" class="fa fa-pencil" title="<bean:message key='admin.table.edit'/>"></i>
                                            </html:link>
                                        </td>
                                        <td class="center delete">
                                            <a href="#delete-confirm" id="<bean:write name="row" property="categoryID"/>" class="delete"><i rel="tooltip" data-toggle="tooltip" data-placement="top" class="fa fa-times-circle" title="<bean:message key='admin.table.delete'/>"></i></a>
                                        </td>
                                        <td><bean:write name="row" property="name"/></td>
                                        <td><img height="32" width="32" src="<bean:write name="row" property="image"/>" alt="<bean:write name="row" property="name"/>"/></td>
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
                    $("#categoryID").val(id);
                    return false;
                });

                $("#deleteForm").submit(function(event) {
                    $.ajax({
                        type: "POST",
                        url: "DeleteCategoryAction.do",
                        data: $("#deleteForm").serialize(),
                        success: function(data) {
                            if ($("#messageDiv").length === 0) {
                                $(".modal-header").append('<bean:message key="message.messageDiv"/>');
                            }
                            switch (data.trim())
                            {
                                case "success":
                                    $("#messageDiv").addClass("alert-success").removeClass("alert-error");
                                    $("#message").html('<bean:message key="admin.category.delete.success"/>');
                                    // redirect
                                    setTimeout(function() {
                                        window.location.href = "category.do";
                                    }, 1000);
                                    break;
                                case "cannotDelete":
                                    $("#messageDiv").addClass("alert-error").removeClass("alert-success");
                                    $("#message").html('<bean:message key="admin.category.delete.cannotDelete"/>');
                                    break;
                                case "passwordNotCorrect":
                                    $("#messageDiv").addClass("alert-error").removeClass("alert-success");
                                    $("#message").html('<bean:message key="admin.category.delete.passwordNotCorrect"/>');
                                    break;
                                default:
                                    $("#messageDiv").addClass("alert-error").removeClass("alert-success");
                                    $("#message").html('<bean:message key="admin.category.delete.failure"/>');
                                    break;
                            }
                        },
                        error: function(e) {
                            if ($("#messageDiv").length === 0) {
                                $(".modal-header").append('<bean:message key="message.messageDiv"/>');
                            }
                            $("#messageDiv").addClass("alert-error").removeClass("alert-success");
                            $("#message").html('<bean:message key="admin.category.delete.failure"/>');
                        }
                    });
                    event.preventDefault();
                });
            });
        </script>
    </body>
</html>
