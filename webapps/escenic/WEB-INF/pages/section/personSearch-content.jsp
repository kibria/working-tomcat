<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>

<div class="error"><html:errors property="global" /></div>
<html:form action="/section/personSearch/dispatch">
<%--  <bean:define name="neo.phoenix.section.PersonSearchForm_Section" scope="request"
              type="neo.phoenix.section.PersonSearchForm_Section" id="form"/>
--%>
  <html:hidden property="parentWorkItemId" />
  <html:hidden property="doPubSearch"/>
  <input type="hidden" name="submitButton" value="action:/section/personSearch/perform.do">
  <input type="hidden" name="validateInput" value="success">
  <template:call file="../person/searchParameters.jsp">
    <template:parameter key="formName" value="neo.phoenix.person.PersonSearchForm"/>
  </template:call>
  <template:call file="../person/searchResult.jsp">
    <template:parameter key="formName" value="neo.phoenix.person.PersonSearchForm"/>
    <template:parameter key="nextUrl" value="/section/personSearch/search/prev"/>
    <template:parameter key="prevUrl" value="/section/personSearch/search/prev"/>
  </template:call>
  <% 
    java.util.Collection types = neo.phoenix.base.RoleUtil.getInstance().getSectionRoles();
    request.setAttribute("types",types);
  %>
  <bean:define name="types" id="roles" />  
  <table>
    <tr>
      <td>
        Add persons as
      </td>
    <logic:iterate id="role" type="java.lang.String" name="roles">
      <tr>
        <td>
        </td>
        <td>
          <bean:write name="role"/>
        </td>
        <td>
          <% String key = "role(" + role + ")"; %>
          <html:checkbox property="<%=key%>"/>
        </td>
      </tr>
    </logic:iterate>
    <tr>
      <td>
        <a href="javascript:submitForm('finished')">Add to section</a>
      </td>
    </tr>
  </table>    
</html:form>