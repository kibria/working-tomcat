<%--@elvariable id="article" type="neo.xredsys.presentation.PresentationArticle"--%>
<%--
 * Copyright (C) 2009 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-article" prefix="article"%>
<h2>
  ${article.fields.title}
</h2>
<div class="date">
  <fmt:formatDate value="${article.lastModifiedDateAsDate}"/>
</div>
<div class="byline">
  Written by
  <c:forEach var="author" varStatus="status" items="${article.authors}">
    ${author.name}<c:if test="${not status.last}">,</c:if>
  </c:forEach>
</div>
<div class="summary">
  ${article.fields.summary}
</div>
<div class="body">
  <article:renderField field="body" var="inline">
    <c:choose>
      <c:when test="${inline.content.articleTypeName == 'image'}">
        <img src="${inline.content.fields.binary.value.original}" alt=""/>
      </c:when>
      <c:otherwise>
        <a href="${inline.content.url}">${inline.content.title}</a>
      </c:otherwise>
    </c:choose>
  </article:renderField>
  <c:forEach items="${article.relatedElements.images.items}" var="related">
    <c:if test="${not empty related.content.fields.alternates.value}">
      <img src="${related.content.fields.alternates.value.SmallSquare.href}" alt="${related.fields.caption}"
           width="${related.content.fields.alternates.value.SmallSquare.width}"
           height="${related.content.fields.alternates.value.SmallSquare.height}"/>
    </c:if>
  </c:forEach>
</div>

<div class="stories">
  <h3>Related articles</h3>
  <ul>
    <c:forEach items="${article.relatedElements.stories.items}" var="related">
      <li>
        <a href="${related.content.url}">${related.fields.title}</a>
      </li>
    </c:forEach>
  </ul>
</div>

<div>
  <h3>Article tags</h3>
  <ul>
    <c:forEach items="${article.tags}" var="tag">
      <li>
        ${tag.name}
      </li>
     </c:forEach>
  </ul>
</div>