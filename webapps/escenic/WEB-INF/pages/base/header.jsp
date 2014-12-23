<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<html>
  <head>
    <title><bean:message bundle="org.apache.struts.action.MESSAGE" name="title"/></title>
    <link rel="stylesheet" href="<html:rewrite page="/images/basic.css"/>" type="text/css">
    <link rel="SHORTCUT ICON" href="<html:rewrite page="/images/favicon.ico"/>">
  </head>
  <logic:present name="escenic-publication" scope="session">

      <% if (request.getSession().getAttribute("escenic-publication") != null) {
  request.setAttribute("publication", request.getSession().getAttribute("escenic-publication"));
%>
      <% } %>

  </logic:present>
  <bean:define id="listcolors" value="#DDEEFF,#FFFFFF" toScope="request" />
    <script language="JavaScript1.2"><!-- 
  function submitForm(button) {
    document.forms[0].submitButton.value=button;
    document.forms[0].submit();
  }

  var init = new Function() 

  // -->
</script>

<template:serviceParameter name="content-beforeBody" />
