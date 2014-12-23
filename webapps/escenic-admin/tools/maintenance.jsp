<%
String error = null;
java.util.List messages = new java.util.ArrayList();
String pubname = request.getParameter("publication");
try {
  neo.xredsys.api.Publication p;
  if (!neo.util.StringUtil.isEmpty(pubname)) {
    messages.add("Loading publication " + pubname);
    p = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPublication(pubname);
    messages.add("Successfully loaded publication " + pubname);
    if (neo.util.StringUtil.getBoolean(request.getParameter("layouts"))) {
      p.scanPublicationLayouts();
      messages.add("Successfully reloaded layouts");
    }
    if (neo.util.StringUtil.getBoolean(request.getParameter("articletypes"))) {
      neo.xredsys.content.type.TypeManager.getInstance().invalidate(p.getId());
      messages.add("Successfully reloaded layouts");
    }
    if (neo.util.StringUtil.getBoolean(request.getParameter("clearparamcache"))) {
      neo.xredsys.api.IOAPI.getAPI().getObjectUpdater().emptySectionParameterCache();
      messages.add("Successfully sent flush request");
    }
    if (neo.util.StringUtil.getBoolean(request.getParameter("refresh"))) {
      neo.xredsys.content.PublicationManager.getPublicationManager().getPublication(p.getId()).refreshPublication();
      messages.add("Successfully refreshed publication");
    }
  } else {
    pubname = "";
  }
} catch (Exception e) {
  e.printStackTrace();
  error = e.toString();
}


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Publication Maintenance</title>
  </head>

  <body>
    <h1>Publication Maintenance</h1>
    <% if (! messages.isEmpty()) { %>
    <h2>Messages</h2>
    <ol>
      <% for (java.util.Iterator i = messages.iterator(); i.hasNext(); ) {
           String message = (String)i.next(); %>
          <li><%=message%></li>
      <% } %>
    </ol>
    <% } %>
    <% if (error != null) { %>
    <h2>An error occured</h2>
    <pre style="color: red;"><%=error%></pre>
    <% } %>

    <form method="get" action="maintenance.jsp">
      Publication Name: <input name="publication" type="text" value="<%=pubname%>" /> <input type="submit"/><br/>
      <input type="checkbox" name="layouts" value="true" /> Reload layouts (on this server only)<br/>
      <input type="checkbox" name="articletypes" value="true" /> Reload article types (on this server only)<br/>
      <input type="checkbox" name="clearparamcache" value="true" /> Clear Parameter Cache (on all servers I send events to)<br/>
      <input type="checkbox" name="refresh" value="true" /> Perform a 'Refresh publication (on this server only)<br/>
    </form>
  </body>
</html>
