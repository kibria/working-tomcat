<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-view" prefix="view" %>
<bean:define id="publication" name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<div class="error"><html:errors property="global" /></div>
<input type="hidden" name="enterAction" value="save"/>
<input type="hidden" name="validateButton" value="save">
<input type="hidden" name="validateInput"  value="save">
<input type="hidden" name="validateField" value="none" />
<table border="0" cellpadding="2" cellspacing="0">
  <tr>
    <th><bean:message key="h.Change_your_password"/></th>
  </tr>
  <tr>
    <td><bean:message key="t.Old_password"/>:</td>
    <td><html:password property="oldPassword"/></td><td><html:errors property="oldPassword" /></td>
  </tr>
  <tr>
    <td><bean:message key="t.New_password"/>:</td>
    <td><html:password property="password"/></td><td><html:errors property="password" /></td>
  </tr>
  <tr>
    <td><bean:message key="t.Confirm_password"/>:</td>
    <td><html:password property="confirmPassword"/></td><td><html:errors property="confirmPassword" /></td>
  </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td><a class="global-button" href="javascript:submitForm('save')"><bean:message key="b.update"/></a></td>
    <td>&nbsp;</td>
    <td><a class="global-button" href="javascript:submitForm('cancel')"><bean:message key="b.cancel"/></a></td>
  </tr>
</table>
<input type="hidden" name="submitButton" value="">