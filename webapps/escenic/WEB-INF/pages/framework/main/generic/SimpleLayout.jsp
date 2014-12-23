<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<!-- SimpleLayout -->
<div class='simple-layout <%=request.getAttribute("textmap-style-class-layout")%>'>
  <div class="main-content">
    <div class="main-content-top"><template:serviceParameter name="areamap-main-content-top"/></div>
    <template:serviceParameter name="areamap-main-content"/>
  </div>
</div>
