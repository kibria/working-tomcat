package org.apache.jsp.WEB_002dINF.pages.framework;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import java.net.URL;

public final class frame_002dmapping_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


neo.xredsys.config.StringPairMapping mapping = new neo.xredsys.config.StringPairMapping();



public void jspInit() {
  org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger("neo.phoenix.framework.FrameMapping");
  String resource = "/WEB-INF/frame-mapping.xml";
  java.io.InputStream stream = getServletConfig().getServletContext().getResourceAsStream(resource);
  org.xml.sax.InputSource source = new org.xml.sax.InputSource(stream);
  readMapping(source);

  try{
    Enumeration resources = getClass().getClassLoader().getResources("com/escenic/plugin/frame-mapping.xml");
    if (resources.hasMoreElements()) {
      while (resources.hasMoreElements()) {
        URL u = (URL) resources.nextElement();
        LOGGER.info("Loading additional mappings from url " + u);
        try{
          source = new org.xml.sax.InputSource(u.openStream());
          readMapping(source);
        } catch (java.io.IOException e) {
          LOGGER.warn("Loading additional mappings from url " + u + " failed: " + e);
          LOGGER.debug("Exception details: ", e);
        }
      }
    }
  }catch(Exception e){
    LOGGER.error("Could not read any resources at all");
  }
}
private String dtd = System.getProperty("templateRoot") + "pairmap.dtd";

private void readMapping(org.xml.sax.InputSource source) {
  source.setSystemId(dtd);
  neo.xredsys.config.StringPairMappingXmlReader.readMapping(mapping,source);
}


 
  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(1);
    _jspx_dependants.add("/WEB-INF/pages/base/common-jsp-header.jspf");
  }

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
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write('\n');
      out.write('\n');
      out.write(' ');
      out.write('\n');
      out.write('\n');
      out.write('\n');
      out.write('\n');
      out.write('\n');
      out.write('\n');
      out.write('\n');
      out.write('\n');
      out.write('\n');
      out.write('\n');
      out.write('\n');


String task = (String)request.getAttribute("task");

java.util.Iterator keys = mapping.getSecondaryKeyIterator(task);
if (!keys.hasNext()) {
  org.apache.log4j.Category.getInstance("neo.phoenix.framework").error("Invalid task specified '" + task + "': Reverting to '/generic' mapping.");
  task = "/generic";
}

for (keys = mapping.getSecondaryKeyIterator(task); keys.hasNext(); ) {
  String key = (String)keys.next();
  String value = mapping.getValue(task,key);
  if (value.startsWith("//") && value.endsWith(".jsp")) {
    value = value.substring(1);
    request.setAttribute("areamap-" + key, value);
  }else if (value.startsWith("/") && value.endsWith(".jsp")) {
    value = "/WEB-INF/pages" + value;
    request.setAttribute("areamap-" + key, value);
  }else if(key.equals("enctype")){
    request.setAttribute(key,value);
  }else {
    request.setAttribute("textmap-" + key, value);
  }
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
