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
        <title><bean:message key="admin.title.poilist" /></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="../includes/includeCSS.jsp" %>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?libraries=places&sensor=false&language=vi"></script>
        <script type="text/javascript" src="js/infobubble.min.js"></script>
        <script type="text/javascript" src="js/map.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
        <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="js/jquery.dataTables.extend.js"></script>
        <script type="text/javascript" src="js/jquery.fancybox.pack.js"></script>
        <script type="text/javascript">
            var oTable;
            $("a[rel^='fancybox']").fancybox();

            /* Formating function for row details */
            function fnFormatDetails(nTr)
            {
                var aData = oTable.fnGetData(nTr);
                var sOut = '<table class="table sub-table">';
                sOut += '<tr><td rowspan="6" class="center">' + aData[4] + '</td></tr>';
                if (aData[19] !== undefined) {
                    sOut += '<tr><td>' + '<bean:message key="admin.poi.table.details.description"/>: <span>' + aData[19] + '</span></td></tr>';
                }
                sOut += '<tr><td>' + '<bean:message key="admin.poi.table.details.createdBy"/>: <span>' + aData[12] + '</span></td></tr>';
                if (aData[13] !== '') {
                    sOut += '<tr><td>' + '<bean:message key="admin.poi.table.details.updatedOnDate"/>: <span>' + aData[13] + '</span> <bean:message key="admin.table.by"/>: <span>' + aData[14] + '</span>';
                }
                if (aData[15] !== '') {
                    sOut += '<tr><td>' + '<bean:message key="admin.poi.table.details.deletedOnDate"/>: <span>' + aData[15] + '</span> <bean:message key="admin.table.by"/>: <span>' + aData[16] + '</span>';
                }
                if (aData[17] !== '') {
                    sOut += '<tr><td>' + '<bean:message key="admin.poi.table.details.restoredOnDate"/>: <span>' + aData[17] + '</span> <bean:message key="admin.table.by"/>: <span>' + aData[18] + '</span>';
                }
                sOut += '</table>';
                return sOut;
            }
            $(function() {
                $('[rel=tooltip]').tooltip();
                oTable = $('#myTable').dataTable({
                    "bProcessing": true,
                    "aaSorting": [[11, 'asc']],
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
        <%@include  file="../includes/navbar-admin-alter.jsp" %>
        <div id="map-modal" class="modal fade hide" style="width: 800px; margin-left: -400px;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3><bean:message key="admin.poi.list.h3" /></h3>
            </div>
            <div class="modal-body">
                <div id="map-canvas" style="height: 400px;"></div>
            </div>
        </div>
        <c:if test="${userStr[3] eq 1}">
            <div id="delete-confirm" class="modal fade hide">
                <html:form styleId="deleteForm" method="POST" action="/DeletePOIAction" styleClass="form-horizontal my-form">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h3><bean:message key="admin.poi.delete.h3" /></h3>
                    </div>
                    <div class="modal-body">
                        <html:hidden styleId="poiID" name="POIForm" property="id"/>
                        <div class="alert alert-holder">
                            <span><bean:message key="admin.poi.delete.warning" /></span>
                        </div>
                        <ul>
                            <li><bean:message key="admin.poi.delete.warningMSG1" /></li>
                            <li><bean:message key="admin.poi.delete.warningMSG2" /></li>
                        </ul>
                        <div class="control-group">
                            <label class="control-label" for="password">
                                <bean:message key="admin.poi.delete.password" />
                                <span class="asterisk">*</span>
                            </label>
                            <div class="controls">
                                <input type="password" id="password" name="password" placeholder="<bean:message key="admin.poi.delete.password" />"/>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="submit" class="btn btn-primary pull-right" value="<bean:message key="admin.poi.form.delete" />" />
                    </div>
                </html:form>
            </div>
        </c:if>
        <section>
            <div class="container">
                <div class="row-fluid">
                    <div class="span12 table-list border-red">
                        <a href="newpoi.do" class="btn btn-primary"><bean:message key="admin.poi.list.addNewBtn"/></a>
                        <i class="fa fa-times"></i> <a href="deletedlist.do" class="other-link"><bean:message key="admin.poi.list.deleteBtn"/></a> |
                        <i class="fa fa-user"></i> <a href="fromuser.do" class="other-link"><bean:message key="admin.poi.list.fromUserBtn"/></a>
                        <table id="myTable" class="table table-striped table-bordered table-hover table-condensed">
                            <caption><bean:message key="admin.poi.list.caption"/></caption>
                            <thead>
                                <tr>
                                    <th class="sorting_disabled"></th>
                                    <th class="sorting_disabled"></th>
                                    <th class="sorting_disabled"></th>
                                    <th class="sorting_disabled"></th>
                                    <th class="invisible"></th>
                                    <th><bean:message key="admin.poi.form.name" /></th>
                                    <th><bean:message key="admin.poi.form.address" /></th>
                                    <th><bean:message key="admin.poi.form.city" /></th>
                                    <th><bean:message key="admin.poi.form.district" /></th>
                                    <th><bean:message key="admin.poi.form.category" /></th>
                                    <th><bean:message key="admin.poi.form.rating" /></th>
                                    <th><bean:message key="admin.poi.table.details.createdOnDate" /></th>
                                    <th class="invisible"></th>
                                    <th class="invisible"></th>
                                    <th class="invisible"></th>
                                    <th class="invisible"></th>
                                    <th class="invisible"></th>
                                    <th class="invisible"></th>
                                    <th class="invisible"></th>
                                    <th class="invisible"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <logic:iterate id="row" name="POIForm" property="poiList">
                                    <tr>
                                        <td class="center"><i title="<bean:message key="admin.poi.form.viewDetails" />" rel="tooltip" data-toggle="tooltip" data-placement="top" class="fa fa-angle-double-down"></i></td>
                                        <td class="center">
                                            <a class="view-in-map" href="#map-modal" id="<bean:write name="row" property="id" />"><i rel="tooltip" data-toggle="tooltip" data-placement="top" class="fa fa-map-marker" title="<bean:message key="admin.poi.form.viewInMap"/>"></i></a>
                                        </td>
                                        <td class="center">
                                            <html:link action="editpoi" paramId="id" paramName="row" paramProperty="id">
                                                <i class="fa fa-pencil" rel="tooltip" data-toggle="tooltip" data-placement="top" title="<bean:message key="admin.poi.form.edit"/>"></i>
                                            </html:link>
                                        </td>
                                        <td class="center delete">
                                            <a href="#delete-confirm" class="delete" id="<bean:write name="row" property="id" />"><i rel="tooltip" data-toggle="tooltip" data-placement="top" class="fa fa-times-circle"  title="<bean:message key="admin.poi.form.delete" />"></i></a>
                                        </td>
                                        <td>
                                            <a rel="fancybox" href="<bean:write name="row" property="image" />" title="<bean:write name="row" property="name" />">
                                                <img width="200" src="<bean:write name="row" property="image"/>" alt="<bean:write name="row" property="name"/>" />
                                            </a>
                                        </td>
                                        <td><bean:write name="row" property="name"/></td>
                                        <td><bean:write name="row" property="address"/></td>
                                        <td>
                                            <html:link action="city" paramId="id" paramName="row" paramProperty="city">
                                                <bean:write name="row" property="cityName"/>
                                            </html:link>
                                        </td>
                                        <td>
                                            <html:link action="district" paramId="id" paramName="row" paramProperty="district">
                                                <bean:write name="row" property="districtName"/>
                                            </html:link>
                                        </td>                                        
                                        <td>
                                            <html:link action="poibycategory" paramId="id" paramName="row" paramProperty="categoryID">
                                                <bean:write name="row" property="categoryName"/>
                                            </html:link>
                                        </td>
                                        <td><bean:write name="row" property="rating"/></td>
                                        <td><bean:write name="row" property="createdOnDate"/></td>
                                        <td><bean:write name="row" property="createdByUserName"/></td>
                                        <td><bean:write name="row" property="updatedOnDate"/></td>
                                        <td><bean:write name="row" property="updatedByUserName"/></td>
                                        <td><bean:write name="row" property="deletedOnDate"/></td>
                                        <td><bean:write name="row" property="deletedByUserName"/></td>
                                        <td><bean:write name="row" property="restoreOnDate"/></td>
                                        <td><bean:write name="row" property="restoredByUserName"/></td>
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
                MapsLib.initialize();
                $("a.view-in-map").click(function() {
                    $("#map-modal").modal();

                    var id = $(this).attr('id');
                    MapsLib.getPOIByID(id);

                    return false;
                });

                $('#map-modal').on('shown', function() {
                    var currentCenter = map.getCenter();
                    google.maps.event.trigger(map, "resize");
                    map.setCenter(currentCenter);
                });

                $("a.delete").click(function() {
                    // remove messageDiv
                    $("#messageDiv").remove();
                    // reset password input
                    $("#password").val('');
                    $('#delete-confirm').modal();

                    var id = $(this).attr('id');
                    $("#poiID").val(id);
                    return false;
                });

                $("#deleteForm").submit(function(event) {
                    $.ajax({
                        type: "POST",
                        url: "DeletePOIAction.do",
                        data: $("#deleteForm").serialize(),
                        success: function(data) {
                            if ($("#messageDiv").length === 0) {
                                $("#delete-confirm .modal-header").append('<bean:message key="message.messageDiv"/>');
                            }
                            switch (data.trim())
                            {
                                case "success":
                                    $("#messageDiv").addClass("alert-success").removeClass("alert-error");
                                    $("#message").html('<bean:message key="admin.poi.delete.success"/>');
                                    // redirect
                                    setTimeout(function() {
                                        window.location.href = "poilist.do";
                                    }, 1000);
                                    break;
                                case "passwordNotCorrect":
                                    $("#messageDiv").addClass("alert-error").removeClass("alert-success");
                                    $("#message").html('<bean:message key="admin.poi.delete.passwordNotCorrect"/>');
                                    break;
                                default:
                                    $("#messageDiv").addClass("alert-error").removeClass("alert-success");
                                    $("#message").html('<bean:message key="admin.poi.delete.failure"/>');
                                    break;
                            }
                        },
                        error: function(e) {
                            if ($("#messageDiv").length === 0) {
                                $(".modal-header").append('<bean:message key="message.messageDiv"/>');
                            }
                            $("#messageDiv").addClass("alert-error").removeClass("alert-success");
                            $("#message").html('<bean:message key="admin.poi.delete.failure"/>');
                        }
                    });
                    event.preventDefault();
                });
            });
        </script>                                    
    </body>
</html>
