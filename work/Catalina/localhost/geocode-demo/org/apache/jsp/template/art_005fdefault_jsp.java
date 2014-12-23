package org.apache.jsp.template;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import com.escenic.geocode.utils.KMLUtils;
import java.util.List;
import java.io.PrintWriter;
import com.escenic.geocode.plugin.GeocodePluginConstants;

public final class art_005fdefault_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fbean_005fdefine_0026_005fvalue_005fid_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005flogic_005fempty_0026_005fname;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005flogic_005fnotEmpty_0026_005fname;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005ftemplate_005fcall_0026_005ffile;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005ftemplate_005fparameter_0026_005fname_005fkey_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fbean_005fdefine_0026_005fvalue_005fid_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005flogic_005fempty_0026_005fname = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005flogic_005fnotEmpty_0026_005fname = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005ftemplate_005fcall_0026_005ffile = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005ftemplate_005fparameter_0026_005fname_005fkey_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.release();
    _005fjspx_005ftagPool_005fbean_005fdefine_0026_005fvalue_005fid_005fnobody.release();
    _005fjspx_005ftagPool_005flogic_005fempty_0026_005fname.release();
    _005fjspx_005ftagPool_005flogic_005fnotEmpty_0026_005fname.release();
    _005fjspx_005ftagPool_005ftemplate_005fcall_0026_005ffile.release();
    _005fjspx_005ftagPool_005ftemplate_005fparameter_0026_005fname_005fkey_005fnobody.release();
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
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!-- Start: art_default.jsp -->\n");
      out.write("<h1>");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${article.fields.title.value}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</h1><br/>\n");
      out.write("<h2>");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${article.fields.body.value}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</h2><br/>\n");
      //  c:set
      org.apache.taglibs.standard.tag.rt.core.SetTag _jspx_th_c_005fset_005f0 = (org.apache.taglibs.standard.tag.rt.core.SetTag) _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.SetTag.class);
      _jspx_th_c_005fset_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005fset_005f0.setParent(null);
      // /template/art_default.jsp(29,0) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fset_005f0.setVar("geocodeFieldName");
      // /template/art_default.jsp(29,0) name = value type = javax.el.ValueExpression reqTime = true required = false fragment = false deferredValue = true expectedTypeName = java.lang.Object deferredMethod = false methodSignature = null
      _jspx_th_c_005fset_005f0.setValue(GeocodePluginConstants.GEOCODE_FIELD);
      int _jspx_eval_c_005fset_005f0 = _jspx_th_c_005fset_005f0.doStartTag();
      if (_jspx_th_c_005fset_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.reuse(_jspx_th_c_005fset_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.reuse(_jspx_th_c_005fset_005f0);
      out.write('\n');
      //  bean:define
      org.apache.struts.taglib.bean.DefineTag _jspx_th_bean_005fdefine_005f0 = (org.apache.struts.taglib.bean.DefineTag) _005fjspx_005ftagPool_005fbean_005fdefine_0026_005fvalue_005fid_005fnobody.get(org.apache.struts.taglib.bean.DefineTag.class);
      _jspx_th_bean_005fdefine_005f0.setPageContext(_jspx_page_context);
      _jspx_th_bean_005fdefine_005f0.setParent(null);
      // /template/art_default.jsp(30,0) name = id type = java.lang.String reqTime = false required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bean_005fdefine_005f0.setId("articleGeoField");
      // /template/art_default.jsp(30,0) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_bean_005fdefine_005f0.setValue((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${article.fields[geocodeFieldName].value}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      int _jspx_eval_bean_005fdefine_005f0 = _jspx_th_bean_005fdefine_005f0.doStartTag();
      if (_jspx_th_bean_005fdefine_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fbean_005fdefine_0026_005fvalue_005fid_005fnobody.reuse(_jspx_th_bean_005fdefine_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fbean_005fdefine_0026_005fvalue_005fid_005fnobody.reuse(_jspx_th_bean_005fdefine_005f0);
      java.lang.String articleGeoField = null;
      articleGeoField = (java.lang.String) _jspx_page_context.findAttribute("articleGeoField");
      out.write('\n');
      out.write('\n');
      if (_jspx_meth_logic_005fempty_005f0(_jspx_page_context))
        return;
      out.write('\n');
      //  logic:notEmpty
      org.apache.struts.taglib.logic.NotEmptyTag _jspx_th_logic_005fnotEmpty_005f0 = (org.apache.struts.taglib.logic.NotEmptyTag) _005fjspx_005ftagPool_005flogic_005fnotEmpty_0026_005fname.get(org.apache.struts.taglib.logic.NotEmptyTag.class);
      _jspx_th_logic_005fnotEmpty_005f0.setPageContext(_jspx_page_context);
      _jspx_th_logic_005fnotEmpty_005f0.setParent(null);
      // /template/art_default.jsp(35,0) name = name type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_logic_005fnotEmpty_005f0.setName("articleGeoField");
      int _jspx_eval_logic_005fnotEmpty_005f0 = _jspx_th_logic_005fnotEmpty_005f0.doStartTag();
      if (_jspx_eval_logic_005fnotEmpty_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write('\n');

  try {
    List geoFields = KMLUtils.getGeoFields(articleGeoField);
    request.setAttribute("geoFields", geoFields);

          out.write("\n");
          out.write("Num Of Fields : ");
          out.print(geoFields.size());
          out.write("<br/>\n");
          out.write("<div id=\"resultGoogleMap\" style=\"width:500px;height:300px\"></div>\n");
          if (_jspx_meth_template_005fcall_005f0(_jspx_th_logic_005fnotEmpty_005f0, _jspx_page_context))
            return;
          out.write('\n');

  } catch (Exception e) {
    e.printStackTrace(new PrintWriter(out));

          out.write("\n");
          out.write("<h3>Unable to retrieve geo information from article</h3>\n");

  }

          out.write('\n');
          int evalDoAfterBody = _jspx_th_logic_005fnotEmpty_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_logic_005fnotEmpty_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005flogic_005fnotEmpty_0026_005fname.reuse(_jspx_th_logic_005fnotEmpty_005f0);
        return;
      }
      _005fjspx_005ftagPool_005flogic_005fnotEmpty_0026_005fname.reuse(_jspx_th_logic_005fnotEmpty_005f0);
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

  private boolean _jspx_meth_logic_005fempty_005f0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  logic:empty
    org.apache.struts.taglib.logic.EmptyTag _jspx_th_logic_005fempty_005f0 = (org.apache.struts.taglib.logic.EmptyTag) _005fjspx_005ftagPool_005flogic_005fempty_0026_005fname.get(org.apache.struts.taglib.logic.EmptyTag.class);
    _jspx_th_logic_005fempty_005f0.setPageContext(_jspx_page_context);
    _jspx_th_logic_005fempty_005f0.setParent(null);
    // /template/art_default.jsp(32,0) name = name type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_logic_005fempty_005f0.setName("articleGeoField");
    int _jspx_eval_logic_005fempty_005f0 = _jspx_th_logic_005fempty_005f0.doStartTag();
    if (_jspx_eval_logic_005fempty_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\n");
        out.write("  <h3>Article doesn't contain any geo information.</h3>\n");
        int evalDoAfterBody = _jspx_th_logic_005fempty_005f0.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_logic_005fempty_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005flogic_005fempty_0026_005fname.reuse(_jspx_th_logic_005fempty_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005flogic_005fempty_0026_005fname.reuse(_jspx_th_logic_005fempty_005f0);
    return false;
  }

  private boolean _jspx_meth_template_005fcall_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_logic_005fnotEmpty_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  template:call
    neo.taglib.template.CallTemplateTag _jspx_th_template_005fcall_005f0 = (neo.taglib.template.CallTemplateTag) _005fjspx_005ftagPool_005ftemplate_005fcall_0026_005ffile.get(neo.taglib.template.CallTemplateTag.class);
    _jspx_th_template_005fcall_005f0.setPageContext(_jspx_page_context);
    _jspx_th_template_005fcall_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_logic_005fnotEmpty_005f0);
    // /template/art_default.jsp(43,0) name = file type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_template_005fcall_005f0.setFile("./geoFieldsOnMap.jsp");
    int _jspx_eval_template_005fcall_005f0 = _jspx_th_template_005fcall_005f0.doStartTag();
    if (_jspx_eval_template_005fcall_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write('\n');
        out.write(' ');
        out.write(' ');
        if (_jspx_meth_template_005fparameter_005f0(_jspx_th_template_005fcall_005f0, _jspx_page_context))
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
    neo.taglib.util.ParameterTag _jspx_th_template_005fparameter_005f0 = (neo.taglib.util.ParameterTag) _005fjspx_005ftagPool_005ftemplate_005fparameter_0026_005fname_005fkey_005fnobody.get(neo.taglib.util.ParameterTag.class);
    _jspx_th_template_005fparameter_005f0.setPageContext(_jspx_page_context);
    _jspx_th_template_005fparameter_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_template_005fcall_005f0);
    // /template/art_default.jsp(44,2) name = key type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_template_005fparameter_005f0.setKey("geoFields");
    // /template/art_default.jsp(44,2) name = name type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_template_005fparameter_005f0.setName("geoFields");
    int _jspx_eval_template_005fparameter_005f0 = _jspx_th_template_005fparameter_005f0.doStartTag();
    if (_jspx_th_template_005fparameter_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005ftemplate_005fparameter_0026_005fname_005fkey_005fnobody.reuse(_jspx_th_template_005fparameter_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005ftemplate_005fparameter_0026_005fname_005fkey_005fnobody.reuse(_jspx_th_template_005fparameter_005f0);
    return false;
  }
}
