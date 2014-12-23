<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<!-- Calling frame -->
<template:call file="../base/frame.jsp">
  <template:parameter key="includeWorkItems"         value="true" />
  <template:parameter key="includeLogoffButton"      value="true" />
  <template:parameter key="includeBasket"            value="true" />
  <template:parameter key="isSubmittingForm"         value="true" />
  <template:parameter key="title"                    value="h.Edit_section_members" />
  <template:parameter key="content"                  value="/WEB-INF/pages/section/listMembersByRole-content.jsp" />
</template:call>
<!-- Finished call to frame -->
