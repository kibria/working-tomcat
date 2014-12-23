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
<div><font color="red"><html:errors property="global" /></font></div>
<bean:define name="neo.phoenix.userGroup.UserGroupForm" id="form" type="neo.phoenix.userGroup.UserGroupForm"  />
<%@include file="../base/relatedObjects.jspf" %>
<%@include file="hiddenProps.jspf" %>
<%@include file="../person/hiddenTags.jspf" %>
<%@include file="../person/hiddenContentTypes.jspf" %>
<%@include file="hiddenRelations.jspf" %>
<%@include file="hiddenMembers.jspf" %>
<%@include file="hiddenGroups.jspf" %>
<html:hidden property="parentWorkItemId" />

<input type="hidden" name="validateInput"  value="editGlobalRoles"/>

<input type="hidden" name="validateButton" value="editGlobalRoles"/>
<input type="hidden" name="validateButton" value="save"/>
<input type="hidden" name="validateInput"  value="editGlobalRoles"/>
<input type="hidden" name="validateField" value="none" />
<bean:define id="checker" 
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<% 
  neo.xredsys.api.UserGroup group = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getUserGroup(form.getName(),Integer.parseInt(form.getPubId()));
  boolean isReadOnly = neo.util.StringUtil.getBoolean(form.getReadOnly()); 
%> 

<jsp:include page="../person/listGlobalRoles.jsp">
  <jsp:param name="readOnly" value="<%= isReadOnly %>"/>
</jsp:include>

<input type="hidden" name="submitButton" value="">
