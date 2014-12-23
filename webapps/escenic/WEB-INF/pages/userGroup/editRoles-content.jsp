<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-view" prefix="view" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<bean:define id="publication" 
             name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<div><font color="red"><html:errors property="global" /></font></div>
<bean:define name="neo.phoenix.userGroup.UserGroupForm" id="form" scope="request" type="neo.phoenix.userGroup.UserGroupForm"/>
<%@include file="hiddenGroups.jspf" %>
<%@include file="hiddenMembers.jspf" %>
<%@include file="hiddenProps.jspf" %>
<%@include file="hiddenRelations.jspf" %>
<%@include file="../person/hiddenTags.jspf" %>
<%@include file="../person/hiddenContentTypes.jspf" %>
<%@include file="hiddenGlobalRoles.jspf" %>
<% boolean readOnly = neo.util.StringUtil.getBoolean(form.getReadOnly());
  if(readOnly && neo.util.StringUtil.getBoolean(form.getEditRoles())){
    readOnly = false;
  }
%>
<input type="hidden" name="validateButton" value="editRoles"/>
<input type="hidden" name="validateButton" value="save"/>
<input type="hidden" name="validateInput"  value="editRoles"/>
<input type="hidden" name="validateField" value="none" />
<html:hidden property="parentWorkItemId"/>

<h3><bean:message key="t.Roles"/></h3>
<%-- make this a tag or something like that --%> 
<% 
  java.util.Collection types = new java.util.HashSet(neo.phoenix.base.RoleUtil.getInstance().getSectionRoles());
//request.setAttribute("types",types);
  java.util.List roleList = new java.util.ArrayList();
  request.setAttribute("roleList",roleList);
  roleList.add(neo.phoenix.access.AccessChecker.ADMINISTRATOR);
  roleList.add(neo.phoenix.access.AccessChecker.USER_ADMIN);
  roleList.add(neo.phoenix.access.AccessChecker.EDITOR);
  roleList.add(neo.phoenix.access.AccessChecker.JOURNALIST);
  roleList.add(neo.phoenix.access.AccessChecker.READER);
  roleList.add(neo.phoenix.access.AccessChecker.FORUM_ADMIN);
%>
<table class="listing" cellpadding="0" cellspacing="0">
  <tr class="labels">
    <th>
      <bean:message key="t.Roles"/>:
    </th>
    <logic:iterate id="role" type="java.lang.String" name="roleList">
    <%if(types.contains(role)){%>
    <th>
      <% String key = "r." + role; %>
      <bean:message key="<%=key%>"/>
    </th>
    <%}%>
    </logic:iterate>
  </tr>
  <logic:iterate name="form" property="relatedObjects" id="item" >
    <% String p1 = "relatedObject(" + item + ").id"; 
    String p2 = "relatedObject(" + item + ").type"; 
    String p3 = "relatedObject(" + item + ").publicationId"; 
    String p4 = "relatedObject(" + item + ").attributeNames";
    %>
    <html:hidden property="<%=p1%>"/>
    <html:hidden property="<%=p2%>"/>
    <html:hidden property="<%=p3%>"/>
    <bean:define id="sectionId" name="form" property="<%=p1%>" type="java.lang.String"/>
    <tr>
      <td>
      <% neo.xredsys.api.Section section = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getSection(Integer.parseInt(sectionId));
      %>
      <template:call file="../base/presentSection.jsp">
        <% 
           String pubId = section.getOwnerPublicationId() + "";       
        %>
        <template:parameter key="sectionId" value="<%=sectionId%>" />
        <template:parameter key="external" value="true" />
        <template:parameter key="pubId" value="<%=pubId%>" />
        <template:parameter key="noTable" value="true" />
        <template:parameter key="showPath" value="true"/>
      </template:call>
      </td>
      <logic:iterate id="role" type="java.lang.String" name="roleList">
      <%if(types.contains(role)){%>
      <td>
        <% String key = "relatedObject(" + item + ").attribute("+ role + ")"; %>
        <html:checkbox property="<%=key%>" disabled="<%=readOnly%>"/>
        <%if(readOnly){%>
          <html:hidden property="<%=key%>"/>
        <%}%>
      </td>
      <%}%>
      </logic:iterate>
    </tr>
  </logic:iterate>
</table>
<input type="hidden" name="submitButton" value="">
