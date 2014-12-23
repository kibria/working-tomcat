<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page import="neo.phoenix.base.WorkItemForm,
                 org.apache.struts.action.Action,
                 java.util.Locale,
                 java.util.List"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>

<input type="hidden" name="enterAction" value="action:/person/search/popup/perform.do"/>
<div class="error"><html:errors property="global" /></div>
<%  org.apache.log4j.Category LOGGER = org.apache.log4j.Category.getInstance(this.getClass());%>
<bean:define id="publication" name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<bean:define id="checker"
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />

<html:hidden property="doPubSearch"/>
<input type="hidden" name="submitButton" value="success">
<input type="hidden" name="validateInput" value="success">
<template:call file="searchParameters.jsp">
  <template:parameter key="formName" value="neo.phoenix.person.PersonSearchForm"/>
  <template:parameter key="popup" value="true"/> 
</template:call>
<%
  
String nextUrl=(String)request.getAttribute("nextUrl");
if (nextUrl==null) nextUrl="/person/search/next";
String prevUrl=(String)request.getAttribute("prevUrl");
if (prevUrl==null) prevUrl="/person/search/prev";
%>
  <%
    String workItemName = request.getParameter("parentWorkItemName");
    if (workItemName == null) workItemName = "article";
  %>
<template:call file="searchResult.jsp">
  <template:parameter key="nextUrl" value="<%=nextUrl%>"/>
  <template:parameter key="prevUrl" value="<%=prevUrl%>"/>
  <template:parameter key="formName" value="neo.phoenix.person.PersonSearchForm"/>
  <template:parameter key="popup" value="true"/> 
</template:call>

<input type="button" class="important-button" onClick="submitPopup('finished')" value="<bean:message key="b.add_selected_persons_to" arg0="<%= workItemName %>"/>" />

<bean:define name="neo.phoenix.person.PersonSearchForm" scope="request" type="neo.phoenix.person.PersonSearchForm" id="form"/>
<%-- Remember paging..... --%>
<%  request.getSession().setAttribute("escenic-personSearch-currentPage",form.getPageStart()); %>
<logic:present name="neo.phoenix.person.SearchResult">
    <% String clear = "javascript:submitForm('action:/profile/search/clearSelection.do')"; %>
    <% String selectAll = "javascript:submitForm('action:/profile/search/selectAll.do?searchResult=neo.phoenix.profile.SearchResult')"; %>
    <a href="<%=clear%>" class="global-button"><bean:message key="t.Clear_selection"/></a>
    <a href="<%=selectAll%>" class="global-button"><bean:message key="t.Select_all"/></a>

    <logic:present name="WorkItemManager" scope="session">
      <logic:notEqual name="parentWorkItemId" value="empty" >
    <%
    neo.phoenix.base.WorkItemManager manager = (neo.phoenix.base.WorkItemManager)request.getSession().getAttribute("WorkItemManager");
    neo.phoenix.base.WorkItem workItem = manager.getWorkItem(form.getParentWorkItemId());
    if(workItem!=null&&((WorkItemForm)workItem.getForm()).displayInLists()){%>
        <a class="global-button" href="javascript:submitPopup('finished')"><bean:message key="b.return_to" arg0="<%=workItem.getName()%>"/></a>
    <%}%>
      </logic:notEqual>
    </logic:present>

</logic:present>
