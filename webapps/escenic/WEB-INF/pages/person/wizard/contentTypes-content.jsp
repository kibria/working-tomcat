<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<bean:define id="publication"
             name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<bean:define id="form" name="neo.phoenix.person.PersonForm" type="neo.phoenix.person.PersonForm"/>
<bean:define id="checker"
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<%@include file="../../base/relatedObjects.jspf" %>
<%@include file="../hiddenProperties.jspf" %>
<%@include file="../hiddenGlobalRoles.jspf" %>
<%@include file="../hiddenGroups.jspf" %>
<%@include file="../hiddenTags.jspf" %>
<html:hidden property="parentWorkItemId" />
<html:hidden property="isGuestUser"/>
<input type="hidden" name="validateButton" value="save"/>
<input type="hidden" name="validateInput"  value="contentTypes"/>
<input type="hidden" name="validateField" value="none" />
<input type="hidden" name="submitButton" value="">
<%
  boolean isReadOnly = false;
%>
<%@ include file="../editContentTypesFragment.jspf"%>

<br />

<table cellpadding="0" cellspacing="0" border="0">
  <tr>
    <td><a href="javascript:submitForm('sectionRoles')" class="global-button">Back</a></td>
    <td>&nbsp;</td>
    <td><a href="javascript:submitForm('cancel')" class="global-button">Cancel</a></td>
    <td>&nbsp;</td>
    <td><a href="javascript:submitForm('save')" class="global-button">Save</a></td>
  </tr>
</table>
