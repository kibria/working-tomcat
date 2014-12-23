<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.StringWriter" %>
<%@ page isErrorPage="true"%>
<pre>
<%
  StringWriter writer = new StringWriter();
  exception.printStackTrace(new PrintWriter(writer));
  out.print(writer.toString());
%>
</pre>