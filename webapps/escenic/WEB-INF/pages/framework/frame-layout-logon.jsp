<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!-- Frame begins -->
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<html>
<template:serviceParameter name="areamap-frame-header"/>
<body id="body" class="login-background invisible" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" onLoad="callHooks('onLoad'); callHooks('afterLoad');">
<div id="body-container">
<bean:define id="form" name="textmap-form" type="java.lang.String" />
<bean:define id="enctype" name="enctype" type="java.lang.String" />

<html:form action="<%=form%>" enctype="<%=enctype%>" onsubmit="callHooks('onSubmit');">

<%-- Start table surounding complete page to place loginbox in the middle of the browser  --%>
<template:serviceParameter name="areamap-frame-main" />
<%-- End table surounding complete page to place loginbox in the middle of the browser  --%>

</html:form>
</div>
</body>
