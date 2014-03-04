<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:if test="${empty sessionScope.blackpoints and empty cookie.blackpoints}">
    <c:redirect url="/login.do" />
</c:if>
<!DOCTYPE html>
<html>
    <head>
        <title><bean:message  key="poi.title"/> | <bean:message key="welcome.title"/></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="../includes/includeCSS.jsp" %>
    </head>
    <body>
        <%@include file="../includes/navbar-alter.jsp" %>
        <section style="padding-bottom:30px;">
            <div class="container">
                <div class="row">
                    <div class="span12 offset2" style="padding-top:20px; font-weight: bold;"><bean:message key="poi.note" /></div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="span7 offset2" style="min-height: 550px !important;">
                        <html:form styleId="tempPOIForm" method="POST" action="/AddNewTempPOIAction" styleClass="form-horizontal my-form">
                            <fieldset>
                                <legend><bean:message key="poi.legend.step1"/></legend>
                                <div class="control-group">
                                    <label class="control-label" for="name">
                                        <bean:message key="poi.name" />
                                        <span class="asterisk">*</span>
                                    </label>
                                    <div class="controls">
                                        <input type="text" id="name" name="name" placeholder="<bean:message key="poi.name" />"
                                               value="<bean:write name="TempPOIForm" property="name" />" />
                                        <label for="name" class="error"><html:errors property="name" /></label>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="address">
                                        <bean:message key="poi.address" />
                                        <span class="asterisk">*</span>
                                    </label>
                                    <div class="controls">
                                        <input type="text" id="address" name="address" placeholder="<bean:message key="poi.address" />"
                                               value="<bean:write name="TempPOIForm" property="address" />" />
                                        <label for="address" class="error"><html:errors property="address" /></label>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="city">
                                        <bean:message key="poi.city" />
                                        <span class="asterisk">*</span>
                                    </label>
                                    <div class="controls">
                                        <html:select name="TempPOIForm" property="city" styleId="city">
                                            <html:optionsCollection name="TempPOIForm" property="cityList" label="name" value="id"/>
                                        </html:select>
                                        <html:select name="TempPOIForm" property="district" styleId="district">
                                            <html:optionsCollection name="TempPOIForm" property="districtList" label="name" value="id"/>
                                        </html:select>
                                        <label for="city" class="error"><html:errors property="city" /></label>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="categoryID">
                                        <bean:message key="poi.categoryID" />
                                        <span class="asterisk">*</span>
                                    </label>
                                    <div class="controls">
                                        <html:select name="TempPOIForm" property="categoryID" styleId="categoryID">
                                            <html:option value="0"><bean:message key="poi.selectCategory" /></html:option>
                                            <html:optionsCollection name="TempPOIForm" property="categoryList" label="name" value="categoryID"/>
                                        </html:select>
                                        <label for="categoryID" class="error"><html:errors property="categoryID" /></label>
                                    </div>
                                </div>
                            </fieldset>
                            <fieldset>
                                <legend><bean:message key="poi.legend.step2"/></legend>
                                <div class="control-group">
                                    <label class="control-label" for="rating"><bean:message key="poi.rating" /></label>
                                    <div class="controls">
                                        <html:select styleId="rating" name="TempPOIForm" property="rating">
                                            <html:option value="1"><bean:message key="poi.rating.1"/></html:option>
                                            <html:option value="2"><bean:message key="poi.rating.2"/></html:option>
                                            <html:option value="3"><bean:message key="poi.rating.3"/></html:option>
                                            <html:option value="4"><bean:message key="poi.rating.4"/></html:option>
                                            <html:option value="5"><bean:message key="poi.rating.5"/></html:option>
                                        </html:select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="description"><bean:message key="poi.description" /></label>
                                    <div class="controls">
                                        <textarea id="description" name="description" placeholder="<bean:message key="poi.description" />"><bean:write name="TempPOIForm" property="description" /></textarea>
                                        <label for="description" class="error"><html:errors property="description" /></label>
                                    </div>
                                </div>
                            </fieldset>
                            <input type="reset" id="reset" class="btn pull-right" value="<bean:message key='poi.reset' />" />
                            <input id="step4" type="submit" class="btn btn-primary pull-right" value="<bean:message key='poi.submit' />" />
                        </html:form>
                        <div id="loading"></div>
                    </div>
                </div>
            </div>
        </section>
        <%@include file="../includes/footer.jsp" %>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
        <script type="text/javascript" src="js/jquery.validate.min.js"></script>
        <script type="text/javascript">
            $(function() {

                $("#city").change(function() {

                    $.ajax({
                        type: "GET",
                        url: "service/utils/getDistrictsInCity/" + $(this).val(),
                        dataType: "json",
                        success: function(json) {
                            // empty select
                            $("#district").empty();

                            $.each(json, function(idx, obj) {
                                $("#district").append('<option value="' + obj.id + '">' + obj.name + '</option>');
                            });
                        }
                    });
                });

                $.validator.addMethod("checkSelectCategory", function(value, element) {
                    return this.optional(element) || value !== "0";
                }, "<bean:message key="errors.select" arg0="kiểu điểm đen" />");

                $("#tempPOIForm").validate({
                    errorClass: "error",
                    rules: {
                        name: {
                            required: true,
                            minlength: 10,
                            maxlength: 100
                        },
                        address: {
                            required: true,
                            minlength: 10,
                            maxlength: 100
                        },
                        categoryID: {
                            checkSelectCategory: true
                        },
                        description: {
                            maxlength: 500
                        }
                    },
                    messages: {
                        name: {
                            required: "<bean:message key="errors.required" arg0="Tên" />",
                            minlength: "<bean:message key="errors.minlength" arg0="Tên điểm đen" arg1="10" />",
                            maxlength: "<bean:message key="errors.maxlength" arg0="Tên điểm đen" arg1="100" />"
                        },
                        address: {
                            required: "<bean:message key="errors.required" arg0="Địa chỉ" />",
                            minlength: "<bean:message key="errors.minlength" arg0="Địa chỉ" arg1="10" />",
                            maxlength: "<bean:message key="errors.maxlength" arg0="Địa chỉ" arg1="100" />"
                        },
                        description: {
                            maxlength: "<bean:message key="errors.maxlength" arg0="Thông tin thêm" arg1="500" />"
                        }
                    },
                    submitHandler: function(form) {
                        $("#tempPOIForm").fadeOut();
                        $('#loading').html('<img src="img/loading.GIF">' + '<bean:message key="poi.loading"/>');
                        $.ajax({
                            type: "POST",
                            url: "AddNewTempPOIAction.do",
                            data: $("#tempPOIForm").serialize(),
                            success: function(data) {
                                setTimeout(function() {
                                    if (data.trim() === "success") {
                                        $('#loading').html('<p><i class="fa fa-check"></i> ' + '<bean:message key="poi.success"/>' + '</p>');
                                    } else {
                                        $('#loading').html('<p class="error">' + '<bean:message key="poi.failure"/>' + '</p>');
                                    }
                                }, 2000);
                            },
                            error: function(e) {
                                setTimeout(function() {
                                    $('#loading').html('<p class="error">' + '<bean:message key="poi.failure"/>' + '</p>');
                                }, 2000);
                            }
                        });
                        // redirect
                        setTimeout(function() {
                            window.location.href = "poi.do";
                        }, 4000);
                    }
                });
            });
        </script>
    </body>
</html>