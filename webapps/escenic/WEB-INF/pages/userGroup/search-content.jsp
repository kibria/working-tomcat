<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page import="neo.phoenix.base.WorkItemForm"%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<script language="JavaScript1.2"><!--
  function confirmDelete(){
    if(confirm("Are you sure you want to delete these usergroups?")){
      submitForm('external:/userGroup/search/deleteUserGroups.do?searchResult=neo.phoenix.userGroup.SearchResult&deletePossible=true');
    }else{
      submitForm('userGroup-archive');
    }
  }
  // -->
</script>
<input type="hidden" name="enterAction" value="action:/userGroup/search/perform.do"/>
<bean:define id="publication"
             name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<bean:define id="checker"
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />

<div class="error"><html:errors property="global" /></div>
<html:hidden property="parentWorkItemId" />
<html:hidden property="doPubSearch"/>
<html:hidden property="hidePubs"/>
<input type="hidden" name="pubId" value="<%=publication.getId()%>"/>
<input type="hidden" name="submitButton" value="action:/userGroup/search/perform.do">
<input type="hidden" name="validateInput" value="success">
<bean:define name="neo.phoenix.userGroup.UserGroupSearchForm" scope="request"
              type="neo.phoenix.userGroup.UserGroupSearchForm" id="form"/>
<%-- Remember paging..... --%>
<%  request.getSession().setAttribute("escenic-groupSearch-currentPage",form.getPageStart()); %>

<template:call file="searchParameters.jsp">
  <template:parameter key="hidePubs" value="<%=form.getHidePubs()%>"/>
</template:call>
<%
String nextUrl=(String)request.getAttribute("nextUrl");
if (nextUrl==null) nextUrl="/userGroup/search/next";
String prevUrl=(String)request.getAttribute("prevUrl");
if (prevUrl==null) prevUrl="/userGroup/search/prev";
%>
<template:call file="searchResult.jsp">
  <template:parameter key="nextUrl" value="<%=nextUrl%>"/>
  <template:parameter key="prevUrl" value="<%=prevUrl%>"/>
</template:call>
<%-- <template:call file="searchButtons.jsp">
</template:call> --%>
<logic:notPresent name="hideExtraOperations" scope="request"><%-- jf:
optionally turn off all 'extra operations', leaving search only (for plugins)
--%>
  <p>
<logic:greaterThan name="resultSize" value="0">
  <logic:notPresent name="hideSelect" scope="request"><%-- jf: optionally hide all select options (for plugins) --%>
  <br><bean:message key="t.Operate_on_selected_usergroups" bundle="org.apache.struts.action.MESSAGE"/>:<br>

  <table border="0" cellspacing="0" cellpadding="0">
  <tr>
   <%-- Add items to work items --%>
   <logic:present name="WorkItemManager" scope="session">
     <logic:iterate name="WorkItemManager" scope="session" property="workItems" id="workItem" type="neo.phoenix.base.WorkItem">

      <td>
       <a class="global-button" href="javascript:submitForm('<%=  "action:/userGroup/search/addUserGroupsToWorkItem.do?workItemId=" + workItem.getId() %>')">
       <bean:message key="b.add_usergroups_to" arg0="<%=workItem.getName()%>" bundle="org.apache.struts.action.MESSAGE"/></a>
      </td>
      <td>&nbsp;</td>

     </logic:iterate>
   </logic:present>
  </logic:notPresent>

  <logic:notPresent name="hideDelete" scope="request"><%-- jf: optionally hide all delete options (for plugins) --%>

  <%if(checker.isGlobalPublicationAdmin(publication.getId())){%>
    <td>
     <a class="global-button" href="javascript: confirmDelete()"><bean:message key="b.delete_usergroups" bundle="org.apache.struts.action.MESSAGE"/></a>
    </td>
    <td>&nbsp;</td>
  <%}%>
  </logic:notPresent>

  </tr>
  </table>
</logic:greaterThan>

<% if (neo.util.StringUtil.isEmpty(form.getParentWorkItemId())) { %>

<% } else { %>
  <hr>
<%
  neo.phoenix.base.WorkItemManager manager = (neo.phoenix.base.WorkItemManager)request.getSession().getAttribute("WorkItemManager");
  neo.phoenix.base.WorkItem item = manager.getWorkItem(form.getParentWorkItemId());
%>
<%if(item!=null&&((WorkItemForm)item.getForm()).displayInLists()){%>

<table border="0" cellpadding="0" cellspacing="0">
<tr>
 <td><input type="button" class="important-button" onClick="submitForm('finished')" value="<bean:message key="b.return_to" arg0="<%=item.getName()%>" bundle="org.apache.struts.action.MESSAGE"/>" /></td>
</tr>
</table>

<% }} %>
</p>
</logic:notPresent>

<logic:present name="nonDeletedItems">
  <table>
    <tr>
      <th align="left"><bean:message key="t.These_items_could_not_be_deleted" bundle="org.apache.struts.action.MESSAGE"/></th>
    </tr>
    <tr>
      <td>
        <table>
          <logic:iterate name="nonDeletedItems" id="object" type="neo.xredsys.api.UserGroup">
              <tr><template:call file="../base/presentUserGroup.jsp">
                  <% String name = object.getName() + ""; %>
                  <% String pubId = object.getOwnerPublicationId() + ""; %>
                  <template:parameter key="pubId" value="<%=pubId%>" />
                  <template:parameter key="groupName" value="<%=name%>" />
                </template:call>
              </tr>
          </logic:iterate>
        </table>
      </td>
    </tr>
  </table>
</logic:present>
