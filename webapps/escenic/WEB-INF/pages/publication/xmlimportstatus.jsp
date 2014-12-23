<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>

<logic:present name="feedback" scope="session">
<h2>Import progress</h2>
Running <b><bean:write name="feedback" property="running"/></b>
<logic:equal name="feedback" property="running" value="true">
  <html:link page="/publication/xmlimport/stop.do">Stop import</html:link>
</logic:equal><br>
Running time: <b><bean:write name="feedback" property="runningTime"/>ms</b><br>
Number of messages <b><bean:write name="feedback" property="messageCount"/></b><br>
Number of lines processed <b><bean:write name="feedback" property="lineNumber"/></b><br>
Types of imported data: 
<ul>
<logic:iterate name="feedback" property="contextTypes" id="type" type="java.lang.String">
<logic:present name="type">
 <li>
 <b><bean:write name="type" /></b>:
 <bean:write name="feedback" property="<%=\"successCount(\" + type +\")\" %>"/> success;
 <bean:write name="feedback" property="<%=\"failureCount(\" + type +\")\" %>"/> failure.
 </li>
</logic:present>
</logic:iterate>
<% int max = ((com.escenic.syndication.xml.ImportFeedback)request.getSession().getAttribute("feedback")).getMessageCount(); %>
</ul>
<logic:equal name="feedback" property="running" value="true">
  <html:link page="/publication/xmlimport/status.do?page=1">Refresh</html:link><br/>
</logic:equal><br>

See messages <% for (int i = 0; i < (max-1)/100 + 1; i++) { %><html:link
      page="<%= \"/publication/xmlimport/status.do?page=\" + i%>"><%= i*100+1 %>-<%= i*100+100 %></html:link>&nbsp;&nbsp;<% } %>

<% int pageNo = -1; 
try {
  pageNo = Integer.parseInt(request.getParameter("page"));
} catch (Exception e) {
}
if (pageNo != -1) { %>
  <table>
    <logic:iterate name="feedback" property="messages" offset="<%= pageNo*100 + \"\" %>" length="100" id="message">
    <tr>
      <td><bean:write name="message" property="formattedMessage"/></td>
    </tr>
    </logic:iterate>
  </table>  
<% } %>

</logic:present>

<logic:present name="messages" scope="request">
  <table>
    <logic:iterate name="messages" scope="request" id="message">
    <tr>
      <td><bean:write name="message"/></td>
    </tr>
    </logic:iterate>
  </table>
</logic:present>
