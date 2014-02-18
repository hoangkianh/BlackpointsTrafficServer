<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:if test="${empty param.f}">
    <c:redirect url="/"/>
</c:if>
<!DOCTYPE html>
<html>
    <head>
        <title><bean:message key="failure.header" /> | <bean:message key="welcome.title"/></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="../includes/includeCSS.jsp" %>
    </head>
    <body>
        <%@include file="../includes/navbar.jsp" %>
        <div id="headerwrap">
            <header class="clearfix">
                <div class="container">
                    <h1><i class="fa fa-exclamation-triangle fa-2x error"></i></h1>                    
                    <h1><bean:message key="failure.${param.f}"/></h1>
                    <h3><bean:message key="failure.message.${param.f}" /></h3>                    
                </div>
            </header>
        </div>
    </body>
</html>
