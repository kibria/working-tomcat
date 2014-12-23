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

<bean:define id="form" name="neo.phoenix.section.SectionMembersForm" type="neo.phoenix.section.SectionMembersForm"/>
<%
java.util.Vector menuItems = new java.util.Vector();
java.util.HashMap menuItem = new java.util.HashMap();
menuItem.put("type", "panel");
%>

<% 
menuItem.put("label", RequestUtils.message(pageContext, null, null, "a.section.users", null));
menuItem.put("link", "javascript:submitForm('editMembers')");
if( ((String)request.getAttribute("task")).equals("/section/editMembers")) {
  menuItem.put("selected", "true");
} else {menuItem.put("selected", "false");
}
menuItems.add(new java.util.HashMap(menuItem));

menuItem.put("label", RequestUtils.message(pageContext, null, null, "a.section.groups", null));
menuItem.put("link", "javascript:submitForm('editGroups')");
if( ((String)request.getAttribute("task")).equals("/section/editGroups")) {
  menuItem.put("selected", "true");
} else {menuItem.put("selected", "false");
}
menuItems.add(new java.util.HashMap(menuItem));


menuItem.put("type", "space");
menuItem.put("size", "4");
menuItems.add(new java.util.HashMap(menuItem));
menuItem.put("type", "panel");

boolean isChild = !neo.util.StringUtil.isEmpty(form.getParentWorkItemId());
/*
menuItem.put("label", "Cancel");
if(!isChild){
  menuItem.put("link", "javascript:submitForm('cancel')");
}else{
  menuItem.put("link", "javascript:submitForm('cancelAsChild')");
}
menuItem.put("selected", "false");
menuItems.add(new java.util.HashMap(menuItem));

menuItem.put("label", "Save");
if(!isChild){
  menuItem.put("link", "javascript:submitForm('save')");
}else{
  menuItem.put("link", "javascript:submitForm('saveAsChild')");
}
menuItem.put("selected", "false");
menuItems.add(new java.util.HashMap(menuItem));
*/
%>



<%
menuItem.put("type", "menu");
menuItem.put("size", "100");
if(request.getAttribute("disablePanelMenu")!=null&&request.getAttribute("disablePanelMenu").equals("true") ) {
	menuItem.put("file", "/WEB-INF/pages/section/save-menu-disabled.jsp");
} else {
	menuItem.put("file", "/WEB-INF/pages/section/editMembers-save-menu.jsp");
}
menuItems.add(new java.util.HashMap(menuItem));
%>

<% request.setAttribute("menuItems", menuItems); %>
<template:call file="/WEB-INF/pages/framework/panelMenu.jsp"/> 
