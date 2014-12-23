<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<!-- edit1.jsp -->
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<!-- Calling frame -->
<bean:define id="task" value="/publication/exportUsers" toScope="request" />
<jsp:forward page="/WEB-INF/pages/framework/frame.jsp" />
