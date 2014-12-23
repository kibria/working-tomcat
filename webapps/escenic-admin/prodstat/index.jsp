<!-- index.jsp -->
<%@ page language="java" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<!-- Calling frame -->
<link href="prod.css" rel="stylesheet">
<template:call file="/pages/base/frame.jsp">
  <template:parameter key="title"                    value="h.Menu" />
  <template:parameter key="content"                  value="/prodstat/index-content.jsp" />
</template:call>
<!-- Finished call to frame -->
<!-- End of index.jsp  -->
