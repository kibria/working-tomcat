<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %><%@ 
taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %><%@
taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %><%@
taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %><%@ 
taglib uri="http://struts.apache.org/tags-html" prefix="html" %><%!

// returns a <a href=..> object. needs a linktext and an url, will insert the title if given.

String makeLink(String linktext, String url, String title) {
   StringBuffer sb=new StringBuffer();
   sb.append("<a href=\"");   
   sb.append(url);
   sb.append('"');
   if (title!=null) {
      sb.append(" title=\"");
      sb.append(title);
      sb.append('"');
   }
   sb.append(">");
   sb.append(linktext);
   sb.append("</a>");
   return sb.toString();
}
%> 
<%

try { 

boolean disableAll = false;
   
if(request.getAttribute("disablePanelMenu")!=null && request.getAttribute("disablePanelMenu").equals("true")) {
   disableAll=true;
}
   
%>

<div id="panelmenu">
<logic:iterate id="item0" name="menuItems">
<% 
  java.util.HashMap itemValues = (java.util.HashMap) pageContext.getAttribute("item0");
  Object itemValueType = itemValues.get("type");
  if("menu".equals(itemValueType)) {
%>
    <%
      String size = (String) itemValues.get("size");
      String file = (String) itemValues.get("file");
    %>
    <div class="panelmenu-area">
    <div class="roundedbox">
      <template:call file='<%= file %>'/>
    </div>
    </div>
  <%}%>
</logic:iterate>
</div>

<!-- navigationmenu is moved using DOM Scripting to the 'main-content-nav' element. -->
<div id="navigationmenu">
<logic:iterate id="item" name="menuItems">
<% 
  java.util.HashMap itemValues = (java.util.HashMap) pageContext.getAttribute("item");
  Object itemValueType = itemValues.get("type");
  if("panel".equals(itemValueType)) {
%>
	   <%	
	String label = (String) itemValues.get("label");
	String link = (String) itemValues.get("link");
	String selected = (String) itemValues.get("selected");
	String enabled = (String) itemValues.get("enabled");
	String title=(String)itemValues.get("title");
String help=(String)itemValues.get("help");
String info=(String)itemValues.get("info");
	// inserted by jf: 
	// 'not disabled' is default for non-selected and 'disabled' is default for selected items
	boolean disable= disableAll || "false".equals(enabled) || "true".equals(selected);
	// allow explicit override:
	if ("true".equals(enabled)) disable=false;
	%>  
	<% if("true".equals(selected)) { %>
	<%-- do not disable the area panel if selected - needed to keep track of selections. disable non-selected
	panels only. --%>
	<span class="panelmenu-tab-selected">
	<% } else { %>
	<span class="panelmenu-tab<%= disable?"-disabled":"" %>">
	<% } %>
<div class="panelmenu-tab-content">
		<!--
		&nbsp;&nbsp;-->
		
		<% if (disable) {
      if(!neo.util.StringUtil.isEmpty(help)){
        %><%= label %><a href="<%=help%>" target="_new"><html:img page="/images/studio/S_helpicon.gif" border="0" /></a><%  
      }else{
        %><%= label %><%
      }
      if(!neo.util.StringUtil.isEmpty(info)){%>
        <html:img title="<%=info%>" page="/images/studio/S_infoicon.gif" border="0"/>
      <%}
    }else { 
        %><%=makeLink(label, link, title)%>
        <%if(!neo.util.StringUtil.isEmpty(info)){%>
          <html:img title="<%=info%>" page="/images/studio/S_infoicon.gif" border="0"/>
        <%}%>
      <%
    } %></div></span>
    <%} else if("space".equals(itemValueType)) {%>
            <%
		String size = (String) itemValues.get("size");
		%>
		<span style="height: <%= size %>px" class="panelmenu-empty"><span>&nbsp;</span></span>
    <%}else if("menu".equals(itemValueType)){} %>
</logic:iterate>
</div>
 <% } catch (NullPointerException e) {
  e.printStackTrace();
} %>
