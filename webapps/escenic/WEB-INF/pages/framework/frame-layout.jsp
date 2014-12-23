<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!-- Frame begins -->
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %><%@
taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %><%@
taglib uri="http://struts.apache.org/tags-html" prefix="html" %><%@
taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>

<%-- Set a few default values, if they are not set by the calling JSP. --%>
<%-- By default, include the menu... --%>
<logic:notPresent name="includeMenu" scope="request">
  <bean:define id="includeMenu" value="true" toScope="request"/>
</logic:notPresent>

<%-- 
   By default, assume we're not submitting a form in the content area.
--%>
<logic:notPresent name="isSubmittingForm" scope="request">
  <bean:define id="isSubmittingForm" value="false" toScope="request"/>
</logic:notPresent>

<%-- 
   Set up some default list colors; blue on white....
--%>
<logic:notPresent name="navigation" scope="request">
  <bean:define id="navigation" value="navigation.jsp" toScope="request" />
</logic:notPresent>


<%--
     Include the header, start the body and show the banner...  
     These could be inlined. 
 --%>
<html>
<template:serviceParameter name="areamap-frame-header"/>
<body onload="callHooks('onLoad'); callHooks('afterLoad');" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" >
<div id="body-container">
<bean:define id="form" name="textmap-form" type="java.lang.String" />
<bean:define id="enctype" name="enctype" type="java.lang.String" />

<html:form action="<%=form%>" enctype="<%=enctype%>" onsubmit="callHooks('onSubmit');">
<div id="frame-top"><template:serviceParameter name="areamap-frame-top" /></div>
<div id="frame-left"><template:serviceParameter name="areamap-frame-left" /></div>
<div id="frame-main"><template:serviceParameter name="areamap-frame-main" /></div>
</html:form>
</div>
</body>
