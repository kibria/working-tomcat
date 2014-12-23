package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 32768, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<!-- index.jsp -->\n");
      out.write("\n");
 try {
      out.write("\n");
      out.write("<!-- Calling frame -->\n");

 request.setAttribute("title","h.Menu");
 request.setAttribute("content", "/index-content.jsp");

      out.write('\n');
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "/do/nop", out, false);
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "/pages/base/frame.jsp", out, false);
      out.write("\n");
      out.write("<!-- Finished call to frame -->\n");
      out.write("<!-- End of index.jsp  -->\n");
 } catch (Throwable t) { 
      out.write("\n");
      out.write("  <html><head><title>Escenic Administration Web Application</title></head>\n");
      out.write("  <body>\n");
      out.write("  <h1>Welcome to Escenic Content Engine!</h1>\n");
      out.write("  <p>You have reached the Escenic Content Engine <em>Administration application</em>.  Unfortunately, your web application server does not have sufficient information to execute this application.  What you see now is a slimmed down version of the application.</p>\n");
      out.write("  <h2>Slimmed down web application</h2>\n");
      out.write("  <p>\n");
      out.write("    Your system has not been set up correctly.  Possible problems could be missing <tt>CLASSPATH</tt> or <tt>localconfig</tt> configuration.  Please refer to the <em>Escenic Installation Guide</em> and the <em>Escenic Administration Guide</em> for information on how to install and administer Escenic.  Both are found from the Escenic Technet, located at <a href=\"http://technet.escenic.com/\">technet.escenic.com</a>.\n");
      out.write("  </p>\n");
      out.write("  <p>\n");
      out.write("    To help you find out what the problem is, you can have a look at a slimmed down version of the <a href=\"status-content.jsp\">status</a> page.  It contains system sanity checks, and hints that tell you what is wrong.  You may also view the current set of <a href=\"pages/systemproperties-content.jsp\">system properties</a>.\n");
      out.write("  </p>\n");
      out.write("  <h2>Error details</h2>\n");
      out.write("  <p>The error that caused this page to be displayed is as follows:</p>\n");
      out.write("  <pre>");
      out.print(t.toString());
      out.write("</pre>\n");
      out.write("  ");
 if (t instanceof javax.servlet.ServletException) { 
      out.write("\n");
      out.write("  <h3>Root Cause</h3>\n");
      out.write("  <pre>");
      out.print(((ServletException)t).getRootCause());
      out.write("</pre>\n");
      out.write("  <h3>Stack Trace</h3>\n");
      out.write("  <pre>");
((ServletException)t).getRootCause().printStackTrace(new java.io.PrintWriter(out));
      out.write("</pre>\n");
      out.write("  ");
 } else { 
      out.write("\n");
      out.write("  <h3>Stack Trace</h3>\n");
      out.write("  <pre>");
t.printStackTrace(new java.io.PrintWriter(out));
      out.write("</pre>\n");
      out.write("  ");
 } 
      out.write("\n");
      out.write("  </body>\n");
 } 
      out.write('\n');
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else log(t.getMessage(), t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
