<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %><%@ 
taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %><%@
taglib uri="http://struts.apache.org/tags-html" prefix="html" %><%@
taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %><%@
taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %><%@
taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %><%@
page import="org.apache.struts.util.*,
             neo.xredsys.api.Person,
             neo.xredsys.api.IOAPI" %>

<bean:define id="form" name="neo.phoenix.person.PersonForm" type="neo.phoenix.person.PersonForm"/>
<bean:define id="checker"
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<bean:define id="user" 
             name="escenic-user" scope="session" type="neo.xredsys.api.User" />
<bean:define id="publication" 
             name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<%
    request.setAttribute("form", form);
%>

<% 
java.util.Vector menuItems = new java.util.Vector();
java.util.HashMap menuItem = new java.util.HashMap();
%>

<%
menuItems.add(new java.util.HashMap(menuItem));
menuItem.put("type", "panel");
%>

<%
boolean isReadOnly = neo.util.StringUtil.getBoolean(form.getReadOnly());
boolean isUser = neo.util.StringUtil.getBoolean(form.getIsUser());
boolean globalAdmin = checker.isGlobalPublicationAdmin(publication.getId());
boolean isUserAdmin = checker.isUserAdmin();
if(neo.util.StringUtil.getBoolean(form.getEditRoles())){
  isReadOnly = false;
}
if(isReadOnly){
  menuItem.put("label", RequestUtils.message(pageContext, null, null, "a.person.personal_data", null));
  menuItem.put("link", "javascript:submitForm('edit')");
  if( ((String)request.getAttribute("task")).equals("/person/edit")) {
    menuItem.put("selected", "true");
  } else {menuItem.put("selected", "false");
  }
  menuItems.add(new java.util.HashMap(menuItem));
  if(isUser){
    if(globalAdmin){  
      menuItem.put("label", RequestUtils.message(pageContext, null, null, "a.person.global_roles", null));
      menuItem.put("link", "javascript:submitForm('editGlobalRoles')");
      if( ((String)request.getAttribute("task")).equals("/person/editGlobalRoles")) {
        menuItem.put("selected", "true");
      } else {menuItem.put("selected", "false");
      }
      menuItems.add(new java.util.HashMap(menuItem));
    }
    if(globalAdmin||isUserAdmin){
      menuItem.put("label", RequestUtils.message(pageContext, null, null, "a.person.section_roles", null));
      menuItem.put("link", "javascript:submitForm('editRoles')");
      if( ((String)request.getAttribute("task")).equals("/person/editRoles")) {
        menuItem.put("selected", "true");
      } else {menuItem.put("selected", "false");
      }
      menuItems.add(new java.util.HashMap(menuItem));
    }
    if(globalAdmin){
      menuItem.put("label", RequestUtils.message(pageContext, null, null, "a.person.groups", null));
      menuItem.put("link", "javascript:submitForm('editGroups')");
      if( ((String)request.getAttribute("task")).equals("/person/editGroups")) {
        menuItem.put("selected", "true");
      } else {menuItem.put("selected", "false");
      }
      menuItems.add(new java.util.HashMap(menuItem));

      menuItem.put("label", RequestUtils.message(pageContext, null, null, "a.person.tags", null));
      menuItem.put("link", "javascript:submitForm('editTagStructures')");
      if( ((String)request.getAttribute("task")).equals("/person/editTagStructures")) {
        menuItem.put("selected", "true");
      } else {menuItem.put("selected", "false");
      }
      menuItems.add(new java.util.HashMap(menuItem));

      menuItem.put("label", RequestUtils.message(pageContext, null, null, "a.person.contentTypes", null));
      menuItem.put("link", "javascript:submitForm('editContentTypes')");
      if( ((String)request.getAttribute("task")).equals("/person/editContentTypes")) {
        menuItem.put("selected", "true");
      } else {menuItem.put("selected", "false");
      }
      menuItems.add(new java.util.HashMap(menuItem));
    }
    menuItem.put("type", "space");
    menuItem.put("size", "4");
    menuItems.add(new java.util.HashMap(menuItem));
  }
    
  String edit = null; 
  Person p = IOAPI.getAPI().getObjectLoader().getPerson(form.getIdInt(),form.getPubIdInt(publication.getId()));
  if(!p.isLocked()&&checker.isEditable(p)){
    edit = "/person/edit.do?id="+form.getId()+"&pubId="+form.getPubId();
  }
  menuItem.put("type", "panel");
  if(edit!=null){
    menuItem.put("label", "Edit");
    menuItem.put("link", "javascript:submitForm('external:"+edit+"')");
    menuItem.put("selected", "false");
    menuItems.add(new java.util.HashMap(menuItem));
  }
  
  /*
  menuItem.put("label", "Close");
  menuItem.put("link", "javascript:submitForm('close')");
  menuItem.put("selected", "false");
  menuItems.add(new java.util.HashMap(menuItem));
  */
  
 
  
  menuItem.put("type", "menu");
	menuItem.put("size", "100");
	if(request.getAttribute("disablePanelMenu")!=null&&request.getAttribute("disablePanelMenu").equals("true") ) {
		menuItem.put("file", "/WEB-INF/pages/person/save-menu-disabled.jsp");
	} else {
		menuItem.put("file", "/WEB-INF/pages/person/save-menu.jsp");
	}
	menuItems.add(new java.util.HashMap(menuItem));
  
  
  
}else{
  menuItem.put("label", RequestUtils.message(pageContext, null, null, "a.person.personal_data", null));
  menuItem.put("link", "javascript:submitForm('edit')");
  if( ((String)request.getAttribute("task")).equals("/person/edit")) {
    menuItem.put("selected", "true");
  } else {menuItem.put("selected", "false");
  }
  menuItems.add(new java.util.HashMap(menuItem));
  
  if(isUser){  
    if(globalAdmin){
      menuItem.put("label",  RequestUtils.message(pageContext, null, null, "a.person.global_roles", null));
      menuItem.put("link", "javascript:submitForm('editGlobalRoles')");
      if( ((String)request.getAttribute("task")).equals("/person/editGlobalRoles")) {
        menuItem.put("selected", "true");
      } else {menuItem.put("selected", "false");
      }
      menuItems.add(new java.util.HashMap(menuItem));
    }    
    menuItem.put("label", RequestUtils.message(pageContext, null, null, "a.person.section_roles", null));
    menuItem.put("link", "javascript:submitForm('editRoles')");
    if( ((String)request.getAttribute("task")).equals("/person/editRoles")) {
      menuItem.put("selected", "true");
    } else {menuItem.put("selected", "false");
    }
    menuItems.add(new java.util.HashMap(menuItem));
   if(globalAdmin){
      menuItem.put("label", RequestUtils.message(pageContext, null, null, "a.person.groups", null));
      menuItem.put("link", "javascript:submitForm('editGroups')");
      if( ((String)request.getAttribute("task")).equals("/person/editGroups")) {
        menuItem.put("selected", "true");
      } else {menuItem.put("selected", "false");
      }
      menuItems.add(new java.util.HashMap(menuItem));
       
       menuItem.put("label", RequestUtils.message(pageContext, null, null, "a.person.tags", null));
       menuItem.put("link", "javascript:submitForm('editTagStructures')");
       if( ((String)request.getAttribute("task")).equals("/person/editTagStructures")) {
         menuItem.put("selected", "true");
       } else {menuItem.put("selected", "false");
       }
       menuItems.add(new java.util.HashMap(menuItem));

       menuItem.put("label", RequestUtils.message(pageContext, null, null, "a.person.contentTypes", null));
       menuItem.put("link", "javascript:submitForm('editContentTypes')");
       if( ((String)request.getAttribute("task")).equals("/person/editContentTypes")) {
         menuItem.put("selected", "true");
       } else {menuItem.put("selected", "false");
       }
       menuItems.add(new java.util.HashMap(menuItem));
   }
   
    menuItem.put("type", "space");
    menuItem.put("size", "4");
    menuItems.add(new java.util.HashMap(menuItem));
    menuItem.put("type", "panel");
  }  
	menuItem.put("type", "menu");
	menuItem.put("size", "100");
	if(request.getAttribute("disablePanelMenu")!=null&&request.getAttribute("disablePanelMenu").equals("true") ) {
		menuItem.put("file", "/WEB-INF/pages/person/save-menu-disabled.jsp");
	} else {
		menuItem.put("file", "/WEB-INF/pages/person/save-menu.jsp");
	}
	menuItems.add(new java.util.HashMap(menuItem));
  
}



%>

<% request.setAttribute("menuItems", menuItems); %>
<template:call file="/WEB-INF/pages/framework/panelMenu.jsp"/> 





