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
<bean:define id="checker" 
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<div><font color="red"><html:errors property="global" /></font></div>
<html:form action="/section/edit/roles/dispatch">
  <bean:define id="memberForm" 
                 name="neo.phoenix.section.SectionMembersForm"
                 type="neo.phoenix.section.SectionMembersForm"/>
  <% 
    neo.xredsys.api.Section section = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getSection(Integer.parseInt(memberForm.getId())); 
  %>
  <input type="hidden" name="validateButton" value="save"/>
  <input type="hidden" name="validateInput"  value="listByRole"/>
  <input type="hidden" name="validateField" value="none" />
  <html:hidden property="id" />
  <html:hidden property="name" />
  <h3>User members of section <%=memberForm.getName()%> with role <%=memberForm.getCurrentRole()%></h3>
  <%-- make this a tag or something like that --%>
  <% 
    java.util.Collection types = neo.phoenix.base.RoleUtil.getInstance().getSectionRoles();
    request.setAttribute("types",types);
  %>
  <bean:define name="types" id="roles" />  

  <table>
    <bean:define id="userMembers" name="memberForm" property="users" type="java.util.Collection"/>
    <logic:iterate id="item" name="userMembers" type="java.lang.String">
      <%
        String p1 = "user(" + item + ").id"; 
        String p2 = "user(" + item + ").type"; 
        String p3 = "user(" + item + ").publicationId";
      %>
     <html:hidden property="<%=p1%>"/>
     <html:hidden property="<%=p2%>"/>
     <html:hidden property="<%=p3%>"/>
     <bean:define id="pubId" name="memberForm" property="<%=p3%>" type="java.lang.String"/>
      <tr>
        <%  
          neo.phoenix.base.RelatedObject user = memberForm.getUser(item);
          String personId = user.getId();
          String pub = user.getPublicationId();   
        %>
        <% String currentRole = user.getAttribute(memberForm.getCurrentRole());
           if(currentRole!=null&&currentRole.equalsIgnoreCase("on")){
        %>    
          <td>
            <table>
              <tr>
                <template:call file="../base/presentPerson.jsp">
                  <template:parameter key="external" value="true" />
                  <template:parameter key="pubId" value="<%=pub%>" />
                  <template:parameter key="personId" value="<%=personId%>" />
                </template:call>
                  <td><a href="javascript:submitForm('action:/section/removeMember.do?id=<%=personId%>&pubId=<%=pubId%>&role=<%=memberForm.getCurrentRole()%>')"><html:img
                                 page="/images/qw/delete.png"/></a>
                  </td>
              </tr>
            </table>
          </td>            
        <% } %> 
        <logic:iterate id="role" name="roles" type="java.lang.String">
          <% String key = "user(" + item + ").attribute(" + role + ")"; %>
          <td align="center">
            <html:hidden property="<%=key%>"/>
          </td>
        </logic:iterate>
    </logic:iterate>
    <bean:define id="userGroupMembers" name="memberForm" property="userGroups" type="java.util.Collection"/>
    <logic:iterate id="item" name="userGroupMembers" type="java.lang.String">
      <%
        String p1 = "userGroup(" + item + ").id"; 
        String p2 = "userGroup(" + item + ").type"; 
        String p3 = "userGroup(" + item + ").publicationId";
        String p4 = "userGroup(" + item + ").attribute(name)";
      %>
     <html:hidden property="<%=p1%>"/>
     <html:hidden property="<%=p2%>"/>
     <html:hidden property="<%=p3%>"/>
     <html:hidden property="<%=p4%>"/>
     <bean:define id="groupPubId" name="memberForm" property="<%=p3%>" type="java.lang.String"/>
      <tr>
        <%  
          neo.phoenix.base.RelatedObject user = memberForm.getUserGroup(item);
          String groupName = user.getAttribute("name");
          String pub = user.getPublicationId();   
        %>
        <% String currentRole = user.getAttribute(memberForm.getCurrentRole());
           if(currentRole!=null&&currentRole.equalsIgnoreCase("on")){
        %>    
          <template:call file="../base/presentUserGroup.jsp">
            <template:parameter key="external" value="true" />
            <template:parameter key="pubId" value="<%=pub%>" />
            <template:parameter key="groupName" value="<%=groupName%>" />
          </template:call>
            <td><a href="javascript:submitForm('action:/section/removeMember.do?groupName=<%=groupName%>&pubId=<%=groupPubId%>&role=<%=memberForm.getCurrentRole()%>')"><html:img
                           page="/images/qw/delete.png"/></a>
        <% } %>
        <logic:iterate id="role" name="roles" type="java.lang.String">
          <% String key = "userGroup(" + item + ").attribute(" + role + ")"; %>
          <td align="center">
            <html:hidden property="<%=key%>"/>
          </td>
        </logic:iterate>
        </td>           
    </logic:iterate>
  </table>
  <table><tr>
    <td><a class="global-button" href="javascript:submitForm('save')">Save</a></td>
    <td><a class="global-button" href="javascript:submitForm('edit')">Edit</a></td>
  </tr>
  </table>
  <input type="hidden" name="submitButton" value="">
</html:form>
