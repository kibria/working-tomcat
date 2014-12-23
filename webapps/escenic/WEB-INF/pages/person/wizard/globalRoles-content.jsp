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
<div class="error"><html:errors property="global" /></div>
<bean:define id="form" name="neo.phoenix.person.PersonForm" type="neo.phoenix.person.PersonForm"/>
<input type="hidden" name="validateButton" value="save"/>
<input type="hidden" name="validateInput"  value="globalRoles"/>
<input type="hidden" name="validateField" value="none" />
<%@include file="../hiddenProperties.jspf" %>
<%@include file="../../base/relatedObjects.jspf" %>
<%@include file="../hiddenGroups.jspf" %>
<%@include file="../hiddenTags.jspf" %>
<%@include file="../hiddenContentTypes.jspf" %>

<jsp:include page="../listGlobalRoles.jsp">
  <jsp:param name="readOnly" value="<%=false%>"/>
</jsp:include>

<br />
<table cellpadding="0" cellspacing="0" border="0">
<tr>
 <td><a href="javascript:submitForm('properties')" class="global-button">Back</a></td>
 <td>&nbsp;</td>
 <td><a href="javascript:submitForm('groups')" class="global-button">Next</a></td>
 <td>&nbsp;</td>
 <td><a href="javascript:submitForm('cancel')" class="global-button">Cancel</a></td>
 <td>&nbsp;</td>
 <td><a href="javascript:submitForm('save')" class="global-button">Save</a></td>
</tr>
</table>

<input type="hidden" name="submitButton" value="">
