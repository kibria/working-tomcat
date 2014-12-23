<%@ page language="java" %>
<%@ page import="com.escenic.geocode.utils.KMLUtils" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.escenic.geocode.plugin.GeocodePluginConstants" %>

<%--
 * Copyright (C) 2001 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.

 * The reason for the strange formatting, is that in  this way,
 * this file does not include any extra garbage whitespace, that could
 * hurt the resulting page.
 --%>

<%@ taglib uri="http://www.escenic.com/taglib/escenic-article" prefix="article" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic" %>
<%@ taglib prefix="bean" uri="http://struts.apache.org/tags-bean" %>

<!-- Start: art_default.jsp -->
<h1>${article.fields.title.value}</h1><br/>
<h2>${article.fields.body.value}</h2><br/>
<c:set var="geocodeFieldName" value="<%=GeocodePluginConstants.GEOCODE_FIELD%>"></c:set>
<bean:define id="articleGeoField" value="${article.fields[geocodeFieldName].value}" />

<logic:empty name="articleGeoField">
  <h3>Article doesn't contain any geo information.</h3>
</logic:empty>
<logic:notEmpty name="articleGeoField">
<%
  try {
    List geoFields = KMLUtils.getGeoFields(articleGeoField);
    request.setAttribute("geoFields", geoFields);
%>
Num Of Fields : <%=geoFields.size()%><br/>
<div id="resultGoogleMap" style="width:500px;height:300px"></div>
<template:call file="./geoFieldsOnMap.jsp">
  <template:parameter key="geoFields" name="geoFields"/>
</template:call>
<%
  } catch (Exception e) {
    e.printStackTrace(new PrintWriter(out));
%>
<h3>Unable to retrieve geo information from article</h3>
<%
  }
%>
</logic:notEmpty>
