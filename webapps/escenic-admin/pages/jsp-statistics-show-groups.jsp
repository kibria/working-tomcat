<h1>JSP Statistics</h1>
<%
neo.util.callinfo.Statistics statistics = (neo.util.callinfo.Statistics) request.getAttribute("statistics");
if (statistics == null) { %>
  The statistics component (/neo/io/reports/Statistics) has not been installed on this server.
  <%
} else { %>
  Please select a group of statistics.
  <%
  if (statistics.getNames().size() != 0) { %>
  <ul>
  <%
  for (java.util.Iterator i =  statistics.getNames().iterator(); i.hasNext();) {
    String name = (String) i.next(); %>
    <li>
    <a href="<%= name %>"><%=name%></a>
    </li>
    <%
  } %>
  </ul>
  <%
  } else { %>
    <p>
    <em>You have not enabled any web applications for statistics
    collection since the server was started.</em>
    </p>
  <% } %>
  <p>
  To enable JSP profiling, two steps must be completed.  A servlet filter must be installed in your web application, and
  the filter must be enabled.
  </p>
  <p>
  To add the filter, add the following servlet filter to your web.xml:
  <pre>
  &lt;filter>
    &lt;filter-name>ECEProfileFilter&lt;/filter-name>
    &lt;filter-class>com.escenic.servlet.ECEProfileFilter&lt;/filter-class>
  &lt;/filter>

  &lt;filter-mapping>
    &lt;filter-name>ECEProfileFilter&lt;/filter-name>
    &lt;url-pattern>/*&lt;/url-pattern>
    &lt;dispatcher>INCLUDE&lt;/dispatcher>
    &lt;dispatcher>FORWARD&lt;/dispatcher>
  &lt;/filter-mapping>
  </pre>
  This filter is turned off by default, to avoid memory leakage in production environments when the filter is left
  on for a long time.  Therefore, the filter must be actively turned on.
  </p>
  <p>
  To make your web application log JSP template performance at all, you need to specify an application scoped variable called
  <tt>neo.util.servlet.RequestInfo.StatisticsSource</tt>.  Make a JSP page with the following fragment of code:</p>
  <pre>pageContext.getServletContext().setAttribute(
        "neo.util.servlet.RequestInfo.StatisticsSource",
        neo.nursery.GlobalBus.lookupSafe("/neo/io/reports/ReportsStatisticsSource"));</pre>
  <p>
  This will profile JSP calls based on database, memory, and time usage.  Invoke the above lines, and the filter will kick
  into action, and you will see the results on this page.
  </p>
  <h2>Advanced topics</h2>
  <p>This section describes some more advanced options for the experimental user</p>
  <h3>Profiling cache footprint</h3>
  <p>
  It is easy to profile something other than the standard memory, database connections and so on.  These resources are
  universally constrained, and universally useful.  However, there are times when you want to find out why your templates
  are exherting strain on the presentation layer caches.  To do this, it is wiser to profile this directly.  Turn on profilnig.
      
  </p>
  <h3>Profiling other resources</h3>
  <p>
  As you can see, you must name a StatisticsSource component.
  To add more instrumentation, modify the component, or
  create your own StatisticsSource.
  There is another source of statistics defined in Escenic Content Engine,
  called <tt>CacheHits</tt>:
  </p>
  <pre>pageContext.getServletContext().setAttribute(
      "neo.util.servlet.RequestInfo.StatisticsSource",
      neo.nursery.GlobalBus.lookup("/neo/io/reports/CacheHits"));</pre>
  <p>
  The <tt>CacheHits</tt> will show you the number of hits, misses and additions to three
  central presentation layer caches.
  </p>
  <%
} %>
