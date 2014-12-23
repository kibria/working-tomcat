<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page import="neo.phoenix.base.WorkItem,
                 neo.phoenix.base.WorkItemForm"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<bean:define id="workItemId" name="workItemId" type="java.lang.String" />
<bean:define id="publication" name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />

<%
  neo.phoenix.base.WorkItemManager manager = (neo.phoenix.base.WorkItemManager)request.getSession().getAttribute("WorkItemManager");
  WorkItem wItem = manager.getWorkItem(workItemId);
  request.setAttribute("workItem",wItem);
  String url = "/base/restoreWork.do?id=" + workItemId; 
String previewUrl = null;
%>
<bean:define name="workItem" property="form" id="workItemForm" type="neo.phoenix.base.WorkItemForm" />
<li class="type-<%=workItemForm.getWorkItemType()%>">
<%
  String closeUrl = "javaScript:submitForm('action:/base/closeWorkItem.do?id="+wItem.getId()+"')";
%>
<span class="close operation">
  <a href="<%=closeUrl%>"><bean:message key="b.close"/></a>
</span>
<%--<a href="javascript:submitForm('external:<%= url %>')">--%>
  <%--<util:notEqual name="longFormat" value="false">--%>
    <%--<util:valueof param="workItem.name">(<bean:message key="t.no_title"/>)</util:valueof>--%>
  <%--</util:notEqual>--%>
  <%----%>
<%--</a>--%>

</li>
