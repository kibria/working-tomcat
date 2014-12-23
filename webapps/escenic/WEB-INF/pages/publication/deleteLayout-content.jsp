<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<!-- viewTemplates.jsp -->
<%@ page language="java" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>

<%@ page import="neo.xredsys.content.layout.*, neo.xredsys.content.*, neo.xredsys.*, java.io.*" %>

<bean:define id="publication" 
             name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<input type="hidden" name="submitButton" value="success">
<input type="hidden" name="validateInput" value="success">
<input type="hidden" name="validateField" value="none">

<%--
  TemplateManager TM = TemplateManager.getTemplateManager();

  String ids = request.getParameter("layoutId");
  int layoutId = -1;
  if (ids != null) layoutId = Integer.parseInt(ids); 
  out.println("Deleting layout " + ids + " ...");

  TM.Layout(layoutId,publication.getId());
--%>
<%
  TemplateManager TM = TemplateManager.getTemplateManager();
  LayoutManager LM = LayoutManager.getLayoutManager();

  String ids = request.getParameter("layoutId");
  int layoutId = -1;
  if (ids != null) layoutId = Integer.parseInt(ids); 
  // out.println("Deleting layout " + ids);

  Layout l = LM.getLayout(layoutId);
  String fileName = l.getFileName();
  String name = l.getName();
  int type = l.getLayoutType();
  int index = fileName.lastIndexOf("/");
  fileName = fileName.substring(index);

  neo.xredsys.Publication publ = neo.xredsys.content.PublicationManager.getPublicationManager().getPublication(publication.getId());
  
  if (l.isUsed()) {
    out.println("Layout is in use");
  }
  else if (l.isUsedInPreview()) {
    out.println("Layout is used in preview");
  }
  else {
    publ.removeLayout(layoutId);
    out.println("Removed template information from database<BR/><BR/>");
    if (LM.getLayout(name, type, publ.getPublicationID()) == null) {
      out.println("The template file " + fileName + " can be deleted.<BR/><BR/>");
    }
    
    // reinitialize the template manager
    TemplateManager.getTemplateManager().initialize();
    out.println("Template has been successfully deleted<BR/>");
  }
%>

<%!


%>
<!-- Finished call to frame -->
<!-- End of viewTemplates.jsp  -->
