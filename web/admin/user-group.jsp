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
        <script type="text/javascript" src="//code.jquery.com/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
        <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="js/jquery.dataTables.extend.js"></script>
        <script type="text/javascript">
            var oTable;

            $(function() {
            oTable = $('#myTable').dataTable({
            "bProcessing": true,
                    "aaSorting": [[3, 'asc']],
                    "sDom": "<'row-fluid'<'span3'l><'span5'f>r>t<'row-fluid'<'span3'i><'span9'p>>",
                    "sPaginationType": "bootstrap",
                    "aoColumnDefs": [{'bSortable': false, 'bSearchable': false, 'aTargets': ['sorting_disabled']}, {'bVisible': false, 'aTargets': ['invisible']}],
                    "oLanguage": {
                    "sProcessing": "<bean:message key='admin.table.processing'/>",
                            "sLengthMenu": "<bean:message key='admin.table.show' /> _MENU_ <bean:message key='admin.table.blackpoints'/>",
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
        </script>
    </head>
    <body>
        <%@include file="../includes/navbar-alter.jsp" %>
        <%@include  file="../includes/navbar-admin-alter.jsp" %>
        <section>
            <div class="container">
                <div class="row-fluid">
                    <div class="span12 table-list border-red">
                        <a href="#" class="btn btn-primary"><bean:message key="admin.usergroup.list.addNewBtn" /></a>
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
                                        <td class="center"><a href="#"><i class="fa fa-pencil" title="<bean:message key="admin.table.edit"/>"></i></a></td>
                                                <c:if test="${not empty sessionScope.blackpoints or not empty cookie.blackpoints}">
                                                    <c:if test="${not empty sessionScope.blackpoints}">
                                                        <c:set var="userStr" value="${fn:split(sessionScope.blackpoints, '~')}"/>        
                                                    </c:if>
                                                    <c:if test="${not empty cookie.blackpoints}">
                                                        <c:set var="userStr" value="${fn:split(cookie.blackpoints.value, '~')}"/>
                                                    </c:if>
                                                    <c:choose>
                                                        <c:when test="${userStr[3] eq 1}">
                                                            <td class="center delete">
                                                                <a href="#" class="delete"><i class="fa fa-times-circle" title="<bean:message key="admin.table.delete"/>"></i></a>
                                                            </td>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <td class="center delete"><i class="fa fa-times-circle muted" title="<bean:message key="admin.table.deleteDisable"/>"></i></td>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:if>
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
    </body>
</html>