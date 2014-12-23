package org.apache.jsp.pages.publication;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import neo.xredsys.config.Publications;

public final class todo_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005flogic_005fpresent_0026_005fscope_005fname;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fbean_005fwrite_0026_005fname_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005flogic_005fpresent_0026_005fscope_005fname = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fbean_005fwrite_0026_005fname_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005flogic_005fpresent_0026_005fscope_005fname.release();
    _005fjspx_005ftagPool_005fbean_005fwrite_0026_005fname_005fnobody.release();
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
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");

try {
  neo.xredsys.api.Publication pub = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPublication((String)request.getAttribute("name"));
  if (pub != null) {
    pageContext.setAttribute("publication",pub);
  }
  {

      out.write('\n');
      out.write('\n');
      //  logic:present
      org.apache.struts.taglib.logic.PresentTag _jspx_th_logic_005fpresent_005f0 = (org.apache.struts.taglib.logic.PresentTag) _005fjspx_005ftagPool_005flogic_005fpresent_0026_005fscope_005fname.get(org.apache.struts.taglib.logic.PresentTag.class);
      _jspx_th_logic_005fpresent_005f0.setPageContext(_jspx_page_context);
      _jspx_th_logic_005fpresent_005f0.setParent(null);
      // /pages/publication/todo.jsp(17,0) name = name type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_logic_005fpresent_005f0.setName("publication");
      // /pages/publication/todo.jsp(17,0) name = scope type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_logic_005fpresent_005f0.setScope("page");
      int _jspx_eval_logic_005fpresent_005f0 = _jspx_th_logic_005fpresent_005f0.doStartTag();
      if (_jspx_eval_logic_005fpresent_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\n");
          out.write("  <style>\n");
          out.write("dt {\n");
          out.write("   font-weight: bold;\n");
          out.write("   space-before: 12pt;\n");
          out.write("   background: #dddddd;\n");
          out.write("}\n");
          out.write("  </style>\n");
          out.write("\n");
          out.write("  <dl>\n");
          out.write("    <dt valign=\"top\">Log in using Studio</dt>\n");
          out.write("    <dd valign=\"top\">Use <a href=\"/studio/\">Escenic Content Studio</a> to log on to this publication to start adding content immediately.</dd>\n");
          out.write("\n");
          out.write("    <dt valign=\"top\">Log in from the Web</dt>\n");
          out.write("    <dd valign=\"top\">Use the <a href=\"/escenic/\">Escenic Web interface</a> to log on to this publication to start administering it.   Here you can create new users, create a section hierarchy.  Use the user ID \"<tt>");
          if (_jspx_meth_bean_005fwrite_005f0(_jspx_th_logic_005fpresent_005f0, _jspx_page_context))
            return;
          out.write("_admin</tt>\" to log on to get publication administrative rights.</dd>\n");
          out.write("\n");
          out.write("    <dt valign=\"top\">Deploy the web application in your app server</dt>\n");
          out.write("    <dd valign=\"top\">The publication can be deployed on this (or another) server.  Use your application server administration tools to deploy this web application in order for the web application to respond to requests.</dd>\n");
          out.write("\n");
          out.write("    <dt valign=\"top\">Browse the publication</dt>\n");
          out.write("    <dd valign=\"top\">If you have deployed the web application, you may browse the publication at <tt><a href=\"");
          out.print(pub.getUrl());
          out.write('"');
          out.write('>');
          out.print(pub.getUrl());
          out.write("</a></tt>.  If the URL above does not work, try to deploy the web application to your application server.</dd>\n");
          out.write("\n");
          out.write("    <dt valign=\"top\">Who is logged on?</dt>\n");
          out.write("    <dd valign=\"top\"><a href=\"");
          out.print( request.getContextPath() );
          out.write("/pages/publication/sessions.jsp?publicationID=");
          out.print( pub.getId() );
          out.write("\">See who is currently logged in.</a></dd>\n");
          out.write("    <dt valign=\"top\">Export content</dt>\n");
          out.write("    <dd valign=\"top\"><a href=\"");
          out.print( request.getContextPath() );
          out.write("/pages/publication/migrate.jsp?publicationId=");
          out.print( pub.getId() );
          out.write("\">Export all contents of the publication \"");
          out.print(pub.getName());
          out.write("\" .</a></dd>\n");
          out.write("\n");
          out.write("    <dt valign=\"top\">Publication resources (download)</dt>\n");
          out.write("    <dd valign=\"top\">\n");
          out.write("    ");

      List l = pub.getResourceNames();
      String path = request.getContextPath();
      for (int i = 0; i < l.size(); i++) {
        String resource = String.valueOf(l.get(i));
        out.println("<a href=\"" + path + "/publication-resources/"+ pub.getName() + resource + "\">"+resource + "</a><br/>");
      }
    
          out.write("\n");
          out.write("    </dd>\n");
          out.write("    </dl>\n");
          out.write("  <p>The publication \"");
          out.print(pub.getName());
          out.write("\" has publication ID ");
          out.print(pub.getId());
          out.write(".</p>\n");
          out.write("\n");
 if ("true".equals(request.getAttribute("create"))) { 
          out.write('\n');
          out.write(' ');
          out.write(' ');

    Object contentResource = request.getSession().getAttribute("uploaded-resource:/escenic/content");
    if(contentResource != null) {
  
          out.write("\n");
          out.write("  <p>NOTE: There is a xml import running in the background to add content to your publication.</p>\n");
          out.write("  ");
 } 
          out.write("\n");
          out.write("  \n");
          out.write("  ");

  java.util.Map sectionParameterResource = (java.util.Map)request.getSession().getAttribute("uploaded-resource:/0/escenic/section-parameter");
  if(sectionParameterResource != null) {
    byte[] data = (byte[])sectionParameterResource.get("data");
    String parameters = neo.util.StringUtil.escapeHtml(new String(data, 0, data.length));
   
          out.write("\n");
          out.write("  <p>\n");
          out.write("    <dl>\n");
          out.write("      <dt valign=\"top\">The following section parameters were set for\n");
          out.write("      the root section of this publication.</dt>\n");
          out.write("      <dd>\n");
          out.write("        <pre>\n");
          out.write("        ");
          out.print(parameters);
          out.write("\n");
          out.write("        </pre>\n");
          out.write("      </dd>\n");
          out.write("    </dl> \n");
          out.write("  </p>\n");
          out.write("  ");
 } 
          out.write('\n');
 } 
          out.write('\n');
          int evalDoAfterBody = _jspx_th_logic_005fpresent_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_logic_005fpresent_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005flogic_005fpresent_0026_005fscope_005fname.reuse(_jspx_th_logic_005fpresent_005f0);
        return;
      }
      _005fjspx_005ftagPool_005flogic_005fpresent_0026_005fscope_005fname.reuse(_jspx_th_logic_005fpresent_005f0);
      out.write('\n');
      out.write('\n');

  }
} catch (Exception e) {
  out.println(e.toString());
}

      out.write("\n");
      out.write("\n");
      out.write("<hr />\n");
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

  private boolean _jspx_meth_bean_005fwrite_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_logic_005fpresent_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:write
    org.apache.struts.taglib.bean.WriteTag _jspx_th_bean_005fwrite_005f0 = (org.apache.struts.taglib.bean.WriteTag) _005fjspx_005ftagPool_005fbean_005fwrite_0026_005fname_005fnobody.get(org.apache.struts.taglib.bean.WriteTag.class);
    _jspx_th_bean_005fwrite_005f0.setPageContext(_jspx_page_context);
    _jspx_th_bean_005fwrite_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_logic_005fpresent_005f0);
    // /pages/publication/todo.jsp(31,215) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f0.setName("name");
    int _jspx_eval_bean_005fwrite_005f0 = _jspx_th_bean_005fwrite_005f0.doStartTag();
    if (_jspx_th_bean_005fwrite_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fbean_005fwrite_0026_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fbean_005fwrite_0026_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f0);
    return false;
  }
}
