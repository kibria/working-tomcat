<%@ page import="com.escenic.phoenix.admin.servlet.PerformancePageHelper, com.escenic.common.util.JSONMap" %><%
    JSONMap report = PerformancePageHelper.getJSONReport();
    response.setContentType("application/json");
    out.write(report.toString());
%>