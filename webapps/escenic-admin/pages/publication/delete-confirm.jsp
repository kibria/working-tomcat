<!-- delete-confirm.jsp -->
<%@ page language="java" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<!-- Calling frame -->
<template:call file="/pages/base/frame.jsp">
  <template:parameter key="title"                    value="h.Delete_publication" />
  <template:parameter key="content"                  value="/pages/publication/delete-confirm-content.jsp" />
</template:call>
<!-- Finished call to frame -->
<!-- End of delete-confirm.jsp  -->
