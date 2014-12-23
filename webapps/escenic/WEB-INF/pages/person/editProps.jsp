<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%--
  isAdmin -- wether or not the username should be modifiable or not. (always false?)
  canEditUser (true/false) -- wether or not username and password(s) should be visible
  isGuestUser (true/false) (true if read only) -- ?????
  readOnly (true/false) -- wether or not the properties should be read only.
--%>


<bean:define id="checker" 
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<bean:define id="form" name="neo.phoenix.person.PersonForm" type="neo.phoenix.person.PersonForm"/>
<bean:define id="isGuestUser" name="isGuestUser" type="java.lang.String"/>
<bean:define id="canEditUser" name="canEditUser" type="java.lang.String"/>
<bean:define id="sReadOnly" name="readOnly" type="java.lang.String"/>
<% boolean guestUser = neo.util.StringUtil.getBoolean(isGuestUser); 
  boolean isReadOnly = neo.util.StringUtil.getBoolean(sReadOnly);
  if(isReadOnly){
    guestUser = true;
  }
%>
<table class="wide">
  <tr>
    <td><bean:message key="t.First_name"/>:</td>
    <td><html:text property="firstName" readonly="<%=guestUser%>" /></td><td><html:errors property="firstName" /></td>
  </tr>
  <tr>
    <td><bean:message key="t.Surname"/>:</td>
    <td><html:text property="surName" readonly="<%=guestUser%>" /></td><td><html:errors property="surName" /></td>
  </tr>
  <% boolean isModifyingExistingPerson = (!neo.util.StringUtil.isEmpty(form.getId()))&&Integer.parseInt(form.getId())>0;
     boolean isModifyingUser = !neo.util.StringUtil.isEmpty(form.getUserName());
  %>
  <% if (canEditUser.equalsIgnoreCase("true")){ %> 
    <% 
       String sIsAdmin = (String)request.getAttribute("isAdmin");
       boolean readOnly = false;
       boolean isAdmin = false;
       if(sIsAdmin!=null&&sIsAdmin.equalsIgnoreCase("true")){
        readOnly = true;
        isAdmin = true;
       }
       if(!readOnly&&guestUser){
        readOnly = true;
       }
    %>
    <% if (canEditUser.equalsIgnoreCase("true")) { %>
    <tr>
      <td><bean:message key="t.User_name"/>:</td>
      <%if(!isAdmin){%>
        <td><%=form.getUserName()%></td>
        <html:hidden property="userName"/>
      <%}else{%>
        <td><html:text property="userName" readonly="<%=guestUser%>"/></td><td><html:errors property="userName" /></td>
      <%}%>
    </tr>
    <% } %>
    <% if (isModifyingExistingPerson && isModifyingUser) { %> 
      <tr>
        <td><bean:message key="t.Password"/>:</td>
        <td><%=form.getOldPassword()%><html:hidden property="oldPassword"/></td><td><html:errors property="oldPassword" /></td>
      </tr>
    <%}%>
    <tr>
      <td><bean:message key="t.New_password"/>:</td>
      <td><html:password property="newPassword" readonly="<%=guestUser%>" redisplay="false" /></td><td><html:errors property="newPassword" /></td>
    </tr>
    <tr>
      <td><bean:message key="t.Confirm_password"/></td>
      <td><html:password property="confirmPassword" readonly="<%=guestUser%>" redisplay="false" /></td><td><html:errors property="confirmPassword" /></td>
    </tr>
  <% }else{ %>
    <html:hidden property="userName"/>
  <%}%>
  <tr>
    <td><bean:message key="t.E_mail"/>:</td>
    <td><html:text property="email" readonly="<%=guestUser%>"/></td><td><html:errors property="email" /></td>
  </tr>
  <tr>
    <td><bean:message key="t.Address"/>:</td>
    <td><html:text property="adress" readonly="<%=guestUser%>"/></td><td><html:errors property="adress" /></td>
  </tr>
  <tr>
    <td><bean:message key="t.Post_number"/>:</td>
    <td><html:text property="postNumber" readonly="<%=guestUser%>" /></td><td><html:errors property="postNumber" /></td>
  </tr>
  <tr>
    <td><bean:message key="t.Post_place"/>:</td>
    <td><html:text property="postPlace" readonly="<%=guestUser%>"/></td><td><html:errors property="postPlace" /></td>
  </tr>
<%--  <tr>
    <td>NickName:</td>
    <td><html:text property="nickName" /></td><td><html:errors property="nickName" /></td>
  </tr> --%>
  <tr>
    <td><bean:message key="t.Work_direct"/>:</td>
    <td><html:text property="phoneWorkDirect" readonly="<%=guestUser%>"/></td><td><html:errors property="phoneWorkDirect" /></td>
  </tr>
  <tr>
    <td><bean:message key="t.Mobile_phone"/>:</td>
    <td><html:text property="phoneMobile" readonly="<%=guestUser%>"/></td><td><html:errors property="phoneMobile" /></td>
  </tr>
  <tr>
    <td><bean:message key="t.Phone_private"/>:</td>
    <td><html:text property="phonePrivate" readonly="<%=guestUser%>"/></td><td><html:errors property="phonePrivate" /></td>
  </tr>
  <tr>
    <td><bean:message key="t.Description"/>:</td>
    <td><html:textarea property="description" readonly="<%=guestUser%>"/></td><td><html:errors property="description" /></td>
  </tr>
</table>
