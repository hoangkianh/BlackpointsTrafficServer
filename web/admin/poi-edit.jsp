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
        <title><bean:message key="admin.poi.edit.title" /></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="../includes/includeCSS.jsp" %>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?libraries=places&sensor=false&language=vi"></script>
        <script type="text/javascript" src="js/infobubble.min.js"></script>
        <script type="text/javascript" src="js/jquery.geocomplete.min.js"></script>
        <script type="text/javascript" src="js/map.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
        <script type="text/javascript" src="js/jquery.validate.min.js"></script>
        <script type="text/javascript" src="js/jquery.form.js"></script>
    </head>
    <body>
        <%@include file="../includes/navbar-alter.jsp" %>
        <%@include  file="../includes/navbar-admin-alter.jsp" %>
        <div id="map-modal" class="modal fade hide" style="width: 1000px; margin-left: -500px;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3><bean:message key="admin.poi.list.h3" /></h3>
                <div class="alert alert-holder alert-info">
                    <span><bean:message key="admin.poi.new.info" /></span>
                </div>
                <div class="offset2" style="margin-bottom: 1%;">
                    <div class="form-inline">
                        <div class="input-append">
                            <input type="text" id="search_address" placeholder="<bean:message key='map.enterAddress'/>" 
                                   style="height: 25px; width: 300px;"/>
                            <a class="btn btn-primary" id="search" href="#">
                                <i class="fa fa-search"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-body">
                <div id="map-canvas" style="height: 300px;"></div>
            </div>
            <div class="modal-footer">
                <a data-dismiss="modal" id="close-map" href="#"><bean:message key="admin.poi.form.close"/></a>
            </div>
        </div>
        <div id="upload-new-image" class="modal fade hide">
            <html:form styleId="updateImageForm" method="POST"
                       action="/UpdatePOIImageAction" styleClass="form-horizontal my-form">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h3><bean:message key="admin.poi.edit.h3" /></h3>
                </div>
                <div class="modal-body">
                    <html:hidden styleId="poiID" name="POIForm" property="id"/>
                    <div class="alert alert-holder">
                        <span><bean:message key="admin.poi.edit.warning" /></span>
                    </div>
                    <div class="controls">
                        <input type="file" id="file" name="file" accept="image/*" />
                    </div>
                </div>
                <div class="modal-footer">
                    <input id="step4" type="submit" class="btn btn-primary pull-right" value="<bean:message key="admin.poi.edit.upload" />" />
                </div>
            </html:form>
        </div>
        <section>
            <div class="container">
                <div class="row-fluid">
                    <div class="span12 form-admin border-red">
                        <div class="span8 offset2">
                            <a href="poilist.do" rel="tooltip" data-toggle="tooltip" data-placement="top"
                               title="<bean:message key="admin.poi.form.back"/>"><bean:message key="admin.poi.form.back"/></a>
                            <br/><br/>
                            <h3><bean:message key="admin.poi.edit.caption" /></h3>
                            <html:form styleId="editForm" method="POST" action="/UpdatePOIAction"
                                       styleClass="form-horizontal my-form" enctype="multipart/form-data">
                                <div class="control-group">
                                    <label class="control-label" for="name">
                                        <bean:message key="admin.poi.form.name" />
                                        <span class="asterisk">*</span>
                                    </label>
                                    <div class="controls">
                                        <input type="text" id="name" name="name" placeholder="<bean:message key="admin.poi.form.name" />"
                                               value="<bean:write name="POIForm" property="name" />"/>
                                        <label for="name" class="error"><html:errors property="name" /></label>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="address">
                                        <bean:message key="admin.poi.form.address" />
                                        <span class="asterisk">*</span>
                                    </label>
                                    <div class="controls">
                                        <input type="text" id="address" name="address" placeholder="<bean:message key="poi.address" />"
                                               value="<bean:write name="POIForm" property="address" />" />
                                        <label for="address" class="error"><html:errors property="address" /></label>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="city">
                                        <bean:message key="admin.poi.form.city" />
                                        <span class="asterisk">*</span>
                                    </label>
                                    <div class="controls">
                                        <html:select name="POIForm" property="city" styleId="city">
                                            <html:optionsCollection name="POIForm" property="cityList" label="name" value="id"/>
                                        </html:select>
                                        <html:select name="POIForm" property="district" styleId="district">
                                            <html:optionsCollection name="POIForm" property="districtList" label="name" value="id"/>
                                        </html:select>
                                        <label for="city" class="error"><html:errors property="city" /></label>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="longitude">
                                        <bean:message key="admin.poi.form.geometry" />
                                        <span class="asterisk">*</span>
                                    </label>
                                    <div class="controls">
                                        <input type="text" id="longitude" name="longitude" value="<bean:write name="POIForm" property="longitude"/>"
                                               class="input-medium"  placeholder="<bean:message key="admin.poi.form.longitude" />"/>
                                        <input type="text" id="latitude" name="latitude"  value="<bean:write name="POIForm" property="latitude"/>"
                                               class="input-medium" placeholder="<bean:message key="admin.poi.form.latitude" />"/>
                                        <a class="open-map" href="#map-modal" id="<bean:write name="POIForm" property="id"/>"><i rel="tooltip" data-toggle="tooltip" data-placement="top" class="fa fa-map-marker" title="<bean:message key="admin.poi.form.openMap"/>"></i></a>
                                        <label for="longitude" class="error"><html:errors property="longitude" /></label>
                                        <label for="latitude" class="error"><html:errors property="latitude" /></label>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="file">
                                        <bean:message key="admin.poi.form.file"/>
                                        <span class="asterisk">*</span>
                                    </label>
                                    <div class="controls">
                                        <a id="upload" href="#upload-new-image">
                                            <img height="100" src="<bean:write name="POIForm" property="image"/>" 
                                                 alt="<bean:write name="POIForm" property="name"/>" 
                                                 rel="tooltip" data-toggle="tooltip" data-placement="top"
                                                 title="<bean:message key="admin.poi.edit.file"/>"/>
                                        </a><br/>
                                        <small><bean:message key="admin.poi.edit.file"/></small>
                                        <label for="file" class="error"><html:errors property="file" /></label>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="categoryID">
                                        <bean:message key="admin.poi.form.category" />
                                        <span class="asterisk">*</span>
                                    </label>
                                    <div class="controls">
                                        <html:select name="POIForm" property="categoryID" styleId="categoryID">
                                            <html:option value="0"><bean:message key="poi.selectCategory" /></html:option>
                                            <html:optionsCollection name="POIForm" property="categoryList" label="name" value="categoryID"/>
                                        </html:select>
                                        <label for="categoryID" class="error"><html:errors property="categoryID" /></label>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="rating"><bean:message key="poi.rating" /></label>
                                    <div class="controls">
                                        <html:select styleId="rating" name="POIForm" property="rating">
                                            <html:option value="1"><bean:message key="poi.rating.1"/></html:option>
                                            <html:option value="2"><bean:message key="poi.rating.2"/></html:option>
                                            <html:option value="3"><bean:message key="poi.rating.3"/></html:option>
                                            <html:option value="4"><bean:message key="poi.rating.4"/></html:option>
                                            <html:option value="5"><bean:message key="poi.rating.5"/></html:option>
                                        </html:select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="description"><bean:message key="admin.poi.form.description"/></label>
                                    <div class="controls">
                                        <textarea id="description" name="description" placeholder="<bean:message key="admin.poi.form.description" />"><bean:write name="POIForm" property="description" /></textarea>
                                        <label for="description" class="error"><html:errors property="description" /></label>
                                    </div>
                                </div>
                                <input type="reset" id="reset" class="btn pull-right" value="<bean:message key="admin.poi.form.reset"/>" />
                                <input type="submit" class="btn btn-primary pull-right" value="<bean:message key="admin.poi.edit.submit"/>" />
                            </html:form>
                            <div id="loading"></div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <script type="text/javascript">
            $(function() {
                $('[rel=tooltip]').tooltip();

                MapsLib.initializeDisableDoubleClickZoom();
                MapsLib.doSearch();

                $("#search_address").geocomplete({
                    country: "vn",
                    markerOptions: {
                        draggable: true
                    }
                });
                $("#search_address").keydown(function(e) {
                    var key = e.keyCode ? e.keyCode : e.which;
                    if (key === 13) {
                        $('#search').click();
                        return false;
                    }
                });

                $('#search').click(function() {
                    MapsLib.doSearch();
                });

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

                $("a.open-map").click(function() {
                    $("#map-modal").modal();
                    var id = $(this).attr('id');
                    MapsLib.getPOIByID(id);
                    return false;
                });

                $("#close").click(function() {
                    $("#map-modal").modal('hide');
                    return false;
                });

                $('#map-modal').on('shown', function() {
                    var currentCenter = map.getCenter();
                    google.maps.event.trigger(map, "resize");
                    map.setCenter(currentCenter);
                });

                google.maps.event.addListener(map, 'dblclick', function(event) {
                    MapsLib.getLatLng(event.latLng);
                });

                function afterSuccess(data) {
                    setTimeout(function() {
                        if (data.trim() === "success") {
                            $('#loading').html('<p><i class="fa fa-check"></i> ' + '<bean:message key="admin.poi.edit.success"/>' + '</p>');
                        } else {
                            $('#loading').html('<p class="error">' + '<bean:message key="admin.poi.edit.failure"/>' + '</p>');
                        }
                    }, 2000);
                    setTimeout(function() {
                        window.location.href = "poilist.do";
                    }, 3500);
                }

                function onProgress() {
                    $("#editForm").fadeOut();
                    $('#loading').html('<img src="img/loading.GIF">' + '<bean:message key="admin.loading"/>');
                }

                $.validator.addMethod("checkSelectCategory", function(value, element) {
                    return this.optional(element) || value !== "0";
                }, "<bean:message key="errors.select" arg0="kiểu điểm đen" />");


                $("#editForm").validate({
                    errorClass: "error",
                    rules: {
                        name: {
                            required: true,
                            minlength: 4,
                            maxlength: 100
                        },
                        address: {
                            required: true,
                            minlength: 10,
                            maxlength: 100
                        },
                        longitude: {
                            required: true
                        },
                        latitude: {
                            required: true
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
                            required: "<bean:message key="errors.required" arg0="Tên điểm đen" />",
                            minlength: "<bean:message key="errors.minlength" arg0="Tên điểm đen" arg1="4" />",
                            maxlength: "<bean:message key="errors.maxlength" arg0="Tên điểm đen" arg1="100" />"
                        },
                        address: {
                            required: "<bean:message key="errors.required" arg0="Địa chỉ" />",
                            minlength: "<bean:message key="errors.minlength" arg0="Địa chỉ" arg1="10" />",
                            maxlength: "<bean:message key="errors.maxlength" arg0="Địa chỉ" arg1="100" />"
                        },
                        longitude: {
                            required: "<bean:message key="errors.required" arg0="Kinh độ" />",
                        },
                        latitude: {
                            required: "<bean:message key="errors.required" arg0="Vĩ độ" />",
                        },
                        description: {
                            maxlength: "<bean:message key="errors.maxlength" arg0="Thông tin thêm" arg1="500" />"
                        }
                    },
                    submitHandler: function(form) {
                        var options = {
                            success: afterSuccess,
                            uploadProgress: onProgress
                        };
                        $('#editForm').ajaxSubmit(options);
                    }
                });

                $('#upload').click(function() {
                    // remove messageDiv
                    $("#messageDiv").remove();

                    $('#upload-new-image').modal();
                    return false;
                });

                function afterUpdateImageSuccess(data) {
                    if ($("#messageDiv").length === 0) {
                        $("#upload-new-image .modal-header").append('<bean:message key="message.messageDiv"/>');
                    }
                    switch (data.trim())
                    {
                        case "success":
                            $("#messageDiv").addClass("alert-success").removeClass("alert-error");
                            $("#message").html('<bean:message key="admin.poi.edit.success"/>');
                            // redirect
                            setTimeout(function() {
                                window.location.href = "editpoi.do?id=<bean:write name="POIForm" property="id" />";
                            }, 1000);
                            break;
                        default:
                            $("#messageDiv").addClass("alert-error").removeClass("alert-success");
                            $("#message").html('<bean:message key="admin.poi.edit.failure"/>');
                            break;
                    }
                }

                $.validator.addMethod("checkFileType", function(value, element) {
                    var kq = true;
                    if (window.File && window.FileReader && window.FileList && window.Blob) {
                        var ftype = $('#file')[0].files[0].type; // get file type

                        if (ftype !== 'image/png' &&
                                ftype !== 'image/jpeg' &&
                                ftype !== 'image/bmp') {
                            kq = false;
                        }
                    }
                    else {
                        kq = false;
                    }
                    return this.optional(element) || kq;
                }, "<bean:message key="errors.file.extension" arg0=".png, .jpg, .jpeg, .bmp" />");

                $.validator.addMethod("checkFileSize", function(value, element) {
                    var kq = true;
                    if (window.File && window.FileReader && window.FileList && window.Blob) {
                        var fsize = $('#file')[0].files[0].size;
                        if (fsize > 1048576) {
                            kq = false;
                        }
                    }
                    else {
                        kq = false;
                    }
                    return this.optional(element) || kq;
                }, "<bean:message key="errors.file.size" />");

                $("#updateImageForm").validate({
                    errorClass: "error",
                    rules: {
                        file: {
                            required: true,
                            checkFileType: true,
                            checkFileSize: true
                        }
                    },
                    messages: {
                        file: {
                            required: "<bean:message key="errors.file.required" />"
                        }
                    },
                    submitHandler: function(form) {
                        var options = {
                            success: afterUpdateImageSuccess
                        };
                        $('#updateImageForm').ajaxSubmit(options);
                    }
                });
            });
        </script>
    </body>
</html>