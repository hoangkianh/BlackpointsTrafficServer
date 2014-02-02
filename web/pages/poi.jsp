<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:if test="${empty sessionScope.blackpoints and empty cookie.blackpoints}">
    <c:redirect url="/" />
</c:if>
<!DOCTYPE html>
<html>
    <head>
        <title><bean:message key="welcome.title"/> - <bean:message  key="poi.title"/></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="../includes/includeCSS.jsp" %>
    </head>
    <body>
        <div class="navbar-wrapper">
            <div class="navbar navbar-inverse navbar-static-top">
                <div class="navbar-inner">
                    <div class="container">
                        <a class="btn btn-navbar"  data-toggle="collapse" data-target=".nav-collapse">
                            <i class="fa fa-bars"></i>
                        </a>
                        <h1 class="brand">
                            <html:link action="/home"><bean:message key="navbar.webLogo"/></html:link>
                            </h1>
                            <nav class="pull-right nav-collapse collapse">
                                <ul id="menu-main" class="nav">                                
                                    <li>
                                    <html:link action="/home" ><bean:message key="navbar.home"/></html:link>
                                    </li>
                                    <li>
                                    <html:link action="/map" ><bean:message key="navbar.map"/></html:link>
                                    </li>
                                    <li>
                                        <a href="#">
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.blackpoints}">
                                                <c:set var="userStr" value="${fn:split(sessionScope.blackpoints, '~')}"/>
                                            </c:when>
                                            <c:otherwise>                                                        
                                                <c:set var="userStr" value="${fn:split(cookie.blackpoints.value, '~')}"/>                                                            
                                            </c:otherwise>
                                        </c:choose>
                                        ${userStr[2]}
                                    </a>
                                </li>
                                <c:if test="${userStr[3] ne 3}">
                                    <li>
                                        <a href="#"><i class="fa fa-gear"></i> <bean:message key="navbar.controlPanel"/></a>
                                    </li>
                                </c:if>
                                <li>
                                    <html:link action="logout"><i class="fa fa-sign-out"></i> <bean:message key="logout" /></html:link>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
            <section id="map-wrapper">
                <div class="container">
                    <div class="row">
                        <div class="span12">
                        <bean:message key="poi.note" />
                        <h3><a href="#" id="startIntro"><i class="fa fa-question-circle"></i> <bean:message key="poi.intro"/></a></h3>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="span5">
                        <html:form styleId="poiForm" method="POST" action="/AddNewPOIAction" styleClass="form-horizontal my-form">
                            <fieldset id="step1">
                                <legend><bean:message key="poi.legend.step1"/></legend>
                                <div class="control-group">
                                    <label class="control-label" for="categoryID">
                                        <bean:message key="poi.categoryID" />
                                        <span class="asterisk">*</span>
                                    </label>
                                    <div class="controls">
                                        <select id="categoryID" name="categoryID">
                                            <option value="0"><bean:message key="poi.select" /></option>
                                            <logic:iterate id="c" name="POIForm" property="categoryList">
                                                <option value="<bean:write name="c" property="categoryID" />"><bean:write name="c" property="name" /></option>
                                            </logic:iterate>
                                        </select>
                                        <label for="categoryID" class="error"><html:errors property="name" /></label>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="address">
                                        <bean:message key="poi.address" />
                                        <span class="asterisk">*</span>
                                    </label>
                                    <div class="controls">
                                        <div class="input-append">
                                            <input type="text" id="name" name="name" placeholder="<bean:message key="poi.address" />"
                                                   value="<bean:write name="POIForm" property="name" />" style="height: 17px;" />
                                            <a class="btn btn-primary" id="search" href="#">
                                                <i class="fa fa-search"></i>
                                            </a>
                                        </div>
                                        <label for="name" class="error"><html:errors property="name" /></label>
                                    </div>
                                </div>
                            </fieldset>
                            <fieldset id="step3">
                                <legend><bean:message key="poi.legend.step3"/></legend>
                                <div class="control-group">
                                    <label class="control-label" for="rating"><bean:message key="poi.rating" /></label>
                                    <ul id="rating">
                                        <li><a href="#"><bean:message key="poi.rating.1"/></a></li>
                                        <li><a href="#"><bean:message key="poi.rating.2"/></a></li>
                                        <li><a href="#"><bean:message key="poi.rating.3"/></a></li>
                                        <li><a href="#"><bean:message key="poi.rating.4"/></a></li>
                                        <li><a href="#"><bean:message key="poi.rating.5"/></a></li>
                                    </ul>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="description"><bean:message key="poi.description" /></label>
                                    <div class="controls">
                                        <textarea id="description" name="description" placeholder="<bean:message key="poi.description" />"><bean:write name="POIForm" property="description" /></textarea>
                                        <label for="description" class="error"><html:errors property="description" /></label>
                                    </div>
                                </div>
                            </fieldset>
                            <input type="reset" class="btn pull-right" value="<bean:message key='poi.reset' />" />
                            <input id="step4" type="submit" class="btn btn-primary pull-right" value="<bean:message key='poi.submit' />" />
                        </html:form>
                    </div>
                    <div class="span7">
                        <fieldset id="step2">
                            <legend><bean:message key="poi.legend.step2"/></legend>
                            <div class="control-group">
                                <div id="map-canvas" style="height: 500px;"></div>
                            </div>
                        </fieldset>
                    </div>
                </div>
            </div>
        </section>        
        <script type="text/javascript" src="//code.jquery.com/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
        <script type="text/javascript" src="js/jquery.address.js"></script>
        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?libraries=places&sensor=true&language=vi"></script>
        <script type="text/javascript" src="js/jquery.geocomplete.min.js"></script>
        <script type="text/javascript" src="js/jquery.validate.min.js"></script>
        <script type="text/javascript" src="js/intro.js"></script>
        <script type="text/javascript" src="js/map.js"></script>
        <script type="text/javascript" src="js/poi.js"></script>
        <script type="text/javascript">
            $(function() {
                $("#name").geocomplete();
                MapsLib.initialize();

                $.validator.addMethod("checkSelect", function(value, element) {
                    return this.optional(element) || value !== "0";
                }, "<bean:message key="errors.select" arg0="kiểu điểm đen" />");

                $("#poiForm").validate({
                    errorClass: "error",
                    validClass: "valid",
                    highlight: function(element, errorClass, validClass) {
                        $(element).addClass(errorClass);
                        $(element).parent().find("label[for=" + element.id + "]")
                                .removeClass(validClass)
                                .addClass(errorClass)
                                .css("display", "block");
                    },
                    unhighlight: function(element, errorClass, validClass) {
                        $(element).removeClass(errorClass);
                        $(element).parent().find("label[for=" + element.id + "]")
                                .removeClass(errorClass)
                                .addClass(validClass)
                                .html("<i class='fa fa-check valid'></i>")
                                .css("display", "block");
                    },
                    rules: {
                        name: {
                            required: true,
                            maxlength: 100
                        },
                        categoryID: {
                            checkSelect: true
                        },
                        description: {
                            maxlength: 500
                        }
                    },
                    messages: {
                        name: {
                            required: "<bean:message key="errors.required" arg0="Địa chỉ điểm đen" />",
                            maxlength: "<bean:message key="errors.maxlength" arg0="Địa chỉ điểm đen" arg1="100" />"
                        },
                        categoryID: {
                            checkSelect: "<bean:message key="errors.required" arg0="Kiểu điểm đen" />"
                        },
                        description: {
                            maxlength: "<bean:message key="errors.maxlength" arg0="Thông tin thêm" arg1="500" />"
                        }
                    }
                });

                $("#startIntro").click(function() {
                    var intro = introJs();
                    intro.setOptions({
                        steps: [
                            {
                                element: "#step1",
                                intro: "<bean:message key="poi.intro.step1"/>"
                            },
                            {
                                element: "#step2",
                                intro: "<bean:message key="poi.intro.step2"/>",
                                position: 'left'
                            },
                            {
                                element: "#step3",
                                intro: "<bean:message key="poi.intro.step3"/>",
                                position: 'top'
                            },
                            {
                                element: "#step4",
                                intro: "<bean:message key="poi.intro.step4"/>",
                                position: 'top'
                            }
                        ],
                        nextLabel: "<bean:message key="poi.intro.nextLabel"/>",
                        prevLabel: "<bean:message key="poi.intro.prevLabel"/>",
                        doneLabel: "<bean:message key="poi.intro.doneLabel"/>",
                        skipLabel: "<bean:message key="poi.intro.skipLabel"/>",
                    });
                    intro.start();
                });
            });
        </script>
    </body>
</html>
