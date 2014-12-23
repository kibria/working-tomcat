<%@ page import="com.escenic.auth.jaas.oauth2.OAuth2ProviderConfiguration" %>
<%@ page import="neo.nursery.GlobalBus" %>
<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<!-- inside logon-content.jsp -->
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%-- includeds browserdetect --%>
<script language="JavaScript1.2" src="<html:rewrite page="/script/browserdetect.js"/>">
</SCRIPT>


<script type="text/javascript" language="JavaScript">

function initFocus() {
  /* only invoke the 'focus' if the field is rendered, and it is not
   * actually a hidden field!  IE6 chokes on focus()'ing a hidden field
   */
  if (document.forms[0])
  if (document.forms[0].userId)
  if (document.forms[0].userId.type)
  if (document.forms[0].userId.type != 'hidden')
    document.forms[0].userId.focus();
  return true;
}
registerHook('afterLoad',initFocus);

function continueWorking(){
  document.getElementById("hijack").value="true";
  submitForm("submit");
}

function doNotcontinueWorking(){
  document.getElementById("hijack").value="false";
  submitForm("submit");
}

</script>

<div class="header">
  <html:img page="/gfx/escenic_ws_logo.png" alt="Escenic Content Studio" />
</div>
<logic:notPresent name="my-logons" scope="request">
  <div class="buttons">
    <div class="head">Log in to WebStudio</div>
    <div class="label"><bean:message key="t.User_name"/>:</div>
    <div class="loginField"><html:text styleClass="loginFields" styleId="userId" property="userId" /></div>
    <div class="label"><bean:message key="t.Password"/>:</div>
    <div class="loginField"><html:password styleClass="loginFields" styleId="password" property="password" /></div>
    <div class="messages"><html:errors property="userId"/></div>
    <div class="messages"><html:errors property="password"/></div>
    <div class="messages"><html:errors property="global"/></div>
    <div class="buttons">
      <button class="login" onClick="submitForm('submit')" ><bean:message key="b.login"/></button>
    </div>
    <%
      OAuth2ProviderConfiguration configuration = (OAuth2ProviderConfiguration) GlobalBus.lookupSafe("/com/escenic/auth/oauth2/OAuth2Configuration");
      if (configuration != null && configuration.getClientIdAndSecretFor("web") != null) {
    %>
      <div class="ssoBox">
          <div class="label"><span class="hover">or, using:</span></div>
          <div class="buttons">
            <html:link styleClass="sso" page="/oauth2/auth"><%=configuration.getName()%></html:link>
          </div>
        </div>
    <%}%>
  </div>
</logic:notPresent>
<logic:present name="my-logons" scope="request">
  <div class="hijack">
    <div class="head">Log in to WebStudio</div>
    <button class="hijack" onClick="javascript:continueWorking()"><bean:message key="b.login_hijack_session"/></button>
    <button class="leaveBe" onClick="javascript:doNotcontinueWorking()"><bean:message key="b.login_new_session"/></button>
  </div>
  <html:hidden property="password"/>
  <html:hidden property="userId"/>
</logic:present>

<input type="hidden" name="submitButton" value="">
<input type="hidden" name="hijackSession" value="" id="hijack"/>