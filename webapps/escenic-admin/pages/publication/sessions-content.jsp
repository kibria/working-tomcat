<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.escenic.service.user.SessionManager"%>
<%@ page import="com.escenic.service.user.Session"%>
<%@ page import="com.escenic.phoenix.admin.servlet.UserSessions"%>
<%@ page import="java.util.Date"%>
<%@ page import="neo.nursery.GlobalBus"%>
<%@ page import="neo.xredsys.api.IOAPI"%>
<%@ page import="neo.util.StringUtil"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Hashtable"%>
<bean:parameter id="orderBy" name="orderBy" value="<%= Session.ATT_LAST_UPDATED %>"/> <%-- Default: sort by "last updated"  --%>
<bean:parameter id="descending" name="descending" value="true"/> <%-- Default: sort descending --%>
<bean:parameter id="publicationIDStr" name="publicationID" value=""/>
<bean:parameter id="filterExact" name="filterExact" value=""/>
<bean:parameter id="offset" name="offset" value="0"/>
<bean:parameter id="itemsPerPageStr" name="itemsPerPage" value="20"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="Expires" content="0">
	<meta http-equiv="Pragma" content="no-cache">
	<title>Sessions</title>
	<script type="text/javascript" language="JavaScript">
	<%-- To allow submitting a form by pressing enter --%>
	<!--
	function submitenter(myfield,e) {
		var keycode;
		
		if (window.event)
			keycode = window.event.keyCode;
		else if (e)
			keycode = e.which;
		else
			return true;
		
		if (keycode == 13) {
		   myfield.form.submit();
		   return false;
		}
		else
		   return true;
	}
	//-->
	</script>
</head>
<body>
	
<%
			Hashtable filterTable = new Hashtable();
			Enumeration paramNamesEnum = request.getParameterNames();
			while (paramNamesEnum.hasMoreElements()) {
			  String paramName = paramNamesEnum.nextElement().toString();
			  if (paramName.startsWith("filter_")) {
			    filterTable.put(paramName.substring("filter_".length()), request.getParameter(paramName));
			  }
			}
			
			if (filterTable.isEmpty()) {
			  // Default filter: don't display expired sessions
			  filterTable.put(Session.ATT_EXPIRED, "false");
			}

			int itemsPerPage = 20;
			try {
			  itemsPerPage = Integer.parseInt(itemsPerPageStr);
			}
			catch (NumberFormatException nfe) {}

			DateFormat formatter = DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT, request.getLocale());

			String SERVICE = "/com/escenic/service/UserSessionsService";
			if (!GlobalBus.getGlobalBus().isAvailable(SERVICE)) {
	%>
		<div class="error">
			The service <%=SERVICE%> is not running! When the service is enabled, it will collect user information
			which is displayed on this page.
		</div>
		<p/>
<%
	return;}

	Long publicationID = null;

	if (!StringUtil.isEmpty(publicationIDStr))
		publicationID = new Long(request.getParameter("publicationID"));

	Session[] sessions = new UserSessions().getSessions(publicationID, filterTable, !StringUtil.isEmpty(filterExact), orderBy, Boolean.valueOf(descending).booleanValue());

	String[][] xcolumns = {
	    { Session.ATT_PUBLICATION_NAME, "Publication"},
	    { Session.ATT_USER, "Username"},
	    { Session.ATT_SUBSYSTEM, "Subsystem"},
	    {"sessionid", "Session ID"},
	    { Session.ATT_SPAWNED, "Spawned"},
	    {"lastoperation", "Last operation"},
	    { Session.ATT_LAST_UPDATED, "Last updated" },
	    { Session.ATT_EXPIRED, "Expired?"},
	};
	ArrayList columns = new ArrayList();
	
	for (int i = publicationID != null ? 1/* skip publication column */:0; i < xcolumns.length; i++)
	  columns.add(xcolumns[i]);
