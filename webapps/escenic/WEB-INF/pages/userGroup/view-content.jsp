<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-view" prefix="view" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<div class="error"><html:errors property="global" /></div>
<bean:define id="publication" 
             name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<bean:define name="neo.phoenix.userGroup.UserGroupForm" id="form" scope="request" type="neo.phoenix.userGroup.UserGroupForm"/>
<bean:define id="checker" 
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
  <%@include file="../base/relatedObjects.jspf" %>
  <html:hidden property="pubId" />
  <table>
    <tr>
      <td><h2><%=form.getName()%></h2></td>
    </tr>
  </table>
  <html:hidden property="createWorkItem" value="false"/>
  <% int pubID = publication.getId(); %>

  <html:hidden property="name" value="<%=form.getName()%>" />
  <p><h4>Members</h4>
    <table>
    <bean:define id="members" name="neo.phoenix.userGroup.UserGroupForm" property="users" scope="request" type="java.util.List"/>
    <% if(members.size()>0){ %>
        <logic:iterate name="members" id="key" type="java.lang.String">
          <%  String p1 = "user(" + key + ").id"; 
              String p2 = "user(" + key + ").type"; 
              String p3 = "user(" + key + ").publicationId";
          %>
          <html:hidden property="<%=p1%>"/>
          <html:hidden property="<%=p2%>"/>
          <html:hidden property="<%=p3%>"/>

          <% 
             neo.phoenix.base.RelatedObject relObj = form.getUser(key);
             neo.xredsys.api.Person item = (neo.xredsys.api.Person)neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPerson(Integer.parseInt(relObj.getId()),Integer.parseInt(relObj.getPublicationId())); %>
          <tr>
            <template:call file="../base/presentPerson.jsp">
              <% String perId = item.getId() + "";
                 String pubId = item.getOwnerPublicationId() + "";       
              %>
              <template:parameter key="personId" value="<%=perId%>" />
              <template:parameter key="external" value="false" />
              <template:parameter key="pubId" value="<%=pubId%>" />
            </template:call>
          </tr>
        </logic:iterate>
    <% } %> 
    </table>

    <bean:define id="groups" name="neo.phoenix.userGroup.UserGroupForm" property="userGroups" scope="request" type="java.util.Collection"/>
    <h4>Groups</h4>
    <table>
      <% if(groups.size()>0){%>
        <logic:iterate name="groups" id="key" type="java.lang.String">
          <%  String p1 = "userGroup(" + key + ").attribute(name)"; 
              String p2 = "userGroup(" + key + ").type"; 
              String p3 = "userGroup(" + key + ").publicationId";
          %>
          <html:hidden property="<%=p1%>"/>
          <html:hidden property="<%=p2%>"/>
          <html:hidden property="<%=p3%>"/>

          <% 
             neo.phoenix.base.RelatedObject relObj = form.getUserGroup(key);
             String name = relObj.getAttribute("name");
             int pubId = Integer.parseInt(relObj.getPublicationId());
             neo.xredsys.api.UserGroup item = (neo.xredsys.api.UserGroup)neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getUserGroup(name,pubId); %>
          <% String remove = "action:/userGroup/RemoveGroupFromUserGroup.do?groupName="+name+"&pubId="+pubId;%>

            <template:call file="../base/presentUserGroup.jsp">
              <% String groupName = item.getName() + ""; 
                 String pub = item.getOwnerPublicationId() + "";   
              %>
              <template:parameter key="external" value="false" />
              <template:parameter key="pubId" value="<%=pub%>" />
              <template:parameter key="groupName" value="<%=groupName%>" />
            </template:call> 
            <td><a href="javascript:submitForm('<%=remove%>')">
              <html:img page="/images/qw/delete.png" />
            </td></a>
          </tr> 
        </logic:iterate>
       <% } %> 
      </table>
  </p>
  
  <hr />
  <input type="hidden" name="validateButton" value="viewRoles"/>
  <input type="hidden" name="validateField" value="none" />
  <input type="hidden" name="validateInput"  value="none"/>
  <input type="hidden" name="submitButton" value="">
  <table>
    <tr>
    <%
      neo.xredsys.api.UserGroup group = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getUserGroup(form.getName(),Integer.parseInt(form.getPubId())); 
      if(checker.isGlobalPublicationAdmin(group.getOwnerPublicationId())){ %>
     <% String edit = "/userGroup/edit.do?name="+form.getName()+"&pubId="+form.getPubId()+"')"; %>
    <td><html:link styleClass="global-button"  page="<%=edit%>">Edit</html:link></td>
    <td><a class="global-button" href="javascript:submitForm('viewRoles')">View roles</a></td>
    <% } %>
    </tr>
  </table>

