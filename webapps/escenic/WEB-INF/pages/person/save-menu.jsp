<%@ page import="java.util.Properties" %>
<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@
taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %><%@
taglib uri="http://struts.apache.org/tags-html" prefix="html" %><%@
taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %><%@
taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %><%@
taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %><bean:define
id="publication" name="escenic-publication" scope="session" type="neo.xredsys.api.Publication"/><bean:define
name="neo.phoenix.person.PersonForm" id="form" type="neo.phoenix.person.PersonForm"
/><bean:define id="checker"
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<% boolean readOnly = neo.util.StringUtil.getBoolean(form.getReadOnly()); %>
 <%
   String cancel = "javascript:submitForm('close')";
   String save = "javascript:submitForm('save')";

   String saveAndClose = null;
   Properties preferences = (Properties) neo.nursery.GlobalBus.lookupSafe("/com/escenic/webstudio/Preferences");
   if (neo.util.StringUtil.getBoolean(preferences.getProperty("displaySaveAndCloseButton"), false)) {
     saveAndClose = "javascript:submitForm('saveAndClose')";
   }
 %>
<template:call file="../base/actionBox.jsp" >
  <template:parameter key="readOnly" value="<%=String.valueOf(readOnly)%>" />
  <template:parameter key="saveAction" value='<%=save%>' />
  <template:parameter key="closeAction" value='<%=cancel%>' />
  <%if (saveAndClose != null) {%>
  <template:parameter key="saveAndCloseAction" value='<%=saveAndClose%>' />
  <%}%>
</template:call>
