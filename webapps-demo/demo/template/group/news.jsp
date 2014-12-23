<%--
 * Copyright (C) 2008 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="news">
  <div class="header" style="background-color: ${pool.rootElement.areas.header.options['news-area-background']}">
    <c:if test="${fn:length(pool.rootElement.areas.header.items) > 0}">
      <div style="${pool.rootElement.areas.header.items[0].options.border}">
        <c:set var="element" value="${pool.rootElement.areas.header.items[0]}" scope="request"/>
        <jsp:include page="ats.jsp"/>
      </div>
    </c:if>
  </div>  
  <div class="center">
    <c:forEach items="${pool.rootElement.areas.center.items}" var="item">
      <c:set var="element" value="${item}" scope="request"/>
      <c:choose>
        <c:when test="${item.type eq 'two-col'}">
          <jsp:include page="twoCol.jsp"/>
        </c:when>
        <c:when test="${item.type eq 'three-col'}">
          <jsp:include page="threeCol.jsp"/>
        </c:when>
        <c:otherwise>
          <jsp:include page="ats.jsp"/>
        </c:otherwise>
      </c:choose>
    </c:forEach>
  </div>
  <c:if test="${not empty pool.rootElement.areas.rightcolumn.items}">
	  <div class="right">
	    <ul>
	      <c:forEach items="${pool.rootElement.areas.rightcolumn.items}" var="item">
	        <li><a href="${item.content.url}">${item.fields.TITLE}</a></li>
	      </c:forEach>
	    </ul>
	  </div>
  </c:if>
</div>
