<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>



<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%" valign="top">
<tr><td class="openItemHeading">Open unsaved items: <a href="">[close all]</a></td></tr>
<logic:notPresent name="WorkItemManager" scope="session">
	<tr><td>(No items are opened)</td></tr>
</logic:notPresent>

<logic:present name="WorkItemManager" scope="session">
    <% if (((neo.phoenix.base.WorkItemManager)session.getAttribute("WorkItemManager")).getWorkItems().size() == 0) { %>
	<tr><td class="openItem">(No items are opened)</td></tr>
    <% } %>
    <logic:iterate name="WorkItemManager" scope="session" property="workItems" id="workItem" type="neo.phoenix.base.WorkItem">
      <% String url = "/base/restoreWork.do?id=" + workItem.getId(); %>
      <tr><td class="openItem"><a href="javascript:submitForm('external:<%= url %>')"><bean:write name="workItem" property="name"/></a></td></tr>
    </logic:iterate>
  </logic:present>
</table>
