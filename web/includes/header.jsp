<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<div id="headerwrap">
    <header class="clearfix">
        <div class="container">
            <h1><span><bean:message key="headerwrap.projectTitle"/></span></h1>
            <h2><bean:message key="headerwrap.nameLine1"/></h2>
            <h2><bean:message key="headerwrap.nameLine2"/> <i class="fa fa-cloud"></i></h2>
            <h3><bean:message key="headerwrap.studentName"/></h3>
            <h3><bean:message key="headerwrap.teacherName"/></span></h3>
            <p id="p-arrow">
                <a class="first-link" href="#map" title="Xem bản đồ điểm đen tai nạn giao thông"><i class="fa fa-arrow-circle-down fa-3x"></i></a>
                <a class="second-link" href="#map"><i class="fa fa-arrow-circle-down fa-3x"></i></a>
            </p>
        </div>
    </header>
</div>