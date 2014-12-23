package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import neo.nursery.Bus;
import neo.nursery.GlobalBus;
import java.util.Collection;
import java.util.UUID;
import java.beans.*;
import com.escenic.phoenix.admin.servlet.ECEBrowserHelper;
import java.beans.Introspector;
import com.escenic.phoenix.admin.servlet.ECEBrowserHelper;
import neo.nursery.Bus;
import neo.nursery.GlobalBus;
import java.net.URLEncoder;
import java.util.List;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

public final class browser_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(1);
    _jspx_dependants.add("/buslist.jsp");
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
      out.write('\n');

        String requestURI =  request.getRequestURI();
        String componentName = request.getPathInfo();
        Bus bus;

        EventSetDescriptor[] eventSetDescriptors = null;
        try {
            bus = ECEBrowserHelper.getBusForComponent(componentName);
        }
        catch (Exception e) {
            response.sendError(404, e.toString());
            return;
        }

        if (bus == null) {
            response.sendError(404);
            return;
        }

        componentName = ECEBrowserHelper.removeBusNameFromComponentName(componentName);
        Object bean = bus.lookupSafe(componentName);

        if (bean != null) {
            BeanInfo beanInfo = Introspector.getBeanInfo(bean.getClass(), Introspector.USE_ALL_BEANINFO);
            eventSetDescriptors = beanInfo.getEventSetDescriptors();
        }

    try { 
      out.write("\n");
      out.write("<h1>Component browser</h1>\n");
      out.write("<div class=\"componentBrowser\">\n");
      out.write("    <h1>Scope: ");
      out.print(bus.getDisplayName());
      out.write("</h1>\n");
      out.write("    ");
if("true".equals(request.getParameter("changeBus"))){
      out.write("\n");
      out.write("        ");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<h4>Select a scope to browse</h4>\n");

    out.println("<a href=\""+request.getContextPath()+"/browser/"+ ECEBrowserHelper.makeUrlSafeBusName(GlobalBus.getGlobalBus())+"/\">"+GlobalBus.getGlobalBus().getDisplayName()+"<a/><br>");
    List<Bus> children = new ArrayList<Bus>(GlobalBus.getGlobalBus().getChildren());
    Collections.sort(children, new Comparator<Bus>() {

      public int compare(final Bus o1, final Bus o2) {
        return o1.getDisplayName().compareTo(o2.getDisplayName());
      }
    });
    for (Bus entry : children) {
        out.println("<a href=\""+request.getContextPath()+"/browser/"+ ECEBrowserHelper.makeUrlSafeBusName(entry)+"/\">" +
                ""+entry.getDisplayName()+"<a/><br>");
    }

      out.write('\n');
      out.write("\n");
      out.write("    ");
} else {
      out.write("\n");
      out.write("        <h4><a href=\"?changeBus=true\">Browse other scope</a></h4>\n");
      out.write("    ");
}
      out.write("\n");
      out.write("    <H1>");
      out.print( ECEBrowserHelper.getBreadCrums(bus, componentName, request) );
      out.write("</H1>\n");
      out.write("    ");
 if (bean != null) { 
      out.write("\n");
      out.write("    ");
      out.print( ECEBrowserHelper.displayClassInfo(bus, componentName, request) );
      out.write("\n");
      out.write("    <HR>\n");
      out.write("    ");

      out.flush();
      String property = request.getParameter("property");
      String map = request.getParameter("map");
      String method = request.getParameter("method");
      if (property != null) {
        ECEBrowserHelper.displayProperty(bus, componentName, property, request, response, out);
      } else if (map != null) {
        ECEBrowserHelper.displayMap(bus, componentName, map, request, out);
      } else if (method != null) {
        ECEBrowserHelper.displayMethod(bus, componentName,method, request, out);
      } else {
        out.println();
        ECEBrowserHelper.displayDirectoryListing(bus, componentName, request, response, out);
        
      out.write("<hr/>");

        ECEBrowserHelper.displayProperties(bus, componentName, request, response, out);
        ECEBrowserHelper.displayEventSets(eventSetDescriptors, response, out);
        ECEBrowserHelper.displayMethods(bus, componentName, request, out);
        ECEBrowserHelper.displayServiceInfo(bus, componentName, response, out);
        ECEBrowserHelper.displayBusConfiguration(bus, out);
        ECEBrowserHelper.displayStringValue(bean, out);

      }
    
      out.write("\n");
      out.write("    ");
 } else { 
      out.write("\n");
      out.write("    Directory\n");
      out.write("    <HR>\n");
      out.write("    ");

      out.flush();
      ECEBrowserHelper.displayDirectoryListing(bus, componentName, request, response,out);
    
      out.write("\n");
      out.write("    ");
 } 
      out.write("\n");
      out.write("    <HR>\n");
      out.write("    (C) 2002 Escenic AS\n");
 } catch (Exception e) {
  out.println("<span class='error'>Exception occurred: " + e + "</span><pre>");
  e.printStackTrace(new java.io.PrintWriter(out));
  out.println("</pre>");
 } 
      out.write("\n");
      out.write("</div>");
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
