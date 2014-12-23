<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template"
%><bean:define id="publication"
             name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<bean:define id="checker"
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<bean:define id="form" name="neo.phoenix.person.PersonForm" type="neo.phoenix.person.PersonForm"/>
<div class="error"><html:errors property="global" /></div>

<input type="hidden" name="validateButton" value="save"/>
<input type="hidden" name="validateButton" value="globalRoles"/>
<input type="hidden" name="validateInput"  value="properties"/>
<input type="hidden" name="validateField" value="userName" />
<input type="hidden" name="validateField" value="password" />

<%@include file="../hiddenGlobalRoles.jspf" %>
<%@include file="../hiddenGroups.jspf" %>
<%@include file="../../base/relatedObjects.jspf" %>
<%@include file="../hiddenTags.jspf" %>
<%@include file="../hiddenContentTypes.jspf" %>
<%
  boolean isUser = neo.util.StringUtil.getBoolean(request.getParameter("isUser"),neo.util.StringUtil.getBoolean(form.getIsUser()));
  form.setIsUser(String.valueOf(isUser));
%>
<html:hidden property="isUser"/>
<template:call file="../editProps.jsp">
  <template:parameter key="canEditUser" value="<%=form.getIsUser()%>"/>
  <template:parameter key="isAdmin" value="true"/>
  <template:parameter key="isGuestUser" value="false"/>
  <template:parameter key="readOnly" value="false"/>
</template:call>
<br>
<table cellpadding="0" cellspacing="0" border="0">
<tr>
 <% if(isUser){ %>
 <td><a href="javascript:submitForm('globalRoles')" class="global-button"><bean:message key="b.next"/></a></td>
 <td>&nbsp;</td>
 <% } %>
 <td><input type="button" class="link" onclick="javascript:submitForm('cancel')" value="<bean:message key="b.cancel"/>"/></td>
 <td>&nbsp;</td>
 <td><input type="button" class="important-button" onclick="javascript:submitForm('save')" value="<bean:message key="b.save"/>"/></td>
</tr>
</table>
<input type="hidden" name="submitButton" value="">
