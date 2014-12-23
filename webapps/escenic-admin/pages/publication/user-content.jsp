<%@ page language="java" isELIgnored="false" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>

<script type="text/javascript">
  function enableDisableTextFields() {
    var newUser = document.getElementById('newUser').checked;
    document.getElementById('oldUserName').disabled = newUser;
    document.getElementById('userName').disabled = !newUser;
    document.getElementById('password').disabled = !newUser;
    document.getElementById('confirmPassword').disabled = !newUser;
    document.getElementById('firstName').disabled = !newUser;
    document.getElementById('lastName').disabled = !newUser;
    document.getElementById('homePublication').disabled = !newUser;
  }

  if (window.addEventListener) {
    window.addEventListener("load", enableDisableTextFields, false);
  } else if (window.attachEvent) {
    window.attachEvent("onload", enableDisableTextFields);
  }
</script>
<h1>Grant a user read/write permission</h1 >
<h3>Step 1 : Select/create user</h3>
<html:errors property="global"/>
<html:form action="/publication/user/select">
  <div class="group">
    <html:radio property="newUser"
                value="false"
                styleId="oldUser"
                onchange="enableDisableTextFields();">
      Existing user
    </html:radio>
    <div class="field">
      <div class="label"><label for="oldUserName">User name:</label></div>
      <html:text property="oldUserName" styleId="oldUserName"/>
      <html:errors property="oldUserName"/>
    </div>
  </div>
  <div class="group">
    <html:radio property="newUser"
                value="true"
                styleId="newUser"
                onchange="enableDisableTextFields();">
      New user
    </html:radio>
    <div class="field">
      <div class="label"><label for="userName">User name:</label></div>
      <html:text property="userName" styleId="userName"/>
      <html:errors property="userName"/>
    </div>
    <div class="field">
      <div class="label"><label for="password">Password:</label></div>
      <html:password property="password" styleId="password"/>
      <html:errors property="password"/>
    </div>
    <div class="field">
      <div class="label"><label for="confirmPassword">Confirm password:</label></div>
      <html:password property="confirmPassword" styleId="confirmPassword"/>
      <html:errors property="confirmPassword"/>
    </div>
    <div class="field">
      <div class="label"><label for="firstName">First name:</label></div>
      <html:text property="firstName" styleId="firstName"/>
      <html:errors property="firstName"/>
    </div>
    <div class="field">
      <div class="label"><label for="lastName">Last name:</label></div>
      <html:text property="lastName" styleId="lastName"/>
      <html:errors property="lastName"/>
    </div>
    <div class="field">
      <div class="label"><label for="homePublication">Publication:</label></div>
      <html:select property="homePublication" styleId="homePublication">
        <html:options collection="publications" property="id" labelProperty="name"/>
      </html:select>
      <html:errors property="homePublication"/>
    </div>
  </div>
  <div class="group">
    <html:submit>Next</html:submit>
  </div>
</html:form>
