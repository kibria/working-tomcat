<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<!-- PanelTabLayout -->
<div class='panel-tab-layout <%=request.getAttribute("textmap-style-class-layout")%>'>
  <div id="main-content-nav" class="main-content-nav"><template:serviceParameter name="areamap-main-content-nav"/></div>
  <div id="main-content-menu" class="main-content-menu"><template:serviceParameter name="areamap-main-content-menu"/></div>
  <div id="main-content" class="main-content">
    <div id="main-content-top" class="main-content-top"><template:serviceParameter name="areamap-main-content-top"/></div>
    <div id="main-content-heading" class="main-content-heading"><template:serviceParameter name="areamap-main-content-top-heading"/></div>
    <template:serviceParameter name="areamap-main-content"/>
  </div>
</div>
