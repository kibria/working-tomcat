<%--
  ******************************************************************************
  * Copyright (C) 2002 Escenic AS.
  * All Rights Reserved.  No use, copying or distribution of this
  * work may be made except in accordance with a valid license
  * agreement from Escenic AS.  This notice must be included on
  * all copies, modifications and derivatives of this work.
  ******************************************************************************
  *           File: $Header: //depot/escenic/engine/branches/5.7/phoenix/phoenix-admin/src/main/webapp/pages/performance-content.jsp#4 $
  * Last edited by: $Author: kewl $ $Date: 2013/12/20 $
  *   Version     : $Revision: #4 $
  ******************************************************************************
  * This is a prototype for the "all new" Component Browser
  ******************************************************************************
 --%>

<%@ page language="java" %>
<%@ page import="com.escenic.phoenix.admin.servlet.PerformancePageHelper" %>
<%@ page import="neo.nursery.GlobalBus" %>
<%@ page import="com.escenic.common.util.JSONMap" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    JSONMap report = PerformancePageHelper.getJSONReport();
    request.setAttribute("report", report);
    JSONMap keysToGet = new JSONMap(" {  " +
        "'cache' : [ " +
            "'hit-ratio', " +
            "'size', " +
            "'hits', " +
            "'adds', " +
            "'misses', " +
            "'removes', " +
            "'expires', " +
            "'pushes', " +
            "'clears', " +
            "'average-idle-last-thrown', " +
            "'gen-hitrate', " +
            "'description' " +
        "],  " +
        "'collector' :  [ " +
          "'hits', " +
          "'misses', " +
          "'load', " +
          "'hertz', " +
          "'average-duration', " +
          "'duration', " +
          "'peak', " +
          "'gen-load', " +
          "'description' " +
        "],  " +
        "'throttle' : [" +
          "'usage', " +
          "'limit', " +
          "'gen-ratio' , " +
          "'description' " +
        "] }");
    request.setAttribute("keysToGet", keysToGet);
    JSONMap whats = new JSONMap(" {  'cache' : 'Caches', 'collector' : 'Load Averages', 'throttle' : 'Activity Monitors' } ");
    request.setAttribute("whats", whats);
    // .number -- typically right aligned
    // .number.mode-raw -- raw value left untouched (default)
    // .number.mode-iso -- 1000 and millions replaced with "k" and "M" etc.
    // .millisecond -- replaced with user friendly variant (original left, just hidden)
    // .millisecond.mode-millisecond-raw -- Show as milliseconds (default) seldom used
    // .millisecond.mode-millisecond-seconds -- Show as seconds
    // .millisecond.mode-millisecond-full -- Show very verbose
    // .counter -- can calculate Hz, graphing Hz
    // .counter.mode-counter-raw -- show the raw sample (default)
    // .counter.mode-counter-delta -- show the raw sample + change in data from the last sample
    // .counter.mode-counter-hz -- show the raw sample + change as Hz
    // .gauge -- Number that can vary up or down, remembers highs and lows. can be graphed.
    // .gauge.mode-gauge-raw -- shows the raw data
    // .gauge.mode-gauge-delta -- shows the raw data + change in the gauge
    // .gauge.mode-gauge-minmax -- shows the raw data + minimum and maximum recorded values
    JSONMap keyClasses = new JSONMap(" {  " +
        "'jvm' : { " +
          "'uptime' : 'millisecond number mode-millisecond-full', " +
          "'memory-usage' : 'gauge number mode-minmax', " +
          "'threads' : 'gauge number mode-raw' " +
        "},  " +
        "'cache' : { " +
          "'size' : 'number', " +
          "'hit-ratio' : 'counter number mode-counter-raw', " +
          "'adds' : 'counter number mode-counter-raw', " +
          "'hits' : 'counter number mode-counter-raw', " +
          "'misses' : 'counter number mode-counter-raw', " +
          "'removes' : 'counter number mode-counter-raw', " +
          "'expires' : 'counter number mode-counter-raw', " +
          "'pushes' : 'counter number mode-counter-raw', " +
          "'clears' : 'counter number mode-counter-raw', " +
          "'average-idle-last-thrown' : 'gauge millisecond number mode-gauge-raw mode-millisecond-full', " +
          "'popular' : 'gauge number', " +
          "'lru-distribution' : 'mode-bar', " +
          "'popularity-distribution' : 'mode-line', " +
          "'gen-hitrate' : '', " +
          "'description' : '' },  " +
        "'collector' :  { " +
          "'hits' : 'counter number mode-counter-hz', " +
          "'misses' : 'counter number mode-counter-raw', " +
          "'duration' : 'millisecond number mode-millisecond-seconds', " +
          "'average-duration' : 'millisecond number mode-millisecond-seconds', " +
          "'load' : '', " +
          "'hertz' : '', " +
          "'peak' : 'number', " +
          "'gen-load' : '', " +
          "'description' : '' " +
        "},  " +
        "'throttle' : {" +
          "'usage' : 'gauge number', " +
          "'limit' : ' number' , " +
          "'description' : '' " +
        "} }");
    request.setAttribute("keyClasses", keyClasses);
    JSONMap keyLabels = new JSONMap(" {  " +
        "'cache' : { " +
          "'size' : 'Size', " +
          "'adds' : 'Adds', " +
          "'hits' : 'Hits', " +
          "'misses' : 'Misses', " +
          "'hit-ratio' : 'Hit ratio', " +
          "'removes' : 'Removes', " +
          "'expires' : 'Expired', " +
          "'pushes' : 'Pushed', " +
          "'clears' : 'Clears', " +
          "'average-idle-last-thrown' : 'Idle', " +
          "'popular' : 'Cache Health', " +
          "'lru-distribution' : 'LRU Distribution', " +
          "'popularity-distribution' : 'Popularity distribution', " +
          "'gen-hitrate' : 'Live hit rate', " +
          "'description' : 'Cache type' " +
        "},  " +
        "'collector' :  { " +
          "'hits' : 'Success', " +
          "'misses' : 'Failures', " +
          "'duration' : 'Time', " +
          "'gen-load' : 'Load Average', " +
          "'load' : 'Load', " +
          "'hertz' : 'Effective'," +
          "'peak' : 'Peak', " +
          "'average-duration' : 'Avg time', " +
          "'description' : 'Description' " +
        "},  " +
        "'throttle' : {" +
          "'usage' : 'Current Usage', " +
          "'limit' : 'Limit' , " +
          "'description' : 'Description' " +
        "} }");
    request.setAttribute("keyLabels", keyLabels);
    JSONMap keyDescriptions = new JSONMap(" {  " +
        "'cache' : { " +
          "'size' : 'The current limit of objects in the cache', " +
          "'adds' : 'How many new objects that have been added to the cache since the server started.', " +
          "'removes' : 'How many objects that have been removed from the cache since the server started.', " +
          "'expires' : 'How many objects that has expired by the TTL since the server started.', " +
          "'pushes' : 'How many objects that has been pushed out of the cache due to size constraints.', " +
          "'clears' : 'How many objects that has been cleared when the cache is flushed.', " +
          "'hits' : 'The number of cache hits since the server started.', " +
          "'misses' : 'The number of cache misses since the server started.', " +
          "'average-idle-last-thrown' : 'The average time that an idle object uses to pass through the cache.', " +
          "'popular' : 'The health of a cache is measured every time it fills up.  The health is determined based on the number of popular objects in relation to the size of the cache.  In a healthy cache, the gague should be in the middle.', " +
          "'lru-distribution' : 'The last time the cache filled up, the distribution of objects in the cache, based on popularity. Left is is popular, right is unpopular. In a healthy cache, the left hand side of the graph should have more weight than the right hand side.', " +
          "'popularity-distribution' : 'The relative popularity of all the objects in the cache.  When a cache fills up, the objects are ordered after the last access time.  This graph shows how recently used the objects were relative to each other the last time the cache was full.  The high values on the left show the most recently used, while the low values on the right indicate the least recently used.', " +
          "'gen-hitrate' : 'Updated every two to three seconds, the percentage of hits of the total number of requests.  High is good..' " +
        "},  " +
        "'collector' :  { " +
          "'hits' : '', " +
          "'misses' : '', " +
          "'duration' : '', " +
          "'gen-load' : 'Graph of load average the last minute or so.', " +
          "'description' : '' " +
        "},  " +
        "'throttle' : {" +
          "'usage' : 'The number of resources of this type that are currently in use at this time.', " +
          "'limit' : 'The configured maximum limit.', " +
          "'description' : '' " +
        "} }");
    request.setAttribute("keyDescriptions", keyDescriptions);
