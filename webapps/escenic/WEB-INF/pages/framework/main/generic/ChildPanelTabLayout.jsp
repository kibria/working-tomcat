<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<!-- ChildPanelTabLayout -->
<% request.setAttribute("disablePanelMenu", "true"); %>
<jsp:include page="PanelTabLayout.jsp"/>