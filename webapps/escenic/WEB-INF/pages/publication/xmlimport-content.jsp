<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>

<input type="hidden" name="submitButton" value="success">
<input type="hidden" name="validateInput" value="validate">
<input type="hidden" name="validateButton" value="import">
<input type="hidden" name="validateField" value="filename">

<bean:message key="t.File_to_import" />: <html:text property="filename" size="30"/> <span class="error"><html:errors property="filename" /></span>
<br />
<bean:message key="t.Force_wait" /><html:checkbox property="forceWait" /> <span class="error"><html:errors property="forceWait" /></span>
<br />

<%
 neo.xredsys.api.Publication publication = (neo.xredsys.api.Publication)request.getSession().getAttribute("escenic-publication");
 int pubid = publication.getId();
 neo.xredsys.api.Section[] sections = publication.getRootSection().getSubSections();
 neo.xredsys.api.Section section = publication.getRootSection();
 for (int i = 0; i < sections.length; i++) {
   if ("ece_incoming".equals(sections[i].getUniqueName())) {
     section = sections[i];
   }
 }
%>

<input type="hidden" name="defaultSection" value="<%= section.getId() %>">
<bean:message key="t.Articles_with_no_home_section_will_be_imported_into"/> <%=section.getName()%> (<%=section.getId()%>).
<br /><br />

<table border="0" cellpadding="0" cellspacing="0">
<tr>
 <td><a class="global-button" href="javascript:submitForm('import')"><bean:message key="b.import"/></a></td>
</tr>
</table>

<br /><br />
<span class="error"><html:errors property="global" /></span>

<jsp:include page="xmlimportstatus.jsp"/>