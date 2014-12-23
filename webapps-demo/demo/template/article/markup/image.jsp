<%--
 * Copyright (C) 2008 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<h2>
  ${article.fields.name}
</h2>
<div class="date">
  <fmt:formatDate value="${article.lastModifiedDateAsDate}"/>
</div>
<div>
  ${article.fields.description}
</div>
<img src="${article.fields.alternates.value.WideBig.href}" alt="${article.fields.alttext}"
     width="${article.fields.alternates.value.WideBig.width}" height="${article.fields.alternates.value.WideBig.height}"/>
