<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-view" prefix="view" %>
<bean:define id="publication" 
             name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<div class="error"><html:errors property="global" /></div>
<html:hidden property="parentWorkItemId"/>
<input type="hidden" name="validateButton" value="save"/>
<input type="hidden" name="validateInput"  value="validate"/>
<input type="hidden" name="validateField" value="name" />
<table>
  <tr>
    <td><bean:message key="t.Name"/>:</td>
    <td><html:text property="name"/></td><td><html:errors property="name" /></td>
  </tr>
</table>

<input type="button" class="important-button" onClick="submitForm('save')" value="<bean:message key="b.save"/>" />
<input type="button" class="link" onClick="submitForm('cancel')" value="<bean:message key="b.cancel"/>" />
<input type="hidden" name="submitButton" value="save">
