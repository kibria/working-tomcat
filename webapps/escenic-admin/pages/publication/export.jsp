<%@ page language="java" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%
 EmbeddedExportService embeddedExportService=new EmbeddedExportService();
    //Properties initialSystemProp = embeddedExportService.createSystemProperty();
    //System.setProperties(initialSystemProp);


    embeddedExportService.exportAllPublications("testAppPublicatiomExport.xml");


%>
<template:call file="/pages/base/frame.jsp">
  <template:parameter key="title"                    value="h.Menu" />

</template:call>
All the publications are successfully exported to <%=embeddedExportService.getWorkingDir()+"/"+"testAppPublicatiomExport.xml"%>