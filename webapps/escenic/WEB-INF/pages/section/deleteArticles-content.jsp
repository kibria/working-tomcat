<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-view" prefix="view" %>
<input type="hidden" name="submitButton" value="success">
<input type="hidden" name="validateInput" value="">
<input type="hidden" name="validateButton" value="success">

<bean:parameter id="sectionId" name="id" />
<section:use sectionId="<%=sectionId%>">
<bean:define id="section" name="section" type="neo.xredsys.api.Section" />
<bean:define id="checker" 
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />

<table>
<tr><th align="right"><bean:message key="t.Section_name"/></th><td><bean:write name="section" property="name"/></td></tr>
</table>
<% String baseUrl= "/section/deleteArticles.do?confirm=true&id=" + section.getId(); %>
<ul>

<table><tr><td><html:link styleClass="global-button" page="<%=baseUrl+\"&articles=true&shortcuts=false&recursive=false\"%>"><bean:message key="t.Delete_articles"/></td>
	<td> <bean:message key="t.in_this_section"/> </html:link>.</td></tr></table>
<table><tr><td><html:link styleClass="global-button" page="<%=baseUrl+\"&articles=false&shortcuts=true&recursive=false\"%>"><bean:message key="t.Delete_shortcuts"/></td>
	<td> <bean:message key="t.in_this_section"/> </html:link>.</td></tr></table>

<table><tr><td><html:link styleClass="global-button" page="<%=baseUrl+\"&articles=true&shortcuts=false&recursive=true\"%>"><bean:message key="t.Delete_articles"/></td>
	<td> <bean:message key="t.in_this_section"/> <bean:message key="t.recursively"/></html:link>.</td></tr></table>
<table><tr><td><html:link styleClass="global-button" page="<%=baseUrl+\"&articles=false&shortcuts=true&recursive=true\"%>"><bean:message key="t.Delete_shortcuts"/></td>
	<td> <bean:message key="t.in_this_section"/> <bean:message key="t.recursively"/></html:link>.</td></tr></table>
</ul> 
</p>

<hr>
<table><tr><td><html:link styleClass="global-button" page="<%= \"/section/view.do?id=\" + section.getId() %>"><bean:message key="b.cancel"/></html:link></td></tr></table>
</section:use>
