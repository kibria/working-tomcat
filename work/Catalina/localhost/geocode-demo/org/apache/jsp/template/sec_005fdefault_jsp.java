package org.apache.jsp.template;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import com.escenic.geocode.presentation.PresentationConstants;

public final class sec_005fdefault_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005ftemplate_005fcall_0026_005ffile_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005flogic_005fpresent_0026_005fname;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005ftemplate_005fcall_0026_005ffile_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005flogic_005fpresent_0026_005fname = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005ftemplate_005fcall_0026_005ffile_005fnobody.release();
    _005fjspx_005ftagPool_005flogic_005fpresent_0026_005fname.release();
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
      out.write("\n");
      out.write("\n");
      out.write("<!-- Start: sec_default.jsp -->\n");
      out.write("\n");
      out.write("<div align=\"center\">\n");
      out.write("  <div style=\"float:left;\">\n");
      out.write("    ");
      if (_jspx_meth_template_005fcall_005f0(_jspx_page_context))
        return;
      out.write("\n");
      out.write("  </div>\n");
      out.write("  <div style=\"float:left;margin-left:2%;\">\n");
      out.write("    ");
      if (_jspx_meth_template_005fcall_005f1(_jspx_page_context))
        return;
      out.write("\n");
      out.write("  </div>\n");
      out.write("  <br clear=\"left\"/>\n");
      out.write("</div>  \n");
      out.write("<br/>\n");
      out.write("<br/>\n");
      out.write("<div style=\"float:left;\">\n");
      out.write("  ");
      //  logic:present
      org.apache.struts.taglib.logic.PresentTag _jspx_th_logic_005fpresent_005f0 = (org.apache.struts.taglib.logic.PresentTag) _005fjspx_005ftagPool_005flogic_005fpresent_0026_005fname.get(org.apache.struts.taglib.logic.PresentTag.class);
      _jspx_th_logic_005fpresent_005f0.setPageContext(_jspx_page_context);
      _jspx_th_logic_005fpresent_005f0.setParent(null);
      // /template/sec_default.jsp(37,2) name = name type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_logic_005fpresent_005f0.setName(PresentationConstants.RQ_ATTR_GEO_ARTICLE_SEARCH_RESULT);
      int _jspx_eval_logic_005fpresent_005f0 = _jspx_th_logic_005fpresent_005f0.doStartTag();
      if (_jspx_eval_logic_005fpresent_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\n");
          out.write("    ");
          if (_jspx_meth_template_005fcall_005f2(_jspx_th_logic_005fpresent_005f0, _jspx_page_context))
            return;
          out.write('\n');
          out.write(' ');
          out.write(' ');
          int evalDoAfterBody = _jspx_th_logic_005fpresent_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_logic_005fpresent_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005flogic_005fpresent_0026_005fname.reuse(_jspx_th_logic_005fpresent_005f0);
        return;
      }
      _005fjspx_005ftagPool_005flogic_005fpresent_0026_005fname.reuse(_jspx_th_logic_005fpresent_005f0);
      out.write("\n");
      out.write("</div>\n");
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
    neo.taglib.template.CallTemplateTag _jspx_th_template_005fcall_005f0 = (neo.taglib.template.CallTemplateTag) _005fjspx_005ftagPool_005ftemplate_005fcall_0026_005ffile_005fnobody.get(neo.taglib.template.CallTemplateTag.class);
    _jspx_th_template_005fcall_005f0.setPageContext(_jspx_page_context);
    _jspx_th_template_005fcall_005f0.setParent(null);
    // /template/sec_default.jsp(27,4) name = file type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_template_005fcall_005f0.setFile("./geoArticleSearch.jsp");
    int _jspx_eval_template_005fcall_005f0 = _jspx_th_template_005fcall_005f0.doStartTag();
    if (_jspx_th_template_005fcall_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005ftemplate_005fcall_0026_005ffile_005fnobody.reuse(_jspx_th_template_005fcall_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005ftemplate_005fcall_0026_005ffile_005fnobody.reuse(_jspx_th_template_005fcall_005f0);
    return false;
  }

  private boolean _jspx_meth_template_005fcall_005f1(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  template:call
    neo.taglib.template.CallTemplateTag _jspx_th_template_005fcall_005f1 = (neo.taglib.template.CallTemplateTag) _005fjspx_005ftagPool_005ftemplate_005fcall_0026_005ffile_005fnobody.get(neo.taglib.template.CallTemplateTag.class);
    _jspx_th_template_005fcall_005f1.setPageContext(_jspx_page_context);
    _jspx_th_template_005fcall_005f1.setParent(null);
    // /template/sec_default.jsp(30,4) name = file type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_template_005fcall_005f1.setFile("./geoArticleMap.jsp");
    int _jspx_eval_template_005fcall_005f1 = _jspx_th_template_005fcall_005f1.doStartTag();
    if (_jspx_th_template_005fcall_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005ftemplate_005fcall_0026_005ffile_005fnobody.reuse(_jspx_th_template_005fcall_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005ftemplate_005fcall_0026_005ffile_005fnobody.reuse(_jspx_th_template_005fcall_005f1);
    return false;
  }

  private boolean _jspx_meth_template_005fcall_005f2(javax.servlet.jsp.tagext.JspTag _jspx_th_logic_005fpresent_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  template:call
    neo.taglib.template.CallTemplateTag _jspx_th_template_005fcall_005f2 = (neo.taglib.template.CallTemplateTag) _005fjspx_005ftagPool_005ftemplate_005fcall_0026_005ffile_005fnobody.get(neo.taglib.template.CallTemplateTag.class);
    _jspx_th_template_005fcall_005f2.setPageContext(_jspx_page_context);
    _jspx_th_template_005fcall_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_logic_005fpresent_005f0);
    // /template/sec_default.jsp(38,4) name = file type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_template_005fcall_005f2.setFile("./geoArticleSearchResult.jsp");
    int _jspx_eval_template_005fcall_005f2 = _jspx_th_template_005fcall_005f2.doStartTag();
    if (_jspx_th_template_005fcall_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005ftemplate_005fcall_0026_005ffile_005fnobody.reuse(_jspx_th_template_005fcall_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005ftemplate_005fcall_0026_005ffile_005fnobody.reuse(_jspx_th_template_005fcall_005f2);
    return false;
  }
}
