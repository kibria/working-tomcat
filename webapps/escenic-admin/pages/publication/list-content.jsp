<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>

<% neo.xredsys.api.Publication[] pubs;
   String error = null;
   try {
     pubs = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPublications();
   } catch (Throwable t) {
     pubs = new neo.xredsys.api.Publication[0];
     error = (t.getMessage() == null ? t.toString() : t.getMessage()) + "  No publications will be listed.";
   }
   java.util.Arrays.sort(pubs, new java.util.Comparator() { public int compare(Object o1, Object o2) {
     return ((neo.xredsys.api.Publication) o1).getName().compareToIgnoreCase(((neo.xredsys.api.Publication) o2).getName());
   } });
%>

<script type="text/javascript">
  
  function invertSelection(){
    var form = document.forms[0];
    for (i = 0; i < form.length; i++){
      var name= form.elements[i].name;
      if (name.substr(0,8)=='selected'){
        if (form.elements[i].checked== true){
          form.elements[i].checked=false;
        } else {
          form.elements[i].checked=true;
        }
      }
    }
  }
  
  function selectAll(select){
    var form = document.forms[0];
    for (i = 0; i < form.length; i++){
      var name= form.elements[i].name;
      if (name.substr(0,8)=='selected'){
        form.elements[i].checked=select;
      }
    }
  }
</script>

<ul>
<% if (error != null) { %>
  <li><font color="red"><%=error%></font></li>
<% } %>
<html:messages id="err" property="failure">
  <li><font color="red"><bean:write name="err"/></font></li>
</html:messages>
</ul>

<ul><html:messages id="msg" property="success" message="true">
  <li><bean:write name="msg"/></li>
</html:messages></ul>

<% 
  request.setAttribute("publishers", neo.xredsys.content.PublicationManager.getPublicationManager().getPublishers());
%>

<%if (pubs.length >1){%>
  <a href="javascript:selectAll(true);"><bean:message key="b.select_all"/></a> | 
  <a href="javascript:selectAll(false);"><bean:message key="b.unselect_all"/></a> | 
  <a href="javascript:invertSelection();"><bean:message key="b.invert_selection"/></a>
  <%}%>

<table><tr><td valign="top" width="500">

<html:form action="/publication/execute">
  <input type="hidden" name="submitButton" value=""/>
  <table>
  <logic:iterate collection="<%=pubs%>" id="item" type="neo.xredsys.api.Publication">
  <% if (item != null) { %>
    <tr>
    <td>
    <html:checkbox property="<%= \"selected(\" + item.getId() + \")\" %>" />
    </td><td>
    <bean:write name="item" property="name" />
    </td><td>
     <a class="global-button" href="<html:rewrite page="/pages/publication/view.jsp"/>?name=<bean:write name="item" property="name" />"><bean:message key="t.Information"/></a>
     </td>
    </tr>

  <% } %>
  </logic:iterate>
   </table>
<table cellspacing="4" cellpadding="4"><tr>
<td><a class="global-button" href="javascript:document.forms[0].submitButton.value='runfieldindexer'; document.forms[0].submit();">Run field indexer</a></td>
<td><a class="global-button" href="javascript:document.forms[0].submitButton.value='resources'; document.forms[0].submit();">Update resources</a></td>
<td><a class="global-button" href="javascript:document.forms[0].submitButton.value='delete'; document.forms[0].submit();" style="background: #f88" ><b>Delete</b></a></td>
</tr></table>
</html:form>
</td>

<td valign="top">
<template:call file="/pages/base/box.jsp">
  <template:parameter key="title" value="Select publications to work with" />
  <template:parameter key="content" value="<b>This page</b> allows the administrator of an Escenic installation to create and maintain the web application that is linked to  the publication.  Each publication has its own web application, and there are several reasons to keep them up-to-date.  Such maintenance is needed only if a patch of some sort has been applied.<p>When a patch has been applied, some of the patch files might have to be propagated to the web applications that are running in your application server.<p>Select the publications to operate on, and then select <b>Update</b> to make your web applications up-to-date; or select <b>Delete</b> to delete the web application from your database completely" />
</template:call>
</td></tr></table>

