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
<script language="JavaScript1.2"><!--
  function confirmDelete(){
    if(confirm("Are you sure you want to delete these persons?")){
      submitForm('external:/person/search/deletePersons.do?searchResult=neo.phoenix.person.SearchResult&deleteAction=/person/search/deletePersons');
    }else{
      submitForm('person-archive');
    }
  }
  // -->
</script>

<div id="person-archive" class="archive">
<%
  String enterAction=(String)request.getAttribute("enterAction");
  if (enterAction==null) enterAction="action:/person/search/perform.do";
%>

<input type="hidden" name="enterAction" value="<%=enterAction%>"/>
<div class="error"><html:errors property="global" /></div>
<%  org.apache.log4j.Category LOGGER = org.apache.log4j.Category.getInstance(this.getClass());%>
<bean:define id="publication" name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<bean:define id="checker"
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />

<html:hidden property="parentWorkItemId" />
<html:hidden property="doPubSearch"/>
<input type="hidden" name="submitButton" value="success">
<input type="hidden" name="validateInput" value="success">
<template:call file="searchParameters.jsp">
  <template:parameter key="formName" value="neo.phoenix.person.PersonSearchForm"/>
</template:call>
<%
  
String nextUrl=(String)request.getAttribute("nextUrl");
if (nextUrl==null) nextUrl="/person/search/next";
String prevUrl=(String)request.getAttribute("prevUrl");
if (prevUrl==null) prevUrl="/person/search/prev";
%>
<template:call file="searchResult.jsp">
  <template:parameter key="nextUrl" value="<%=nextUrl%>"/>
  <template:parameter key="prevUrl" value="<%=prevUrl%>"/>
  <template:parameter key="formName" value="neo.phoenix.person.PersonSearchForm"/>
</template:call>
<%-- <template:call file="searchButtons.jsp">
  <template:parameter key="formName" value="neo.phoenix.person.PersonSearchForm"/>
</template:call> --%>

<bean:define name="neo.phoenix.person.PersonSearchForm" scope="request" type="neo.phoenix.person.PersonSearchForm" id="form"/>
<%-- Remember paging..... --%>
<%  request.getSession().setAttribute("escenic-personSearch-currentPage",form.getPageStart()); %>
<logic:present name="neo.phoenix.person.SearchResult">
<logic:notPresent name="hideExtraOperations" scope="request"><%-- jf:
optionally turn off all 'extra operations', leaving search only (for plugins)
--%>
<p>
<logic:greaterThan name="resultSize" value="0">
<logic:notPresent name="hideSelect" scope="request"><%-- jf: optionally hide all select options (for plugins) --%>
<br><bean:message key="t.Operate_on_selected_persons"/>:<br>

<table border="0" cellpadding="0" cellspacing="0">
<tr>

</logic:notPresent>
<logic:notPresent name="hideDelete" scope="request"><%-- jf: optionally hide all delete options (for plugins) --%>

 <td><a class="global-button" href="javascript: confirmDelete()"><bean:message key="b.delete_persons"/></a></td>
 <td>&nbsp;</td>

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
 <td><a class="global-button" href="javascript:submitForm('finished')"><bean:message key="b.add_selected_persons_to" arg0="<%=item.getName()%>"/></a></td>
</tr>
</table>

<% }} %>
</p>
</logic:notPresent>

<logic:present name="nonDeletedItems">
  <table>
    <tr>
      <th align="left"><bean:message key="t.These_items_could_not_be_deleted"/></th>
    </tr>
    <tr>
      <td>
        <table>
          <logic:iterate name="nonDeletedItems" id="object" type="neo.xredsys.api.IOObject">
              <tr><template:call file="../base/presentPerson.jsp">
                  <% String perId = object.getId() + ""; %>
                  <% String pubId = object.getOwnerPublicationId() + ""; %>
                  <template:parameter key="personId" value="<%=perId%>" />
                  <template:parameter key="pubId" value="<%=pubId%>" />
                  <template:parameter key="hideEditLink" value="false" />
                  <template:parameter key="showAttributes" value="true" />
                  <template:parameter key="displayedAttributes" value="id,name,lastModified,publication,view" />
                </template:call>
              </tr>
          </logic:iterate>
        </table>
      </td>
    </tr>
  </table>
</logic:present>
</logic:present>
</div>
