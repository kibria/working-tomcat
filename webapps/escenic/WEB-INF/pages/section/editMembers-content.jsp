<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-view" prefix="view" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<bean:define id="publication" 
             name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<bean:define id="checker" 
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<div><font color="red"><html:errors property="global" /></font></div>
<bean:define id="memberForm" 
               name="neo.phoenix.section.SectionMembersForm"
               type="neo.phoenix.section.SectionMembersForm"/>
<bean:define id="task" name="task" type="java.lang.String" />
               
<br/>
<br/>
<br/>
<br/>
<input type="hidden" name="validateButton" value="save"/>
<input type="hidden" name="validateInput"  value="<%= task.equals("/section/editMembers")?"editMembers":"editGroups"%>">
<input type="hidden" name="validateField" value="none" />
<html:hidden property="id" />
<html:hidden property="name" />
<% 
  neo.xredsys.api.Section section = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getSection(Integer.parseInt(memberForm.getId())); 
%>
<%-- make this a tag or something like that --%>
<%
java.util.Collection types = new java.util.HashSet(neo.phoenix.base.RoleUtil.getInstance().getSectionRoles()); 
//  request.setAttribute("types",types);
  java.util.List roleList = new java.util.ArrayList();
  request.setAttribute("roleList",roleList);
  roleList.add(neo.phoenix.access.AccessChecker.ADMINISTRATOR);
  roleList.add(neo.phoenix.access.AccessChecker.USER_ADMIN);
  roleList.add(neo.phoenix.access.AccessChecker.EDITOR);
  roleList.add(neo.phoenix.access.AccessChecker.JOURNALIST);
  roleList.add(neo.phoenix.access.AccessChecker.READER);
  roleList.add(neo.phoenix.access.AccessChecker.FORUM_ADMIN);
