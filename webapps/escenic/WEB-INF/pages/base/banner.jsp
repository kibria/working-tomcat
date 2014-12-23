<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-view" prefix="view" %>
<%--  This is how the top looks like...
  <tr>
    <td width="100"><html:img page="/images/nothing.gif" width="100" height="1" /></td>
    <td width="5"><html:img page="/images/nothing.gif" width="5" height="1"/></td>
    <td width="100%"><html:img page="/images/nothing.gif" width="300" height="1"/></td>
    <td width="5"><html:img page="/images/nothing.gif" width="5" height="1"/></td>
    <td width="100"><html:img page="/images/nothing.gif" width="100" height="1"/></td>
  </tr>
--%>
<tr>
<td colspan="5" class="banner"><html:img align="middle" page="/images/nothing.gif" height="40"/><span class="bannertext">&nbsp;<bean:message bundle="org.apache.struts.action.MESSAGE" name="title"/></span></td>
</tr>
