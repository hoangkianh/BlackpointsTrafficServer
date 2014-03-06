<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:if test="${empty sessionScope.blackpoints and empty cookie.blackpoints}">
    <c:redirect url="/login.do" />
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
        <script type="text/javascript">
            var oTable;

            /* Formating function for row details */
            function fnFormatDetails(nTr)
            {
                var aData = oTable.fnGetData(nTr);
                var sOut = '<table class="table sub-table">';
                if (aData[8] !== '') {
                    sOut += '<tr><td>' + '<bean:message key="admin.poi.table.details.description"/>: <span>' + aData[8] + '</span></td></tr>';
                } else {
                    sOut += '<tr><td>' + '<bean:message key="admin.poi.table.details.description"/>: <span></span></td></tr>';
                }
                sOut += '</table>';
                return sOut;
            }
            $(function() {
                $('[rel=tooltip]').tooltip();
                oTable = $('#myTable').dataTable({
                    "bProcessing": true,
                    "aaSorting": [[7, 'asc']],
                    "sDom": "<'row-fluid'<'span3'l><'span5'f>r>t<'row-fluid'<'span3'i><'span9'p>>",
                    "sPaginationType": "bootstrap",
                    "aoColumnDefs": [{'bSortable': false, 'bSearchable': false, 'aTargets': ['sorting_disabled']}, {'bVisible': false, 'aTargets': ['invisible']}],
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
                                $('#myTable tbody td i.fa-angle-double-down').bind('click', function() {
                                    var nTr = $(this).parents('tr')[0];
                                    if (oTable.fnIsOpen(nTr))
                                    {
                                        /* This row is already open - close it */
                                        $(this).removeClass("fa fa-angle-double-up");
                                        $(this).addClass("fa fa-angle-double-down");
                                        oTable.fnClose(nTr);
                                    }
                                    else
                                    {
                                        /* Open this row */
                                        $(this).removeClass("fa fa-angle-double-down");
                                        $(this).addClass("fa fa-angle-double-up");
                                        oTable.fnOpen(nTr, fnFormatDetails(nTr), 'details');
                                    }
                                });
                            });
        </script>
    </head>
    <body>
        <%@include file="../includes/navbar-alter.jsp" %>
        <section>
            <div class="container">
                <div class="row-fluid">
                    <div class="span12 table-list border-red">
                        <a href="poi.do" class="btn btn-primary"><bean:message key="temPOIByUser.addNewPOI"/></a>
                        <table id="myTable" class="table table-striped table-bordered table-hover table-condensed">
                            <caption><bean:message key="tempPOIByUser.caption"/></caption>
                            <thead>
                                <tr>
                                    <th class="sorting_disabled"></th>
                                    <th><bean:message key="tempPOIByUser.name"/></th>
                                    <th><bean:message key="tempPOIByUser.address"/></th>
                                    <th><bean:message key="tempPOIByUser.city" /></th>
                                    <th><bean:message key="tempPOIByUser.district" /></th>
                                    <th><bean:message key="tempPOIByUser.category" /></th>
                                    <th><bean:message key="tempPOIByUser.rating" /></th>
                                    <th><bean:message key="tempPOIByUser.createdOnDate" /></th>
                                    <th class="invisible"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <logic:iterate id="row" name="TempPOIForm" property="tempPOIList">
                                    <tr>
                                        <td class="center"><i class="fa fa-angle-double-down"></i></td>
                                        <td><bean:write name="row" property="name"/></td>
                                        <td><bean:write name="row" property="address"/></td>
                                        <td><bean:write name="row" property="cityName"/></td>
                                        <td><bean:write name="row" property="districtName"/></td>
                                        <td><bean:write name="row" property="categoryName"/></td>
                                        <td><bean:write name="row" property="rating"/> - <bean:write name="row" property="ratingName"/></td>
                                        <td><bean:write name="row" property="createdOnDate"/></td>
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
                    $('#delete-confirm').modal();

                    var id = $(this).attr('id');
                    $("#tempPOIID").val(id);
                    return false;
                });

                $("#deleteForm").submit(function(event) {
                    $.ajax({
                        type: "POST",
                        url: "DeleteTempPOIAction.do",
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
