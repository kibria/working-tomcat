<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<dl>
  <dt><a href="status.jsp">Status &raquo;</a></dt>
  <dd>Check the status of this server and its configuration.
      Use this page to verify that the server is set up correctly.
      The Status page will perform simple checks toward the Database
      to verify that the configured values actually work.</dd>
      
  <dt><a href="nurserystatus.jsp">Configuration Layer Report &raquo;</a></dt>
  <dd>Check the critical properties in the configuration layers
     of this server.  Use this to see if you have problems initially setting
     up the server.  Normally, these properties don't
     change after an initial installation.</dd>

  <dt><a href="pages/plugin/list.jsp">View installed plugins &raquo;</a></dt>
  <dd>Any plugins that have been installed successfully will be shown on this page.</dd>

  <dt><a href="pages/publication/sessions.jsp">View sessions &raquo;</a></dt>
  <dd>View a list of user sessions created since the last startup of the server.</dd>

  <dt><a href="pages/performance.jsp">Performance Summary &raquo;</a></dt>
  <dd>Display a performance summary of this server.  This will show a
      summary of all of Escenic's caches, along with the current request
      times, statistics for database access, and memory information.</dd>
      
  <dt><a href="pages/systemproperties.jsp">System properties &raquo;</a></dt>
  <dd>View all the system properties in the system.</dd>

  <dt valign="top"><a href="do/services/display">View services &raquo;</a></dt>
  <dd valign="top">View services.</dd>

  <dt><a href="pages/support-request.jsp">Issue a support request &raquo;</a></dt>
  <dd>To contact Escenic Support, e-mail <a href="mailto:support@escenic.com">support@escenic.com</a>.  We have
      provided a page listing the most important features from this server,
      all in one page, ready to cut-and-paste into your support ticket.</dd>
      
  <dt><a href="pages/threaddump.jsp">Create a thread dump &raquo;</a></dt>
  <dd>Creates a thread dump from the server.</dd>


<util:pluginResources
      type="internal-link"
      target="admin"
      task="/index"
      area="menu"
      id="resources" />
<util:pluginResources
      type="external-link"
      target="admin"
      task="/index"
      area="menu"
      id="externalResources" />
<logic:iterate name="resources" id="resource" type="neo.xredsys.plugin.Resource" >
  <dt><html:link page="<%=resource.getUri()%>"><bean:write name="resource" property="label"/> &raquo;</html:link></dt>
  <dd><%=resource.getPlugin().getParameter("neo.phoenix.plugin.description")%></dd>
</logic:iterate>
<logic:iterate name="externalResources" id="resource" type="neo.xredsys.plugin.Resource" >
  <dt><a href="<%=resource.getUri()%>"><bean:write name="resource" property="label"/> &raquo;</a></dt>
  <dd><%=resource.getPlugin().getParameter("neo.phoenix.plugin.description")%></dd>
</logic:iterate>
</dl>
<h3>Helpers:</h3>
<dl>
  <dt><a href="top?refresh=1">Top &raquo;</a></dt>
  <dd>Show the most active JSP files that are currently active.  This will
      provide a dynamic real-time view of a running system.  It shows the
      amount of time spent in different resources in the last two second
      interval.</dd>

  <dt><a href="logger.jsp">View the browser log &raquo;</a></dt>
  <dd>The browser log displays errors generated by the templates. You
      can add your own log messages in templates. The ECE tag libraries also
      output their messages into this log. Please use the
      '<a href="debug" target="debug">View the logging levels</a>'
      to adjust the log levels.
  </dd>

  <dt><a href="debug">Configure logging levels &raquo;</a></dt>
  <dd>The debug logs can help you diagnose your system.  By adjusting the
     logging levels of individual components you can generate the
     necessary logs to find the failing component</dd>

  
  <dt><a href="statistics/">View JSP Statistics &raquo;</a></dt>
  <dd>The JSP statistics can show the hot-spots of your JSP templates.
      The statistics include time and database resources spent in each
      of your JSP templates.  It is also possible to get a raw CSV
      of the data for further processing.
  </dd>

  <dt><a href="do/publication/cache-invalidation">Remove objects from cache &raquo;</a></dt>
  <dd>Allows you to remove objects from the Escenic caches
     by specifying numeric IDs or SQL statements to retrieve the IDs.</dd>
     
  <dt><a href="do/publication/clearallcaches">Clear all caches &raquo;</a></dt>
  <dd>This option will allow you to clear all the caches in this Escenic
     Content Engine. It is useful for debugging cache-related issues.</dd>
  
      
  <dt><a href="browser/Global/Initial">Component Browser &raquo;</a></dt>
  <dd>Browse the Escenic Components and modify their configured values on the fly.</dd>

  <dt><a href="pages/database/query.jsp">Database Browser &raquo;</a></dt>
  <dd>Execute SQL Queries toward the database.</dd>
  
</dl>