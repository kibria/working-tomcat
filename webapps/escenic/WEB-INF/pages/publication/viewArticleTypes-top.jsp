<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<bean:define id="publication" name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />

<table>
  <tr>
    <th>
      <bean:message key="h.Article_types" />
    </th>
</table>


