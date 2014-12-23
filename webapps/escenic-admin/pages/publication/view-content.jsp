<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<h3>Publication '<%= request.getParameter("name") %>'</h3>

<template:call file="/pages/publication/todo.jsp">
  <template:parameter key="name" value="<%= request.getParameter(\"name\")%>" /> <%-- This is added to avoid weird behavoir from oracle appserver --%>
  <template:parameter key="create" value="false" />
</template:call>

