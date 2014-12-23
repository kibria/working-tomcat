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
<bean:define name="neo.phoenix.userGroup.UserGroupForm" id="form"
	scope="request" type="neo.phoenix.userGroup.UserGroupForm" />
<bean:define id="checker" name="escenic-access" scope="session"
	type="neo.phoenix.access.AccessChecker" />
<%@include file="../base/relatedObjects.jspf"%>
<%@include file="hiddenRelations.jspf"%>
<%@include file="hiddenMembers.jspf"%>
<%@include file="hiddenGroups.jspf"%>
<%@include file="hiddenGlobalRoles.jspf"%>
<%@include file="../person/hiddenTags.jspf" %>
<%@include file="hiddenProps.jspf" %>
<html:hidden property="parentWorkItemId" />

<input type="hidden" name="validateButton" value="edit" />
<input type="hidden" name="validateButton" value="editRoles" />
<input type="hidden" name="validateButton" value="save" />
<input type="hidden" name="validateInput" value="editContentTypes" />
<input type="hidden" name="validateField" value="none" />
<input type="hidden" name="submitButton" value="" />
<%
  boolean isReadOnly = neo.util.StringUtil.getBoolean(form.getReadOnly()) || !checker.isGlobalPublicationAdmin(publication.getId());
%>
<%@ include file="../person/editContentTypesFragment.jspf"%>