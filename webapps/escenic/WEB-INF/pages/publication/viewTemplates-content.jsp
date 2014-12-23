<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<!-- viewTemplates-content.jsp -->
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ page import="neo.xredsys.content.layout.*, neo.xredsys.Layout, java.util.*" %>
<%@ page import="neo.nursery.GlobalBus" %>
<%@ page import="com.escenic.domain.index.GroupDescriptor" %>
<%@ page import="com.escenic.domain.index.AreaDescriptor" %>

<bean:define id="publication"
             name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<input type="hidden" name="submitButton" value="success">
<input type="hidden" name="validateInput" value="success">
<input type="hidden" name="validateField" value="none">
<br />
<%
  TemplateManager TM = TemplateManager.getTemplateManager();
  LayoutGroupDefinitionManager lgdm = (LayoutGroupDefinitionManager) GlobalBus.lookupSafe("/neo/io/managers/LayoutGroupDefinitionManager");

  neo.xredsys.Publication iopubl = neo.xredsys.content.PublicationManager.getPublicationManager().getPublication(publication.getId());
  int ARTICLE_LAYOUT = LayoutManager.getLayoutManager().getLayoutType("article");
  int GRID_LAYOUT = LayoutManager.getLayoutManager().getLayoutType("frontpage_content");
  int ELEMENT_LAYOUT = LayoutManager.getLayoutManager().getLayoutType("frontpage_element");
  int SECTION_LAYOUT = LayoutManager.getLayoutManager().getLayoutType("section");
%>

<p>Layoutgroups</p>
<ul>
  <%
    for (Map.Entry<String, GroupDescriptor> entry : lgdm.getLayoutGroupDescriptors(publication.getId()).entrySet()) {
      out.println("<li title=\"" + (entry.getValue().getDescription() == null ? "" : entry.getValue().getDescription()) + "\">"
              + entry.getValue().getLabel() + " (isRoot:" + entry.getValue().isRoot() + ")");
      out.println("<ul>");
      for (AreaDescriptor area : entry.getValue().getAreaDescriptors()) {
        out.println("<li title=\"" + (area.getDescription() == null ? "" : area.getDescription()) + "\">");
        out.println(area.getLabel());
        out.println("</li>");
      }
      out.println("</ul>");
      out.println("</li>");
    }
  %>
</ul>

<%-- Section Templates --%>
<P><bean:message key="t.Section_templates"/></P>
<UL>
<%
  Vector secLayouts = iopubl.getLayouts(SECTION_LAYOUT);
  for (int i = 0; i < secLayouts.size(); i++) {
    Layout secLayout = (Layout) secLayouts.elementAt(i);
    AbstractLayoutComponent alc = TM.getLayout(secLayout.getLayoutID());
    boolean isDeclared = (alc != null && alc.isDeclared());
    boolean isUsed = secLayout.isUsed();
    out.println("<LI>" + secLayout.getName() + " (id:" + secLayout.getLayoutID() +
       ", isUsed:" + isUsed + ", isDeclared:" + isDeclared + ")");
    if (!isUsed && !isDeclared) {
      %>
      <html:link page='<%="/publication/deleteLayout.do?layoutId="+secLayout.getLayoutID()%>'>
        delete
      </html:link>
     <%
   }
  }
%>
</UL>

<%-- Article Templates --%>
<P><bean:message key="t.Article_templates"/></P>
<UL>
<%
   Layout l;
   Vector articleLayouts = iopubl.getLayouts(ARTICLE_LAYOUT);
   for (int i = 0; i < articleLayouts.size(); i++) {
     l = (Layout) articleLayouts.elementAt(i);
     boolean isUsed = l.isUsed();
     out.println("<LI>" + l.getName() + " (id:" + l.getLayoutID() +
        ", isUsed:" + isUsed + ", isDeclared:false)");
     if (!isUsed) {
      %>
      <html:link page='<%="/publication/deleteLayout.do?layoutId="+l.getLayoutID()%>'>
        delete
      </html:link>
     <%
    }
   }
%>
</UL>

<hr/>
<p><b>Deprecated templates</b></p>
<%-- Grid Templates --%>
<P><bean:message key="t.Colomn_templates"/></P>
<UL>
<%
  Vector gridLayouts = iopubl.getLayouts(GRID_LAYOUT);
  for (int i = 0; i < gridLayouts.size(); i++) {
    Layout gridLayout = (Layout) gridLayouts.elementAt(i);
    AbstractLayoutComponent alc = TM.getLayout(gridLayout.getLayoutID());
    boolean isDeclared = (alc != null && alc.isDeclared());
    boolean isUsed = gridLayout.isUsed();
    out.println("<LI>" + gridLayout.getName() + " (id:" + gridLayout.getLayoutID() +
       ", isUsed:" + isUsed + ", isDeclared:" + isDeclared + ")");
    if (!isUsed && !isDeclared) {
      %>
      <html:link page='<%="/publication/deleteLayout.do?layoutId="+gridLayout.getLayoutID()%>'>
        delete
      </html:link>
     <%
   }
  }
%>
</UL>


<%-- Element Templates --%>
<P><bean:message key="t.Element_templates"/></P>
<UL>
<%
  Vector elementLayouts = iopubl.getLayouts(ELEMENT_LAYOUT);
  for (int i = 0; i < elementLayouts.size(); i++) {
    Layout elementLayout = (Layout) elementLayouts.elementAt(i);
    AbstractLayoutComponent alc = TM.getLayout(elementLayout.getLayoutID());
    boolean isDeclared = (alc != null && alc.isDeclared());
    boolean isUsed = elementLayout.isUsed();
    out.println("<LI>" + elementLayout.getName() + " (id:" + elementLayout.getLayoutID() +
       ", isUsed:" + isUsed + ", isDeclared:" + isDeclared + ")");
    if (!isUsed && !isDeclared) {
      %>
      <html:link page='<%="/publication/deleteLayout.do?layoutId="+elementLayout.getLayoutID()%>'>
        delete
      </html:link>
     <%
   }
  }
%>
</UL>

