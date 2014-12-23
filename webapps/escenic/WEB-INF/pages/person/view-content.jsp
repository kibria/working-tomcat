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

<div class="error"><html:errors property="global" /></div>
  <bean:define name="neo.phoenix.person.PersonForm" id="form" scope="request" type="neo.phoenix.person.PersonForm"/>
<% 
    neo.xredsys.api.Person person = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPerson(Integer.parseInt(form.getId()), Integer.parseInt(form.getPubId()));
%>
  <%@include file="../base/relatedObjects.jspf" %>
  <table>
  <% 
    boolean canEditUser = checker.isGlobalPublicationAdmin(person.getOwnerPublicationId());
    String canEditAsString = String.valueOf(canEditUser); 
  %> 
    <template:call file="viewProps.jsp">
      <template:parameter key="canEditUser" value="<%=canEditAsString%>"/>
      <template:parameter key="personID" value="<%=form.getId()%>"/>
      <template:parameter key="pubID" value="<%=form.getPubId()%>"/>
    </template:call>
  </table>
  <html:hidden property="id" />
  <html:hidden property="pubId" />
  <logic:iterate name="form" property="userGroups" id="key" type="java.lang.String">
    <%  String p1 = "userGroup(" + key + ").attribute(name)"; 
        String p2 = "userGroup(" + key + ").type"; 
        String p3 = "userGroup(" + key + ").publicationId";
    %>
    <html:hidden property="<%=p1%>"/>
    <html:hidden property="<%=p2%>"/>
    <html:hidden property="<%=p3%>"/>
  </logic:iterate>
  <html:hidden property="createWorkItem" value="false"/>      
  <hr />
  <input type="hidden" name="validateButton" value="none"/>
  <input type="hidden" name="validateField" value="none" />
  <input type="hidden" name="validateInput"  value="none"/>
  <input type="hidden" name="submitButton" value="">
  <table>
    <tr>
      <%
        if(checker.isGlobalPublicationAdmin(person.getOwnerPublicationId())){ %>
        <td><a href="javascript:submitForm('viewGroups')">viewGroups</a></td>
        <td><a href="javascript:submitForm('viewRoles')">viewRoles</a></td>
      <% } %>
      <td><a href="javascript:submitForm('back')">Finished</a></td>
    </tr>
  </table>
