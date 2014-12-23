<%@ page import="java.util.Properties"%>
<%@ page import="java.util.TreeSet"%>
<%@ page import="java.util.Iterator"%>
<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<!-- viewArticleTypes-content.jsp -->
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>

<bean:define id="publication" name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />

<input type="hidden" name="submitButton" value="success">
<input type="hidden" name="validateInput" value="success">
<%
  Properties features = publication.getFeatures();
%>
<h1><bean:message key="a.publication.features"/></h1>
<table>
  <tr>
    <th align="left">Name</th>
    <th align="left">Value</th>
  </tr>
  <%
    Iterator i = new TreeSet(features.keySet()).iterator();
    while(i.hasNext()){
      String key = (String)i.next();
      %>
      <tr>
        <td class="view-propertyname"><%=key%></td>
        <td class="view-propertyvalue"><%=features.getProperty(key)%></td>
      </tr>
      <%
    }
  %>
</table>