package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class index_002dcontent_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005futil_005fpluginResources_0026_005ftype_005ftask_005ftarget_005fid_005farea_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005flogic_005fiterate_0026_005ftype_005fname_005fid;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005flink_0026_005fpage;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fbean_005fwrite_0026_005fproperty_005fname_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005futil_005fpluginResources_0026_005ftype_005ftask_005ftarget_005fid_005farea_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005flogic_005fiterate_0026_005ftype_005fname_005fid = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005flink_0026_005fpage = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fbean_005fwrite_0026_005fproperty_005fname_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005futil_005fpluginResources_0026_005ftype_005ftask_005ftarget_005fid_005farea_005fnobody.release();
    _005fjspx_005ftagPool_005flogic_005fiterate_0026_005ftype_005fname_005fid.release();
    _005fjspx_005ftagPool_005fhtml_005flink_0026_005fpage.release();
    _005fjspx_005ftagPool_005fbean_005fwrite_0026_005fproperty_005fname_005fnobody.release();
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
      out.write("<dl>\n");
      out.write("  <dt><a href=\"status.jsp\">Status &raquo;</a></dt>\n");
      out.write("  <dd>Check the status of this server and its configuration.\n");
      out.write("      Use this page to verify that the server is set up correctly.\n");
      out.write("      The Status page will perform simple checks toward the Database\n");
      out.write("      to verify that the configured values actually work.</dd>\n");
      out.write("      \n");
      out.write("  <dt><a href=\"nurserystatus.jsp\">Configuration Layer Report &raquo;</a></dt>\n");
      out.write("  <dd>Check the critical properties in the configuration layers\n");
      out.write("     of this server.  Use this to see if you have problems initially setting\n");
      out.write("     up the server.  Normally, these properties don't\n");
      out.write("     change after an initial installation.</dd>\n");
      out.write("\n");
      out.write("  <dt><a href=\"pages/plugin/list.jsp\">View installed plugins &raquo;</a></dt>\n");
      out.write("  <dd>Any plugins that have been installed successfully will be shown on this page.</dd>\n");
      out.write("\n");
      out.write("  <dt><a href=\"pages/publication/sessions.jsp\">View sessions &raquo;</a></dt>\n");
      out.write("  <dd>View a list of user sessions created since the last startup of the server.</dd>\n");
      out.write("\n");
      out.write("  <dt><a href=\"pages/performance.jsp\">Performance Summary &raquo;</a></dt>\n");
      out.write("  <dd>Display a performance summary of this server.  This will show a\n");
      out.write("      summary of all of Escenic's caches, along with the current request\n");
      out.write("      times, statistics for database access, and memory information.</dd>\n");
      out.write("      \n");
      out.write("  <dt><a href=\"pages/systemproperties.jsp\">System properties &raquo;</a></dt>\n");
      out.write("  <dd>View all the system properties in the system.</dd>\n");
      out.write("\n");
      out.write("  <dt valign=\"top\"><a href=\"do/services/display\">View services &raquo;</a></dt>\n");
      out.write("  <dd valign=\"top\">View services.</dd>\n");
      out.write("\n");
      out.write("  <dt><a href=\"pages/support-request.jsp\">Issue a support request &raquo;</a></dt>\n");
      out.write("  <dd>To contact Escenic Support, e-mail <a href=\"mailto:support@escenic.com\">support@escenic.com</a>.  We have\n");
      out.write("      provided a page listing the most important features from this server,\n");
      out.write("      all in one page, ready to cut-and-paste into your support ticket.</dd>\n");
      out.write("      \n");
      out.write("  <dt><a href=\"pages/threaddump.jsp\">Create a thread dump &raquo;</a></dt>\n");
      out.write("  <dd>Creates a thread dump from the server.</dd>\n");
      out.write("\n");
      out.write("\n");
      //  util:pluginResources
      java.util.Collection resources = null;
      neo.taglib.util.PluginResourcesTag _jspx_th_util_005fpluginResources_005f0 = (neo.taglib.util.PluginResourcesTag) _005fjspx_005ftagPool_005futil_005fpluginResources_0026_005ftype_005ftask_005ftarget_005fid_005farea_005fnobody.get(neo.taglib.util.PluginResourcesTag.class);
      _jspx_th_util_005fpluginResources_005f0.setPageContext(_jspx_page_context);
      _jspx_th_util_005fpluginResources_005f0.setParent(null);
      // /index-content.jsp(44,0) name = type type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_util_005fpluginResources_005f0.setType("internal-link");
      // /index-content.jsp(44,0) name = target type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_util_005fpluginResources_005f0.setTarget("admin");
      // /index-content.jsp(44,0) name = task type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_util_005fpluginResources_005f0.setTask("/index");
      // /index-content.jsp(44,0) name = area type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_util_005fpluginResources_005f0.setArea("menu");
      // /index-content.jsp(44,0) name = id type = java.lang.String reqTime = false required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_util_005fpluginResources_005f0.setId("resources");
      int _jspx_eval_util_005fpluginResources_005f0 = _jspx_th_util_005fpluginResources_005f0.doStartTag();
      resources = (java.util.Collection) _jspx_page_context.findAttribute("resources");
      if (_jspx_th_util_005fpluginResources_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005futil_005fpluginResources_0026_005ftype_005ftask_005ftarget_005fid_005farea_005fnobody.reuse(_jspx_th_util_005fpluginResources_005f0);
        return;
      }
      resources = (java.util.Collection) _jspx_page_context.findAttribute("resources");
      _005fjspx_005ftagPool_005futil_005fpluginResources_0026_005ftype_005ftask_005ftarget_005fid_005farea_005fnobody.reuse(_jspx_th_util_005fpluginResources_005f0);
      out.write('\n');
      //  util:pluginResources
      java.util.Collection externalResources = null;
      neo.taglib.util.PluginResourcesTag _jspx_th_util_005fpluginResources_005f1 = (neo.taglib.util.PluginResourcesTag) _005fjspx_005ftagPool_005futil_005fpluginResources_0026_005ftype_005ftask_005ftarget_005fid_005farea_005fnobody.get(neo.taglib.util.PluginResourcesTag.class);
      _jspx_th_util_005fpluginResources_005f1.setPageContext(_jspx_page_context);
      _jspx_th_util_005fpluginResources_005f1.setParent(null);
      // /index-content.jsp(50,0) name = type type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_util_005fpluginResources_005f1.setType("external-link");
      // /index-content.jsp(50,0) name = target type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_util_005fpluginResources_005f1.setTarget("admin");
      // /index-content.jsp(50,0) name = task type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_util_005fpluginResources_005f1.setTask("/index");
      // /index-content.jsp(50,0) name = area type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_util_005fpluginResources_005f1.setArea("menu");
      // /index-content.jsp(50,0) name = id type = java.lang.String reqTime = false required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_util_005fpluginResources_005f1.setId("externalResources");
      int _jspx_eval_util_005fpluginResources_005f1 = _jspx_th_util_005fpluginResources_005f1.doStartTag();
      externalResources = (java.util.Collection) _jspx_page_context.findAttribute("externalResources");
      if (_jspx_th_util_005fpluginResources_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005futil_005fpluginResources_0026_005ftype_005ftask_005ftarget_005fid_005farea_005fnobody.reuse(_jspx_th_util_005fpluginResources_005f1);
        return;
      }
      externalResources = (java.util.Collection) _jspx_page_context.findAttribute("externalResources");
      _005fjspx_005ftagPool_005futil_005fpluginResources_0026_005ftype_005ftask_005ftarget_005fid_005farea_005fnobody.reuse(_jspx_th_util_005fpluginResources_005f1);
      out.write('\n');
      //  logic:iterate
      org.apache.struts.taglib.logic.IterateTag _jspx_th_logic_005fiterate_005f0 = (org.apache.struts.taglib.logic.IterateTag) _005fjspx_005ftagPool_005flogic_005fiterate_0026_005ftype_005fname_005fid.get(org.apache.struts.taglib.logic.IterateTag.class);
      _jspx_th_logic_005fiterate_005f0.setPageContext(_jspx_page_context);
      _jspx_th_logic_005fiterate_005f0.setParent(null);
      // /index-content.jsp(56,0) name = name type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_logic_005fiterate_005f0.setName("resources");
      // /index-content.jsp(56,0) name = id type = java.lang.String reqTime = false required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_logic_005fiterate_005f0.setId("resource");
      // /index-content.jsp(56,0) name = type type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_logic_005fiterate_005f0.setType("neo.xredsys.plugin.Resource");
      int _jspx_eval_logic_005fiterate_005f0 = _jspx_th_logic_005fiterate_005f0.doStartTag();
      if (_jspx_eval_logic_005fiterate_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        neo.xredsys.plugin.Resource resource = null;
        if (_jspx_eval_logic_005fiterate_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.pushBody();
          _jspx_th_logic_005fiterate_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
          _jspx_th_logic_005fiterate_005f0.doInitBody();
        }
        resource = (neo.xredsys.plugin.Resource) _jspx_page_context.findAttribute("resource");
        do {
          out.write("\n");
          out.write("  <dt>");
          //  html:link
          org.apache.struts.taglib.html.LinkTag _jspx_th_html_005flink_005f0 = (org.apache.struts.taglib.html.LinkTag) _005fjspx_005ftagPool_005fhtml_005flink_0026_005fpage.get(org.apache.struts.taglib.html.LinkTag.class);
          _jspx_th_html_005flink_005f0.setPageContext(_jspx_page_context);
          _jspx_th_html_005flink_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_logic_005fiterate_005f0);
          // /index-content.jsp(57,6) name = page type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
          _jspx_th_html_005flink_005f0.setPage(resource.getUri());
          int _jspx_eval_html_005flink_005f0 = _jspx_th_html_005flink_005f0.doStartTag();
          if (_jspx_eval_html_005flink_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            if (_jspx_eval_html_005flink_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
              out = _jspx_page_context.pushBody();
              _jspx_th_html_005flink_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
              _jspx_th_html_005flink_005f0.doInitBody();
            }
            do {
              if (_jspx_meth_bean_005fwrite_005f0(_jspx_th_html_005flink_005f0, _jspx_page_context))
                return;
              out.write(" &raquo;");
              int evalDoAfterBody = _jspx_th_html_005flink_005f0.doAfterBody();
              if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                break;
            } while (true);
            if (_jspx_eval_html_005flink_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
              out = _jspx_page_context.popBody();
            }
          }
          if (_jspx_th_html_005flink_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fhtml_005flink_0026_005fpage.reuse(_jspx_th_html_005flink_005f0);
            return;
          }
          _005fjspx_005ftagPool_005fhtml_005flink_0026_005fpage.reuse(_jspx_th_html_005flink_005f0);
          out.write("</dt>\n");
          out.write("  <dd>");
          out.print(resource.getPlugin().getParameter("neo.phoenix.plugin.description"));
          out.write("</dd>\n");
          int evalDoAfterBody = _jspx_th_logic_005fiterate_005f0.doAfterBody();
          resource = (neo.xredsys.plugin.Resource) _jspx_page_context.findAttribute("resource");
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
        if (_jspx_eval_logic_005fiterate_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.popBody();
        }
      }
      if (_jspx_th_logic_005fiterate_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005flogic_005fiterate_0026_005ftype_005fname_005fid.reuse(_jspx_th_logic_005fiterate_005f0);
        return;
      }
      _005fjspx_005ftagPool_005flogic_005fiterate_0026_005ftype_005fname_005fid.reuse(_jspx_th_logic_005fiterate_005f0);
      out.write('\n');
      //  logic:iterate
      org.apache.struts.taglib.logic.IterateTag _jspx_th_logic_005fiterate_005f1 = (org.apache.struts.taglib.logic.IterateTag) _005fjspx_005ftagPool_005flogic_005fiterate_0026_005ftype_005fname_005fid.get(org.apache.struts.taglib.logic.IterateTag.class);
      _jspx_th_logic_005fiterate_005f1.setPageContext(_jspx_page_context);
      _jspx_th_logic_005fiterate_005f1.setParent(null);
      // /index-content.jsp(60,0) name = name type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_logic_005fiterate_005f1.setName("externalResources");
      // /index-content.jsp(60,0) name = id type = java.lang.String reqTime = false required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_logic_005fiterate_005f1.setId("resource");
      // /index-content.jsp(60,0) name = type type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_logic_005fiterate_005f1.setType("neo.xredsys.plugin.Resource");
      int _jspx_eval_logic_005fiterate_005f1 = _jspx_th_logic_005fiterate_005f1.doStartTag();
      if (_jspx_eval_logic_005fiterate_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        neo.xredsys.plugin.Resource resource = null;
        if (_jspx_eval_logic_005fiterate_005f1 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.pushBody();
          _jspx_th_logic_005fiterate_005f1.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
          _jspx_th_logic_005fiterate_005f1.doInitBody();
        }
        resource = (neo.xredsys.plugin.Resource) _jspx_page_context.findAttribute("resource");
        do {
          out.write("\n");
          out.write("  <dt><a href=\"");
          out.print(resource.getUri());
          out.write('"');
          out.write('>');
          if (_jspx_meth_bean_005fwrite_005f1(_jspx_th_logic_005fiterate_005f1, _jspx_page_context))
            return;
          out.write(" &raquo;</a></dt>\n");
          out.write("  <dd>");
          out.print(resource.getPlugin().getParameter("neo.phoenix.plugin.description"));
          out.write("</dd>\n");
          int evalDoAfterBody = _jspx_th_logic_005fiterate_005f1.doAfterBody();
          resource = (neo.xredsys.plugin.Resource) _jspx_page_context.findAttribute("resource");
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
        if (_jspx_eval_logic_005fiterate_005f1 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.popBody();
        }
      }
      if (_jspx_th_logic_005fiterate_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005flogic_005fiterate_0026_005ftype_005fname_005fid.reuse(_jspx_th_logic_005fiterate_005f1);
        return;
      }
      _005fjspx_005ftagPool_005flogic_005fiterate_0026_005ftype_005fname_005fid.reuse(_jspx_th_logic_005fiterate_005f1);
      out.write("\n");
      out.write("</dl>\n");
      out.write("<h3>Helpers:</h3>\n");
      out.write("<dl>\n");
      out.write("  <dt><a href=\"top?refresh=1\">Top &raquo;</a></dt>\n");
      out.write("  <dd>Show the most active JSP files that are currently active.  This will\n");
      out.write("      provide a dynamic real-time view of a running system.  It shows the\n");
      out.write("      amount of time spent in different resources in the last two second\n");
      out.write("      interval.</dd>\n");
      out.write("\n");
      out.write("  <dt><a href=\"logger.jsp\">View the browser log &raquo;</a></dt>\n");
      out.write("  <dd>The browser log displays errors generated by the templates. You\n");
      out.write("      can add your own log messages in templates. The ECE tag libraries also\n");
      out.write("      output their messages into this log. Please use the\n");
      out.write("      '<a href=\"debug\" target=\"debug\">View the logging levels</a>'\n");
      out.write("      to adjust the log levels.\n");
      out.write("  </dd>\n");
      out.write("\n");
      out.write("  <dt><a href=\"debug\">Configure logging levels &raquo;</a></dt>\n");
      out.write("  <dd>The debug logs can help you diagnose your system.  By adjusting the\n");
      out.write("     logging levels of individual components you can generate the\n");
      out.write("     necessary logs to find the failing component</dd>\n");
      out.write("\n");
      out.write("  \n");
      out.write("  <dt><a href=\"statistics/\">View JSP Statistics &raquo;</a></dt>\n");
      out.write("  <dd>The JSP statistics can show the hot-spots of your JSP templates.\n");
      out.write("      The statistics include time and database resources spent in each\n");
      out.write("      of your JSP templates.  It is also possible to get a raw CSV\n");
      out.write("      of the data for further processing.\n");
      out.write("  </dd>\n");
      out.write("\n");
      out.write("  <dt><a href=\"do/publication/cache-invalidation\">Remove objects from cache &raquo;</a></dt>\n");
      out.write("  <dd>Allows you to remove objects from the Escenic caches\n");
      out.write("     by specifying numeric IDs or SQL statements to retrieve the IDs.</dd>\n");
      out.write("     \n");
      out.write("  <dt><a href=\"do/publication/clearallcaches\">Clear all caches &raquo;</a></dt>\n");
      out.write("  <dd>This option will allow you to clear all the caches in this Escenic\n");
      out.write("     Content Engine. It is useful for debugging cache-related issues.</dd>\n");
      out.write("  \n");
      out.write("      \n");
      out.write("  <dt><a href=\"browser/Global/Initial\">Component Browser &raquo;</a></dt>\n");
      out.write("  <dd>Browse the Escenic Components and modify their configured values on the fly.</dd>\n");
      out.write("\n");
      out.write("  <dt><a href=\"pages/database/query.jsp\">Database Browser &raquo;</a></dt>\n");
      out.write("  <dd>Execute SQL Queries toward the database.</dd>\n");
      out.write("  \n");
      out.write("</dl>\n");
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

  private boolean _jspx_meth_bean_005fwrite_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005flink_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:write
    org.apache.struts.taglib.bean.WriteTag _jspx_th_bean_005fwrite_005f0 = (org.apache.struts.taglib.bean.WriteTag) _005fjspx_005ftagPool_005fbean_005fwrite_0026_005fproperty_005fname_005fnobody.get(org.apache.struts.taglib.bean.WriteTag.class);
    _jspx_th_bean_005fwrite_005f0.setPageContext(_jspx_page_context);
    _jspx_th_bean_005fwrite_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005flink_005f0);
    // /index-content.jsp(57,47) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f0.setName("resource");
    // /index-content.jsp(57,47) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f0.setProperty("label");
    int _jspx_eval_bean_005fwrite_005f0 = _jspx_th_bean_005fwrite_005f0.doStartTag();
    if (_jspx_th_bean_005fwrite_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fbean_005fwrite_0026_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fbean_005fwrite_0026_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f0);
    return false;
  }

  private boolean _jspx_meth_bean_005fwrite_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_logic_005fiterate_005f1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:write
    org.apache.struts.taglib.bean.WriteTag _jspx_th_bean_005fwrite_005f1 = (org.apache.struts.taglib.bean.WriteTag) _005fjspx_005ftagPool_005fbean_005fwrite_0026_005fproperty_005fname_005fnobody.get(org.apache.struts.taglib.bean.WriteTag.class);
    _jspx_th_bean_005fwrite_005f1.setPageContext(_jspx_page_context);
    _jspx_th_bean_005fwrite_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_logic_005fiterate_005f1);
    // /index-content.jsp(61,39) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f1.setName("resource");
    // /index-content.jsp(61,39) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fwrite_005f1.setProperty("label");
    int _jspx_eval_bean_005fwrite_005f1 = _jspx_th_bean_005fwrite_005f1.doStartTag();
    if (_jspx_th_bean_005fwrite_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fbean_005fwrite_0026_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005fbean_005fwrite_0026_005fproperty_005fname_005fnobody.reuse(_jspx_th_bean_005fwrite_005f1);
    return false;
  }
}
