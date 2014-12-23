<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %><%@ 
taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %><%@
taglib uri="http://struts.apache.org/tags-html" prefix="html" %><%@
taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %><%@
taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %><%@
taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %><%@
page import="org.apache.struts.util.*" %>

<bean:define id="form" name="neo.phoenix.section.SectionForm" type="neo.phoenix.section.SectionForm"/>
<% boolean readOnly = neo.util.StringUtil.getBoolean(form.getReadOnly());%>

<%
java.util.Vector menuItems = new java.util.Vector();
java.util.HashMap menuItem = new java.util.HashMap();
menuItem.put("type", "panel");
%>

<%
menuItem.put("type", "menu");
menuItem.put("size", "100");
menuItem.put("file", "/WEB-INF/pages/section/edit-details.jsp");
menuItems.add(new java.util.HashMap(menuItem));
menuItem.put("type", "panel");
menuItem.remove("file");
menuItem.remove("size");
%>

<% 
menuItem.put("label", RequestUtils.message(pageContext, null, null, "t.Edit", null));
menuItem.put("link", "javascript:submitForm('edit')");
if( ((String)request.getAttribute("task")).equals("/section/edit")) {
  menuItem.put("selected", "true");
} else {menuItem.put("selected", "false");
}
menuItems.add(new java.util.HashMap(menuItem));

if(!neo.util.StringUtil.getBoolean(form.getIsVirtual())){  
  menuItem.put("label", RequestUtils.message(pageContext, null, null, "t.Sharing", null));
  menuItem.put("link", "javascript:submitForm('share')");
  if( ((String)request.getAttribute("task")).equals("/section/edit/share")) {
    menuItem.put("selected", "true");
  } else {menuItem.put("selected", "false");
  }
  menuItems.add(new java.util.HashMap(menuItem));
}
%>


<%
menuItem.put("type", "menu");
menuItem.put("size", "100");
if(request.getAttribute("disablePanelMenu")!=null&&request.getAttribute("disablePanelMenu").equals("true") ) {
	menuItem.put("file", "/WEB-INF/pages/section/save-menu-disabled.jsp");
} else {
	menuItem.put("file", "/WEB-INF/pages/section/save-menu.jsp");
}
menuItems.add(new java.util.HashMap(menuItem));
%>
<% request.setAttribute("menuItems", menuItems); %>
<template:call file="/WEB-INF/pages/framework/panelMenu.jsp"/> 
