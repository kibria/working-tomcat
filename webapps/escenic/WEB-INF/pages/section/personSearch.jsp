<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<!-- search.jsp -->
<%@ page language="java" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<!-- Calling frame -->
<template:call file="../base/frame.jsp">
  <template:parameter key="includeWorkItems"         value="true" />
  <template:parameter key="includeLogoffButton"      value="true" />
  <template:parameter key="includeBasket"            value="true" />
  <template:parameter key="isSubmittingForm"         value="false" />
  <template:parameter key="title"                    value="h.Person_archive" />
  <template:parameter key="content"                  value="/WEB-INF/pages/section/personSearch-content.jsp" />
</template:call>
<!-- Finished call to frame -->
<!-- End of search.jsp  -->