%>

<p>
    <a href="<%= request.getContextPath() + "/" %>">admin</a>/Escenic
    Content Engine Performance Summary
</p>

<h1>Performance Summary</h1>
<p>
  This performance summary shows the most important components of
  the Escenic Content Engine instance that you're currently viewing.
  It shows the key statistics for the caches, load and activity monitor.
</p>
<input type="button" id="refresh" value="Refresh" title="Refreshes all the numbers, and updates the graphs.">
<label title="Automatically refreshes the numbers and graphs every 2.5 seconds." ><input type="checkbox" id="autorefresh"> Auto refresh</label>
<h1>Current Status Report</h1>
<pre><%=((neo.xredsys.config.ScheduledReport) GlobalBus.lookup("/neo/io/reports/Reporter")).getReport()%></pre>

<!-- todo: jquery these in; prog.enh.-->
<c:forEach items="${report}" var="bus">
  <%
    java.util.Map.Entry entry = (java.util.Map.Entry) pageContext.findAttribute("bus");
    String busName = (String) entry.getKey();
    pageContext.setAttribute("busName", com.escenic.phoenix.admin.servlet.ECEBrowserHelper.makeUrlSafeBusName(busName));
  %>
  <h2>${bus.key}</h2>
  <c:forEach items="${bus.value}" var="what">
    <%-- todo: make labels for these keys --%>
    <h3 title="${what.key}">${whats[what.key]}</h3>
    <table class="components ${what.key}">
      <thead>
        <tr>
    <c:forEach items="${what.value}" var="component" begin="0" end="0">
          <th align="left">Component Name</th>
      <c:forEach items="${keysToGet[what.key]}" var="statistic">
          <%-- todo: make labels for these keys --%>
          <th align="left" title="${keyDescriptions[what.key][statistic]}">${keyLabels[what.key][statistic]}</th>
      </c:forEach>
    </c:forEach>
        </tr>
      </thead>
      <tbody>
    <c:forEach items="${what.value}" var="component">
        <tr class="component">
          <th class="component-name" ><a href="<%=request.getContextPath()%>/browser/${busName}${component.key}">${component.key}</a></th>
      <c:forEach items="${keysToGet[what.key]}" var="statistic">
          <td class="${statistic} ${keyClasses[what.key][statistic]}"><span class="raw">
        <c:set var="v" value="${component.value[statistic]}" />
        <% if (pageContext.getAttribute("v") instanceof Iterable) { %>
          <c:forEach items="${v}" var="vitem">${vitem} </c:forEach>
        <% } else { %>
          ${v}
        <% } %>
          </span></td>
      </c:forEach>
        </tr>
    </c:forEach>
      </tbody>
    </table>
  </c:forEach>
