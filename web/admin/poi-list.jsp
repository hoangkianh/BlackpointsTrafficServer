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
        <script type="text/javascript" src="js/bootstrap.js"></script>
        <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="js/jquery.dataTables.extend.js"></script>
        <script type="text/javascript">
            var oTable;

            /* Formating function for row details */
            function fnFormatDetails(nTr)
            {
                var aData = oTable.fnGetData(nTr);
                var sOut = '<table class="table">';
                sOut += '<tr class="info"><td>'+'Ảnh (image)'+':</td><td>' + aData[2] + ' ' + aData[5] + '</td></tr>';
                sOut += '<tr class="info"><td>'+'Thông tin thêm (description)'+':</td><td>Could provide a link here</td></tr>';
                sOut += '<tr class="info"><td>'+'Thêm vào bởi (createdByUserID)'+':</td><td>And any further details here (images etc)</td></tr>';
                sOut += '<tr class="info"><td>'+'Ngày cập nhật gần nhất (updatedOnDate) bởi (updatedByUserID)'+':</td><td>And any further details here (images etc)</td></tr>';
                sOut += '<tr class="info"><td>'+'Ngày xóa (deletedOnDate) bởi (deletedByUserID)'+':</td><td>And any further details here (images etc)</td></tr>';
                sOut += '<tr class="info"><td>'+'Ngày khôi phục lại (restoreOnDate) bởi (restoreByUserID)'+':</td><td>And any further details here (images etc)</td></tr>';
                sOut += '</table>';

                return sOut;
            }
            $(function() {
                oTable = $('#myTable').dataTable({
                    "bProcessing": true,
                    "aaSorting": [[7, 'asc']],
                    "sDom": "<'row-fluid'<'span3'l><'span5'f>r>t<'row-fluid'<'span3'i><'span9'p>>",
                    "sPaginationType": "bootstrap",
                    "aoColumnDefs": [{'bSortable': false, 'bSearchable': false, 'aTargets': ["sorting_disabled"]}],
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
                                $('#myTable tbody td i').bind('click', function() {
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
        <section>
            <div class="container">
                <div class="row-fluid">
                    <div class="span12 table-list border-red">
                        <a href="#" class="btn btn-primary">Thêm điểm đen mới</a>
                        <i class="fa fa-times"></i> <a href="deletedlist.do" class="other-link">Danh sách điểm đen đã xóa</a> |
                        <i class="fa fa-user"></i> <a href="fromuser.do" class="other-link">Danh sách điểm đen từ người dùng</a>
                        <table id="myTable" class="table table-striped table-bordered table-hover table-condensed">
                            <caption>Danh sách điểm đen trên toàn quốc</caption>
                            <thead>
                                <tr>
                                    <th class="sorting_disabled"></th>
                                    <th>Tên</th>
                                    <th>Địa chỉ</th>
                                    <th>Tỉnh/Thành</th>
                                    <th>Quận/Huyện</th>
                                    <th>Phân loại</th>
                                    <th>Xếp hạng</th>
                                    <th>Ngày thêm vào</th>
                                    <th class="sorting_disabled"></th>
                                    <th class="sorting_disabled"></th>
                                    <th class="sorting_disabled"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="center"><i class="fa fa-angle-double-down"></i></td>
                                    <td>A</td>
                                    <td>B</td>
                                    <td>C</td>
                                    <td>C</td>
                                    <td>C</td>
                                    <td>C</td>
                                    <td>C</td>
                                    <td class="center"><a href="#" target="_blank"><i class="fa fa-map-marker" title="Xem trên bản đồ"></i></a></td>
                                    <td class="center"><a href="#"><i class="fa fa-pencil" title="Sửa"></i></a></td>
                                    <td class="center delete"><a href="#" class="delete"><i class="fa fa-times-circle" title="Xóa"></i></a></td>
                                </tr>
                                <tr class="error">
                                    <td class="center"><i class="fa fa-angle-double-down"></i></td>
                                    <td>D</td>
                                    <td>E</td>
                                    <td>F</td>
                                    <td>F</td>
                                    <td>F</td>
                                    <td>F</td>
                                    <td>F</td>
                                    <td class="center"><a href="#" target="_blank"><i class="fa fa-map-marker" title="Xem trên bản đồ"></i></a></td>
                                    <td class="center"><a href="#"><i class="fa fa-pencil" title="Sửa"></i></a></td>
                                    <td class="center"><a href="#"><i class="fa fa-rotate-left" title="Khôi phục lại"></i></a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>
