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
<div class="error"><html:errors property="global" /></div>
  <bean:define name="neo.phoenix.person.PersonForm" id="form" scope="request" type="neo.phoenix.person.PersonForm"/>
  <html:hidden property="id" />
  <html:hidden property="pubId" />
  <html:hidden property="createWorkItem" value="false"/>
  <%@include file="../base/relatedObjects.jspf" %>
  <h3>User is member of these groups</h3>
  <table>
    <logic:iterate name="form" property="userGroups" id="key" type="java.lang.String">
      <tr>
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
           String pubId = relObj.getPublicationId();
        %>
        <template:call file="../base/presentUserGroup.jsp">
          <template:parameter key="external" value="false" />
          <template:parameter key="pubId" value="<%=pubId%>" />
          <template:parameter key="groupName" value="<%=name%>" />
        </template:call>
      </tr>
    </logic:iterate>
  </table>
  <hr />
  <% if(form.isHasFoundAllGroups()){ %>
    <table>
      <tr>
        <th>All groups</th>
      </tr>
      <logic:iterate name="form" property="allUserGroups" id="key" type="java.lang.String">
        <tr>
          <%  String p1 = "allUserGroup(" + key + ").attribute(name)"; 
              String p2 = "allUserGroup(" + key + ").type"; 
              String p3 = "allUserGroup(" + key + ").publicationId";
          %>
          <html:hidden property="<%=p1%>"/>
          <html:hidden property="<%=p2%>"/>
          <html:hidden property="<%=p3%>"/>
          <% 
             neo.phoenix.base.RelatedObject relObj = form.getAllUserGroup(key);
             String name = relObj.getAttribute("name");
             String pubId = relObj.getPublicationId();
          %>
          <template:call file="../base/presentUserGroup.jsp">
            <template:parameter key="external" value="false" />
            <template:parameter key="pubId" value="<%=pubId%>" />
            <template:parameter key="groupName" value="<%=name%>" />
          </template:call>
        </tr>
      </logic:iterate>
    </table>
  <% } %>
  <input type="hidden" name="validateButton" value="none"/>
  <input type="hidden" name="validateField" value="none" />
  <input type="hidden" name="validateInput"  value="none"/>
  <input type="hidden" name="submitButton" value="">
  <table>
    <tr>
      <td><a href="javascript:submitForm('view')">view person</a></td>
      <td><a href="javascript:submitForm('viewRoles')">view roles</a></td>
      <% if(!form.isHasFoundAllGroups()){ %>
        <td><a href="javascript:submitForm('action:/person/findAllGroups.do')">view all groups</a>
        </td>
      <% } %>  
      <td><a href="javascript:submitForm('back')">Finished</a></td>
    </tr>
  </table>
