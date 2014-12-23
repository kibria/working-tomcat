<!-- index.jsp -->
<%@ page language="java" buffer="32kb" %>
<% try {%>
<!-- Calling frame -->
<%
 request.setAttribute("title","h.Menu");
 request.setAttribute("content", "/index-content.jsp");
%>

<jsp:include page="/do/nop" />
<jsp:include page="/pages/base/frame.jsp" />
<!-- Finished call to frame -->
<!-- End of index.jsp  -->
<% } catch (Throwable t) { %>
  <html><head><title>Escenic Administration Web Application</title></head>
  <body>
  <h1>Welcome to Escenic Content Engine!</h1>
  <p>You have reached the Escenic Content Engine <em>Administration application</em>.  Unfortunately, your web application server does not have sufficient information to execute this application.  What you see now is a slimmed down version of the application.</p>
  <h2>Slimmed down web application</h2>
  <p>
    Your system has not been set up correctly.  Possible problems could be missing <tt>CLASSPATH</tt> or <tt>localconfig</tt> configuration.  Please refer to the <em>Escenic Installation Guide</em> and the <em>Escenic Administration Guide</em> for information on how to install and administer Escenic.  Both are found from the Escenic Technet, located at <a href="http://technet.escenic.com/">technet.escenic.com</a>.
  </p>
  <p>
    To help you find out what the problem is, you can have a look at a slimmed down version of the <a href="status-content.jsp">status</a> page.  It contains system sanity checks, and hints that tell you what is wrong.  You may also view the current set of <a href="pages/systemproperties-content.jsp">system properties</a>.
  </p>
  <h2>Error details</h2>
  <p>The error that caused this page to be displayed is as follows:</p>
  <pre><%=t.toString()%></pre>
  <% if (t instanceof javax.servlet.ServletException) { %>
  <h3>Root Cause</h3>
  <pre><%=((ServletException)t).getRootCause()%></pre>
  <h3>Stack Trace</h3>
  <pre><%((ServletException)t).getRootCause().printStackTrace(new java.io.PrintWriter(out));%></pre>
  <% } else { %>
  <h3>Stack Trace</h3>
  <pre><%t.printStackTrace(new java.io.PrintWriter(out));%></pre>
  <% } %>
  </body>
<% } %>
