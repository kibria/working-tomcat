<!-- performance.jsp -->
<%@ page language="java" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<!-- Calling frame -->

<!-- Logic to figure out what to do... -->
<%
  String outputFormat = request.getParameter("format"); 
  String path = request.getPathInfo();
  String content = null;
  String name = null;
  neo.util.callinfo.Statistics statistics = (neo.util.callinfo.Statistics) neo.nursery.GlobalBus.lookupSafe("/neo/io/reports/Statistics");
  neo.util.callinfo.CallInfoCollector collector = null;
  java.util.Set metricKeys = null;
  String errormessage = null;

  if (neo.util.StringUtil.isEmpty(path) || !path.startsWith("/")) {
    content = "jsp-statistics-show-groups.jsp";
  } else if (path.equals("/")) { 
    content = "jsp-statistics-show-groups.jsp";
  } else {
    content = "jsp-statistics-content.jsp";
    /*  We have a name and/or path.  Calculate the name-portion */

    /* remove the initial slash */
    path=path.substring(1);
    if (path.indexOf("/") != -1) {
      name = path.substring(0,path.indexOf("/"));
      path = path.substring(path.indexOf("/"));
    } else {
      name = path;
      path = "";
    }
  }

 if (statistics == null) {
   errormessage = "The statistics component (/neo/io/reports/Statistics) has not been installed on this server.";
 } else if (name != null && !statistics.getNames().contains(name)) {
   errormessage = "No statistics have been collected using the name <tt>'" + name + "'</tt>";
 }

 if (name != null) {
   collector = statistics.getCallInfoCollectorCalled(name);
   if (collector != null && collector.getAll().size() != 0) {
     metricKeys = ((neo.util.callinfo.AggregateCallInfo)collector.getAll().get(0)).getMetricKeys();
   }
 }


/* all information collected.  Add to request scope. */
  if (path != null) request.setAttribute("path", path);
  if (name != null) request.setAttribute("name", name);
  if (statistics != null) request.setAttribute("statistics", statistics);
  if (collector != null) request.setAttribute("collector", collector);
  if (metricKeys != null) request.setAttribute("metricKeys", metricKeys);
  if (errormessage != null) request.setAttribute("erromessage", errormessage);
%>

<% if (! neo.util.StringUtil.isEmpty(request.getParameter("format"))) { %>
  <jsp:forward page="/pages/jsp-statistics-format.jsp"/>
<% } else { %>
<template:call file="/pages/base/frame.jsp">
  <template:parameter key="title"                    value="h.Menu" />
  <template:parameter key="content"                  value='<%="/pages/" + content%>' />
</template:call>
<% } %>
<!-- Finished call to frame -->
<!-- End of index.jsp  -->