</c:forEach>

<%--

make LAST_THROW a relative date (x seconds ago) using javascript
filter out uninteresting statistics (by CSS'ing them away)
pretty numbers as "23.1k" instead of 23124
sparkline certain numbers, join specific cells
make non-numeric values not be right aligned
link to component name
 --%>


<style>
  .hidden {display: none;}
  .idle { color: #999; font-style: italic; }
  td.number {text-align: right;}
  td.hertz:after {
    content: "Hz";
  }
  /* Todo: remove these from CSS, make them scripted */
  td.popularity-distribution span.raw,
  td.lru-distribution span.raw,
  td.popular span.raw { display: none; }
  th.component-name { text-align: left; }
  td.modified { color: #900; }
</style>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="jquery.sparkline.min.js"></script>
<script>
  function ensureMode(t, modes) {
    for (var i in modes) {
      if (t.hasClass("mode-" + modes[i])) {
        return modes[i];
      }
    }
    t.addClass("mode-" + modes[0]);
    return modes[0];
  }

  function createSpanIfNeeded(t, className, additionalClassNames) {
    var bullet = t.find("." + className);
    if (typeof additionalClassNames != "undefined") {
      additionalClassNames = " " + additionalClassNames;
    }
    else {
      additionalClassNames = "";
    }
    if (bullet.size() == 0) {
      return $("<span class='" + className + additionalClassNames + "'></span>").appendTo(t);
    }
    return bullet;
  }

  /*
   * Calculates a running delta by storing the delta value in an HTML element supplied.
   * mark's text is read and written to.
   * the response of this method is either null, if it's impossible to calculate a delta, or
   * an array containing two values, where the first value is the difference in value since
   * the "last time" the method was called, and the second is the time (in milliseconds)
   * since the last method was called.  The context of this is the mark element itself.
   * Both return values are integers, zero or positive. 
   */
  function calculateDelta(mark, newValue) {
    var now = new Date().getTime();

    // span.mark contains the values of the last "mark" if any.
    var marktext = mark.text();

    // unconditionally store the new values
    mark.text(newValue + " " + now);

    // if the mark text is malformed (must contain a space), glitch.
    if (marktext.indexOf(" ") < 0) {
      return null;
    }
    // response contains the deltas since the last
    var response = [
      newValue - parseInt(marktext.substring(0, marktext.indexOf(" "))),
      now - parseInt(marktext.substring(marktext.indexOf(" ")))
    ];

    // response[1] should never be negative, but what the heck.
    if (response[0] < 0 || response[1] < 0) return null;
    return response;
  }

  function remember(history, value, count, nullValue) {
    if (history.text() == "") history.text([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0].join(' '));
    // todo. figure out if there's a better way to store this
    // todo use the count parameter for something useful
    // todo use the nullValue as the initial value for the items

    var values = history.text().split(' ');
    values.shift();  // removes the first item
    values.push(value);
    history.text(values.join(" "));
    return values;
  }

  var updateLoad = function() {
    // mode-graph -- show a graph of the history of the load
    // mode-percent -- only show the percent load right now (hides the graph)

    t = $(this); // a "td.gen-load" inside a collector

    var bullet = createSpanIfNeeded(t, "sparkline");
    // span.current contains the current value
    var current = createSpanIfNeeded(t, "current");

    var duration = parseInt(t.parents("tr.component").find(".duration.number .raw").text());
    var delta = calculateDelta(createSpanIfNeeded(t, "mark", "hidden"), duration);
    // if the delta time is 0 we can't divide by anything, so ignore the sample.
    // this happens the first update (no delta) and if a glitch occurs (like the server
    // restarting
    if (delta == null || delta[1] == 0) return;

    var value = delta[0] / delta[1];
    var values = remember(
        createSpanIfNeeded(t, "history", "hidden"),
        (value * 1000).toFixed(0),
        30,
        0
    );
    bullet.empty();

    var mode = ensureMode(t, ["graph", "percent"]);
    if (mode == "graph") {
      bullet.sparkline(values, {
        "chartRangeMin" : "0",
        "fillColor" : "#fc0"
      });
      // Show four significant digits after the period
      current.text(" " + (value*100).toFixed(1)+'% ');
    }
    else if (mode == "percent") {
      current.text(" " + (value*100).toFixed(1)+'% ');
    }
  };


  var updatePopular = function() {
    // mode-raw -- show the raw number
    // mode-graph -- show the sparkline of the "health"
    // mode-health -- show a text indicating if the cache is too small or too big (?)

    var t = $(this); // a td.popular.number with span.raw inside it.

    var bullet = createSpanIfNeeded(t, "sparkline").css("padding", "0 10px");

    var value = parseInt(t.find(".raw").text());
    var size = parseInt(t.parents("tr.component").find(".size.number .raw").text());

    bullet.empty();
    if (value > 0) {
      var mode = ensureMode(t, ["graph", "raw"]);
      if (mode == "graph") {
        bullet.attr("title", value + " popular objects");
        bullet.sparkline([value*100, 0, size*100, size*95, size*80, size*70, size*30, size*20, size * 5   ], {
          "type":"bullet",
          "width":"100px",
          "performanceColor":"#f99",
          "targetColor":"#00f",
          "rangeColors":["#fcc", "#cfc", "#6f6", "#0f0", "#6f6", "#efe", "#fcc"]
        });
      }
      else if (mode == "raw") {
        bullet.attr("title", "");
        bullet.text(value);
      }
      else {
        bullet.attr("title", "");
        bullet.text("unknown mode");
      }
    }
    /*  TODO: make color of performance bar change based on how well things are going */
    // perhaps fake it by putting two sparklines beside each other, mirrored on 0, the goal is to have
    // as small a bar as possible.  Perhaps it's overkill.
  }

  var updateDistribution = function() {
    var t = $(this); // a td.lru-distribution.hidden, with a span.raw with the numbers

    var bullet = createSpanIfNeeded(t, "sparkline");
    var values = t.find(".raw").text().replace(/^\s+|\s+$/, '').split(/[ \r\n\s]+/);

    bullet.empty();
    var mode = ensureMode(t, ["bar", "line"]);
    if (mode == "line") {
      bullet.sparkline(values, {
        "width" : "100px",
        "type" : "line",

        "fillColor" : "#fc0",
        "chartRangeMin" : 0,
        "spotColor" : false,
        "minSpotColor" : false,
        "maxSpotColor" : false
      });
    }
    else if (mode == "bar") {
      bullet.sparkline(values, {
        "width" : "100px",
        "type" : "bar",

        "barWidth" : 6,
        "barSpacing" : 1,
        "barColor" : "#000"
      });
    }
    else if (mode == "huh") {
    }
  }

  var updateMissRates = function() {
    var t = $(this); // a "td.gen-hitrate" which is empty by default

    // span.mark contains the values of the last "mark" if any.
    var mark = createSpanIfNeeded(t, "mark", "hidden");
    if (mark.text() == "") {
      mark.text("-1 -1");
    }
    var marktext = mark.text();
    var oldHits = parseInt(marktext.substring(0, marktext.indexOf(" ")));
    var oldMisses= parseInt(marktext.substring(marktext.indexOf(" ")));
    var tparent = t.parents("tr.component");
    var hits = parseInt(tparent.find(".hits.number .raw").text());
    var misses = parseInt(tparent.find(".misses.number  .raw").text());

    // auto mark
    mark.text(hits + " " + misses);
    if (oldHits == -1) {
      return;
    }
    if ((hits - oldHits) + (misses - oldMisses) == 0) {
      var value = -1
    }
    else {
      var value = 100 * (hits - oldHits) / ((hits - oldHits) + (misses - oldMisses));
    }

    var bullet = createSpanIfNeeded(t, "gen-rate");
    if (value == -1) {
      bullet.addClass("idle")
      bullet.text("idle");
    }
    else {
      bullet.removeClass("idle")
      bullet.text(value.toFixed(2));
    }
  };


  var updateMilliseconds = function() {
    // mode-millisecond-raw -- show ms as is
    // mode-millisecond-full -- A verbose description
    // mode-millisecond-seconds -- show seconds (123154 seconds)
    var t = $(this); // a td.millisecond with a span.raw inside with raw millisecond data
    // Make the number hidden, insert a sibling span node that is shown instead
    // which shows a duration formatted as days/hours/minutes/seconds/ms 2d4:33:14.223
    // 123 ms
    // 45.121
    // 04:44.121
    // 13h04:44.121
    // 19d13:04:44.121

    var raw = t.find(".raw");
    raw.css("display", "none");
    var pretty = createSpanIfNeeded(t, "gen-millisecond-pretty");

    // switch the mode to figure out how to display this.
    // if (this.hasclass(mode-seconds)
    // Minimal amount of prettifying :-)
    var mode = ensureMode(t, ["millisecond-raw", "millisecond-seconds", "millisecond-full"]);
    if (mode == "millisecond-raw") {
      pretty.text(((parseInt(raw.text())) / 1000).toFixed(3) + " s");
    }
    else if (mode == "millisecond-seconds") {
      pretty.text(((parseInt(raw.text())) / 1000).toFixed(1) + " s");
    }
    else { // full
      var v = parseInt(raw.text());
      var result = (v % 1000 / 1000).toFixed(3).replace(/^0/,"");
      v = Math.floor(v / 1000)
      result = (v % 60) + result;
      v = Math.floor(v / 60);
      if (v == 0) {
        result = result + " s";
      }
      else {
        // replace trailing digits
        //result = result.replace(/..$/,'');
        result = (v % 60) + ":" + result
        v = Math.floor(v / 60);
        if (v == 0) {
          result = result.replace(/:/, 'm');
        }
        else {
          result = (v % 24) + ":" + result
          v = Math.floor(v / 24);
          if (v == 0) {
            result = result.replace(/:/, 'h');
          }
          else {
            result = v + "d" + result
          }
        }
      }
      pretty.text(result);
    }
  }


  var updateCounter = function() {
    var t = $(this); // a td.counter with a span.raw that just keeps growing
    // Show changes to these based on the previous value using a hidden "mark"
    // before: [1231]
    // after: [1231 (+41, 12/s)]
    // perhaps keep 2 samples to calculate an average over the last minute or so,
    // and give a "rate" instead (Hz).  Graph the add rate?  Hmm...
    // after: [1231 _/\___ (+41, 12/s)]
    // perhaps enable these by clicking, e.g. if you click on a statistic, it
    // becomes a different statistic.  That would be cool.  So then updateCounter
    // would have to check what "mode" the statistic is in before it continues.

    var rate = createSpanIfNeeded(t, "gen-rate");
    var mark = createSpanIfNeeded(t, "mark");
  }


  var updateGauge = function() {
    var t = $(this); // a td.gauge with a span.raw that goes up and down
    // Graph show how it grows and dips. ___A__/VW\_/^~~^\_
    // Show the extremities (minimum, current, maximum) (with a reset button?)
  }


  var autoRefresh = function() {
    if (! $("#autorefresh").is(':checked')) {
      return false;
    }
    refresh();
  }


  var refresh = function() {
    var j = $.getJSON("performance-json.jsp", function(data,textstatus) {
      $("h2").each(function(){
        var h2 = $(this);
        var scope=h2.text();
        h2.nextAll("h3,h2").each(function() {
          //only loop until next H2
          if (this.tagName=="H2") return false;
          var h3 = $(this);
          var what=h3.attr("title");
          h3.next("table").find("tr.component").each(function() {
            var tr = $(this);
            var component = tr.children("th").text();
            var newValues = data[scope][what][component];
            $.each(newValues, function(key) {
              var targetTd = tr.find("td." + key);
              var targetSpan = targetTd.find("span.raw");
              if (newValues[key].join) {
                var newValue = newValues[key].join(" ");
              }
              else {
                var newValue = newValues[key];
              }
              if (targetSpan.text() != newValue) {
                targetSpan.text(newValue);
                targetTd.addClass("modified");
              }
              else {
                targetTd.removeClass("modified");
              }
            });
          });
        });
      });
    });
    // Update "special" sparklines
    $("td.popular.modified").each(updatePopular);
    $("td.lru-distribution.modified").each(updateDistribution);
    $("td.popularity-distribution.modified").each(updateDistribution);
    $("td.gen-load").each(updateLoad);  // load is function of time, so is usually always modified
    $("td.gen-hitrate").each(updateMissRates);  // hitrates handle modified stuff too.
    // update generic sparks too (gauge, counter, etc).
    $("td.gauge").each(updateGauge);  // not in use...
    $("td.millisecond.modified").each(updateMilliseconds);
  };
  setInterval('autoRefresh()', 2500);

  $(document).ready(function() {
    $("td.millisecond").each(function() {
      var t = $(this);
      if (t.hasClass("mode-millisecond-full")) {
        t.removeClass("mode-millisecond-full");
        t.addClass("mode-millisecond-seconds");
      }
      else if (t.hasClass("mode-millisecond-seconds")) {
        t.removeClass("mode-millisecond-seconds");
        t.addClass("mode-millisecond-raw");
      }
      else if (t.hasClass("mode-millisecond-raw")) {
        t.removeClass("mode-millisecond-raw");
        t.addClass("mode-millisecond-full");
      }
      t.each(updateMilliseconds);
    });
  });

</script>



</body>
