<%--
 * Copyright (C) 2008 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="left" value="${element.areas.left.items[0]}" scope="page"/>
<c:set var="center" value="${element.areas.center.items[0]}" scope="page"/>
<c:set var="right" value="${element.areas.right.items[0]}" scope="page"/>

<div class="three-col">
  <c:if test="${not empty left.legacyContent}">
    <div class="element">
      <c:set var="element" value="${left}" scope="request"/>
      <jsp:include page="ats.jsp"/>
    </div>
  </c:if>
  <c:if test="${not empty center.legacyContent}">
    <div class="element">
      <c:set var="element" value="${center}" scope="request"/>
      <jsp:include page="ats.jsp"/>
    </div>
  </c:if>
  <c:if test="${not empty right.legacyContent}">
    <div class="element">
      <c:set var="element" value="${right}" scope="request"/>
      <jsp:include page="ats.jsp"/>
    </div>
  </c:if>
</div>
