<%--
 * This script is the entry point to the Escenic templates. 

 * Copyright (C) 2001 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.

 * The reason for the strange formatting, is that in  this way,
 * this file does not include any extra garbage whitespace, that could
 * hurt the resulting page.

 * @author: $Author: fkb $
 * @version: $Change: 146565 $, $Revision: #1 $
--%>
<%@ page language="java" %>

<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="googleMapKey" value="${section.parameters['geocode.map.google.key']}"/>

<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
  <head>
    <title>${publication.name}</title>
    <c:if test="${googleMapKey != null}">
      <script src="http://maps.googleapis.com/maps/api/js?v=3&sensor=false&hl=en&key=${googleMapKey}" type="text/javascript"></script>
      <script type="text/javascript" src='<html:rewrite page="/script/geocode.js"/>'>
      </script>
    </c:if>
    <link rel="stylesheet" type="text/css" href='<html:rewrite page="/css/geocode.css"/>'/>
  </head>
  <c:choose>
    <c:when test="${googleMapKey != null}">
      <body>
        <div align="center">
          <div>
            <template:call file="/template/header.jsp"/>
          </div>
          <div style="float:none;width:80%" align="center">
            <c:choose>
              <c:when test="${requestScope['com.escenic.context']=='art'}">
                <jsp:include page="art_default.jsp"/>
              </c:when>
              <c:otherwise>
                <jsp:include page="sec_default.jsp"/>
              </c:otherwise>
            </c:choose>
          </div>
          <br clear="all"/>

          <div style="float:none;">
            <template:call file="/template/footer.jsp"/>
          </div>
        </div>
      </body>
    </c:when>
    <c:otherwise>
      <body>
        <h2>Google Maps API key not found</h2>
        Please define root section-parameter: <em>geocode.map.google.key</em> with your Google Maps API key.
      </body>
    </c:otherwise>
  </c:choose>
</html>
