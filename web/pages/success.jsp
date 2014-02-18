<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:if test="${empty param.s}">
    <c:redirect url="/"/>
</c:if>
<!DOCTYPE html>
<html>
    <head>
        <title><bean:message key="success.header" /> | <bean:message key="welcome.title"/></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="../includes/includeCSS.jsp" %>
    </head>
    <body>
        <%@include file="../includes/navbar.jsp" %>
        <div id="headerwrap">
            <header class="clearfix">
                <div class="container">
                    <h1 style="color:#208C00;"><i class="fa fa-check fa-2x valid"></i></h1>
                    <h1><bean:message key="success.${param.s}" /></h1>
                    <h3><bean:message key="success.message.${param.s}" /></h3>
                </div>
            </header>
        </div>
    </body>
</html>
