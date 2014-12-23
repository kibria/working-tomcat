<%@ page import="neo.nursery.Bus" %>
<%@ page import="neo.nursery.GlobalBus" %>
<%@ page import="java.util.Collection" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.beans.*" %>
<%@ page import="com.escenic.phoenix.admin.servlet.ECEBrowserHelper"%>
<%@ page import="java.beans.Introspector" %>
<%--
 ******************************************************************************
 * Copyright (C) 2007 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.
 ******************************************************************************
 *           File: $Header: //depot/escenic/engine/branches/5.7/phoenix/phoenix-admin/src/main/webapp/browser.jsp#5 $
 * Last edited by: $Author: runebr $ $Date: 2014/09/01 $
 *   Version     : $Revision: #5 $
 ******************************************************************************
 * This is a prototype for the "all new" Component Browser
 ******************************************************************************


--%>
<%
        String requestURI =  request.getRequestURI();
        String componentName = request.getPathInfo();
        Bus bus;

        EventSetDescriptor[] eventSetDescriptors = null;
        try {
            bus = ECEBrowserHelper.getBusForComponent(componentName);
        }
        catch (Exception e) {
            response.sendError(404, e.toString());
            return;
        }

        if (bus == null) {
            response.sendError(404);
            return;
        }

        componentName = ECEBrowserHelper.removeBusNameFromComponentName(componentName);
        Object bean = bus.lookupSafe(componentName);

        if (bean != null) {
            BeanInfo beanInfo = Introspector.getBeanInfo(bean.getClass(), Introspector.USE_ALL_BEANINFO);
            eventSetDescriptors = beanInfo.getEventSetDescriptors();
        }

    try { %>
<h1>Component browser</h1>
<div class="componentBrowser">
    <h1>Scope: <%=bus.getDisplayName()%></h1>
    <%if("true".equals(request.getParameter("changeBus"))){%>
        <%@ include file="buslist.jsp" %>
    <%} else {%>
        <h4><a href="?changeBus=true">Browse other scope</a></h4>
    <%}%>
    <H1><%= ECEBrowserHelper.getBreadCrums(bus, componentName, request) %></H1>
    <% if (bean != null) { %>
    <%= ECEBrowserHelper.displayClassInfo(bus, componentName, request) %>
    <HR>
    <%
      out.flush();
      String property = request.getParameter("property");
      String map = request.getParameter("map");
      String method = request.getParameter("method");
      if (property != null) {
        ECEBrowserHelper.displayProperty(bus, componentName, property, request, response, out);
      } else if (map != null) {
        ECEBrowserHelper.displayMap(bus, componentName, map, request, out);
      } else if (method != null) {
        ECEBrowserHelper.displayMethod(bus, componentName,method, request, out);
      } else {
        out.println();
        ECEBrowserHelper.displayDirectoryListing(bus, componentName, request, response, out);
        %><hr/><%
        ECEBrowserHelper.displayProperties(bus, componentName, request, response, out);
        ECEBrowserHelper.displayEventSets(eventSetDescriptors, response, out);
        ECEBrowserHelper.displayMethods(bus, componentName, request, out);
        ECEBrowserHelper.displayServiceInfo(bus, componentName, response, out);
        ECEBrowserHelper.displayBusConfiguration(bus, out);
        ECEBrowserHelper.displayStringValue(bean, out);

      }
    %>
    <% } else { %>
    Directory
    <HR>
    <%
      out.flush();
      ECEBrowserHelper.displayDirectoryListing(bus, componentName, request, response,out);
    %>
    <% } %>
    <HR>
    (C) 2002 Escenic AS
<% } catch (Exception e) {
  out.println("<span class='error'>Exception occurred: " + e + "</span><pre>");
  e.printStackTrace(new java.io.PrintWriter(out));
  out.println("</pre>");
 } %>
</div>