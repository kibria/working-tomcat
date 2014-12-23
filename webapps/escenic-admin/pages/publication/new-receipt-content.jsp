<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<h3>Congratulations!</h3>
You have successfully created the publication called "<%= request.getParameter("name") %>".  You can now...

<template:call file="/pages/publication/todo.jsp">
  <template:parameter key="name" value="<%= request.getParameter(\"name\")%>" />
  <template:parameter key="create" value="true" />
</template:call>

<div><font color="red"><html:errors property="failure" /></font></div>
<div><html:messages id="success" /></div>
