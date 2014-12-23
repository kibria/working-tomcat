<%--@elvariable id="section" type="neo.xredsys.presentation.PresentationSection"--%>
<%--@elvariable id="pool" type="neo.xredsys.presentation.PresentationPool"--%>
<%--
 * Copyright (C) 2008 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-view" prefix="view" %>
<div id="body" style="background-color: ${pool.rootElement.options['news-background-option']}">
  <div id="header">
    <h1>${section.name}</h1>
   </div>
  <div id="menu">
    <bean:define id="rootSection" name="publication" property="rootSection" type="neo.xredsys.api.Section"/>
    <section:recursiveView id="secView" name="rootSection" depth="2"/>
    <c:url var="arrow" value="/gfx/arrow.gif" scope="request"/>
    <view:iterate view="<%=secView%>" id="item" type="neo.xredsys.api.Section"> 
     <section:use section="<%=item%>">
            <view:forEachLevel>&nbsp;</view:forEachLevel>
            &nbsp;<img src="${arrow}" alt="escenic"/>&nbsp;<a href="${section.url}" class="menu_item">${section.name}</a><br/>
     </section:use>
    </view:iterate>
  </div>
  <div id="content">
    <c:choose>
      <c:when test="${requestScope['com.escenic.context']=='art'}">
        <jsp:include page="../article/ats.jsp"/>
      </c:when>
      <c:otherwise>
        <jsp:include page="../group/${pool.rootElement.type}.jsp" />
      </c:otherwise>
    </c:choose>
  </div>
  <br clear="all"/>
  <div id="footer">Copyright © 2011 Vizrt Ltd.</div>
</div>
