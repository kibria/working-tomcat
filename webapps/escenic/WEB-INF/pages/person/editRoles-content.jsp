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
  <bean:define name="neo.phoenix.person.PersonForm" id="form" type="neo.phoenix.person.PersonForm"  />
  <%@include file="hiddenProperties.jspf" %>
  <%@include file="hiddenGlobalRoles.jspf" %>
  <%@include file="hiddenRelations.jspf" %>
  <%@include file="hiddenGroups.jspf" %>
  <%@include file="hiddenTags.jspf" %>
<%@include file="hiddenContentTypes.jspf" %>
<html:hidden property="parentWorkItemId" />
  <html:hidden property="isGuestUser"/>
  <input type="hidden" name="validateButton" value="edit"/>
  <input type="hidden" name="validateButton" value="editRoles"/>
  <input type="hidden" name="validateButton" value="save"/>
  <input type="hidden" name="validateInput"  value="editRoles"/>
  <input type="hidden" name="validateField" value="none" />
  <template:call file="editSectionRoles.jsp"/>
  <input type="hidden" name="submitButton" value="">