%>
	<h1>Sessions <%
	if (publicationID != null) {
	%>for publication '<%=IOAPI.getAPI().getObjectLoader().getPublicationById(publicationID.intValue()).getName()%>'<%
	}
	%></h1>
	<table>
		<tr>
			<td>
				<form action="<%= request.getRequestURI() %>" method="post">
					<input type="hidden" name="publicationID" value="<%= publicationIDStr %>"/>
					<input class="button" type="submit" value="Clear" title="Remove all filters"/>
				</form>
			</td>
			<td>
				<form action="<%= request.getRequestURI() %>" method="post">
					<input type="hidden" name="orderBy" value="<%= orderBy %>" />
					<input type="hidden" name="descending" value="<%= descending %>" />
					<input type="hidden" name="publicationID" value="<%= publicationIDStr %>"/>
                                        <%= getFilterParameters(request) %>
					<input class="button" type="submit" value="Refresh" title="Reload the data"/>
				</form>
			</td>
		</tr>
	</table>

	<div class="inlinehelp">
        Enter a filter value in the text box below the column name, and hit enter to filter by that column.
        <br/>
        To sort by a certain column, click on the column name.  Clicking it again will reverse the sort order.
    </div>
	
	<table>
		<thead>
			<tr>
				<logic:iterate id="column" collection="<%= columns %>" indexId="idx">
					<%
							String columnName = ((String[]) column)[0];
							String columnTitle = ((String[]) column)[1];
					%>
					<th>
						<form action="<%= request.getRequestURI() %>" method="post" id="<%= "form" + idx %>">
							<input type="hidden" name="orderBy" value="<%= columnName %>" />
							<input type="hidden" name="descending" value="<%= (columnName.equals(orderBy) && !Boolean.valueOf(descending).booleanValue()) ? true : false %>" />
							<input type="hidden" name="publicationID" value="<%= publicationIDStr %>"/>
                                                        <%= getFilterParameters(request) %>
						</form>
						<div onclick="javascript:document.getElementById('<%= "form" + idx %>').submit();" style="cursor: pointer">
							<%=columnTitle%>
						<%
								  if (columnName.equals(orderBy)) {
								  if (Boolean.valueOf(descending).booleanValue()) {
						%>&uarr;<%
								  }
								  else {
						%>&darr;<%
								}
								}
						%>
						</div>
					</th>
				</logic:iterate>
			</tr>
			<tr>
                            <form action="<%= request.getRequestURI() %>" method="post" id="filterform">
                                <input type="hidden" name="orderBy" value="<%= orderBy %>" />
                                <input type="hidden" name="descending" value="<%= descending %>" />
                                <input type="hidden" name="publicationID" value="<%= publicationIDStr %>"/>
				<logic:iterate id="column" collection="<%= columns %>" indexId="idx">
					<%
					String columnName = ((String[]) column)[0];
					%>
					<th>
                                            <%
                                            if (!Session.ATT_LAST_UPDATED.equals(columnName) && !Session.ATT_SPAWNED.equals(columnName)) {
                                            %>
                                            <input onkeypress="return submitenter(this,event)" type="text" name="filter_<%= columnName %>" style="width: 100%" value="<%= filterTable.containsKey(columnName) ? filterTable.get(columnName) : "" %>"/>
                                            <%
                                            }
                                            %>
					</th>
				</logic:iterate>
                            </form>
			</tr>
		</thead>
		<tfoot>
			<%
			if (sessions.length > itemsPerPage) {
			%>
			<tr>
				<th colspan="<%= columns.size() %>">
					<form action="<%= request.getRequestURI() %>" method="post">
						<input type="hidden" name="orderBy" value="<%= orderBy %>" />
						<input type="hidden" name="descending" value="<%= descending %>" />
						<input type="hidden" name="publicationID" value="<%= publicationIDStr %>"/>
                                                <%= getFilterParameters(request) %>
						<button type="submit" name="offset" title="First page" value="0">[&lt;&lt;</button>
						<button type="submit" name="offset" title="-10 pages" value="<%= Math.max(0, Integer.parseInt(offset) - 10*itemsPerPage) %>">&lt;&lt;</button>
						<button type="submit" name="offset" title="Previous page" value="<%= Math.max(0, Integer.parseInt(offset) - itemsPerPage) %>">&lt;</button>
				Page <%=(int) Math.round((Double.parseDouble(offset) / itemsPerPage))+1%> of <%=(int)Math.round((double)sessions.length / (double)itemsPerPage)%>
						<button type="submit" name="offset" title="Next page" value="<%= Math.min(((sessions.length / itemsPerPage)) * itemsPerPage, Integer.parseInt(offset) + itemsPerPage) %>" >&gt;</button>
						<button type="submit" name="offset" title="+10 pages" value="<%= Math.min(((sessions.length / itemsPerPage)) * itemsPerPage, Integer.parseInt(offset) + 10*itemsPerPage) %>">&gt;&gt;</button>
						<button type="submit" name="offset" title="Last page" value="<%= ((sessions.length / itemsPerPage)) * itemsPerPage %>">&gt;&gt;]</button>
					</form>
				</th>
			</tr>
			<%
			}
			%>
			<tr>
				<th colspan="<%= columns.size() %>">Total: <%=sessions.length%></th>
			</tr>
		</tfoot>
		<tbody>
			<%
			boolean odd = false;
			%>
			<logic:iterate id="sessionRow" offset="<%= offset %>" length="<%= String.valueOf(itemsPerPage) %>" collection="<%= sessions %>" type="com.escenic.service.user.Session">
				<tr class="<%= odd ? "odd" : "even" %>">
					<logic:iterate id="column" collection="<%= columns %>">
					<%
							String columnName = ((String[]) column)[0];
							String cellValue;
							
							if (Session.ATT_SPAWNED.equals(columnName) || Session.ATT_LAST_UPDATED.equals(columnName) ) {
							  Date date = new Date(Long.parseLong(sessionRow.getAttribute((columnName))));
							  cellValue = formatter.format(date);
							}
							else {
							  cellValue = sessionRow.getAttribute(columnName);
							}
              if (cellValue == null) {
                cellValue = "&nbsp;";
              }
					%>
					<td><%= cellValue %></td>
					</logic:iterate>
				</tr>
				<% odd = !odd; %>
			</logic:iterate>
		</tbody>
	</table>

</body>
</html>

<%!
private String getFilterParameters(HttpServletRequest request) {
	Enumeration paramNamesEnum = request.getParameterNames();
        StringBuffer buf = new StringBuffer();
	while (paramNamesEnum.hasMoreElements()) {
	  String paramName = paramNamesEnum.nextElement().toString();
	  if (paramName.startsWith("filter_")) {
            buf.append("<input type=\"hidden\" name=\"" + java.net.URLEncoder.encode(paramName) + "\" value=\"" + java.net.URLEncoder.encode(request.getParameter(paramName)) + "\"/>");
	  }
	}
        return buf.toString();
}
%>

