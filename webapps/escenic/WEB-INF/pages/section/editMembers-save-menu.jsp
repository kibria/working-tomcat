<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>

<%@ 
taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %><%@
taglib uri="http://struts.apache.org/tags-html" prefix="html" %><%@
taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %><%@
taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %><%@
taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>

<bean:define id="publication" name="escenic-publication" scope="session" type="neo.xredsys.api.Publication"/>
<bean:define id="form" name="neo.phoenix.section.SectionMembersForm" type="neo.phoenix.section.SectionMembersForm"/>
<bean:define id="checker" name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<% boolean readOnly = neo.util.StringUtil.getBoolean(form.getReadOnly()); %>

<%
   String close ="javascript:submitForm('cancel')";
   String save ="javascript:submitForm('save')";
 %>
<template:call file="../base/actionBox.jsp" >
  <template:parameter key="readOnly" value="<%=String.valueOf(readOnly)%>" />
  <%if(!readOnly){%>
    <template:parameter key="saveAction" value='<%=save%>' />
  <%}%>
 	<template:parameter key="closeAction" value='<%=close%>' />
</template:call>

<script>
  function previewWindowOnLoadHook() {
<% if (request.getAttribute("previewUrl") != null) { %>
    window.open('<%=request.getAttribute("previewUrl")%>', 'escenicPreview');
<% } %>
    return true;
  }
  registerHook('onLoad',previewWindowOnLoadHook);
</script>
