<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<!-- viewTemplates.jsp -->
<%@ page language="java" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>

<!-- Calling frame -->
<%--
<template:call file="../base/frame.jsp">
  <template:parameter key="includeWorkItems"         value="true" />
  <template:parameter key="includeMenu"              value="true" />
  <template:parameter key="includeLogoffButton"      value="true" />
  <template:parameter key="includeBasket"            value="true" />
  <template:parameter key="isSubmittingForm"         value="false" />
  <template:parameter key="title"                    value="l.Templates" />
  <template:parameter key="content"                  value="/WEB-INF/pages/publication/deleteLayout-content.jsp" />
</template:call>
--%>
<!-- Finished call to frame -->
<!-- End of viewTemplates.jsp  -->

<!-- viewTemplates.jsp -->

<!-- Calling frame -->
<bean:define id="task" value="/publication/deleteLayout" toScope="request" />
<jsp:forward page="/WEB-INF/pages/framework/frame.jsp" />


