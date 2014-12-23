package org.apache.jsp.pages.publication;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class new_002dreceipt_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005ftemplate_005fcall_0026_005ffile;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005ftemplate_005fparameter_0026_005fvalue_005fkey_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005ftemplate_005fcall_0026_005ffile = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005ftemplate_005fparameter_0026_005fvalue_005fkey_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005ftemplate_005fcall_0026_005ffile.release();
    _005fjspx_005ftagPool_005ftemplate_005fparameter_0026_005fvalue_005fkey_005fnobody.release();
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

      out.write("<!-- new-receipt.jsp -->\n");
      out.write("\n");
      out.write("\n");
      out.write("<!-- Calling frame -->\n");
      if (_jspx_meth_template_005fcall_005f0(_jspx_page_context))
        return;
      out.write("\n");
      out.write("<!-- Finished call to frame -->\n");
      out.write("<!-- End of new-receipt.jsp  -->\n");
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

  private boolean _jspx_meth_template_005fcall_005f0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  template:call
    neo.taglib.template.CallTemplateTag _jspx_th_template_005fcall_005f0 = (neo.taglib.template.CallTemplateTag) _005fjspx_005ftagPool_005ftemplate_005fcall_0026_005ffile.get(neo.taglib.template.CallTemplateTag.class);
    _jspx_th_template_005fcall_005f0.setPageContext(_jspx_page_context);
    _jspx_th_template_005fcall_005f0.setParent(null);
    // /pages/publication/new-receipt.jsp(5,0) name = file type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_template_005fcall_005f0.setFile("/pages/base/frame.jsp");
    int _jspx_eval_template_005fcall_005f0 = _jspx_th_template_005fcall_005f0.doStartTag();
    if (_jspx_eval_template_005fcall_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write('\n');
        out.write(' ');
        out.write(' ');
        if (_jspx_meth_template_005fparameter_005f0(_jspx_th_template_005fcall_005f0, _jspx_page_context))
          return true;
        out.write('\n');
        out.write(' ');
        out.write(' ');
        if (_jspx_meth_template_005fparameter_005f1(_jspx_th_template_005fcall_005f0, _jspx_page_context))
          return true;
        out.write('\n');
        int evalDoAfterBody = _jspx_th_template_005fcall_005f0.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_template_005fcall_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005ftemplate_005fcall_0026_005ffile.reuse(_jspx_th_template_005fcall_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005ftemplate_005fcall_0026_005ffile.reuse(_jspx_th_template_005fcall_005f0);
    return false;
  }

  private boolean _jspx_meth_template_005fparameter_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_template_005fcall_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  template:parameter
    neo.taglib.util.ParameterTag _jspx_th_template_005fparameter_005f0 = (neo.taglib.util.ParameterTag) _005fjspx_005ftagPool_005ftemplate_005fparameter_0026_005fvalue_005fkey_005fnobody.get(neo.taglib.util.ParameterTag.class);
    _jspx_th_template_005fparameter_005f0.setPageContext(_jspx_page_context);
    _jspx_th_template_005fparameter_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_template_005fcall_005f0);
    // /pages/publication/new-receipt.jsp(6,2) name = key type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_template_005fparameter_005f0.setKey("title");
    // /pages/publication/new-receipt.jsp(6,2) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_template_005fparameter_005f0.setValue("h.Menu");
    int _jspx_eval_template_005fparameter_005f0 = _jspx_th_template_005fparameter_005f0.doStartTag();
    if (_jspx_th_template_005fparameter_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005ftemplate_005fparameter_0026_005fvalue_005fkey_005fnobody.reuse(_jspx_th_template_005fparameter_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005ftemplate_005fparameter_0026_005fvalue_005fkey_005fnobody.reuse(_jspx_th_template_005fparameter_005f0);
    return false;
  }

  private boolean _jspx_meth_template_005fparameter_005f1(javax.servlet.jsp.tagext.JspTag _jspx_th_template_005fcall_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  template:parameter
    neo.taglib.util.ParameterTag _jspx_th_template_005fparameter_005f1 = (neo.taglib.util.ParameterTag) _005fjspx_005ftagPool_005ftemplate_005fparameter_0026_005fvalue_005fkey_005fnobody.get(neo.taglib.util.ParameterTag.class);
    _jspx_th_template_005fparameter_005f1.setPageContext(_jspx_page_context);
    _jspx_th_template_005fparameter_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_template_005fcall_005f0);
    // /pages/publication/new-receipt.jsp(7,2) name = key type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_template_005fparameter_005f1.setKey("content");
    // /pages/publication/new-receipt.jsp(7,2) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_template_005fparameter_005f1.setValue("/pages/publication/new-receipt-content.jsp");
    int _jspx_eval_template_005fparameter_005f1 = _jspx_th_template_005fparameter_005f1.doStartTag();
    if (_jspx_th_template_005fparameter_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005ftemplate_005fparameter_0026_005fvalue_005fkey_005fnobody.reuse(_jspx_th_template_005fparameter_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005ftemplate_005fparameter_0026_005fvalue_005fkey_005fnobody.reuse(_jspx_th_template_005fparameter_005f1);
    return false;
  }
}
