<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>

<%!

  public static String escapeHtml(Object o) {
    if (o == null) return "null";
    if (o instanceof String) return internalEscapeHtml((String) o);
    return internalEscapeHtml(o.toString());
  }

  public static String internalEscapeHtml(String s) {
    s = neo.util.StringUtil.escapeHtml(s);
    if (s.indexOf("'") == -1 && s.indexOf("\"") == -1) {
      return s;
    } else {
      return neo.util.StringUtil.replaceString(s,"'","&apos;");
    }
  }
  public static class QueryInfo {
    String query;
    long runTime;
    java.util.Date date;
    int hits;
    public String getQuery() {
      return query;
    }
    public long getRunTime() {
      return runTime;
    }
    public java.util.Date getDate() {
      return date;
    }
    public int getHits() {
      return hits;
    }
  }

  public static class Query implements neo.dbaccess.TransactionOperation {

    String mQuery;
    JspWriter mOut;
    QueryInfo info = new QueryInfo();

    public Query(String query, JspWriter out) {
      this.mQuery = query;
      this.mOut = out;
      this.info.query = query;
    }

    private java.util.Stack tags = new java.util.Stack();

    public void push(String tag) throws java.io.IOException {
      push(tag,null);
    }
    public void push(String tag, String attributes) throws java.io.IOException {
      tags.push(tag);
      mOut.print("<");
      mOut.print(tag);
      if (!neo.util.StringUtil.isEmpty(attributes)) {
        mOut.print(" ");
        mOut.print(attributes);
      }
      mOut.print(">");
    }

    public void pop() throws java.io.IOException {
      String tag = (String)tags.pop();
      mOut.print("</");
      mOut.print(tag);
      mOut.print(">");
    } 

    public void execute(neo.dbaccess.Transaction t) throws java.sql.SQLException {
      long startTime = System.currentTimeMillis();
      this.info.date = new java.util.Date();
      try {
        mOut.println("<h1>Executing query</h1>");
        mOut.print("<pre>");
        mOut.print(mQuery);
        mOut.println("</pre>");
        java.sql.Statement st = t.getConnection().createStatement();
        try {
          java.sql.ResultSet rs = st.executeQuery(mQuery);
          push("table","border='1' cellspacing='0' cellpadding='2'");
          int index = 0;
          java.sql.ResultSetMetaData metaData = rs.getMetaData();

          push("tr");
          push("td","valign='bottom' rowspan='2'");mOut.println("#");pop();
          for (int i = 0; i < metaData.getColumnCount(); /*>*/ i=i+2) {
            push("th", "style='background:#ffffee;' align='left' colspan='2' valign='top'");
            mOut.println(metaData.getColumnLabel(i+1));
            pop();
          }
          pop();

          push("tr");
          push("td", "style='background:#ffffee;'");mOut.print("&nbsp;");pop();
          for (int i = 1; i < metaData.getColumnCount(); /*>*/ i=i+2) {
            push("th", "style='background:#dddddd;' align='left' colspan='2' valign='top'");
            mOut.println(metaData.getColumnLabel(i+1));
            pop();
          }
          pop();

          while (rs.next()) {
            this.info.hits++;
            index++;
            push("tr");

            push("td","valign='top'");
            mOut.println(index);
            pop();
 
            for (int i = 0; i < metaData.getColumnCount(); /*>*/ i++) {
              push("td","valign='top'" + ( (i % 2 == 0) ? "style='background:#ffffee;'" : "style='background:#dddddd;'"  ));
              String s = escapeHtml(rs.getString(i+1));
              mOut.print(neo.util.StringUtil.isEmpty(s)? "&nbsp" : escapeHtml(rs.getString(i+1)));
              pop();
            }
            pop();
          }
          pop();
        } finally {
          st.close();
          while (tags.size() != 0) {
            pop();
          }
        }
      } catch (java.io.IOException e) {
        // do nothing 
      } finally /*xxx*/ {
        this.info.runTime = System.currentTimeMillis() - startTime;
      }
    }
  }
%>

<%
neo.xredsys.content.ContentManager contentManager = neo.xredsys.content.ContentManager.getContentManager();
String query = request.getParameter("query");
java.util.Collection queries = (java.util.Collection)session.getAttribute("query-history");
if (queries == null) {
  session.setAttribute("query-history", queries = new java.util.ArrayList());
}
%>

    <% try { %>
<%
if (!neo.util.StringUtil.isEmpty(query)) {
  Query q = new Query(query,out);
  contentManager.doQuery(q);
  queries.add(q.info);
}
%>
    <% } catch (Exception e) { %>
      <h1>Exception occured</h1>
      An exception when executing query:
      <pre><%=query%></pre>
      <pre style="color: red"><%=e.toString()%></pre>
    <% } %>
    <h1>SQL Query</h1>

    <form method="post">
      Enter SQL Query: <br><textarea rows="3" cols="80" name="query"><%=((query==null)?"SELECT PublicationName, ReferenceId FROM Publication":query)%></textarea>
      <br>
      <input type="submit">
      <input type="reset">
      <input type="button" onclick="javascript:document.forms[0].query.value='';" value="Clear">

      <div>
      Previous queries this session:
      </div>
      <% { int index = 0;
           for (java.util.Iterator i = queries.iterator(); i.hasNext(); ) {
             try {
               QueryInfo q = (QueryInfo)i.next();
               if (!neo.util.StringUtil.isEmpty(request.getParameter("remove-history-" + index))) {
                 i.remove();
               }
             } catch (ClassCastException e) {
               i.remove();
             }
             index++;
           } 
         }%>

    <% if (queries.size() != 0) { %>
      <ol>
        <% { int index = 0;
           for (java.util.Iterator i = queries.iterator(); i.hasNext(); ) {
             QueryInfo q = (QueryInfo)i.next(); %>
        <li>
          <a href="javascript:void(0)" onClick='javascript:document.forms[0].query.value="<%= escapeHtml(q.getQuery())%>"; false'><%= escapeHtml(q.getQuery())%></a>
          <div style="font-size: small; space-after: 3px;">(Remove: <input type="checkbox" name="remove-history-<%=index%>">)</div>
          <div style="font-size: small;">(returned <%= q.getHits()%> rows; run time <%= escapeHtml("" + q.getRunTime())%>ms; at <%= escapeHtml("" + q.getDate())%>)</div>
        </li>
         <% index++; 
           }
         } %>
      </ol>
    <% } %>
    </form>
