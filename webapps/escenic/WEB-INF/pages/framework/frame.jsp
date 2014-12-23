<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page import="org.apache.struts.config.ActionConfig"%>
<%@ page language="java" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>


<script language="JavaScript1.2"><!-- 
  function unlock(id,type){
<%--    if(confirm("are you sure?")){--%>
    if(confirm("<bean:message key='t.Unlock_message' bundle='org.apache.struts.action.MESSAGE' />")){
      forwardUrl = "action:/base/breakLock.do?id="+id+"&type="+type; 
      submitForm(forwardUrl);
    }
  }
  // -->
</script>

<%-- 

Frame.jsp delegates its responsibility to two files:
frame-mapping.jsp  works out the mapping between the "class" attribute and the actual files to use
frame-layout.jsp uses this information to render the page.
--%>

<% pageContext.getServletContext().setAttribute("neo.util.servlet.RequestInfo.StatisticsSource", neo.nursery.GlobalBus.lookupSafe("/neo/io/reports/ReportsStatisticsSource")); %>

<%
  String localekey = neo.phoenix.base.Constants.LOCALE_KEY;
  String language = (String)session.getAttribute("language");
  if (language == null) language = (String)request.getAttribute("language");
  if (language != null) {
    try {
      java.util.Locale locale = null;
      String[] codes = neo.util.StringUtil.split("_", language);
      if (codes.length == 1) {
        locale = new java.util.Locale(codes[0], "");
      } else if (codes.length == 2) {
        locale = new java.util.Locale(codes[0], codes[1]);
      } else if (codes.length == 3) {
        locale = new java.util.Locale(codes[0], codes[1], codes[2]);
      } else {
        locale = new java.util.Locale("en");
      }
      session.setAttribute(localekey, locale);
    } catch (Exception e) {
    }
  }
%>


<jsp:include page="frame-mapping.jsp"/>


<%
  String formName = (String)request.getAttribute("textmap-form"); 
  org.apache.struts.config.ModuleConfig cfg;
  cfg = (org.apache.struts.config.ModuleConfig) request.getAttribute("org.apache.struts.action.MODULE");
  if (formName != null && cfg != null && cfg.findActionConfig(formName) != null) {
    Object form = request.getAttribute(cfg.findActionConfig(formName).getName());
    if (form != null) {
      request.setAttribute("form", form);
      request.setAttribute("contextForm",form);
      /* get the child form if possible */
      if (form instanceof neo.phoenix.base.ChildForm) {
        neo.phoenix.base.ChildForm childForm = (neo.phoenix.base.ChildForm) form;
        neo.phoenix.base.WorkItemManager manager = (neo.phoenix.base.WorkItemManager)request.getSession().getAttribute("WorkItemManager");
        if (manager != null) {
          neo.phoenix.base.WorkItem item = manager.getWorkItem(childForm.getParentWorkItemId());
          if (item != null && item.getForm() != null) {
            request.setAttribute("parentForm",item.getForm());
            request.setAttribute("contextForm",item.getForm());
          }
        }
      }
    }
  }


%>


<!--
  Several tasks are available.
  For the task "/foo/bar/baz" the following classes are available
  task-foo
  task-foo-bar
  task-foo-bar-baz
 -->
<%
String tmp = "task" + request.getAttribute("task");
StringBuffer multitask = new StringBuffer();
int pos = tmp.indexOf("/"); // ignore the first 'task/'
while (true) {
  pos = tmp.indexOf("/",pos+1);
  if (pos == -1) break;
  multitask.append(' ');
  multitask.append(tmp.substring(0,pos));
}
multitask.append(' ');
multitask.append(tmp);
tmp =  neo.util.StringUtil.replaceString(multitask.toString(),"/","-");
request.setAttribute("bodyclass",tmp.toString());
%>

<template:serviceParameter name="areamap-frame-layout"/>

