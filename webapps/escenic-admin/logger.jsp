<%--
 * Copyright (C) 2007 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.

 * The reason for the strange formatting is that in  this way,
 * this file does not include any extra garbage whitespace that could
 * hurt the resulting page.
 --%>
 <%@ page language="java" %>
 
 <%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
 <%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
 <%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
 <HTML>
  <HEAD>
    <TITLE>
      Log for ECE-templates
    </TITLE>
  </HEAD>
  <BODY>
  <%
    String path= request.getContextPath();
  %>
  <a href="<%=path%>/">Home</a>
    <H2>Log for ECE-templates</H2>
    <%-- 
        neo.util.ListAppender app = (neo.util.ListAppender)neo.nursery.GlobalBus.getGlobalBus().lookupSafe("/neo/util/TemplateLogger"); 
        java.util.List l = app.getLog();
        request.setAttribute("l",l);
    --%>
    <util:lookup id="app" name="/neo/util/TemplateLogger" type="neo.util.ListAppender" />
    <logic:equal parameter="clear" value="true">
      <%
        neo.util.ListAppender app = (neo.util.ListAppender) pageContext.findAttribute("app");
        app.clear();
      %>
    </logic:equal>
      <A href="logger.jsp">Refresh</A> <A href="logger.jsp?clear=true">Clear the log</A>
    <logic:iterate id="item" name="app" property="log" type="String">
      <bean:write name="item" filter="false"/>
    </logic:iterate>
  </BODY>
</HTML>