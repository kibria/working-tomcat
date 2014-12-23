<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" import="neo.phoenix.base.*" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>


<%
 org.apache.struts.action.ActionForm form = (org.apache.struts.action.ActionForm)request.getAttribute("form");
 if (form != null) {
      if (form instanceof neo.phoenix.base.ChildForm) {
       neo.phoenix.base.ChildForm childForm = (neo.phoenix.base.ChildForm) form;
       WorkItemManager manager = (WorkItemManager)request.getSession().getAttribute("WorkItemManager");
       if(manager!=null){
       WorkItem item = manager.getWorkItem(childForm.getParentWorkItemId());
       if (item != null && item.getForm() instanceof neo.phoenix.base.WorkItemForm) {
	 form = item.getForm();
       }
	   }
	 }
   if (form instanceof neo.phoenix.base.WorkItemForm) {
     neo.phoenix.base.WorkItemForm workItemForm = (neo.phoenix.base.WorkItemForm) form;
	      String topName = "areamap-main-content-menu-" + workItemForm.getWorkItemType();
     if (! neo.util.StringUtil.isEmpty((String)request.getAttribute(topName))) {
       %>
         <template:serviceParameter name="<%=topName%>"/>
       <%
     } else {
       %>
         <%-- (empty) --%>
       <%
     }
   }
 }


%>

