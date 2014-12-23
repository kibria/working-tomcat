<%@ page import="java.util.*" %>
<%@ page import="neo.xredsys.config.Publications" %>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%
try {
  neo.xredsys.api.Publication pub = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPublication((String)request.getAttribute("name"));
  if (pub != null) {
    pageContext.setAttribute("publication",pub);
  }
  {
%>

<logic:present name="publication" scope="page">
  <style>
dt {
   font-weight: bold;
   space-before: 12pt;
   background: #dddddd;
}
  </style>

  <dl>
    <dt valign="top">Log in using Studio</dt>
    <dd valign="top">Use <a href="/studio/">Escenic Content Studio</a> to log on to this publication to start adding content immediately.</dd>

    <dt valign="top">Log in from the Web</dt>
    <dd valign="top">Use the <a href="/escenic/">Escenic Web interface</a> to log on to this publication to start administering it.   Here you can create new users, create a section hierarchy.  Use the user ID "<tt><bean:write name="name"/>_admin</tt>" to log on to get publication administrative rights.</dd>

    <dt valign="top">Deploy the web application in your app server</dt>
    <dd valign="top">The publication can be deployed on this (or another) server.  Use your application server administration tools to deploy this web application in order for the web application to respond to requests.</dd>

    <dt valign="top">Browse the publication</dt>
    <dd valign="top">If you have deployed the web application, you may browse the publication at <tt><a href="<%=pub.getUrl()%>"><%=pub.getUrl()%></a></tt>.  If the URL above does not work, try to deploy the web application to your application server.</dd>

    <dt valign="top">Who is logged on?</dt>
    <dd valign="top"><a href="<%= request.getContextPath() %>/pages/publication/sessions.jsp?publicationID=<%= pub.getId() %>">See who is currently logged in.</a></dd>
    <dt valign="top">Export content</dt>
    <dd valign="top"><a href="<%= request.getContextPath() %>/pages/publication/migrate.jsp?publicationId=<%= pub.getId() %>">Export all contents of the publication "<%=pub.getName()%>" .</a></dd>

    <dt valign="top">Publication resources (download)</dt>
    <dd valign="top">
    <%
      List l = pub.getResourceNames();
      String path = request.getContextPath();
      for (int i = 0; i < l.size(); i++) {
        String resource = String.valueOf(l.get(i));
        out.println("<a href=\"" + path + "/publication-resources/"+ pub.getName() + resource + "\">"+resource + "</a><br/>");
      }
    %>
    </dd>
    </dl>
  <p>The publication "<%=pub.getName()%>" has publication ID <%=pub.getId()%>.</p>

<% if ("true".equals(request.getAttribute("create"))) { %>
  <%
    Object contentResource = request.getSession().getAttribute("uploaded-resource:/escenic/content");
    if(contentResource != null) {
  %>
  <p>NOTE: There is a xml import running in the background to add content to your publication.</p>
  <% } %>
  
  <%
  java.util.Map sectionParameterResource = (java.util.Map)request.getSession().getAttribute("uploaded-resource:/0/escenic/section-parameter");
  if(sectionParameterResource != null) {
    byte[] data = (byte[])sectionParameterResource.get("data");
    String parameters = neo.util.StringUtil.escapeHtml(new String(data, 0, data.length));
   %>
  <p>
    <dl>
      <dt valign="top">The following section parameters were set for
      the root section of this publication.</dt>
      <dd>
        <pre>
        <%=parameters%>
        </pre>
      </dd>
    </dl> 
  </p>
  <% } %>
<% } %>
</logic:present>

<%
  }
} catch (Exception e) {
  out.println(e.toString());
}
%>

<hr />
