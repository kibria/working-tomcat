package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import com.escenic.auth.jaas.oauth2.OAuth2ProviderConfiguration;
import neo.nursery.GlobalBus;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

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
      out.write("<html>\n");
      out.write("  <head>\n");
      out.write("    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=ISO-8859-1\">\n");
      out.write("    <title>Escenic Content Studio Webstart!</title>\n");
      out.write("    <link rel=\"shortcut icon\" href=\"images/favicon.ico\" type=\"image/x-icon\">\n");
      out.write("    <link rel=\"icon\" href=\"images/favicon.png\" sizes=\"32x32\">\n");
      out.write("    <script>\n");
      out.write("      function alt() {\n");
      out.write("        var options = document.getElementById('options');\n");
      out.write("        var element = document.getElementById('alt');\n");
      out.write("        element.parentNode.removeChild(element);\n");
      out.write("        options.className = \"open\";\n");
      out.write("      }\n");
      out.write("    \tfunction sync(lang) {\n");
      out.write("        var langItem = document.getElementById('lang');\n");
      out.write("        langItem.value = lang;\n");
      out.write("\t\t  }\n");
      out.write("    </script>\n");
      out.write("    <style>\n");
      out.write("      body {margin: 0; padding: 0; font-family: \"lucida grande\",arial,sans-serif; font-size: 12px; color: #666666;}\n");
      out.write("      .header {text-align: center; background-color: #444444; margin: 100px 0 20px 0;}\n");
      out.write("      .buttons {width: 300px; margin: 0 auto;}\n");
      out.write("      .buttons .head {text-align: center; font-size: 22px; color: #444444; margin: 30px 0;}\n");
      out.write("\n");
      out.write("      #options {max-height: 0; overflow: hidden; -webkit-transition: max-height 0.8s; -moz-transition: max-height 0.8s; transition: max-height 0.8s;}\n");
      out.write("      #options.open {max-height: 1000px;}\n");
      out.write("      \n");
      out.write("\n");
      out.write("      #alt {text-align: right;}\n");
      out.write("      #alt a {color: #888888;}\n");
      out.write("\n");
      out.write("      ul {margin: 0; padding: 10px 0;}\n");
      out.write("      li { list-style: none; margin: 0 0 0.5em 1em;}\n");
      out.write("      input[type='submit']{\n");
      out.write("        width: 100%;\n");
      out.write("        border: 0;\n");
      out.write("        color: #444444;\n");
      out.write("        background-color: #dedede;\n");
      out.write("        text-transform: capitalize;\n");
      out.write("        font-size: 3em;\n");
      out.write("        line-height: 2em;\n");
      out.write("        cursor: pointer;\n");
      out.write("        border-bottom: 1px solid rgba(0,0,0,0.1);\n");
      out.write("        vertical-align: bottom;\n");
      out.write("        text-rendering: optimizeLegibility;\n");
      out.write("        -webkit-user-select: none;\n");
      out.write("        -khtml-user-select: none;\n");
      out.write("        -moz-user-select: none;\n");
      out.write("        -ms-user-select: none;\n");
      out.write("        user-select: none;\n");
      out.write("        -webkit-box-sizing: border-box;\n");
      out.write("        -moz-box-sizing: border-box;\n");
      out.write("        box-sizing: border-box;\n");
      out.write("        -webkit-border-radius: 3px;\n");
      out.write("        -moz-border-radius: 3px;\n");
      out.write("        border-radius: 3px;\n");
      out.write("        -webkit-transition: all .1s ease;\n");
      out.write("        -moz-transition: all .1s ease;\n");
      out.write("        -ms-transition: all .1s ease;\n");
      out.write("        -o-transition: all .1s ease;\n");
      out.write("        transition: all .1s ease;\n");
      out.write("      }\n");
      out.write("      input[type='submit']:hover {\n");
      out.write("        color: #FFFFFF;\n");
      out.write("        background-color: #ff752d;\n");
      out.write("      }\n");
      out.write("      input[type='submit']:active {\n");
      out.write("        color: #FFFFFF;\n");
      out.write("        background-color: #fcb088;\n");
      out.write("      }\n");
      out.write("    </style>\n");
      out.write("  </head>\n");
      out.write("  \n");
      out.write("  <body>\n");
      out.write("    <div class=\"header\">\n");
      out.write("      <img src=\"images/escenic_ws_logo.png\" alt=\"Escenic Content Studio\" />\n");
      out.write("    </div>\n");
      out.write("    <div class=\"buttons\">\n");
      out.write("      <div class=\"head\">Launch Content Studio</div>\n");
      out.write("\n");
      out.write("      <form id=\"frm\" action=\"Studio.jnlp\" method=\"get\">\n");
      out.write("        <div id=\"options\">\n");
      out.write("          Language:\n");
      out.write("          <ul>\n");
      out.write("            <li><input type=\"radio\" name=\"user.country\" value=\"\" onclick=\"sync()\" checked/> Detect Language</li>\n");
      out.write("            <li><input type=\"radio\" name=\"user.country\" value=\"US\" onclick=\"sync('en')\" /> English (American dates)</li>\n");
      out.write("            <li><input type=\"radio\" name=\"user.country\" value=\"GB\" onclick=\"sync('en')\" /> English (British dates)</li>\n");
      out.write("            <li><input type=\"radio\" name=\"user.country\" value=\"DE\" onclick=\"sync('de')\" /> German</li>\n");
      out.write("            <li><input type=\"radio\" name=\"user.country\" value=\"NL\" onclick=\"sync('nl')\" /> Dutch</li>\n");
      out.write("            <li><input type=\"radio\" name=\"user.country\" value=\"SE\" onclick=\"sync('sv')\" /> Swedish</li>\n");
      out.write("            <li><input type=\"radio\" name=\"user.country\" value=\"NO\" onclick=\"sync('nb')\" /> Norwegian</li>\n");
      out.write("          </ul>\n");
      out.write("          <input type=\"hidden\" id=\"lang\" name=\"user.language\" value=\"\"/>\n");
      out.write("          Login type:\n");
      out.write("          <ul>\n");
      out.write("          ");

            OAuth2ProviderConfiguration configuration = (OAuth2ProviderConfiguration) GlobalBus.lookupSafe("/com/escenic/auth/oauth2/OAuth2Configuration");
            if (configuration != null && configuration.getClientIdAndSecretFor("application") != null) {
          
      out.write("\n");
      out.write("            <li><input type=\"radio\" name=\"com.escenic.sso.enabled\" value=\"true\" checked/> ");
      out.print(configuration.getName());
      out.write("</li>\n");
      out.write("            <li><input type=\"radio\" name=\"com.escenic.sso.enabled\" value=\"false\" /> Username & Password</li>\n");
      out.write("            ");
} else { 
      out.write("\n");
      out.write("            <li><input type=\"radio\" name=\"com.escenic.sso.enabled\" value=\"false\" checked/> Username & Password</li>\n");
      out.write("            ");
} 
      out.write("\n");
      out.write("          </ul>\n");
      out.write("          <input type=\"hidden\" name=\"com.escenic.sso.provider\" value=\"Google\" id=\"provider\"/>\n");
      out.write("        </div>\n");
      out.write("        <input type=\"submit\" value=\"Start\"/>\n");
      out.write("      </form>\n");
      out.write("      <div id=\"alt\"><a href=\"javascript: alt();\">Alternative login</a></div>\n");
      out.write("    </div>\n");
      out.write("  </body>\n");
      out.write("</html>\n");
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
