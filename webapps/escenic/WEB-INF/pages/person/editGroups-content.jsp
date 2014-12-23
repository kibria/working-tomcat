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
<bean:define name="neo.phoenix.person.PersonForm" id="form" type="neo.phoenix.person.PersonForm"  />
<%@include file="../base/relatedObjects.jspf" %>
<%@include file="hiddenProperties.jspf" %>
<%@include file="hiddenGlobalRoles.jspf" %>
<%@include file="hiddenGroups.jspf" %>
<%@include file="hiddenRelations.jspf" %>
<%@include file="hiddenContentTypes.jspf" %>
<html:hidden property="parentWorkItemId" />
<html:hidden property="isGuestUser"/>
<input type="hidden" name="validateButton" value="edit"/>
<input type="hidden" name="validateButton" value="editRoles"/>
<input type="hidden" name="validateButton" value="save"/>
<input type="hidden" name="validateInput"  value="editRoles"/>
<input type="hidden" name="validateField" value="none" />
<bean:define id="checker" 
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<% 
  neo.xredsys.api.Person person = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPerson(Integer.parseInt(form.getId()), Integer.parseInt(form.getPubId()));
  boolean canEditUser = checker.isGlobalPublicationAdmin(person.getOwnerPublicationId());
  String canEditAsString = String.valueOf(canEditUser); 
  boolean isAdmin = false;
  String userName = form.getUserName();
  String pubName = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPublication(Integer.parseInt(form.getPubId())).getName();
  if(userName.equals(pubName+"_admin")){
    isAdmin = true;
  }
  String sIsAdmin = String.valueOf(isAdmin);
  boolean isGuestUser = neo.util.StringUtil.getBoolean(form.getIsGuestUser());
%> 
<% if(canEditUser||isGuestUser){ %>
  <table class="listing" cellpadding="0" cellspacing="0">
    <tr class="labels">
      <td>
        Global roles
      </td>
      <td>&nbsp;</td>
    </tr>
    <%
      java.util.Map roleMap = neo.phoenix.base.RoleUtil.getInstance().getAllRoles();
      java.util.Set roles = roleMap.keySet(); 
       request.setAttribute("roles",roles);
    %>
    <% 
       boolean readOnly = false;
       if(isAdmin){
        readOnly = true;
       }
    %>
    <logic:iterate id="role" name="roles" type="java.lang.String">
      <tr> 
        <% String key = "globalRole(" + role + ")"; %>
        <td><%=role%>:</td>
        <td><html:checkbox property="<%=key%>" disabled="<%=readOnly%>"/><html:errors property="<%=key%>" /></td>
      </tr>
    </logic:iterate> 
  </table>
<% } %>

<input type="hidden" name="submitButton" value="">
