<%@ page session="false" contentType="text/plain" language="java" isErrorPage="true"
%><%
  response.setContentType("text/plain");
  Object code = request.getAttribute("javax.servlet.error.status_code");
  if (code == null) {
    code = "";
  }
  Object message = request.getAttribute("javax.servlet.error.message");
  if (message == null) {
    message = "";
  }
  Object o = exception;
  if (! (o instanceof Throwable)) {
    o = request.getAttribute("javax.servlet.error.exception");
  }
  if (! (o instanceof Throwable)) {
    o = request.getAttribute("exception");
  }
  Throwable exc = null;
  if (o instanceof Throwable) {
    exc = (Throwable) o;
  }
%><%= code%> <%= message%>
<%=exc == null ? "" : exc.getMessage() %>

<% if (exc != null) {
 exc.printStackTrace(new java.io.PrintWriter((JspWriter)pageContext.getAttribute(PageContext.OUT)));
}%>
