<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-view" prefix="view" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<bean:define id="publication" 
             name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<bean:define id="checker"
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<div class="error"><html:errors property="global" /></div>
<bean:define name="neo.phoenix.person.PersonForm" id="form" scope="request" type="neo.phoenix.person.PersonForm"/>
<%@include file="../base/relatedObjects.jspf" %>
<%@include file="hiddenGroups.jspf" %>
<%@include file="hiddenGlobalRoles.jspf" %>
<%@include file="hiddenRelations.jspf" %>
<%@include file="hiddenTags.jspf" %>
<%@include file="hiddenContentTypes.jspf" %>
<html:hidden property="id" />
<html:hidden property="pubId" />
<html:hidden property="parentWorkItemId" />
<html:hidden property="isGuestUser"/>
<html:hidden property="readOnly"/>
<html:hidden property="hasFoundAllGroups"/>
<html:hidden property="isUser" />
<html:hidden property="editRoles" />
<input type="hidden" name="validateButton" value="edit"/>
<input type="hidden" name="validateButton" value="editRoles"/>
<input type="hidden" name="validateButton" value="save"/>
<input type="hidden" name="validateButton" value="saveAndClose"/>
<input type="hidden" name="validateInput"  value="edit"/>
<input type="hidden" name="validateField" value="userName" />
<% 
  neo.xredsys.api.Person person = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPerson(Integer.parseInt(form.getId()), Integer.parseInt(form.getPubId()));
  boolean canEditUser = checker.isGlobalPublicationAdmin(person.getOwnerPublicationId());
  if (canEditUser) {
    if (neo.util.StringUtil.isEmpty(form.getUserName())) canEditUser = false;
  }
  String canEditAsString = String.valueOf(canEditUser); 
  boolean isAdmin = true;
  String userName = form.getUserName();
  String sIsAdmin = String.valueOf(isAdmin);
  boolean isGuestUser = neo.util.StringUtil.getBoolean(form.getIsGuestUser());
%> 
<template:call file="editProps.jsp">
  <template:parameter key="canEditUser" value="<%=canEditAsString%>"/>
  <template:parameter key="isAdmin" value="<%=sIsAdmin%>"/>
  <template:parameter key="isGuestUser" value="<%=form.getIsGuestUser()%>"/>
  <template:parameter key="readOnly" value="<%=form.getReadOnly()%>"/>
</template:call>

<%-- <% if(canEditUser||isGuestUser){ %>
  <template:call file="presentGroups.jsp">
</template:call> 
<% } %>--%>
<input type="hidden" name="submitButton" value="">
<hr />
 
