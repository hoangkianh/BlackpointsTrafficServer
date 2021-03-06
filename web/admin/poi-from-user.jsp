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
        <title><bean:message key="admin.title.fromuser" /></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="../includes/includeCSS.jsp" %>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
        <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="js/jquery.dataTables.extend.js"></script>
    </head>
    <body>
        <%@include file="../includes/navbar-alter.jsp" %>
        <%@include  file="../includes/navbar-admin-alter.jsp" %>
        <section>
            <div id="delete-confirm" class="modal fade hide"  style="width: 300px; margin-left: -150px;">
                <html:form styleId="deleteForm" method="POST" action="/DeleteTempPOIAction" styleClass="form-horizontal my-form">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h3><bean:message key="admin.tempPOI.delete.h3" /></h3>
                    </div>
                    <div class="modal-body">
                        <html:hidden styleId="tempPOIID" name="TempPOIForm" property="id"/>
                        <input type="submit" class="btn btn-primary" value="<bean:message key="admin.tempPOI.form.delete" />" />
                        <a data-dismiss="modal" class="btn" id="close" href="#" style="width: auto;"><bean:message key="admin.tempPOI.form.cancel"/></a>
                    </div>
                </html:form>
            </div>
            <div class="container">
                <div class="row-fluid">
                    <div class="span12 table-list border-red">
                        <i class="fa fa-list"></i> <a href="poilist.do" class="other-link"><bean:message key="admin.poi.list.caption"/></a>
                        <table id="myTable" class="table table-striped table-bordered table-hover table-condensed">
                            <caption><bean:message key="admin.tempPOI.caption"/></caption>
                            <thead>
                                <tr>
                                    <th class="sorting_disabled"></th>
                                    <th class="sorting_disabled"></th>
                                    <th class="sorting_disabled"></th>
                                    <th><bean:message key="admin.tempPOI.form.name"/></th>
                                    <th><bean:message key="admin.tempPOI.form.address"/></th>
                                    <th><bean:message key="admin.tempPOI.form.city" /></th>
                                    <th><bean:message key="admin.tempPOI.form.district" /></th>
                                    <th><bean:message key="admin.tempPOI.form.category" /></th>
                                    <th><bean:message key="admin.tempPOI.form.rating" /></th>
                                    <th><bean:message key="admin.tempPOI.form.createdOnDate" /></th>
                                    <th class="invisible"></th>
                                    <th class="invisible"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <logic:iterate id="row" name="TempPOIForm" property="tempPOIList">
                                    <tr>
                                        <td class="center"><i class="fa fa-angle-double-down"></i></td>
                                        <td class="center">
                                            <html:link action="savepoi" paramId="id" paramName="row" paramProperty="id">
                                                <i class="fa fa-save" rel="tooltip" data-toggle="tooltip" data-placement="top" title="<bean:message key="admin.temPOI.form.save"/>"></i>
                                            </html:link>
                                        </td>
                                        <td class="center delete">
                                            <a href="#" class="delete" id="<bean:write name="row" property="id"/>">
                                                <i rel="tooltip" data-toggle="tooltip" data-placement="top" class="fa fa-times-circle"  title="<bean:message key="admin.tempPOI.form.delete" />"></i>
                                            </a>
                                        </td>
                                        <td><bean:write name="row" property="name"/></td>
                                        <td><bean:write name="row" property="address"/></td>
                                        <td><bean:write name="row" property="cityName"/></td>
                                        <td><bean:write name="row" property="districtName"/></td>
                                        <td><bean:write name="row" property="categoryName"/></td>
                                        <td><bean:write name="row" property="rating"/> - <bean:write name="row" property="ratingName"/></td>
                                        <td><bean:write name="row" property="createdOnDate"/></td>
                                        <td><bean:write name="row" property="createdByUserName"/></td>
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
            $(function () {
                $('[rel=tooltip]').tooltip();

                $("a.delete").click(function () {
                    // remove messageDiv
                    $("#messageDiv").remove();
                    $('#delete-confirm').modal();

                    var id = $(this).attr('id');
                    $("#tempPOIID").val(id);
                    return false;
                });

                $("#deleteForm").submit(function (event) {
                    $.ajax({
                        type: "POST",
                        url: "DeleteTempPOIAction.do",
                        data: $("#deleteForm").serialize(),
                        success: function (data) {
                            if ($("#messageDiv").length === 0) {
                                $(".modal-header").append('<bean:message key="message.messageDiv"/>');
                            }
                            switch (data.trim()) {
                            case "success":
                                $("#messageDiv").addClass("alert-success").removeClass("alert-error");
                                $("#message").html('<bean:message key="admin.category.delete.success"/>');
                                // redirect
                                setTimeout(function () {
                                    window.location.href = "fromuser.do";
                                }, 1000);
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
                        error: function (e) {
                            if ($("#messageDiv").length === 0) {
                                $(".modal-header").append('<bean:message key="message.messageDiv"/>');
                            }
                            $("#messageDiv").addClass("alert-error").removeClass("alert-success");
                            $("#message").html('<bean:message key="admin.category.delete.failure"/>');
                        }
                    });
                    event.preventDefault();
                });

                /* Formating function for row details */
                function fnFormatDetails(nTr) {
                    var aData = oTable.fnGetData(nTr);
                    var sOut = '<table class="table sub-table">';
                    sOut += '<tr><td>' + '<bean:message key="admin.poi.table.details.createdBy"/>: <span>' + aData[10] + '</span></td></tr>';
                    if (aData[11] !== '') {
                        sOut += '<tr><td>' + '<bean:message key="admin.poi.table.details.description"/>: <span>' + aData[11] + '</span></td></tr>';
                    }
                    sOut += '</table>';
                    return sOut;
                }
                
                $('#myTable tbody td i.fa-angle-double-down').on('click', function () {
                    var nTr = $(this).parents('tr')[0];
                    if (oTable.fnIsOpen(nTr)) {
                        /* This row is already open - close it */
                        $(this).removeClass("fa fa-angle-double-up");
                        $(this).addClass("fa fa-angle-double-down");
                        oTable.fnClose(nTr);
                    } else {
                        /* Open this row */
                        $(this).removeClass("fa fa-angle-double-down");
                        $(this).addClass("fa fa-angle-double-up");
                        oTable.fnOpen(nTr, fnFormatDetails(nTr), 'details');
                    }
                });

                var oTable = $('#myTable').dataTable({
                    "bProcessing": true,
                    "aaSorting": [
                        [9, 'asc']
                    ],
                    "sDom": "<'row-fluid'<'span3'l><'span5'f>r>t<'row-fluid'<'span3'i><'span9'p>>",
                    "sPaginationType": "bootstrap",
                    "aoColumnDefs": [{
                        'bSortable': false,
                        'bSearchable': false,
                        'aTargets': ['sorting_disabled']
                    }, {
                        'bVisible': false,
                        'aTargets': ['invisible']
                    }],
                    "oLanguage": {
                        "sProcessing": "<bean:message key='admin.table.processing'/>",
                        "sLengthMenu": "<bean:message key='admin.table.show' /> _MENU_ <bean:message key='admin.table.blackpoints'/>",
                        "sZeroRecords": "<bean:message key='admin.table.zeroRecords'/>",
                        "sInfo": "_START_ <bean:message key='admin.table.to'/> _END_ <bean:message key='admin.table.of'/> _TOTAL_ <bean:message key='admin.table.blackpoints'/>",
                        "sInfoEmpty": "0 <bean:message key='admin.table.to'/> 0 <bean:message key='admin.table.of'/> 0 <bean:message key='admin.table.blackpoints'/>",
                        "sInfoFiltered": "(<bean:message key='admin.table.filtered'/> <bean:message key='admin.table.from'/> _MAX_  <bean:message key='admin.table.blackpoints'/>)",
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
    </body>
</html>
