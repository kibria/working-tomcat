package org.apache.jsp.pages.publication;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import neo.util.StringUtil;
import java.util.Map;
import org.apache.commons.lang.StringEscapeUtils;

public final class upload_002dresources_002dcontent_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ferrors_0026_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005flink_0026_005fpage;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fform_0026_005fonsubmit_005fmethod_005fenctype_005faction;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fhidden_0026_005fvalue_005fstyleId_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005ffile_0026_005fproperty_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005fsubmit_0026_005fvalue_005fnobody;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fhtml_005ferrors_0026_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005flink_0026_005fpage = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fform_0026_005fonsubmit_005fmethod_005fenctype_005faction = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fhidden_0026_005fvalue_005fstyleId_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005ffile_0026_005fproperty_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005fsubmit_0026_005fvalue_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fhtml_005ferrors_0026_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005flink_0026_005fpage.release();
    _005fjspx_005ftagPool_005fhtml_005fform_0026_005fonsubmit_005fmethod_005fenctype_005faction.release();
    _005fjspx_005ftagPool_005fhtml_005fhidden_0026_005fvalue_005fstyleId_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005ffile_0026_005fproperty_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005fsubmit_0026_005fvalue_005fnobody.release();
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
      out.write("<div class=\"error\">");
      if (_jspx_meth_html_005ferrors_005f0(_jspx_page_context))
        return;
      out.write("</div>\n");
      out.write("\n");
      out.write("<div class=\"info\"><h2>Uploading resources</h2>\n");
      out.write("  This page allows you to upload resources to the server.  Once you have\n");
      out.write("  uploaded the required resources, you will be able to create publications.\n");
      out.write("</div>\n");
      out.write("\n");

  Map resources = new java.util.TreeMap();
  for (java.util.Enumeration e = request.getSession().getAttributeNames(); e.hasMoreElements();) { String name = (String)e.nextElement();
    if (name.startsWith("uploaded-publication-resource:") || name.startsWith("uploaded-resource:")) {
      resources.put(name, request.getSession().getAttribute(name));
    }
  }
  java.util.List reasons = new java.util.ArrayList();
  java.util.Map contenttypes = (java.util.Map) request.getSession().getAttribute("uploaded-publication-resource:/escenic/content-type");
  java.util.Map layouts = (java.util.Map) request.getSession().getAttribute("uploaded-publication-resource:/escenic/layout");

  if (contenttypes == null || ! Boolean.TRUE.equals(contenttypes.get("valid")) ) {
    reasons.add("Content Type Definition");
  }
  if (layouts == null || ! Boolean.TRUE.equals(layouts.get("valid"))){
    reasons.add("Layout Definition");
  }
  if (reasons.size() == 0) {
    
      out.write("\n");
      out.write("    <h2>Create Publication</h2>\n");
      out.write("    You now have enough resources to ");
      if (_jspx_meth_html_005flink_005f0(_jspx_page_context))
        return;
      out.write("\n");
      out.write("    ");

  }

      out.write('\n');
      out.write('\n');
 if (resources.size() > 0) { 
      out.write("\n");
      out.write("<h2>Available resources</h2>\n");
      out.write("You have now uploaded the following resources.  Once you have uploaded enough valid resources, you can create your publication.\n");
      out.write("<table>\n");
      out.write(" <tr>\n");
      out.write(" <th>Type</th>\n");
      out.write(" <th>Age</th>\n");
      out.write(" <th>Uploaded Content Type</th>\n");
      out.write(" <th>File name</th>\n");
      out.write(" <th>Size (bytes)</th>\n");
      out.write(" <th>Valid</th>\n");
      out.write(" <th>&nbsp;</th>\n");
      out.write(" </tr>\n");
 for (java.util.Iterator i = resources.keySet().iterator(); i.hasNext();) { String name = (String)i.next(); 
      out.write("\n");
      out.write(" <tr>\n");
      out.write("\n");
      out.write("   ");
 Map stuff = (Map) resources.get(name); 
      out.write("\n");
      out.write("   <td>");
      out.print(stuff.get("type"));
      out.write("</td>\n");
      out.write("   <td>");
      out.print(StringUtil.formatDuration(System.currentTimeMillis() - ((Long)stuff.get("date")).longValue()) );
      out.write("</td>\n");
      out.write("   <td>");
      out.print(stuff.get("content-type"));
      out.write("</td>\n");
      out.write("   <td>");
      out.print(stuff.get("file-name"));
      out.write("</td>\n");
      out.write("   <td>");
      out.print(stuff.get("file-size"));
      out.write("</td>\n");
      out.write("   <td>");
      out.print(((Boolean)stuff.get("valid")).booleanValue() ? "Validated" : "Not valid");
      out.write("</td>\n");
      out.write("   <td>");
      //  html:link
      org.apache.struts.taglib.html.LinkTag _jspx_th_html_005flink_005f1 = (org.apache.struts.taglib.html.LinkTag) _005fjspx_005ftagPool_005fhtml_005flink_0026_005fpage.get(org.apache.struts.taglib.html.LinkTag.class);
      _jspx_th_html_005flink_005f1.setPageContext(_jspx_page_context);
      _jspx_th_html_005flink_005f1.setParent(null);
      // /pages/publication/upload-resources-content.jsp(62,7) name = page type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_html_005flink_005f1.setPage("/do/publication/deleteResource?resource=" + stuff.get("type"));
      int _jspx_eval_html_005flink_005f1 = _jspx_th_html_005flink_005f1.doStartTag();
      if (_jspx_eval_html_005flink_005f1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        if (_jspx_eval_html_005flink_005f1 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.pushBody();
          _jspx_th_html_005flink_005f1.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
          _jspx_th_html_005flink_005f1.doInitBody();
        }
        do {
          out.write("Remove uploaded resource");
          int evalDoAfterBody = _jspx_th_html_005flink_005f1.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
        if (_jspx_eval_html_005flink_005f1 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
          out = _jspx_page_context.popBody();
        }
      }
      if (_jspx_th_html_005flink_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fhtml_005flink_0026_005fpage.reuse(_jspx_th_html_005flink_005f1);
        return;
      }
      _005fjspx_005ftagPool_005fhtml_005flink_0026_005fpage.reuse(_jspx_th_html_005flink_005f1);
      out.write(" </td>\n");
      out.write(" </tr>\n");
      out.write("  ");
 if (stuff.get("exception") != null) { 
      out.write("\n");
      out.write("   <tr>\n");
      out.write("     <td colspan=\"6\" class=\"error\">");
      out.print(StringEscapeUtils.escapeHtml(((Exception) stuff.get("exception")).getMessage()));
      out.write("</td>\n");
      out.write("   </tr>\n");
      out.write("  ");
 } 
      out.write('\n');
 } 
      out.write("\n");
      out.write("</table>\n");
 } 
      out.write("\n");
      out.write("\n");
      out.write("<h2>Upload or overwrite a resource</h2>\n");
      //  html:form
      org.apache.struts.taglib.html.FormTag _jspx_th_html_005fform_005f0 = (org.apache.struts.taglib.html.FormTag) _005fjspx_005ftagPool_005fhtml_005fform_0026_005fonsubmit_005fmethod_005fenctype_005faction.get(org.apache.struts.taglib.html.FormTag.class);
      _jspx_th_html_005fform_005f0.setPageContext(_jspx_page_context);
      _jspx_th_html_005fform_005f0.setParent(null);
      // /pages/publication/upload-resources-content.jsp(74,0) name = action type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_html_005fform_005f0.setAction("/publication/resource");
      // /pages/publication/upload-resources-content.jsp(74,0) name = method type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_html_005fform_005f0.setMethod("post");
      // /pages/publication/upload-resources-content.jsp(74,0) name = enctype type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_html_005fform_005f0.setEnctype("multipart/form-data");
      // /pages/publication/upload-resources-content.jsp(74,0) name = onsubmit type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_html_005fform_005f0.setOnsubmit("if (document.getElementById('otherradio').checked) document.getElementById('type').value = document.getElementById('other').value; ");
      int _jspx_eval_html_005fform_005f0 = _jspx_th_html_005fform_005f0.doStartTag();
      if (_jspx_eval_html_005fform_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\n");
          out.write(" <table><tr><td valign=\"top\">\n");
          out.write("  Type of resource:\n");
          out.write(" </td>\n");
          out.write(" <td>\n");
          out.write("\n");
          out.write("   <input checked=\"checked\" type=\"radio\" name=\"typetmp\" value=\"webapp\" id=\"webapp\"\n");
          out.write("          onClick=\"document.getElementById('type').value='webapp'\"/>\n");
          out.write("   <label for=\"webapp\">Publication Definition\n");
          out.write("     ");
 if (! resources.isEmpty()) { 
          out.write("\n");
          out.write("       (will replace any current definitions)\n");
          out.write("     ");
 } 
          out.write("\n");
          out.write("   </label><br>\n");
          out.write("\n");
          out.write("   <input type=\"radio\" name=\"typetmp\" value=\"/escenic/content-type\" id=\"content-type\"\n");
          out.write("          onClick=\"document.getElementById('type').value='/escenic/content-type'\"/>\n");
          out.write("   <label for=\"content-type\">Content Type definitions\n");
          out.write("     ");
 if (resources.containsKey("/escenic/content-type")) { 
          out.write("\n");
          out.write("       (will replace the current content type definition)\n");
          out.write("     ");
 } 
          out.write("\n");
          out.write("   </label><br>\n");
          out.write("\n");
          out.write("   <input type=\"radio\" name=\"typetmp\" value=\"/escenic/feature\" id=\"feature\"\n");
          out.write("          onClick=\"document.getElementById('type').value='/escenic/feature'\"/>\n");
          out.write("   <label for=\"feature\">Feature definitions (optional)\n");
          out.write("       ");
 if (resources.containsKey("/escenic/feature")) { 
          out.write("\n");
          out.write("       (will replace the current feature definition)\n");
          out.write("       ");
 } 
          out.write("\n");
          out.write("   </label><br>\n");
          out.write("\n");
          out.write("  <input type=\"radio\" name=\"typetmp\" value=\"/escenic/image-version\"\n");
          out.write("         id=\"image-version\"\n");
          out.write("         onClick=\"document.getElementById('type').value='/escenic/image-version'\"/>\n");
          out.write("  <label for=\"image-version\">Image Version definitions (optional)\n");
          out.write("    ");
 if (resources.containsKey("/escenic/image-version")) { 
          out.write("\n");
          out.write("      (will replace the current image version definition)\n");
          out.write("    ");
 } 
          out.write("\n");
          out.write("  </label><br>\n");
          out.write("\n");
          out.write("   <input type=\"radio\" name=\"typetmp\" value=\"/escenic/layout\" id=\"layout\"\n");
          out.write("          onClick=\"document.getElementById('type').value='/escenic/layout'\"/>\n");
          out.write("   <label for=\"layout\">Layout definitions\n");
          out.write("     ");
 if (resources.containsKey("/escenic/layout")) { 
          out.write("\n");
          out.write("       (will replace the current layout definition)\n");
          out.write("     ");
 } 
          out.write("\n");
          out.write("   </label><br>\n");
          out.write("   <input type=\"radio\" name=\"typetmp\" value=\"/escenic/layout-group\" id=\"layout-group\"\n");
          out.write("          onClick=\"document.getElementById('type').value='/escenic/layout-group'\"/>\n");
          out.write("   <label for=\"layout-group\">Layout-group definitions\n");
          out.write("     ");
 if (resources.containsKey("/escenic/layout-group")) { 
          out.write("\n");
          out.write("       (will replace the current layout-group definition)\n");
          out.write("     ");
 } 
          out.write("\n");
          out.write("   </label><br>\n");
          out.write("\n");
          out.write("   <input type=\"radio\" name=\"typetmp\" value=\"/escenic/content\" id=\"content\"\n");
          out.write("          onClick=\"document.getElementById('type').value='/escenic/content'\"/>\n");
          out.write("   <label for=\"content\">Content definitions (optional)\n");
          out.write("       ");
 if (resources.containsKey("/escenic/content")) { 
          out.write("\n");
          out.write("       (will replace the current content definition)\n");
          out.write("       ");
 } 
          out.write("\n");
          out.write("   </label><br>\n");
          out.write("\n");
          out.write("   ");
          out.write("\n");
          out.write("  <input type=\"radio\" name=\"typetmp\" value=\"other\" id=\"otherradio\"/>\n");
          out.write("  <label for=\"otherradio\">Other type of resource</label><br>\n");
          out.write("  Please specify: <input type=\"text\" id=\"other\"\n");
          out.write("    onfocus=\"document.getElementById('otherradio').click(); return true;\">\n");
          out.write("  ");
          if (_jspx_meth_html_005fhidden_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\n");
          out.write(" </td>\n");
          out.write("</tr>\n");
          out.write("<tr>\n");
          out.write(" <td valign=\"top\">\n");
          out.write("  File to upload\n");
          out.write(" </td>\n");
          out.write(" <td>\n");
          out.write("  ");
          if (_jspx_meth_html_005ffile_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write('\n');
          out.write(' ');
          out.write(' ');
          if (_jspx_meth_html_005fsubmit_005f0(_jspx_th_html_005fform_005f0, _jspx_page_context))
            return;
          out.write("\n");
          out.write(" </td>\n");
          out.write("</tr>\n");
          out.write("</table>\n");
          int evalDoAfterBody = _jspx_th_html_005fform_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_html_005fform_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fhtml_005fform_0026_005fonsubmit_005fmethod_005fenctype_005faction.reuse(_jspx_th_html_005fform_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fhtml_005fform_0026_005fonsubmit_005fmethod_005fenctype_005faction.reuse(_jspx_th_html_005fform_005f0);
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

  private boolean _jspx_meth_html_005ferrors_005f0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:errors
    org.apache.struts.taglib.html.ErrorsTag _jspx_th_html_005ferrors_005f0 = (org.apache.struts.taglib.html.ErrorsTag) _005fjspx_005ftagPool_005fhtml_005ferrors_0026_005fproperty_005fnobody.get(org.apache.struts.taglib.html.ErrorsTag.class);
    _jspx_th_html_005ferrors_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005ferrors_005f0.setParent(null);
    // /pages/publication/upload-resources-content.jsp(7,19) name = property type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ferrors_005f0.setProperty("global");
    int _jspx_eval_html_005ferrors_005f0 = _jspx_th_html_005ferrors_005f0.doStartTag();
    if (_jspx_th_html_005ferrors_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ferrors_0026_005fproperty_005fnobody.reuse(_jspx_th_html_005ferrors_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ferrors_0026_005fproperty_005fnobody.reuse(_jspx_th_html_005ferrors_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005flink_005f0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:link
    org.apache.struts.taglib.html.LinkTag _jspx_th_html_005flink_005f0 = (org.apache.struts.taglib.html.LinkTag) _005fjspx_005ftagPool_005fhtml_005flink_0026_005fpage.get(org.apache.struts.taglib.html.LinkTag.class);
    _jspx_th_html_005flink_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005flink_005f0.setParent(null);
    // /pages/publication/upload-resources-content.jsp(34,37) name = page type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005flink_005f0.setPage("/pages/publication/new.jsp");
    int _jspx_eval_html_005flink_005f0 = _jspx_th_html_005flink_005f0.doStartTag();
    if (_jspx_eval_html_005flink_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      if (_jspx_eval_html_005flink_005f0 != javax.servlet.jsp.tagext.Tag.EVAL_BODY_INCLUDE) {
        out = _jspx_page_context.pushBody();
        _jspx_th_html_005flink_005f0.setBodyContent((javax.servlet.jsp.tagext.BodyContent) out);
        _jspx_th_html_005flink_005f0.doInitBody();
      }
      do {
        out.write("create a publication");
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
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005flink_0026_005fpage.reuse(_jspx_th_html_005flink_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005fhidden_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:hidden
    org.apache.struts.taglib.html.HiddenTag _jspx_th_html_005fhidden_005f0 = (org.apache.struts.taglib.html.HiddenTag) _005fjspx_005ftagPool_005fhtml_005fhidden_0026_005fvalue_005fstyleId_005fproperty_005fnobody.get(org.apache.struts.taglib.html.HiddenTag.class);
    _jspx_th_html_005fhidden_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005fhidden_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /pages/publication/upload-resources-content.jsp(151,2) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f0.setProperty("type");
    // /pages/publication/upload-resources-content.jsp(151,2) name = styleId type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f0.setStyleId("type");
    // /pages/publication/upload-resources-content.jsp(151,2) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fhidden_005f0.setValue("webapp");
    int _jspx_eval_html_005fhidden_005f0 = _jspx_th_html_005fhidden_005f0.doStartTag();
    if (_jspx_th_html_005fhidden_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fhidden_0026_005fvalue_005fstyleId_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fhidden_0026_005fvalue_005fstyleId_005fproperty_005fnobody.reuse(_jspx_th_html_005fhidden_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005ffile_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:file
    org.apache.struts.taglib.html.FileTag _jspx_th_html_005ffile_005f0 = (org.apache.struts.taglib.html.FileTag) _005fjspx_005ftagPool_005fhtml_005ffile_0026_005fproperty_005fnobody.get(org.apache.struts.taglib.html.FileTag.class);
    _jspx_th_html_005ffile_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005ffile_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /pages/publication/upload-resources-content.jsp(159,2) name = property type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005ffile_005f0.setProperty("resourceFile");
    int _jspx_eval_html_005ffile_005f0 = _jspx_th_html_005ffile_005f0.doStartTag();
    if (_jspx_th_html_005ffile_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005ffile_0026_005fproperty_005fnobody.reuse(_jspx_th_html_005ffile_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005ffile_0026_005fproperty_005fnobody.reuse(_jspx_th_html_005ffile_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005fsubmit_005f0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_005fform_005f0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:submit
    org.apache.struts.taglib.html.SubmitTag _jspx_th_html_005fsubmit_005f0 = (org.apache.struts.taglib.html.SubmitTag) _005fjspx_005ftagPool_005fhtml_005fsubmit_0026_005fvalue_005fnobody.get(org.apache.struts.taglib.html.SubmitTag.class);
    _jspx_th_html_005fsubmit_005f0.setPageContext(_jspx_page_context);
    _jspx_th_html_005fsubmit_005f0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_005fform_005f0);
    // /pages/publication/upload-resources-content.jsp(160,2) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005fsubmit_005f0.setValue("Upload");
    int _jspx_eval_html_005fsubmit_005f0 = _jspx_th_html_005fsubmit_005f0.doStartTag();
    if (_jspx_th_html_005fsubmit_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005fsubmit_0026_005fvalue_005fnobody.reuse(_jspx_th_html_005fsubmit_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005fsubmit_0026_005fvalue_005fnobody.reuse(_jspx_th_html_005fsubmit_005f0);
    return false;
  }
}
