package org.apache.jsp.WEB_002dINF.pages.framework.frame;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class header_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(1);
    _jspx_dependants.add("/WEB-INF/pages/base/common-jsp-header.jspf");
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005ftemplate_005fserviceParameter_0026_005fname_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005flogic_005fpresent_0026_005fscope_005fname;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005ftemplate_005fserviceParameter_0026_005fname_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005flogic_005fpresent_0026_005fscope_005fname = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005ftemplate_005fserviceParameter_0026_005fname_005fnobody.release();
    _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.release();
    _005fjspx_005ftagPool_005flogic_005fpresent_0026_005fscope_005fname.release();
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
      out.write("<head>\n");
      out.write("  <META HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=UTF-8\"> \n");
      out.write("  <meta http-equiv=\"Expires\" content=\"0\">\n");
      out.write("  <meta http-equiv=\"Pragma\" content=\"no-cache\">\n");
      out.write("  <title>");
      if (_jspx_meth_template_005fserviceParameter_005f0(_jspx_page_context))
        return;
      out.write("</title>\n");
      out.write("<!--\n");
      out.write("  <style>\n");
      out.write("    div { border: 1px solid green; margin: 2px; padding: 2px; }\n");
      out.write("    table { border: 1px solid red; margin: 2px; padding: 2px; }\n");
      out.write("    td { border: 1px dotted red; margin: 2px; padding: 2px; }\n");
      out.write("  </style>\n");
      out.write("-->\n");
      out.write("  <link rel=\"stylesheet\" href=\"");
      //  html:rewrite
      org.apache.struts.taglib.html.RewriteTag _jspx_th_html_005frewrite_005f0 = (org.apache.struts.taglib.html.RewriteTag) _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.get(org.apache.struts.taglib.html.RewriteTag.class);
      _jspx_th_html_005frewrite_005f0.setPageContext(_jspx_page_context);
      _jspx_th_html_005frewrite_005f0.setParent(null);
      // /WEB-INF/pages/framework/frame/header.jsp(21,31) name = page type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_html_005frewrite_005f0.setPage((String)pageContext.findAttribute("textmap-style-global"));
      int _jspx_eval_html_005frewrite_005f0 = _jspx_th_html_005frewrite_005f0.doStartTag();
      if (_jspx_th_html_005frewrite_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.reuse(_jspx_th_html_005frewrite_005f0);
        return;
      }
      _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.reuse(_jspx_th_html_005frewrite_005f0);
      out.write("\" type=\"text/css\">\n");
      out.write("  <link rel=\"stylesheet\" href=\"");
      //  html:rewrite
      org.apache.struts.taglib.html.RewriteTag _jspx_th_html_005frewrite_005f1 = (org.apache.struts.taglib.html.RewriteTag) _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.get(org.apache.struts.taglib.html.RewriteTag.class);
      _jspx_th_html_005frewrite_005f1.setPageContext(_jspx_page_context);
      _jspx_th_html_005frewrite_005f1.setParent(null);
      // /WEB-INF/pages/framework/frame/header.jsp(22,31) name = page type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_html_005frewrite_005f1.setPage((String)pageContext.findAttribute("textmap-style-context"));
      int _jspx_eval_html_005frewrite_005f1 = _jspx_th_html_005frewrite_005f1.doStartTag();
      if (_jspx_th_html_005frewrite_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.reuse(_jspx_th_html_005frewrite_005f1);
        return;
      }
      _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.reuse(_jspx_th_html_005frewrite_005f1);
      out.write("\" type=\"text/css\">\n");
      out.write("\n");
      out.write("  <link rel=\"SHORTCUT ICON\" href=\"");
      if (_jspx_meth_html_005frewrite_005f2(_jspx_page_context))
        return;
      out.write("\">\n");
      out.write("  ");
      if (_jspx_meth_template_005fserviceParameter_005f1(_jspx_page_context))
        return;
      out.write('\n');
      //  logic:present
      org.apache.struts.taglib.logic.PresentTag _jspx_th_logic_005fpresent_005f0 = (org.apache.struts.taglib.logic.PresentTag) _005fjspx_005ftagPool_005flogic_005fpresent_0026_005fscope_005fname.get(org.apache.struts.taglib.logic.PresentTag.class);
      _jspx_th_logic_005fpresent_005f0.setPageContext(_jspx_page_context);
      _jspx_th_logic_005fpresent_005f0.setParent(null);
      // /WEB-INF/pages/framework/frame/header.jsp(28,0) name = name type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_logic_005fpresent_005f0.setName("escenic-publication");
      // /WEB-INF/pages/framework/frame/header.jsp(28,0) name = scope type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_logic_005fpresent_005f0.setScope("session");
      int _jspx_eval_logic_005fpresent_005f0 = _jspx_th_logic_005fpresent_005f0.doStartTag();
      if (_jspx_eval_logic_005fpresent_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\n");
          out.write("\n");
          out.write("  ");
 if (request.getSession().getAttribute("escenic-publication") != null) {
    request.setAttribute("publication", request.getSession().getAttribute("escenic-publication"));
  
          out.write('\n');
          out.write(' ');
          out.write(' ');
 } 
          out.write('\n');
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
      out.write("\n");
      out.write("\n");
      out.write("<script language=\"JavaScript1.2\" type=\"text/javascript\">\n");
      out.write("  /* Pop up the forward. */\n");
      out.write("  var currentpopup = null;\n");
      out.write("  function popupcallback() {\n");
      out.write("    alert(\"default pop-up callback -- no handler for the pop-up was installed.\");\n");
      out.write("  }\n");
      out.write("\n");
      out.write("  function popup(forward,callback) {\n");
      out.write("    if (forward && forward != 'null') {\n");
      out.write("      var name = forward.replace(/[^a-zA-Z0-9]/g,\"_\");\n");
      out.write("      var uri = forward.substring(1);\n");
      out.write("      if (getWorkItemName) {\n");
      out.write("        var delim = '?';\n");
      out.write("        if (uri.indexOf('?') != -1) delim = '&';\n");
      out.write("        uri = uri + delim + 'parentWorkItemName=' + getWorkItemName();\n");
      out.write("      }\n");
      out.write("      currentpopup = window.open('");
      if (_jspx_meth_html_005frewrite_005f3(_jspx_page_context))
        return;
      out.write("' + uri, name, 'toolbar=no,statusbar=no,scrollbars=yes,resizable=yes,location=no,width=650,height=500');\n");
      out.write("      if (currentpopup.focus) {\n");
      out.write("        currentpopup.focus();\n");
      out.write("      }\n");
      out.write("      if (callback) {\n");
      out.write("        popupcallback = callback;\n");
      out.write("      }\n");
      out.write("    }\n");
      out.write("  }\n");
      out.write("\n");
      out.write("</script>\n");
      out.write("<script language=\"JavaScript1.2\" type=\"text/javascript\"><!--\n");
      out.write("  function submitForm(button,anchor) {\n");
      out.write("    if(callHooks('beforeSubmit')){\n");
      out.write("      if(document.forms[0]) {\n");
      out.write("        if(document.forms[0].submitButton) {\n");
      out.write("          document.forms[0].submitButton.value=button;\n");
      out.write("          if (anchor && anchor != 'null') {\n");
      out.write("            document.forms[0].action=document.forms[0].action + '#' + anchor;\n");
      out.write("          }\n");
      out.write("          document.forms[0].submit();\n");
      out.write("        } else {\n");
      out.write("          window.location.href='");
      if (_jspx_meth_html_005frewrite_005f4(_jspx_page_context))
        return;
      out.write("?forward=' + button;\n");
      out.write("        }\n");
      out.write("      } else {\n");
      out.write("        window.location.href='");
      if (_jspx_meth_html_005frewrite_005f5(_jspx_page_context))
        return;
      out.write("?forward=' + button;\n");
      out.write("      }\n");
      out.write("    }\n");
      out.write("  }\n");
      out.write("\n");
      out.write("  function globalSearch(searchWord) {\n");
      out.write("    alert(\"Global search has not been implemented yet.  I'm not sure what to do if you click Go. What do you think?  Tell me about it; mogsie@escenic.com\");\n");
      out.write("   /*\n");
      out.write("    if (document.forms[0]) {\n");
      out.write("      document.forms[0].globalSearchWord.value=searchWord;\n");
      out.write("      document.forms[0].submitButton.value='action:/base/globalSearch.do';\n");
      out.write("      document.forms[0].submit();\n");
      out.write("    } else {\n");
      out.write("      alert('unable to search for \"' + searchWord + '\"!');\n");
      out.write("    }*/\n");
      out.write("  }\n");
      out.write("  var eventHooks = new Object();\n");
      out.write("  function registerHook(where,fn) {\n");
      out.write("    if (!eventHooks[where]) {\n");
      out.write("      eventHooks[where] = new Array()\n");
      out.write("    }\n");
      out.write("    eventHooks[where][eventHooks[where].length] = fn;\n");
      out.write("  }\n");
      out.write("\n");
      out.write("  function callHooks(where) {\n");
      out.write("    if (eventHooks[where]) {\n");
      out.write("      for (var i = 0; i < eventHooks[where].length; i++) {\n");
      out.write("        var fn = eventHooks[where][i];\n");
      out.write("        result = fn();\n");
      out.write("        if (! result) {\n");
      out.write("          \n");
      out.write("          return false;\n");
      out.write("        }\n");
      out.write("      }\n");
      out.write("    } else {\n");
      out.write("    }\n");
      out.write("    return true;\n");
      out.write("  }\n");
      out.write("        \n");
      out.write("  var enterHooks = new Array();\n");
      out.write("  function registerEnterHook(fn) {\n");
      out.write("    enterHooks[enterHooks.length]=fn;\n");
      out.write("  }\n");
      out.write("        \n");
      out.write("  function handleKey(e){\n");
      out.write("    var code;\n");
      out.write("    if (!e) var e = window.event;\n");
      out.write("    code = e.keyCode;\n");
      out.write("    if(code==0){\n");
      out.write("      code = e.which;\n");
      out.write("    }\n");
      out.write("    if(code==13){\n");
      out.write("      if(document.forms[0][\"enterAction\"]&&document.forms[0][\"enterAction\"].value!=\"\"){\n");
      out.write("        submitForm(document.forms[0][\"enterAction\"].value);\n");
      out.write("      }else if(enterHooks.length>0){\n");
      out.write("        for (var i = 0; i < enterHooks.length; i++) {\n");
      out.write("          var fn = enterHooks[i];\n");
      out.write("          fn();\n");
      out.write("        }\n");
      out.write("      }\n");
      out.write("    }      \n");
      out.write("   }\n");
      out.write("  //checks if the form has a duplicate relation of some type. Parameters are:\n");
      out.write("  //relationType: type of relation, for instance topic\n");
      out.write("  //objectType: the type of object to be added\n");
      out.write("  //objectId: the id of the object to be added\n");
      out.write("  //numberOfRelations: the highest key stored. This is calculated by using relations(relationType).getNextKey()\n");
      out.write("  function hasDuplicateRelation(relationType,objectType,objectId,numberOfRelations){\n");
      out.write("    for(var k=0;k<numberOfRelations;k++){\n");
      out.write("      var index = ''+k;\n");
      out.write("      for(j=index.length;j<4;j++){\n");
      out.write("        index = \"0\"+index;\n");
      out.write("      }\n");
      out.write("      idField = getFieldElement(\"relations(\"+relationType+\").item(\"+index+\").id\");\n");
      out.write("      typeField = getFieldElement(\"relations(\"+relationType+\").item(\"+index+\").type\");\n");
      out.write("      if(idField){\n");
      out.write("        tmpId = idField.value;\n");
      out.write("        tmpType = typeField.value;\n");
      out.write("        if(tmpId==objectId&&tmpType==objectType){//already added\n");
      out.write("          return true;\n");
      out.write("        }\n");
      out.write("      }\n");
      out.write("    }\n");
      out.write("    return false;\n");
      out.write("  }\n");
      out.write("\n");
      out.write("  function getFieldElement(field){\n");
      out.write("    for (var i=0; i < document.forms[0].elements.length; i++) {\n");
      out.write("      if (document.forms[0].elements[i].name == field){\n");
      out.write("        return document.forms[0].elements[i];\n");
      out.write("      }\n");
      out.write("    }\n");
      out.write("    return \"\";\n");
      out.write("  }\n");
      out.write("        \n");
      out.write("   document.onkeypress = handleKey;\n");
      out.write("  // -->\n");
      out.write("</script>\n");
      out.write("\n");
      out.write("<script language=\"JavaScript1.2\" type=\"text/javascript\" src='");
      if (_jspx_meth_html_005frewrite_005f6(_jspx_page_context))
        return;
      out.write("'></script>\n");
      out.write("<script language=\"JavaScript1.2\" type=\"text/javascript\" src='");
      if (_jspx_meth_html_005frewrite_005f7(_jspx_page_context))
        return;
      out.write("'></script>\n");
      out.write("<script type=\"text/javascript\" src='");
      if (_jspx_meth_html_005frewrite_005f8(_jspx_page_context))
        return;
      out.write("'></script>\n");
      out.write("\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("registerHook(\"afterLoad\",\n");
      out.write("  function() {\n");
      out.write("    var body = document.getElementById('body');\n");
      out.write("    if(!body){\n");
      out.write("      body = document.getElementsByName('body')[0];\n");
      out.write("    }\n");
      out.write("    if(!body){\n");
      out.write("      body = document.getElementsByTagName('body')[0];\n");
      out.write("    }\n");
      out.write("    morphclass(body,'invisible','');\n");
      out.write("    return true;\n");
      out.write("  }\n");
      out.write(");\n");
      out.write("</script>\n");
      out.write("\n");
      if (_jspx_meth_template_005fserviceParameter_005f2(_jspx_page_context))
        return;
      out.write("\n");
      out.write("\n");
      out.write("</head>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
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

  private boolean _jspx_meth_template_005fserviceParameter_005f0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  template:serviceParameter
    neo.taglib.template.ServiceParameterTag _jspx_th_template_005fserviceParameter_005f0 = (neo.taglib.template.ServiceParameterTag) _005fjspx_005ftagPool_005ftemplate_005fserviceParameter_0026_005fname_005fnobody.get(neo.taglib.template.ServiceParameterTag.class);
    _jspx_th_template_005fserviceParameter_005f0.setPageContext(_jspx_page_context);
    _jspx_th_template_005fserviceParameter_005f0.setParent(null);
    // /WEB-INF/pages/framework/frame/header.jsp(13,9) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_template_005fserviceParameter_005f0.setName("areamap-frame-header-title");
    int _jspx_eval_template_005fserviceParameter_005f0 = _jspx_th_template_005fserviceParameter_005f0.doStartTag();
    if (_jspx_th_template_005fserviceParameter_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005ftemplate_005fserviceParameter_0026_005fname_005fnobody.reuse(_jspx_th_template_005fserviceParameter_005f0);
      return true;
    }
    _005fjspx_005ftagPool_005ftemplate_005fserviceParameter_0026_005fname_005fnobody.reuse(_jspx_th_template_005fserviceParameter_005f0);
    return false;
  }

  private boolean _jspx_meth_html_005frewrite_005f2(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:rewrite
    org.apache.struts.taglib.html.RewriteTag _jspx_th_html_005frewrite_005f2 = (org.apache.struts.taglib.html.RewriteTag) _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.get(org.apache.struts.taglib.html.RewriteTag.class);
    _jspx_th_html_005frewrite_005f2.setPageContext(_jspx_page_context);
    _jspx_th_html_005frewrite_005f2.setParent(null);
    // /WEB-INF/pages/framework/frame/header.jsp(26,34) name = page type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005frewrite_005f2.setPage("/images/escenic-content-engine-fav.png");
    int _jspx_eval_html_005frewrite_005f2 = _jspx_th_html_005frewrite_005f2.doStartTag();
    if (_jspx_th_html_005frewrite_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.reuse(_jspx_th_html_005frewrite_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.reuse(_jspx_th_html_005frewrite_005f2);
    return false;
  }

  private boolean _jspx_meth_template_005fserviceParameter_005f1(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  template:serviceParameter
    neo.taglib.template.ServiceParameterTag _jspx_th_template_005fserviceParameter_005f1 = (neo.taglib.template.ServiceParameterTag) _005fjspx_005ftagPool_005ftemplate_005fserviceParameter_0026_005fname_005fnobody.get(neo.taglib.template.ServiceParameterTag.class);
    _jspx_th_template_005fserviceParameter_005f1.setPageContext(_jspx_page_context);
    _jspx_th_template_005fserviceParameter_005f1.setParent(null);
    // /WEB-INF/pages/framework/frame/header.jsp(27,2) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_template_005fserviceParameter_005f1.setName("areamap-frame-header-head");
    int _jspx_eval_template_005fserviceParameter_005f1 = _jspx_th_template_005fserviceParameter_005f1.doStartTag();
    if (_jspx_th_template_005fserviceParameter_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005ftemplate_005fserviceParameter_0026_005fname_005fnobody.reuse(_jspx_th_template_005fserviceParameter_005f1);
      return true;
    }
    _005fjspx_005ftagPool_005ftemplate_005fserviceParameter_0026_005fname_005fnobody.reuse(_jspx_th_template_005fserviceParameter_005f1);
    return false;
  }

  private boolean _jspx_meth_html_005frewrite_005f3(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:rewrite
    org.apache.struts.taglib.html.RewriteTag _jspx_th_html_005frewrite_005f3 = (org.apache.struts.taglib.html.RewriteTag) _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.get(org.apache.struts.taglib.html.RewriteTag.class);
    _jspx_th_html_005frewrite_005f3.setPageContext(_jspx_page_context);
    _jspx_th_html_005frewrite_005f3.setParent(null);
    // /WEB-INF/pages/framework/frame/header.jsp(53,34) name = page type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005frewrite_005f3.setPage("/");
    int _jspx_eval_html_005frewrite_005f3 = _jspx_th_html_005frewrite_005f3.doStartTag();
    if (_jspx_th_html_005frewrite_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.reuse(_jspx_th_html_005frewrite_005f3);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.reuse(_jspx_th_html_005frewrite_005f3);
    return false;
  }

  private boolean _jspx_meth_html_005frewrite_005f4(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:rewrite
    org.apache.struts.taglib.html.RewriteTag _jspx_th_html_005frewrite_005f4 = (org.apache.struts.taglib.html.RewriteTag) _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.get(org.apache.struts.taglib.html.RewriteTag.class);
    _jspx_th_html_005frewrite_005f4.setPageContext(_jspx_page_context);
    _jspx_th_html_005frewrite_005f4.setParent(null);
    // /WEB-INF/pages/framework/frame/header.jsp(75,32) name = page type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005frewrite_005f4.setPage("/base/forward.do");
    int _jspx_eval_html_005frewrite_005f4 = _jspx_th_html_005frewrite_005f4.doStartTag();
    if (_jspx_th_html_005frewrite_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.reuse(_jspx_th_html_005frewrite_005f4);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.reuse(_jspx_th_html_005frewrite_005f4);
    return false;
  }

  private boolean _jspx_meth_html_005frewrite_005f5(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:rewrite
    org.apache.struts.taglib.html.RewriteTag _jspx_th_html_005frewrite_005f5 = (org.apache.struts.taglib.html.RewriteTag) _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.get(org.apache.struts.taglib.html.RewriteTag.class);
    _jspx_th_html_005frewrite_005f5.setPageContext(_jspx_page_context);
    _jspx_th_html_005frewrite_005f5.setParent(null);
    // /WEB-INF/pages/framework/frame/header.jsp(78,30) name = page type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005frewrite_005f5.setPage("/base/forward.do");
    int _jspx_eval_html_005frewrite_005f5 = _jspx_th_html_005frewrite_005f5.doStartTag();
    if (_jspx_th_html_005frewrite_005f5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.reuse(_jspx_th_html_005frewrite_005f5);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.reuse(_jspx_th_html_005frewrite_005f5);
    return false;
  }

  private boolean _jspx_meth_html_005frewrite_005f6(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:rewrite
    org.apache.struts.taglib.html.RewriteTag _jspx_th_html_005frewrite_005f6 = (org.apache.struts.taglib.html.RewriteTag) _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.get(org.apache.struts.taglib.html.RewriteTag.class);
    _jspx_th_html_005frewrite_005f6.setPageContext(_jspx_page_context);
    _jspx_th_html_005frewrite_005f6.setParent(null);
    // /WEB-INF/pages/framework/frame/header.jsp(177,61) name = page type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005frewrite_005f6.setPage("/script/roundedbox.js");
    int _jspx_eval_html_005frewrite_005f6 = _jspx_th_html_005frewrite_005f6.doStartTag();
    if (_jspx_th_html_005frewrite_005f6.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.reuse(_jspx_th_html_005frewrite_005f6);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.reuse(_jspx_th_html_005frewrite_005f6);
    return false;
  }

  private boolean _jspx_meth_html_005frewrite_005f7(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:rewrite
    org.apache.struts.taglib.html.RewriteTag _jspx_th_html_005frewrite_005f7 = (org.apache.struts.taglib.html.RewriteTag) _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.get(org.apache.struts.taglib.html.RewriteTag.class);
    _jspx_th_html_005frewrite_005f7.setPageContext(_jspx_page_context);
    _jspx_th_html_005frewrite_005f7.setParent(null);
    // /WEB-INF/pages/framework/frame/header.jsp(178,61) name = page type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005frewrite_005f7.setPage("/script/menu.js");
    int _jspx_eval_html_005frewrite_005f7 = _jspx_th_html_005frewrite_005f7.doStartTag();
    if (_jspx_th_html_005frewrite_005f7.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.reuse(_jspx_th_html_005frewrite_005f7);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.reuse(_jspx_th_html_005frewrite_005f7);
    return false;
  }

  private boolean _jspx_meth_html_005frewrite_005f8(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:rewrite
    org.apache.struts.taglib.html.RewriteTag _jspx_th_html_005frewrite_005f8 = (org.apache.struts.taglib.html.RewriteTag) _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.get(org.apache.struts.taglib.html.RewriteTag.class);
    _jspx_th_html_005frewrite_005f8.setPageContext(_jspx_page_context);
    _jspx_th_html_005frewrite_005f8.setParent(null);
    // /WEB-INF/pages/framework/frame/header.jsp(179,36) name = page type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_html_005frewrite_005f8.setPage("/script/minmax.js");
    int _jspx_eval_html_005frewrite_005f8 = _jspx_th_html_005frewrite_005f8.doStartTag();
    if (_jspx_th_html_005frewrite_005f8.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.reuse(_jspx_th_html_005frewrite_005f8);
      return true;
    }
    _005fjspx_005ftagPool_005fhtml_005frewrite_0026_005fpage_005fnobody.reuse(_jspx_th_html_005frewrite_005f8);
    return false;
  }

  private boolean _jspx_meth_template_005fserviceParameter_005f2(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  template:serviceParameter
    neo.taglib.template.ServiceParameterTag _jspx_th_template_005fserviceParameter_005f2 = (neo.taglib.template.ServiceParameterTag) _005fjspx_005ftagPool_005ftemplate_005fserviceParameter_0026_005fname_005fnobody.get(neo.taglib.template.ServiceParameterTag.class);
    _jspx_th_template_005fserviceParameter_005f2.setPageContext(_jspx_page_context);
    _jspx_th_template_005fserviceParameter_005f2.setParent(null);
    // /WEB-INF/pages/framework/frame/header.jsp(198,0) name = name type = null reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_template_005fserviceParameter_005f2.setName("areamap-frame-header-prebody");
    int _jspx_eval_template_005fserviceParameter_005f2 = _jspx_th_template_005fserviceParameter_005f2.doStartTag();
    if (_jspx_th_template_005fserviceParameter_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _005fjspx_005ftagPool_005ftemplate_005fserviceParameter_0026_005fname_005fnobody.reuse(_jspx_th_template_005fserviceParameter_005f2);
      return true;
    }
    _005fjspx_005ftagPool_005ftemplate_005fserviceParameter_0026_005fname_005fnobody.reuse(_jspx_th_template_005fserviceParameter_005f2);
    return false;
  }
}
