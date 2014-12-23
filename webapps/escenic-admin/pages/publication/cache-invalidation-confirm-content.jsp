<%--
  ******************************************************************************
  * Copyright (C) 2002 Escenic AS.
  * All Rights Reserved.  No use, copying or distribution of this
  * work may be made except in accordance with a valid license
  * agreement from Escenic AS.  This notice must be included on
  * all copies, modifications and derivatives of this work.
  ******************************************************************************
  *           File: $Header: //depot/escenic/engine/branches/5.7/phoenix/phoenix-admin/src/main/webapp/pages/publication/cache-invalidation-confirm-content.jsp#1 $
  * Last edited by: $Author: sai $ $Date: 2013/12/04 $
  *   Version     : $Revision: #1 $
  ******************************************************************************
  * This is a prototype for the "all new" Component Browser
  ******************************************************************************
 --%>

<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="neo.util.StringUtil" %>
<%@ page import="neo.nursery.*" %>
<%@ page import="neo.util.cache.Cache" %>

<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>


<A href="<%= request.getContextPath() + "/" %>">admin</A>/Cache Invalidation<BR><BR> <!-- " -->

<%
  /* pick up ids from action */
  String ids = (String) request.getAttribute("ids");
  if (ids == null) ids = "";
  if (ids.length() > 1000) ids = ids.substring(0,1000) + "..... (cropped)";

  String sqlcount = (String) request.getAttribute("sqlcount");
  if (sqlcount != null) {
  %>
    <p>Your SQL statement resulted in <%=sqlcount%> IDs.</p>
  <%
  }

%>


<p>The following IDs are scheduled for cache invalidation:</p>
<p><%=ids%></p>

<html:form action="/publication/cache-invalidation">
  <html:hidden property="what"/>
  <html:hidden property="depth"/>
  <html:hidden property="sql"/>
  <html:hidden property="ids"/>
  <html:hidden property="confirm" value="on"/>
  <html:submit value="Confirm"/>
</html:form>

