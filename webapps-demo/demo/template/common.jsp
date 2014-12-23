<%--
 * Copyright (C) 2008 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="no" lang="no">
  <head>
    <meta http-equiv="Content-type" content="text/html; charset=iso-8859-1" />
    <c:url var="css" value="/css/main.css" scope="request"/>
    <link rel="stylesheet" type="text/css" href="${css}">
    <title>
      ${publication.name}
      <c:if test="${requestScope['com.escenic.context']=='art'}">
        - ${article.fields.title} 
      </c:if>
    </title>
    
  </head>
  <body> 
    <jsp:include page="wireframe/default.jsp"/>
  </body>
</html>


