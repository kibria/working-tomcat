<%

String outputFormat = request.getParameter("format"); 
String path = (String) request.getAttribute("path");
String name = (String) request.getAttribute("name");
neo.util.callinfo.CallInfoCollector collector = (neo.util.callinfo.CallInfoCollector) request.getAttribute("collector");
neo.util.callinfo.Statistics statistics = (neo.util.callinfo.Statistics) request.getAttribute("statistics");
java.util.Set metricKeys = (java.util.Set) request.getAttribute("metricKeys");
String errormessage = (String) request.getAttribute("errormessage");
String delim = "\t";


if ("csv".equals(outputFormat)) {

  response.setContentType("application/csv");
  out.print("uri"); out.print(delim);
  for (java.util.Iterator keys = metricKeys.iterator(); keys.hasNext(); ) {
    String key = (String)keys.next();
    out.print(key); out.print(".total"); out.print(delim);
    out.print(key); out.print(".count"); out.print(delim);
    out.print(key); out.print(".low"); out.print(delim);
    out.print(key); out.print(".high"); out.print(delim);
  }
  out.println();

  for (java.util.Iterator i = collector.getAll().iterator(); i.hasNext(); ) {
    neo.util.callinfo.AggregateCallInfo info = (neo.util.callinfo.AggregateCallInfo) i.next();
    out.print('"');
    out.print(info.getUri());
    out.print('"');
    out.print(delim);
    for (java.util.Iterator keys = metricKeys.iterator(); keys.hasNext(); ) {
      String key = (String)keys.next();
      out.print(info.getTotal(key)); out.print(delim);
      out.print(info.getCount(key)); out.print(delim);
      out.print(info.getLow(key)); out.print(delim);
      out.print(info.getHigh(key)); out.print(delim);
    }
    out.println();
  }
}
%>