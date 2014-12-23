<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %><%@
taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %><%@
taglib uri="http://struts.apache.org/tags-html" prefix="html" %><%@
taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %><%@
taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %><%@
taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %><%@
page import="org.apache.struts.util.*" %><%@
page import="org.apache.struts.action.*" %><bean:define
id="publication" name="escenic-publication" scope="session" type="neo.xredsys.api.Publication"/>
<bean:define id="checker" name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<bean:define id="task" name="task" type="java.lang.String" />

<%
java.util.Vector menuItems = new java.util.Vector();
java.util.HashMap menuItem = new java.util.HashMap();
menuItem.put("type", "panel");
%>

<%

if(checker.isGlobalPublicationAdmin(publication.getId())) {
menuItem.put("label", RequestUtils.message(pageContext, null, null, "a.publication.administer", null));
menuItem.put("link", request.getContextPath()+"/publication/view.do");

if( ((String)request.getAttribute("task")).equals("/publication/view")) {
  menuItem.put("selected", "true");
} else {menuItem.put("selected", "false");
}
menuItems.add(new java.util.HashMap(menuItem));

menuItem.put("label", RequestUtils.message(pageContext, null, null, "a.publication.articleTypes", null));
menuItem.put("link", request.getContextPath()+"/publication/viewArticleTypes.do");

if( ((String)request.getAttribute("task")).equals("/publication/viewArticleTypes")) {
  menuItem.put("selected", "true");
} else {menuItem.put("selected", "false");
}
menuItems.add(new java.util.HashMap(menuItem));

menuItem.put("label", RequestUtils.message(pageContext, null, null, "m.admin.Templates", null));
menuItem.put("link", request.getContextPath()+"/publication/viewTemplates.do");
if( ((String)request.getAttribute("task")).equals("/publication/viewTemplates")) {
  menuItem.put("selected", "true");
} else {menuItem.put("selected", "false");
}
menuItems.add(new java.util.HashMap(menuItem));

menuItem.put("label", RequestUtils.message(pageContext, null, null, "a.publication.features", null));
menuItem.put("link", request.getContextPath()+"/publication/viewFeatures.do");
if( ((String)request.getAttribute("task")).equals("/publication/viewFeatures")) {
  menuItem.put("selected", "true");
} else {menuItem.put("selected", "false");
}
menuItems.add(new java.util.HashMap(menuItem));




menuItem.put("label", RequestUtils.message(pageContext, null, null, "a.publication.importArticles", null));
menuItem.put("link", request.getContextPath()+"/publication/xmlimport.do");
if( ((String)request.getAttribute("task")).equals("/publication/xmlimport")) {
  menuItem.put("selected", "true");
} else {menuItem.put("selected", "false");
}
menuItems.add(new java.util.HashMap(menuItem));

menuItem.put("label", RequestUtils.message(pageContext, null, null, "a.publication.exportUsers", null));
menuItem.put("link", request.getContextPath()+"/publication/editFriendlyPubs.do");
if( ((String)request.getAttribute("task")).equals("/publication/exportUsers")) {
  menuItem.put("selected", "true");
} else {menuItem.put("selected", "false");
}
menuItems.add(new java.util.HashMap(menuItem));
}
%>

<% request.setAttribute("menuItems", menuItems); %>
<template:call file="/WEB-INF/pages/framework/panelMenu.jsp"/>