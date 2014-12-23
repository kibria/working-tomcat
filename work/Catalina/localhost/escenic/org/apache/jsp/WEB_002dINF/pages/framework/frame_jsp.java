package org.apache.jsp.WEB_002dINF.pages.framework;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.apache.struts.config.ActionConfig;

public final class frame_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(1);
    _jspx_dependants.add("/WEB-INF/pages/base/common-jsp-header.jspf");
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fbean_005fmessage_0026_005fkey_005fbundle_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005ftemplate_005fserviceParameter_0026_005fname_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fbean_005fmessage_0026_005fkey_005fbundle_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005ftemplate_005fserviceParameter_0026_005fname_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fbean_005fmessage_0026_005fkey_005fbundle_005fnobody.release();
    _005fjspx_005ftagPool_005ftemplate_005fserviceParameter_0026_005fname_005fnobody.release();
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
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<script language=\"JavaScript1.2\"><!-- \n");
      out.write("  function unlock(id,type){\n");
      out.write("\n");
      out.write("    if(confirm(\"");
      if (_jspx_meth_bean_005fmessage_005f0(_jspx_page_context))
        return;
      out.write("\")){\n");
      out.write("      forwardUrl = \"action:/base/breakLock.do?id=\"+id+\"&type=\"+type; \n");
      out.write("      submitForm(forwardUrl);\n");
      out.write("    }\n");
      out.write("  }\n");
      out.write("  // -->\n");
      out.write("</script>\n");
      out.write("\n");
      out.write('\n');
      out.write('\n');
 pageContext.getServletContext().setAttribute("neo.util.servlet.RequestInfo.StatisticsSource", neo.nursery.GlobalBus.lookupSafe("/neo/io/reports/ReportsStatisticsSource")); 
      out.write('\n');
      out.write('\n');

  String localekey = neo.phoenix.base.Constants.LOCALE_KEY;
  String language = (String)session.getAttribute("language");
  if (language == null) language = (String)request.getAttribute("language");
  if (language != null) {
    try {
      java.util.Locale locale = null;
      String[] codes = neo.util.StringUtil.split("_", language);
      if (codes.length == 1) {
        locale = new java.util.Locale(codes[0], "");
      } else if (codes.length == 2) {
        locale = new java.util.Locale(codes[0], codes[1]);
      } else if (codes.length == 3) {
        locale = new java.util.Locale(codes[0], codes[1], codes[2]);
      } else {
        locale = new java.util.Locale("en");
      }
      session.setAttribute(localekey, locale);
    } catch (Exception e) {
    }
  }

      out.write('\n');
      out.write('\n');
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "frame-mapping.jsp", out, false);
      out.write('\n');
      out.write('\n');
      out.write('\n');

  String formName = (String)request.getAttribute("textmap-form"); 
  org.apache.struts.config.ModuleConfig cfg;
  cfg = (org.apache.struts.config.ModuleConfig) request.getAttribute("org.apache.struts.action.MODULE");
  if (formName != null && cfg != null && cfg.findActionConfig(formName) != null) {
    Object form = request.getAttribute(cfg.findActionConfig(formName).getName());
    if (form != null) {
      request.setAttribute("form", form);
      request.setAttribute("contextForm",form);
      /* get the child form if possible */
      if (form instanceof neo.phoenix.base.ChildForm) {
        neo.phoenix.base.ChildForm childForm = (neo.phoenix.base.ChildForm) form;
        neo.phoenix.base.WorkItemManager manager = (neo.phoenix.base.WorkItemManager)request.getSession().getAttribute("WorkItemManager");
        if (manager != null) {
          neo.phoenix.base.WorkItem item = manager.getWorkItem(childForm.getParentWorkItemId());
          if (item != null && item.getForm() != null) {
            request.setAttribute("parentForm",item.getForm());
            request.setAttribute("contextForm",item.getForm());
          }
        }
      }
    }
  }



      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!--\n");
      out.write("  Several tasks are available.\n");
      out.write("  For the task \"/foo/bar/baz\" the following classes are available\n");
      out.write("  task-foo\n");
      out.write("  task-foo-bar\n");
      out.write("  task-foo-bar-baz\n");
      out.write(" -->\n");

String tmp = "task" + request.getAttribute("task");
StringBuffer multitask = new StringBuffer();
int pos = tmp.indexOf("/"); // ignore the first 'task/'
while (true) {
  pos = tmp.indexOf("/",pos+1);
  if (pos == -1) break;
  multitask.append(' ');
  multitask.append(tmp.substring(0,pos));
}
multitask.append(' ');
multitask.append(tmp);
tmp =  neo.util.StringUtil.replaceString(multitask.toString(),"/","-");
request.setAttribute("bodyclass",tmp.toString());

      out.write('\n');
      out.write('\n');
      if (_jspx_meth_template_005fserviceParameter_005f0(_jspx_page_context))
        return;
      out.write('\n');
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

  private boolean _jspx_meth_bean_005fmessage_005f0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_005fmessage_005f0 = (org.apache.struts.taglib.bean.MessageTag) _005fjspx_005ftagPool_005fbean_005fmessage_0026_005fkey_005fbundle_005fnobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_005fmessage_005f0.setPageContext(_jspx_page_context);
    _jspx_th_bean_005fmessage_005f0.setParent(null);
    // /WEB-INF/pages/framework/frame.jsp(13,16) name = key type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fmessage_005f0.setKey("t.Unlock_message");
    // /WEB-INF/pages/framework/frame.jsp(13,16) name = bundle type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_bean_005fmessage_005f0.setBundle("org.apache.struts.action.MESSAGE");
    int _jspx_eval_bean_005fmessage_005f0 = _jspx_th_bean_005fmessage_005f0.doStartTag();
    if (_jspx_th_bean_005fmessage_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fbean_005fmessage_0026_005fkey_005fbundle_005fnobody.reuse(_jspx_th_bean_005fmessage_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fbean_005fmessage_0026_005fkey_005fbundle_005fnobody.reuse(_jspx_th_bean_005fmessage_005f0);
    return false;
  }

  private boolean _jspx_meth_template_005fserviceParameter_005f0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  template:serviceParameter
    neo.taglib.template.ServiceParameterTag _jspx_th_template_005fserviceParameter_005f0 = (neo.taglib.template.ServiceParameterTag) _005fjspx_005ftagPool_005ftemplate_005fserviceParameter_0026_005fname_005fnobody.get(neo.taglib.template.ServiceParameterTag.class);
    _jspx_th_template_005fserviceParameter_005f0.setPageContext(_jspx_page_context);
    _jspx_th_template_005fserviceParameter_005f0.setParent(null);
    // /WEB-INF/pages/framework/frame.jsp(108,0) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_template_005fserviceParameter_005f0.setName("areamap-frame-layout");
    int _jspx_eval_template_005fserviceParameter_005f0 = _jspx_th_template_005fserviceParameter_005f0.doStartTag();
    if (_jspx_th_template_005fserviceParameter_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005ftemplate_005fserviceParameter_0026_005fname_005fnobody.reuse(_jspx_th_template_005fserviceParameter_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005ftemplate_005fserviceParameter_0026_005fname_005fnobody.reuse(_jspx_th_template_005fserviceParameter_005f0);
    return false;
  }
}
