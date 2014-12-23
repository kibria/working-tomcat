<%@ page import="com.escenic.geocode.presentation.PresentationConstants" %>
<%@ page language="java" %>

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

<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>


<!-- Start: sec_default.jsp -->

<div align="center">
  <div style="float:left;">
    <template:call file="./geoArticleSearch.jsp"/>
  </div>
  <div style="float:left;margin-left:2%;">
    <template:call file="./geoArticleMap.jsp"/>
  </div>
  <br clear="left"/>
</div>  
<br/>
<br/>
<div style="float:left;">
  <logic:present name="<%=PresentationConstants.RQ_ATTR_GEO_ARTICLE_SEARCH_RESULT%>">
    <template:call file="./geoArticleSearchResult.jsp"/>
  </logic:present>
</div>
