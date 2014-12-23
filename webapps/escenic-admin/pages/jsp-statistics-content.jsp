<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>

<%-- We have a vaild name.  If we are missing a path, show the top-ten list. --%>

<%

String path = (String) request.getAttribute("path");
String name = (String) request.getAttribute("name");
neo.util.callinfo.CallInfoCollector collector = (neo.util.callinfo.CallInfoCollector) request.getAttribute("collector");
neo.util.callinfo.Statistics statistics = (neo.util.callinfo.Statistics) request.getAttribute("statistics");
java.util.Set metricKeys = (java.util.Set) request.getAttribute("metricKeys");
String errormessage = (String) request.getAttribute("errormessage");

if ("reset".equals(request.getParameter("action"))) {
  statistics.reset(name);
  %>
  <p>
    The statistics have been reset for <%=name%>.
    <html:link page='<%= "/statistics/" %>'>Back</html:link> to the main menu.
  </p>
  
  <%
} else if (neo.util.StringUtil.isEmpty(path) || path.endsWith("/") || metricKeys.contains(path.substring(1))) {
  %>
  <%@ include file="jsp-statistics-show-hotlist.jspf" %> 
  <%
} else {
  %>
  <%@ include file="jsp-statistics-show-pathinfo.jspf" %>
  <%
}
%>


