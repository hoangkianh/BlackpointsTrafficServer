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
        <title><bean:message key="admin.title.category" /> | <bean:message key="admin.category.new.title" /></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="../includes/includeCSS.jsp" %>
    </head>
    <body>
        <%@include file="../includes/navbar-alter.jsp" %>
        <%@include  file="../includes/navbar-admin-alter.jsp" %>
        <section>
            <div class="container">
                <div class="row-fluid">
                    <div class="span12 form-admin border-red">
                        <div class="span8 offset2">
                            <h3><bean:message key="admin.category.new.caption" /></h3>
                            <html:form styleId="categoryForm" method="POST" action="/AddNewCategoryAction"
                                       styleClass="form-horizontal my-form" enctype="multipart/form-data">
                                <div class="control-group">
                                    <label class="control-label" for="name">
                                        <bean:message key="admin.category.form.name" />
                                        <span class="asterisk">*</span>
                                    </label>
                                    <div class="controls">
                                        <input type="text" id="name" name="name" placeholder="<bean:message key="admin.category.form.name" />"
                                               value="<bean:write name="CategoryForm" property="name" />"/>
                                        <label for="name" class="error"><html:errors property="name" /></label>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="file">
                                        <bean:message key="admin.category.form.file"/>
                                        <span class="asterisk">*</span>
                                    </label>
                                    <div class="controls">
                                        <html:file styleId="file" name="CategoryForm" property="file" accept="image/png" />
                                        <label for="file" class="error"><html:errors property="file" /></label>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="description"><bean:message key="admin.category.form.description"/></label>
                                    <div class="controls">
                                        <textarea id="description" name="description" placeholder="<bean:message key="admin.category.form.description" />"><bean:write name="CategoryForm" property="description" /></textarea>
                                        <label for="description" class="error"><html:errors property="description" /></label>
                                    </div>
                                </div>
                                <a href="category.do" rel="tooltip" data-toggle="tooltip" data-placement="top" title="<bean:message key="admin.category.form.back"/>"><bean:message key="admin.category.form.back"/></a>
                                <input type="reset" id="reset" class="btn pull-right" value="<bean:message key="admin.category.form.reset"/>" />
                                <input type="submit" class="btn btn-primary pull-right" value="<bean:message key="admin.category.new.submit"/>" />
                            </html:form>
                            <div id="loading"></div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
        <script type="text/javascript" src="js/jquery.validate.min.js"></script>
        <script type="text/javascript" src="js/jquery.form.js"></script>
        <script type="text/javascript">
            $(function() {
                $('[rel=tooltip]').tooltip();

                function afterSuccess(data) {
                    setTimeout(function() {
                        if (data.trim() === "success") {
                            $('#loading').html('<p><i class="fa fa-check"></i> ' + '<bean:message key="admin.category.new.success"/>' + '</p>');
                        } else {
                            $('#loading').html('<p class="error">' + '<bean:message key="admin.category.new.failure"/>' + '</p>');
                        }
                    }, 2000);
                    setTimeout(function() {
                        window.location.href = "category.do";
                    }, 3500);
                }

                function onProgress() {
                    $("#categoryForm").fadeOut();
                    $('#loading').html('<img src="img/loading.GIF">' + '<bean:message key="admin.loading"/>');
                }

                $.validator.addMethod("checkFileType", function(value, element) {
                    var kq = true;
                    if (window.File && window.FileReader && window.FileList && window.Blob) {
                        var ftype = $('#file')[0].files[0].type; // get file type

                        if (ftype !== 'image/png') {
                            kq = false;
                        }
                    }
                    else {
                        kq = false;
                    }
                    return this.optional(element) || kq;
                }, "<bean:message key="errors.file.extension" arg0=".png" />");

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

                $("#categoryForm").validate({
                    errorClass: "error",
                    rules: {
                        name: {
                            required: true,
                            minlength: 4,
                            maxlength: 30
                        },
                        file: {
                            required: true,
                            checkFileType: true,
                            checkFileSize: true
                        },
                        description: {
                            maxlength: 200
                        }
                    },
                    messages: {
                        name: {
                            required: "<bean:message key="errors.required" arg0="Tên loại" />",
                            minlength: "<bean:message key="errors.minlength" arg0="Tên loại" arg1="4" />",
                            maxlength: "<bean:message key="errors.maxlength" arg0="Tên loại" arg1="30" />"
                        },
                        file: {
                            required: "<bean:message key="errors.file.required" />",
                        },
                        description: {
                            maxlength: "<bean:message key="errors.maxlength" arg0="Thông tin thêm" arg1="200" />"
                        }
                    },
                    submitHandler: function(form) {
                        var options = {
                            success: afterSuccess,
                            uploadProgress: onProgress
                        };
                        $('#categoryForm').ajaxSubmit(options);
                    }
                });
            });
        </script>
    </body>
</html>
