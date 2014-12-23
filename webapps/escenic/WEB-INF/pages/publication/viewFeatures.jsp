<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<!-- viewTemplates.jsp -->
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<!-- Calling frame -->
<bean:define id="task" value="/publication/viewFeatures" toScope="request" />
<jsp:forward page="/WEB-INF/pages/framework/frame.jsp" />


