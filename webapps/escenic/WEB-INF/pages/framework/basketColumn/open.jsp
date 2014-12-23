<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>

<% if (session.getAttribute("settings") != null) { 
     if (!((java.util.List) session.getAttribute("settings")).contains("columnsize"))
       ((java.util.List) session.getAttribute("settings")).add("columnsize");
   } %>

<bean:define id="publication" name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />

<%-- <logic:equal value="normal" name="columnsize"> --%>
<div id="opened-items">
<h2>
<bean:message bundle="org.apache.struts.action.MESSAGE" key="t.Open_unsaved_items"/>:
</h2>
<a href="javascript:submitForm('action:/base/setSessionAttribute.do?attribute=columnsize&value=small')">&lt;&lt;</a>

<logic:notPresent name="WorkItemManager" scope="session">
  <p>(<bean:message bundle="org.apache.struts.action.MESSAGE" key="t.no_items_are_opened"/>)</p>
</logic:notPresent>
 
<logic:present name="WorkItemManager" scope="session">
    <% if (((neo.phoenix.base.WorkItemManager)session.getAttribute("WorkItemManager")).getWorkItems().size() == 0) { %>
	<p>(<bean:message bundle="org.apache.struts.action.MESSAGE" key="t.no_items_are_opened"/>)</p>
    <% } %>
    <ul class="items">
    <logic:iterate name="WorkItemManager" scope="session" property="workItems" id="workItem" type="neo.phoenix.base.WorkItem">
<%--      <% String url = "/base/restoreWork.do?id=" + workItem.getId(); %>--%>
      <li>
        <template:call file="../../base/presentWorkitem.jsp">
          <template:parameter key="workItemId" value="<%=workItem.getId()%>"/>
          <template:parameter key="longFormat" value="true"/>
        </template:call>
      </li>
    </logic:iterate>
  </logic:present>
<%-- </logic:equal>   --%>


<%--
<logic:equal value="small" name="columnsize">
<table class="openSmall">
<tr>
<td class="openHeadingSwitch" align="right">
<a href="javascript:submitForm('action:/base/setSessionAttribute.do?attribute=columnsize&value=normal')">&gt;&gt;</a></td>
</tr>
<logic:present name="WorkItemManager" scope="session">
  <logic:iterate name="WorkItemManager" scope="session" property="workItems" id="workItem" type="neo.phoenix.base.WorkItem">
    <tr><td class="openItem">
      <template:call file="../../base/presentWorkitem.jsp">
        <template:parameter key="workItemId" value="<%=workItem.getId()%>"/>
        <template:parameter key="longFormat" value="false"/>
      </template:call>
	  </td></tr>
    </logic:iterate>
  </logic:present>
</table>
</logic:equal>  
--%>
</div>
