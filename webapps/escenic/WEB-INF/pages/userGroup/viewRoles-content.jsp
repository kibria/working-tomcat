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
<bean:define id="checker" 
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
  <bean:define name="neo.phoenix.userGroup.UserGroupForm" id="form" scope="request" type="neo.phoenix.userGroup.UserGroupForm"/>
  <bean:define id="userMembers" name="neo.phoenix.userGroup.UserGroupForm" property="users" scope="request" type="java.util.List"/>
  <logic:iterate name="userMembers" id="key" type="java.lang.String">
    <%  String p1 = "user(" + key + ").id"; 
        String p2 = "user(" + key + ").type"; 
        String p3 = "user(" + key + ").publicationId";
    %>
    <html:hidden property="<%=p1%>"/>
    <html:hidden property="<%=p2%>"/>
    <html:hidden property="<%=p3%>"/>
  </logic:iterate>
  <bean:define id="userGroups" name="neo.phoenix.userGroup.UserGroupForm" property="userGroups" scope="request" type="java.util.List"/>
  <logic:iterate name="userGroups" id="key" type="java.lang.String">
     <%  String p1 = "userGroup(" + key + ").attribute(name)"; 
          String p2 = "userGroup(" + key + ").type"; 
          String p3 = "userGroup(" + key + ").publicationId";
      %>
      <html:hidden property="<%=p1%>"/>
      <html:hidden property="<%=p2%>"/>
      <html:hidden property="<%=p3%>"/>
  </logic:iterate>
  <html:hidden property="createWorkItem" value="false"/>
  <h2><bean:write name="form" property="name"/></h2>
  <html:hidden property="name" />
  <html:hidden property="pubId" />
  <input type="hidden" name="validateButton" value="edit"/>
  <input type="hidden" name="validateButton" value="editRoles"/>
  <input type="hidden" name="validateButton" value="save"/>
  <input type="hidden" name="validateInput"  value="editRoles"/>
  <input type="hidden" name="validateField" value="none" />
  <h4>Roles</h4>
  <%-- make this a tag or something like that --%>
  <% 
    java.util.Collection types = neo.phoenix.base.RoleUtil.getInstance().getSectionRoles();
  request.setAttribute("types",types);
  %>
  <bean:define name="types" id="roles" />  
  <table border="1">
    <tr>
      <td>
        Roles:
      </td>
      <logic:iterate id="role" type="java.lang.String" name="roles">
      <td>
        <%=role%>    
      </td>
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
        </template:call>
        </td>
        <logic:iterate id="role" type="java.lang.String" name="roles">
        <td>
          <% String key = "relatedObject(" + item + ").attribute("+ role + ")"; %>
          <html:hidden property="<%=key%>"/>
          <html:checkbox disabled="true" property="<%=key%>"/>
        </td>
        
        </logic:iterate>
      </tr>
    </logic:iterate>
  </table>
  <table><tr>
    <%
      neo.xredsys.api.UserGroup group = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getUserGroup(form.getName(),Integer.parseInt(form.getPubId())); 
      if(checker.isGlobalPublicationAdmin(group.getOwnerPublicationId())){ %>
     <% String edit = "/userGroup/edit.do?name="+form.getName()+"&pubId="+form.getPubId()+"')"; %>
    <td><html:link styleClass="global-button" page="<%=edit%>">Edit</html:link></td>
    <% } %>
    <td><a class="global-button" href="javascript:submitForm('view')">View</a></td>
  </tr>
  </table>
  <input type="hidden" name="submitButton" value="">
