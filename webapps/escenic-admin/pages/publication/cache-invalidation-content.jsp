<%--
  ******************************************************************************
  * Copyright (C) 2002 Escenic AS.
  * All Rights Reserved.  No use, copying or distribution of this
  * work may be made except in accordance with a valid license
  * agreement from Escenic AS.  This notice must be included on
  * all copies, modifications and derivatives of this work.
  ******************************************************************************
  *           File: $Header: //depot/escenic/engine/branches/5.7/phoenix/phoenix-admin/src/main/webapp/pages/publication/cache-invalidation-content.jsp#1 $
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

<p>This page allows you to remove selected articles, images, sections and
 so on from specific caches.  ID's may be specified verbatim, or may be
 specified as an SQL statement.</p>

<html:form action="/publication/cache-invalidation">
  <fieldset>
    <legend>What?</legend>
    <p>What type of objects do you whish to remove from the cache?</p>
    <ul>
      <li><html:radio property="what" value="article" /> Articles
      <li><html:radio property="what" value="pool" /> Pools (front pages of sections)
      <li><html:radio property="what" value="section" /> Sections
      <li><html:radio property="what" value="entity" /> Links, images, media etc.
    </ul>
  </fieldset>

  <fieldset>
    <legend>How deep?</legend>
    <p>How many levels of cache should be probed?</p>
    <ul>
      <li><html:radio property="depth" value="presentation" /> Presentation layer
      <li><html:radio property="depth" value="api" /> Presentation layer, API caches
      <li><html:radio property="depth" value="internal" /> Presentation layer, API caches, Internal core caches
    </ul>
  </fieldset>

  <fieldset>
    <legend>IDs</legend>
    <p>Execute the following SQL query, and invalidate all article IDs in the result set.
      <div class="error"><html:errors property="sql"/></div>
    </p>
    <html:text property="sql" size="60" />
    <p>Invalidate the following article IDs:</p>
    <html:textarea property="ids" rows="4" cols="60" />
  </fieldset>
  <html:submit value="Preview"/>
</html:form>

