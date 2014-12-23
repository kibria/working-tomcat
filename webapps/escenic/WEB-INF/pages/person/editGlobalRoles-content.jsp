<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<bean:define id="publication" 
             name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<div><font color="red"><html:errors property="global" /></font></div>
<bean:define name="neo.phoenix.person.PersonForm" id="form" type="neo.phoenix.person.PersonForm"  />
<%@include file="../base/relatedObjects.jspf" %>
<%@include file="hiddenProperties.jspf" %>
<%@include file="hiddenGroups.jspf" %>
<%@include file="hiddenRelations.jspf" %>
<%@include file="hiddenTags.jspf" %>
<%@include file="hiddenContentTypes.jspf" %>
<html:hidden property="parentWorkItemId" />
<html:hidden property="isGuestUser"/>
<input type="hidden" name="validateButton" value="editGlobalRoles"/>
<input type="hidden" name="validateButton" value="save"/>
<input type="hidden" name="validateInput"  value="editGlobalRoles"/>
<input type="hidden" name="validateField" value="none" />
<bean:define id="checker" 
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<% 
  boolean isReadOnly = neo.util.StringUtil.getBoolean(form.getReadOnly());
  neo.xredsys.api.Person person = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPerson(Integer.parseInt(form.getId()), Integer.parseInt(form.getPubId()));
  boolean canEditUser = checker.isGlobalPublicationAdmin(person.getOwnerPublicationId());
  String canEditAsString = String.valueOf(canEditUser); 
  boolean isAdmin = false;
  String userName = form.getUserName();
  String pubName = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPublication(Integer.parseInt(form.getPubId())).getName();
  if(userName.equals(pubName+"_admin")){
    isAdmin = true;
    if(person.getOwnerPublicationId()!=publication.getId()){
      isAdmin = false;
    }
  }
  
  String sIsAdmin = String.valueOf(isAdmin);
  boolean isGuestUser = neo.util.StringUtil.getBoolean(form.getIsGuestUser());

  boolean readOnly = isAdmin || isReadOnly;
%> 
<% if(canEditUser||isGuestUser){ %>
<jsp:include page="listGlobalRoles.jsp">
  <jsp:param name="readOnly" value="<%= readOnly %>"/>
</jsp:include>
<% } %>

<input type="hidden" name="submitButton" value="">
