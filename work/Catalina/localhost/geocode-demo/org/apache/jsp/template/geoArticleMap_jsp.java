package org.apache.jsp.template;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import com.escenic.geocode.presentation.PresentationConstants;
import java.util.Collection;
import com.escenic.geocode.api.GeoField;
import java.util.List;
import com.escenic.geocode.utils.KMLUtils;
import com.escenic.geocode.plugin.GeocodePluginConstants;

public final class geoArticleMap_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


  final String imageURL = "http://labs.google.com/ridefinder/images/mm_20_green.png";

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005flogic_005fpresent_0026_005fname;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fbean_005fdefine_0026_005ftype_005fname_005fid_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005flogic_005fiterate_0026_005ftype_005fname_005fid;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fbean_005fdefine_0026_005ftype_005fid;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005farticle_005fuse_0026_005farticleId;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fbean_005fdefine_0026_005fvalue_005ftype_005fid_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005ftemplate_005fcall_0026_005ffile;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005ftemplate_005fparameter_0026_005fname_005fkey_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005flogic_005fpresent_0026_005fname = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fbean_005fdefine_0026_005ftype_005fname_005fid_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005flogic_005fiterate_0026_005ftype_005fname_005fid = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fbean_005fdefine_0026_005ftype_005fid = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005farticle_005fuse_0026_005farticleId = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fbean_005fdefine_0026_005fvalue_005ftype_005fid_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005ftemplate_005fcall_0026_005ffile = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005ftemplate_005fparameter_0026_005fname_005fkey_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005flogic_005fpresent_0026_005fname.release();
    _005fjspx_005ftagPool_005fbean_005fdefine_0026_005ftype_005fname_005fid_005fnobody.release();
    _005fjspx_005ftagPool_005flogic_005fiterate_0026_005ftype_005fname_005fid.release();
    _005fjspx_005ftagPool_005fbean_005fdefine_0026_005ftype_005fid.release();
    _005fjspx_005ftagPool_005farticle_005fuse_0026_005farticleId.release();
    _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.release();
    _005fjspx_005ftagPool_005fbean_005fdefine_0026_005fvalue_005ftype_005fid_005fnobody.release();
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
      out.write("\n");
      out.write("<div id=\"resultGoogleMap\" style=\"width:500px;height:300px\"></div>\n");
      out.write("\n");
      //  logic:present
      org.apache.struts.taglib.logic.PresentTag _jspx_th_logic_005fpresent_005f0 = (org.apache.struts.taglib.logic.PresentTag) _005fjspx_005ftagPool_005flogic_005fpresent_0026_005fname.get(org.apache.struts.taglib.logic.PresentTag.class);
      _jspx_th_logic_005fpresent_005f0.setPageContext(_jspx_page_context);
      _jspx_th_logic_005fpresent_005f0.setParent(null);
      // /template/geoArticleMap.jsp(21,0) name = name type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_logic_005fpresent_005f0.setName(PresentationConstants.RQ_ATTR_GEO_ARTICLE_SEARCH_RESULT);
      int _jspx_eval_logic_005fpresent_005f0 = _jspx_th_logic_005fpresent_005f0.doStartTag();
      if (_jspx_eval_logic_005fpresent_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write('\n');
          out.write(' ');
          out.write(' ');
          //  bean:define
          org.apache.struts.taglib.bean.DefineTag _jspx_th_bean_005fdefine_005f0 = (org.apache.struts.taglib.bean.DefineTag) _005fjspx_005ftagPool_005fbean_005fdefine_0026_005ftype_005fname_005fid_005fnobody.get(org.apache.struts.taglib.bean.DefineTag.class);
          _jspx_th_bean_005fdefine_005f0.setPageContext(_jspx_page_context);
          _jspx_th_bean_005fdefine_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_logic_005fpresent_005f0);
          // /template/geoArticleMap.jsp(22,2) name = id type = java.lang.String reqTime = false required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
          _jspx_th_bean_005fdefine_005f0.setId("searchResult");
          // /template/geoArticleMap.jsp(22,2) name = name type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
          _jspx_th_bean_005fdefine_005f0.setName(PresentationConstants.RQ_ATTR_GEO_ARTICLE_SEARCH_RESULT);
          // /template/geoArticleMap.jsp(22,2) name = type type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
          _jspx_th_bean_005fdefine_005f0.setType("neo.xredsys.content.search.SearchResult");
          int _jspx_eval_bean_005fdefine_005f0 = _jspx_th_bean_005fdefine_005f0.doStartTag();
          if (_jspx_th_bean_005fdefine_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
            _005fjspx_005ftagPool_005fbean_005fdefine_0026_005ftype_005fname_005fid_005fnobody.reuse(_jspx_th_bean_005fdefine_005f0);
            return;
          }
          _005fjspx_005ftagPool_005fbean_005fdefine_0026_005ftype_005fname_005fid_005fnobody.reuse(_jspx_th_bean_005fdefine_005f0);
          neo.xredsys.content.search.SearchResult searchResult = null;
          searchResult = (neo.xredsys.content.search.SearchResult) _jspx_page_context.findAttribute("searchResult");
          out.write('\n');
          out.write(' ');
          out.write(' ');

    Collection searchHits = searchResult.getSearchHits();
    pageContext.setAttribute("searchHits", searchHits);
  
          out.write("\n");
          out.write("  <script type=\"text/javascript\">\n");
          out.write("    getMarkerArray().length = 0;\n");
          out.write("  </script>\n");
          out.write("    ");
          //  logic:iterate
          org.apache.struts.taglib.logic.IterateTag _jspx_th_logic_005fiterate_005f0 = (org.apache.struts.taglib.logic.IterateTag) _005fjspx_005ftagPool_005flogic_005fiterate_0026_005ftype_005fname_005fid.get(org.apache.struts.taglib.logic.IterateTag.class);
          _jspx_th_logic_005fiterate_005f0.setPageContext(_jspx_page_context);
          _jspx_th_logic_005fiterate_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_logic_005fpresent_005f0);
          // /template/geoArticleMap.jsp(31,4) name = id type = java.lang.String reqTime = false required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
          _jspx_th_logic_005fiterate_005f0.setId("searchHit");
          // /template/geoArticleMap.jsp(31,4) name = name type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
          _jspx_th_logic_005fiterate_005f0.setName("searchHits");
          // /template/geoArticleMap.jsp(31,4) name = type type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
          _jspx_th_logic_005fiterate_005f0.setType("neo.xredsys.content.search.SearchHit");
          int _jspx_eval_logic_005fiterate_005f0 = _jspx_th_logic_005fiterate_005f0.doStartTag();
          if (_jspx_eval_logic_005fiterate_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
            neo.xredsys.content.search.SearchHit searchHit = null;
            if (_jspx_eval_logic_005fiterate_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
              out = _jspx_page_context.pushBody();
              _jspx_th_logic_005fiterate_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
              _jspx_th_logic_005fiterate_005f0.doInitBody();
            }
            searchHit = (neo.xredsys.content.search.SearchHit) _jspx_page_context.findAttribute("searchHit");
            do {
              out.write("\n");
              out.write("      ");
              //  bean:define
              org.apache.struts.taglib.bean.DefineTag _jspx_th_bean_005fdefine_005f1 = (org.apache.struts.taglib.bean.DefineTag) _005fjspx_005ftagPool_005fbean_005fdefine_0026_005ftype_005fid.get(org.apache.struts.taglib.bean.DefineTag.class);
              _jspx_th_bean_005fdefine_005f1.setPageContext(_jspx_page_context);
              _jspx_th_bean_005fdefine_005f1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_logic_005fiterate_005f0);
              // /template/geoArticleMap.jsp(33,6) name = id type = java.lang.String reqTime = false required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
              _jspx_th_bean_005fdefine_005f1.setId("articleIdStr");
              // /template/geoArticleMap.jsp(33,6) name = type type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
              _jspx_th_bean_005fdefine_005f1.setType("java.lang.String");
              int _jspx_eval_bean_005fdefine_005f1 = _jspx_th_bean_005fdefine_005f1.doStartTag();
              if (_jspx_eval_bean_005fdefine_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
                if (_jspx_eval_bean_005fdefine_005f1 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
                  out = _jspx_page_context.pushBody();
                  _jspx_th_bean_005fdefine_005f1.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
                  _jspx_th_bean_005fdefine_005f1.doInitBody();
                }
                do {
                  out.print(searchHit.getField("objectid"));
                  int evalDoAfterBody = _jspx_th_bean_005fdefine_005f1.doAfterBody();
                  if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                    break;
                } while (true);
                if (_jspx_eval_bean_005fdefine_005f1 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
                  out = _jspx_page_context.popBody();
                }
              }
              if (_jspx_th_bean_005fdefine_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                _005fjspx_005ftagPool_005fbean_005fdefine_0026_005ftype_005fid.reuse(_jspx_th_bean_005fdefine_005f1);
                return;
              }
              _005fjspx_005ftagPool_005fbean_005fdefine_0026_005ftype_005fid.reuse(_jspx_th_bean_005fdefine_005f1);
              java.lang.String articleIdStr = null;
              articleIdStr = (java.lang.String) _jspx_page_context.findAttribute("articleIdStr");
              out.write("\n");
              out.write("      ");
              //  article:use
              neo.taglib.article.UseTag _jspx_th_article_005fuse_005f0 = (neo.taglib.article.UseTag) _005fjspx_005ftagPool_005farticle_005fuse_0026_005farticleId.get(neo.taglib.article.UseTag.class);
              _jspx_th_article_005fuse_005f0.setPageContext(_jspx_page_context);
              _jspx_th_article_005fuse_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_logic_005fiterate_005f0);
              // /template/geoArticleMap.jsp(34,6) name = articleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
              _jspx_th_article_005fuse_005f0.setArticleId(Integer.parseInt(articleIdStr));
              int _jspx_eval_article_005fuse_005f0 = _jspx_th_article_005fuse_005f0.doStartTag();
              if (_jspx_eval_article_005fuse_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
                do {
                  out.write("\n");
                  out.write("        ");
                  //  c:set
                  org.apache.taglibs.standard.tag.rt.core.SetTag _jspx_th_c_005fset_005f0 = (org.apache.taglibs.standard.tag.rt.core.SetTag) _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.SetTag.class);
                  _jspx_th_c_005fset_005f0.setPageContext(_jspx_page_context);
                  _jspx_th_c_005fset_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_article_005fuse_005f0);
                  // /template/geoArticleMap.jsp(35,8) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
                  _jspx_th_c_005fset_005f0.setVar("geocodeFieldName");
                  // /template/geoArticleMap.jsp(35,8) name = value type = javax.el.ValueExpression reqTime = true required = false fragment = false deferredValue = true expectedTypeName = java.lang.Object deferredMethod = false methodSignature = null
                  _jspx_th_c_005fset_005f0.setValue(GeocodePluginConstants.GEOCODE_FIELD);
                  int _jspx_eval_c_005fset_005f0 = _jspx_th_c_005fset_005f0.doStartTag();
                  if (_jspx_th_c_005fset_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.reuse(_jspx_th_c_005fset_005f0);
                    return;
                  }
                  _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.reuse(_jspx_th_c_005fset_005f0);
                  out.write("\n");
                  out.write("        ");
                  //  bean:define
                  org.apache.struts.taglib.bean.DefineTag _jspx_th_bean_005fdefine_005f2 = (org.apache.struts.taglib.bean.DefineTag) _005fjspx_005ftagPool_005fbean_005fdefine_0026_005fvalue_005ftype_005fid_005fnobody.get(org.apache.struts.taglib.bean.DefineTag.class);
                  _jspx_th_bean_005fdefine_005f2.setPageContext(_jspx_page_context);
                  _jspx_th_bean_005fdefine_005f2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_article_005fuse_005f0);
                  // /template/geoArticleMap.jsp(36,8) name = id type = java.lang.String reqTime = false required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
                  _jspx_th_bean_005fdefine_005f2.setId("geocodeFields");
                  // /template/geoArticleMap.jsp(36,8) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
                  _jspx_th_bean_005fdefine_005f2.setValue((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${article.fields[geocodeFieldName].value}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
                  // /template/geoArticleMap.jsp(36,8) name = type type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
                  _jspx_th_bean_005fdefine_005f2.setType("java.lang.String");
                  int _jspx_eval_bean_005fdefine_005f2 = _jspx_th_bean_005fdefine_005f2.doStartTag();
                  if (_jspx_th_bean_005fdefine_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                    _005fjspx_005ftagPool_005fbean_005fdefine_0026_005fvalue_005ftype_005fid_005fnobody.reuse(_jspx_th_bean_005fdefine_005f2);
                    return;
                  }
                  _005fjspx_005ftagPool_005fbean_005fdefine_0026_005fvalue_005ftype_005fid_005fnobody.reuse(_jspx_th_bean_005fdefine_005f2);
                  java.lang.String geocodeFields = null;
                  geocodeFields = (java.lang.String) _jspx_page_context.findAttribute("geocodeFields");
                  out.write("\n");
                  out.write("        ");

          List<GeoField> geoFields = KMLUtils.getGeoFields(geocodeFields);
          request.setAttribute("geoFields", geoFields);
        
                  out.write("\n");
                  out.write("        ");
                  if (_jspx_meth_template_005fcall_005f0(_jspx_th_article_005fuse_005f0, _jspx_page_context))
                    return;
                  out.write("\n");
                  out.write("      ");
                  int evalDoAfterBody = _jspx_th_article_005fuse_005f0.doAfterBody();
                  if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
                    break;
                } while (true);
              }
              if (_jspx_th_article_005fuse_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
                _005fjspx_005ftagPool_005farticle_005fuse_0026_005farticleId.reuse(_jspx_th_article_005fuse_005f0);
                return;
              }
              _005fjspx_005ftagPool_005farticle_005fuse_0026_005farticleId.reuse(_jspx_th_article_005fuse_005f0);
              out.write("\n");
              out.write("    ");
              int evalDoAfterBody = _jspx_th_logic_005fiterate_005f0.doAfterBody();
              searchHit = (neo.xredsys.content.search.SearchHit) _jspx_page_context.findAttribute("searchHit");
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

  private boolean _jspx_meth_template_005fcall_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_article_005fuse_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  template:call
    neo.taglib.template.CallTemplateTag _jspx_th_template_005fcall_005f0 = (neo.taglib.template.CallTemplateTag) _005fjspx_005ftagPool_005ftemplate_005fcall_0026_005ffile.get(neo.taglib.template.CallTemplateTag.class);
    _jspx_th_template_005fcall_005f0.setPageContext(_jspx_page_context);
    _jspx_th_template_005fcall_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_article_005fuse_005f0);
    // /template/geoArticleMap.jsp(41,8) name = file type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_template_005fcall_005f0.setFile("./geoFieldsOnMap.jsp");
    int _jspx_eval_template_005fcall_005f0 = _jspx_th_template_005fcall_005f0.doStartTag();
    if (_jspx_eval_template_005fcall_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\n");
        out.write("          ");
        if (_jspx_meth_template_005fparameter_005f0(_jspx_th_template_005fcall_005f0, _jspx_page_context))
          return true;
        out.write("\n");
        out.write("        ");
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
    // /template/geoArticleMap.jsp(42,10) name = key type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_template_005fparameter_005f0.setKey("geoFields");
    // /template/geoArticleMap.jsp(42,10) name = name type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
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
