<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<bean:define name="neo.phoenix.userGroup.UserGroupForm" id="form" scope="request" type="neo.phoenix.userGroup.UserGroupForm"/>
<table>
  <tr><td valign="top"><font size="+2"><b><bean:write name="form" property="name"/></b></font></td></tr>
</table>


