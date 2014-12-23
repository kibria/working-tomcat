<%--
 * Copyright (C) 2008 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<h3>
  ${element.fields.CAPTION}
</h3>
<c:set var="imageBinary" value="${element.content.fields.binary.value}" />
<a href="${element.content.url}">
  <c:choose>
    <%-- If this element is inside a two-col/three-col group, then we use the thumbnail image version --%>
	  <c:when test="${element.parent.parent.type eq 'two-col' or element.parent.parent.type eq 'three-col'}">
	    <img src="${imageBinary.thumbnail}" alt="${element.fields.ALTTEXT}"/>
	  </c:when>
    <c:otherwise>
      <img src="${imageBinary.big}" alt="${element.fields.ALTTEXT}"/>
    </c:otherwise>
  </c:choose>
</a>
