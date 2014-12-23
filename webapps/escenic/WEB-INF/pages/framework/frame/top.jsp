<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page import="org.apache.struts.action.Action"%>
<%@ page import="neo.phoenix.base.WorkItemManager"%>
<%@ page import="java.util.*"%>
<%@ page import="neo.phoenix.base.WorkItem"%>
<%@ page import="neo.phoenix.base.WorkItemForm"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<bean:define name="escenic-publication" id="publication" scope="session" type="neo.xredsys.api.Publication" />
<bean:define id="checker" name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<bean:define id="exitMode" name="textmap-task-exit-mode" type="java.lang.String" />
<bean:define id="user" name="escenic-user" scope="session" type="neo.xredsys.api.User" />

<%
String logo = null;
if(!neo.util.StringUtil.isEmpty(publication.getFeature("publication.logo"))) {
  logo = publication.getFeature("publication.logo");
}
if (logo != null) { %>
  <div id="header-top">
    <span id="header-topLogo">
    <html:img src='<%=logo%>' border="0"/>
    </span>
  </div>
<% } %>

<div id="header-userinfo">
<logic:present name="escenic-user" scope="session">
<bean:define id="hostname" name="escenic-publication" property="name" type="java.lang.String"/>
<bean:define id="userName" name="escenic-user" property="userName" type="java.lang.String"/>
<bean:define id="name" name="escenic-user" property="name" type="java.lang.String"/>

<span id="header-userinfo-publication"><a href="<%=publication.getUrl()%>" target="escenicPreview"><%=hostname%></a></span>
<span class="bar">|</span>
<span id="header-userinfo-name"><%=name%></span>
<span id="header-userinfo-username">(<%=userName%>)</span>
<span id="header-debug">
show <a href="javascript:boxes();" title="add boxes: red=tables; green=div; span=orange">boxes</a> <a href="javascript:classes();" title="add id and class hints to boxes">id/classes</a>
<html:link page='<%="/frame-mapping/task" + request.getAttribute("task")%>' title="Show everything there is to know about this task">task</html:link>
</span>
<span class="bar">|</span>
<span id="header-logout">
  <html:link page="/logoff.do"><bean:message key="m.admin.LogOff"/></html:link>
</span>
<script>
function boxes() {
  webhelper('boxes', ' div { border: 2px solid green !important; } table { border: 2px solid red } td { border: 2px dotted red } span { border: 2px dotted #fc0 !important; } ');
}

function classes() {
  webhelper('classes','*[class]:before { background-color: #990000 !important; color: #ffffff !important; content: "Class=" attr(class) !important; }*[id]:before { background-color: #009900 !important; color: #ffffff !important; content: "Id=" attr(id) !important; }*[id][class]:before { background-color: #000099 !important; color: #ffffff !important; content: "Id=" attr(id) ", Class=" attr(class) !important; }  *:before { background-color: #ffff99 !important; color: #000000 !important;  -moz-opacity: 0.7 !important; opacity: 0.7 !important; }');
}


function webhelper(b,c) {
  if (document.createElement) {
    h=document.createElement('link'); h.name=b; h.rel='stylesheet'; h.href='data:text/css,'+escape(c); 
    document.getElementsByTagName('head')[0].appendChild(h);
  }
}
</script>

</logic:present>&nbsp;
</div>



