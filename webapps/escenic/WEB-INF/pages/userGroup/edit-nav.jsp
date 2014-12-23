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
<bean:define id="checker" name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<% 
    
boolean globalAdmin = checker.isPublicationAdmin();

java.util.Vector menuItems = new java.util.Vector();
java.util.HashMap menuItem = new java.util.HashMap();
menuItem.put("type", "panel");
%>

<% 
// menuItem.put("label", "Members");
menuItem.put("label", RequestUtils.message(pageContext, null, null, "a.usergroup.members", null));
menuItem.put("link", "javascript:submitForm('editMembers')");
if( ((String)request.getAttribute("task")).equals("/userGroup/editMembers")) {
  menuItem.put("selected", "true");
} else {menuItem.put("selected", "false");
}
menuItems.add(new java.util.HashMap(menuItem));

// menuItem.put("label", "Groups");
menuItem.put("label", RequestUtils.message(pageContext, null, null, "a.usergroup.groups", null));
menuItem.put("link", "javascript:submitForm('editGroups')");
if( ((String)request.getAttribute("task")).equals("/userGroup/editGroups")) {
  menuItem.put("selected", "true");
} else {menuItem.put("selected", "false");
}
menuItems.add(new java.util.HashMap(menuItem));

// menuItem.put("label", "GlobalRoles");
menuItem.put("label", RequestUtils.message(pageContext, null, null, "a.usergroup.globalRoles", null));
menuItem.put("link", "javascript:submitForm('editGlobalRoles')");
if( ((String)request.getAttribute("task")).equals("/userGroup/editGlobalRoles")) {
  menuItem.put("selected", "true");
} else {menuItem.put("selected", "false");
}
menuItems.add(new java.util.HashMap(menuItem));


// menuItem.put("label", "Section roles");
menuItem.put("label", RequestUtils.message(pageContext, null, null, "a.usergroup.sectionRoles", null));
menuItem.put("link", "javascript:submitForm('editRoles')");
if( ((String)request.getAttribute("task")).equals("/userGroup/editRoles")) {
  menuItem.put("selected", "true");
} else {menuItem.put("selected", "false");
}
menuItems.add(new java.util.HashMap(menuItem));

if(globalAdmin){
  // tag structures
  menuItem.put("label", RequestUtils.message(pageContext, null, null, "a.person.tags", null));
  menuItem.put("link", "javascript:submitForm('editTagStructures')");
  if( ((String)request.getAttribute("task")).equals("/userGroup/editTagStructures")) {
    menuItem.put("selected", "true");
  } else {menuItem.put("selected", "false");
  }
  menuItems.add(new java.util.HashMap(menuItem));

  // content types
  menuItem.put("label", RequestUtils.message(pageContext, null, null, "a.person.contentTypes", null));
  menuItem.put("link", "javascript:submitForm('editContentTypes')");
  if( ((String)request.getAttribute("task")).equals("/userGroup/editContentTypes")) {
    menuItem.put("selected", "true");
  } else {menuItem.put("selected", "false");
  }
  menuItems.add(new java.util.HashMap(menuItem));
}
    
menuItem.put("type", "space");
menuItem.put("size", "4");
menuItems.add(new java.util.HashMap(menuItem));
menuItem.put("type", "panel");

/*

menuItem.put("label", "Cancel");
menuItem.put("link", "javascript:submitForm('cancel')");
menuItem.put("selected", "false");
menuItems.add(new java.util.HashMap(menuItem));

menuItem.put("label", "Save");
menuItem.put("link", "javascript:submitForm('save')");
menuItem.put("selected", "false");
menuItems.add(new java.util.HashMap(menuItem));

*/
%>

<%
menuItem.put("type", "menu");
menuItem.put("size", "100");
if(request.getAttribute("disablePanelMenu")!=null&&request.getAttribute("disablePanelMenu").equals("true") ) {
	menuItem.put("file", "/WEB-INF/pages/userGroup/save-menu-disabled.jsp");
} else {
	menuItem.put("file", "/WEB-INF/pages/userGroup/save-menu.jsp");
}
menuItems.add(new java.util.HashMap(menuItem));
%>

<% request.setAttribute("menuItems", menuItems); %>
<template:call file="/WEB-INF/pages/framework/panelMenu.jsp"/> 
