<%@ page contentType="text/html" import="com.escenic.phoenix.admin.servlet.ECEBrowserHelper, neo.nursery.Bus, neo.nursery.GlobalBus, java.net.URLEncoder" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Comparator" %>
<h4>Select a scope to browse</h4>
<%
    out.println("<a href=\""+request.getContextPath()+"/browser/"+ ECEBrowserHelper.makeUrlSafeBusName(GlobalBus.getGlobalBus())+"/\">"+GlobalBus.getGlobalBus().getDisplayName()+"<a/><br>");
    List<Bus> children = new ArrayList<Bus>(GlobalBus.getGlobalBus().getChildren());
    Collections.sort(children, new Comparator<Bus>() {

      public int compare(final Bus o1, final Bus o2) {
        return o1.getDisplayName().compareTo(o2.getDisplayName());
      }
    });
    for (Bus entry : children) {
        out.println("<a href=\""+request.getContextPath()+"/browser/"+ ECEBrowserHelper.makeUrlSafeBusName(entry)+"/\">" +
                ""+entry.getDisplayName()+"<a/><br>");
    }
%>
