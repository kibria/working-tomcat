<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<!-- search.jsp -->
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<!-- Calling frame -->
<%
  boolean isUser = neo.util.StringUtil.getBoolean(request.getParameter("isUser"));
  if(isUser){
    request.setAttribute("task","/user/popup/new");
  }else{
    request.setAttribute("task","/person/popup/new");
  }
%>
<jsp:forward page="/WEB-INF/pages/framework/frame.jsp" />
