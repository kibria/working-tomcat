<%@ page import="org.apache.commons.lang.StringUtils" %>
<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf"%>
<%-- END STANDARD HEADER --%>
<%@ page language="java"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util"
	prefix="util"%>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template"
	prefix="template"%>
<bean:define id="publication" name="escenic-publication" scope="session"
	type="neo.xredsys.api.Publication" />
<bean:define id="form" name="neo.phoenix.person.PersonForm"
	type="neo.phoenix.person.PersonForm" />
<bean:define id="checker" name="escenic-access" scope="session"
	type="neo.phoenix.access.AccessChecker" />
<%@include file="../base/relatedObjects.jspf"%>
<%@include file="hiddenProperties.jspf"%>
<%@include file="hiddenGlobalRoles.jspf"%>
<%@include file="hiddenGroups.jspf"%>
<%@include file="hiddenRelations.jspf"%>
<%@include file="hiddenTags.jspf"%>
<html:hidden property="parentWorkItemId" />
<html:hidden property="isGuestUser" />
<input type="hidden" name="validateButton" value="edit" />
<input type="hidden" name="validateButton" value="editRoles" />
<input type="hidden" name="validateButton" value="save" />
<input type="hidden" name="validateInput" value="editContentTypes" />
<input type="hidden" name="validateField" value="none" />
<input type="hidden" name="submitButton" value="">
<%
  boolean isAdmin = false;
  neo.xredsys.api.Person person = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPerson(Integer.parseInt(form.getId()), Integer.parseInt(form.getPubId()));
  String userName = form.getUserName();
  String pubName = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPublication(Integer.parseInt(form.getPubId())).getName();
  if(userName.equals(pubName+"_admin")){
    isAdmin = true;
    if(person.getOwnerPublicationId()!=publication.getId()){
      isAdmin = false;
    }
  }
  boolean isReadOnly = neo.util.StringUtil.getBoolean(form.getReadOnly()) || !checker.isGlobalPublicationAdmin(publication.getId()) || isAdmin;
%>

<%@ include file="editContentTypesFragment.jspf"%>
