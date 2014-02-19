<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<section>
    <div class="container">
        <div class="row">
            <div class="span12">
                <div class="navbar">
                    <div class="navbar-inner">
                        <ul class="nav" id="menu-admin">
                            <li><a href="dashboard.do" title="<bean:message key="navbar.admin.backToDashBoard"/>">&leftarrow;<bean:message key="navbar.admin.backToDashBoard"/></a></li>
                            <li class="dropdown">
                                <a id="drop1" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">
                                    <bean:message key="navbar.admin.blackpoints" />
                                    <b class="caret"></b>
                                </a>
                                <ul class="dropdown-menu" role="menu" aria-labelledby="drop1">
                                    <li>
                                        <a href="poilist.do"><bean:message key="navbar.admin.blackpoints.list" /></a>
                                    </li>
                                    <li>
                                        <a href="#"><bean:message key="navbar.admin.blackpoints.deleted" /></a>
                                    </li>
                                    <li>
                                        <a href="#"><bean:message key="navbar.admin.blackpoints.fromUser" /></a>
                                    </li>
                                    <li>
                                        <a href="#"><bean:message key="navbar.admin.blackpoints.category" /></a>
                                    </li>
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a id="drop1" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">
                                    <bean:message key="navbar.admin.user" />
                                    <b class="caret"></b>
                                </a>
                                <ul class="dropdown-menu" role="menu" aria-labelledby="drop1">
                                    <li>
                                        <a href="#"><bean:message key="navbar.admin.user.list" /></a>
                                    </li>
                                    <li>
                                        <a href="#"><bean:message key="navbar.admin.user.group" /></a>
                                    </li>
                                    <li>
                                        <a href="#"><bean:message key="navbar.admin.user.admin" /></a>
                                    </li>
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a id="drop1" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">
                                    <bean:message key="navbar.admin.other" />
                                    <b class="caret"></b>
                                </a>
                                <ul class="dropdown-menu" role="menu" aria-labelledby="drop1">
                                    <li>
                                        <a href="#"><bean:message key="navbar.admin.other.service" /></a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>