%>
<bean:define name="roleList" id="roles" />
<util:toggle id="toggle" name="textmap-liststyles"/>
<%-- shows users, hides groups --%>
<table class="listing" cellpadding="0" cellspacing="0">
  <% if (task.equals("/section/editMembers")) { %>
      <%-- creates header --%>
      <tr class="labels">
        <th><%--id--%></th>
        <th>
          <bean:message key="t.Name"/>:
        </th>
        <th><%--publication--%></th>
        <logic:iterate id="role" type="java.lang.String" name="roles">
        <%if(types.contains(role)){%>
        <th >
          <% String key = "r." + role; %>
          <bean:message key="<%=key%>"/>
        </th>
        <%}%>
        </logic:iterate>
      </tr>
      <%-- displays the users --%>
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
        <tr class="<bean:write name="toggle" property="value" />">
          <%  
            neo.phoenix.base.RelatedObject user = memberForm.getUser(item);
            String personId = user.getId();
            String pub = user.getPublicationId();   
          %>
          <template:call file="../base/presentPerson.jsp">
            <template:parameter key="external" value="true" />
            <template:parameter key="pubId" value="<%=pub%>" />
            <template:parameter key="personId" value="<%=personId%>" />
            <template:parameter key="readOnly" value="true" />
            <template:parameter key="displayedAttributes" value="icon,id,name,publication" />
          </template:call>
          <logic:iterate id="role" name="roles" type="java.lang.String">
            <%if(types.contains(role)){%>
            <% String key = "user(" + item + ").attribute(" + role + ")"; %>
            <td align="center">
              <html:checkbox property="<%=key%>"/>
            </td>
            <%}%>
          </logic:iterate>
            <td>
              <a href="javascript:submitForm('action:/section/removeMember.do?userId=<%=personId%>&pubId=<%=pubId%>')">
                <html:img page="/images/qw/delete.png" border="0"/>
              </a>
            </td>           
        <util:toggleNext name="toggle" />  
      </logic:iterate>
      <%-- the groups is only hidden properties --%>
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
        <%  
          neo.phoenix.base.RelatedObject user = memberForm.getUserGroup(item);
          String groupName = user.getAttribute("name");
          String pub = user.getPublicationId();   
        %>
        <logic:iterate id="role" name="roles" type="java.lang.String">
          <%if(types.contains(role)){%>
          <% String key = "userGroup(" + item + ").attribute(" + role + ")"; %>
          <html:hidden property="<%=key%>"/>
          <%}%>
        </logic:iterate>
      </logic:iterate>
  <%}else{ %>
      <%-- creates header --%>
      <tr>
        <th align="left">
          <bean:message key="t.Name"/>:
        </th>
        <th><%--publication--%></th>
        <logic:iterate id="role" type="java.lang.String" name="roles">
        <%if(types.contains(role)){%>
        <th align="center">
          <% String key = "r." + role; %>
          <bean:message key="<%=key%>"/>
        </th>
        <%}%>
        </logic:iterate>
      </tr>
      <%-- displays the groups --%>
      <bean:define id="userGroupMembers2" name="memberForm" property="userGroups" type="java.util.Collection"/>
      <logic:iterate id="item" name="userGroupMembers2" type="java.lang.String">
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
       <tr class="<bean:write name="toggle" property="value" />">
        <%  
          neo.phoenix.base.RelatedObject user = memberForm.getUserGroup(item);
          String groupName = user.getAttribute("name");
          String pub = user.getPublicationId();   
        %>
        <template:call file="../base/presentUserGroup.jsp">
          <template:parameter key="external" value="true" />
          <template:parameter key="pubId" value="<%=pub%>" />
          <template:parameter key="groupName" value="<%=groupName%>" />
          <template:parameter key="readOnly" value="true" />
          <template:parameter key="displayedAttributes" value="icon,name,publication" />
        </template:call>

        <logic:iterate id="role" name="roles" type="java.lang.String">
          <%if(types.contains(role)){%>
          <% String key = "userGroup(" + item + ").attribute(" + role + ")"; %>
          <td>
            <html:checkbox property="<%=key%>"/>
          </td>
          <%}%>
        </logic:iterate>
        <util:toggleNext name="toggle" />
      </logic:iterate>
      <%-- hides the users --%>
      <bean:define id="userMembers2" name="memberForm" property="users" type="java.util.Collection"/>
      <logic:iterate id="item" name="userMembers2" type="java.lang.String">
        <%
          String p1 = "user(" + item + ").id"; 
          String p2 = "user(" + item + ").type"; 
          String p3 = "user(" + item + ").publicationId";
        %>
       <html:hidden property="<%=p1%>"/>
       <html:hidden property="<%=p2%>"/>
       <html:hidden property="<%=p3%>"/>
          <%  
            neo.phoenix.base.RelatedObject user = memberForm.getUser(item);
            String personId = user.getId();
            String pub = user.getPublicationId();   
          %>
          <logic:iterate id="role" name="roles" type="java.lang.String">
            <%if(types.contains(role)){%>
            <% String key = "user(" + item + ").attribute(" + role + ")"; %>
              <html:hidden property="<%=key%>"/>
            </td>
            <%}%>
          </logic:iterate>
      </logic:iterate>
  <%}%>
</table>
<table><tr>
<% if (task.equals("/section/editMembers")) { %>
  <%
  %>                       
    <%-- <td><a class="global-button" href="javascript:submitForm('action:/section/addMembersFromBasket.do')">Add members from basket</a></td> --%>
    <td><a class="global-button" href="javascript:submitForm('findUsers')"><bean:message key="b.find_users"/></a></td>
  <% 
}else{  
  %>                       
    <%-- <td><a class="global-button" href="javascript:submitForm('action:/section/addGroupsFromBasket.do')">Add groups from basket</a></td> --%>
    <td><a class="global-button" href="javascript:submitForm('findGroups')"><bean:message key="b.find_groups"/></a></td>
    
<%} %>
  <%-- <td>
    List by role 
    <html:select property="currentRole">
      <logic:iterate id="role" name="roles" type="java.lang.String">
          <%if(types.contains(role)){%>
          <html:option value="<%=role%>"/>
          <%}%>
      </logic:iterate>
    </html:select>
    <a href="javascript:submitForm('listByRole')">Go</a>
  </td> --%>
</tr>
</table>
<input type="hidden" name="submitButton" value="">
