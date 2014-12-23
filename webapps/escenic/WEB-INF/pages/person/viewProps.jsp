<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%
  String personId = (String)request.getAttribute("personID");
  String pubId = (String)request.getAttribute("pubID");
  neo.xredsys.api.Person person = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPerson(Integer.parseInt(personId),Integer.parseInt(pubId));
  request.setAttribute("person",person);
%>
<bean:define id="checker" 
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<bean:define id="canEditUser" name="canEditUser" type="java.lang.String"/>
<logic:notEmpty name="person" property="firstName">
  <tr>
    <td>FirstName:</td>
    <td><bean:write name="person" property="firstName"/>
  </tr>
</logic:notEmpty>
<logic:notEmpty name="person" property="surName">
  <tr>
    <td>Surname:</td>
    <td><bean:write name="person" property="surName"/>
  </tr>
</logic:notEmpty>
<% if(canEditUser.equalsIgnoreCase("true")){ %>
  <logic:notEmpty name="person" property="userName">
    <tr>
      <td>UserName:</td>
      <td><bean:write name="person" property="userName"/>
    </tr>
  </logic:notEmpty>
<% } %>
<logic:notEmpty name="person" property="emailAddress">
  <tr>
    <td>E-mail:</td>
    <td><bean:write name="person" property="emailAddress"/>
  </tr>
</logic:notEmpty>
<logic:notEmpty name="person" property="address">
  <tr>
    <td>Adress:</td>
    <td><bean:write name="person" property="address"/>
  </tr>
</logic:notEmpty>
<logic:notEmpty name="person" property="postNumber">
  <tr>
    <td>PostNumber:</td>
    <td><bean:write name="person" property="postNumber"/>
  </tr>
</logic:notEmpty>
<logic:notEmpty name="person" property="postPlace">
  <tr>
    <td>PostPlace:</td>
    <td><bean:write name="person" property="postPlace"/>
  </tr>
</logic:notEmpty>
<logic:notEmpty name="person" property="nickName">
  <tr>
    <td>NickName:</td>
    <td><bean:write name="person" property="nickName"/>
  </tr>
</logic:notEmpty>
<logic:notEmpty name="person" property="phoneWorkDirect">
  <tr>
    <td>WorkDirect:</td>
    <td><bean:write name="person" property="phoneWorkDirect"/>
  </tr>
</logic:notEmpty>
<logic:notEmpty name="person" property="phoneMobile">
  <tr>
    <td>Mobile:</td>
    <td><bean:write name="person" property="phoneMobile"/>
  </tr>
</logic:notEmpty>
<logic:notEmpty name="person" property="phonePrivate">
  <tr>
    <td>Private:</td>
    <td><bean:write name="person" property="phonePrivate"/>
  </tr>
</logic:notEmpty>
<logic:notEmpty name="person" property="description">
  <tr>
    <td>Description:</td>
    <td><bean:write name="person" property="description"/>
  </tr>
</logic:notEmpty>