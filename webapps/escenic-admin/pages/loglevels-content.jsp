<%@page import="java.util.*" %>
  <style>
.inherited {
  color: #99cc99;
  font-weight: normal;
}
  </style>
  <h1>Logging Levels</h1>

<%
  /* Handle any changes to the page first. */
     String categoryFilter = "";
     boolean showInheritedCategories = false;
     Enumeration params = request.getParameterNames();
     while(params.hasMoreElements()) {
       String param = (String) params.nextElement();
       String value = request.getParameter(param);

       if (param.equals("categoryToCreateLevel")) {
         continue;
       }
       if (param.equals("categoryToCreate")) {
         if(value != null && !value.equals("")) 
           org.apache.log4j.Logger.getLogger(value).setLevel(org.apache.log4j.Level.toLevel(request.getParameter("categoryToCreateLevel"),null));
         continue;
       }

       if (param.equals("categoryFilter")) {
         categoryFilter = value;
         continue;
       }

       if (param.equals("showInheritedCategories")) {
         showInheritedCategories = !value.equals("");
         continue;
       }

       org.apache.log4j.Logger toLogger;
       if (param.equals("root")) 
         toLogger = org.apache.log4j.Logger.getRootLogger();
       else
         toLogger = org.apache.log4j.Logger.getLogger(param);

       if(value.equals("SELECT")) {
         continue;
       } 
       org.apache.log4j.Level toLevel = org.apache.log4j.Level.toLevel(value,null);
       toLogger.setLevel(toLevel);
     }




     Enumeration enumeration = org.apache.log4j.Logger.getCurrentCategories();
     List  s = new ArrayList();
     while (enumeration.hasMoreElements()) {
       s.add(enumeration.nextElement());
     }
     Collections.sort(s,new Comparator() {
         public int compare(Object o1, Object o2) {
           return ((org.apache.log4j.Logger)o1).getName().compareTo(((org.apache.log4j.Logger)o2).getName());
         }
       });

     enumeration = Collections.enumeration (s);
     org.apache.log4j.Logger cat = org.apache.log4j.Logger.getRootLogger();

%>


  <FORM METHOD="POST" ACTION="<%=request.getRequestURI()%>">
    <table>
      <tr>
        <th>Enter new category:</th>
        <td>
          <input type=text size=30 name="categoryToCreate">
        </td>
        <td>
          <select name="categoryToCreateLevel" size="1">
            <option class="inherit" value="INHERIT">INHERIT</option>
            <option value="<%=org.apache.log4j.Level.FATAL%>"><%=org.apache.log4j.Level.FATAL%></option>
            <option value="<%=org.apache.log4j.Level.ERROR%>"><%=org.apache.log4j.Level.ERROR%></option>
            <option value="<%=org.apache.log4j.Level.WARN%>"><%=org.apache.log4j.Level.WARN%></option>
            <option SELECTED value="<%=org.apache.log4j.Level.INFO%>"><%=org.apache.log4j.Level.INFO%></option>
            <option value="<%=org.apache.log4j.Level.DEBUG%>"><%=org.apache.log4j.Level.DEBUG%></option>
            <option value="<%=org.apache.log4j.Level.TRACE%>"><%=org.apache.log4j.Level.TRACE%></option>
          </select>
        </td>
      </tr>
      <tr>
        <th>Filter categories:</th>
        <td colspan="2">
          <input type=text size=30 name="categoryFilter" value="<%=categoryFilter%>">
        </td>
      </tr>
      <tr>
        <th>Show inherited categories:</th>
        <td colspan="2">
          <input type=checkbox size=30 name="showInheritedCategories" <%=showInheritedCategories?"CHECKED":""%> >
        </td>
      </tr>
      <tr>
        <td colspan="3" align="right">
          <input type="submit" value="Apply changes">
        </td>
      </tr>
      <tr>
        <td>
          <b><%= cat.getName() %></b>
        </td>
        <td>
          <b><%= cat.getLevel().toString()%></b>
        </td>
        <td>
          <select name="<%= cat.getName()%>" size="1">
            <option selected value="SELECT">&nbsp;</option>
            <option class="inherit" value="INHERIT">INHERIT</option>
            <option value="<%=org.apache.log4j.Level.FATAL%>"><%=org.apache.log4j.Level.FATAL%></option>
            <option value="<%=org.apache.log4j.Level.ERROR%>"><%=org.apache.log4j.Level.ERROR%></option>
            <option value="<%=org.apache.log4j.Level.WARN%>"><%=org.apache.log4j.Level.WARN%></option>
            <option value="<%=org.apache.log4j.Level.INFO%>"><%=org.apache.log4j.Level.INFO%></option>
            <option value="<%=org.apache.log4j.Level.DEBUG%>"><%=org.apache.log4j.Level.DEBUG%></option>
            <option value="<%=org.apache.log4j.Level.TRACE%>"><%=org.apache.log4j.Level.TRACE%></option>
          </select>
        </td>
      </tr>

<%
  Enumeration e = cat.getAllAppenders();
  while (e.hasMoreElements()) {
    org.apache.log4j.Appender appender = (org.apache.log4j.Appender) e.nextElement(); 
%>
      <tr>
        <td colspan="3">
          <%=appenderToString(appender)%>
        </td>
      </tr>
<%
  }
%>


<%
  int i = 0;
  while(enumeration.hasMoreElements()) {
    cat = (org.apache.log4j.Logger) enumeration.nextElement();
    if (cat.getLevel() == null && !showInheritedCategories) {
      continue;
    }
    if (!categoryFilter.equals("")) {
      if (! cat.getName().toLowerCase().startsWith(categoryFilter)) {
        continue;
      }
    }
    // if we get here, increment the counter.
    i++;
    boolean bold = (cat.getName().equals(cat.getName().toLowerCase()));
%>
      <tr>
        <td>
          <%=bold?"<b>":""%><%= cat.getName() %><%=bold?"</b>":""%>
        </td>
        <td>
          <b><%= cat.getLevel() == null?("<span class='inherited'>" +cat.getEffectiveLevel()+ "</span>"):cat.getLevel().toString()%></b>
        </td>
        <td>
          <% String selected = request.getParameter(cat.getName());
             if (selected == null && cat.getName().equals(request.getParameter("categoryToCreate"))) selected = request.getParameter("categoryToCreateLevel");
             if (selected == null) selected = "SELECT";
          %>
          <select name="<%= cat.getName()%>" size="1">
            <option <%= (selected.equals("SELECT"))?"selected":""%> value="SELECT">&nbsp;</option>
            <option <%= (selected.equals("INHERIT"))?"selected":""%> class="inherited" value="INHERIT">INHERIT</option>
            <option <%= (selected.equals("FATAL"))?"selected":""%> value="<%=org.apache.log4j.Level.FATAL%>">
              <%=org.apache.log4j.Level.FATAL%></option>
            <option <%= (selected.equals("ERROR"))?"selected":""%> value="<%=org.apache.log4j.Level.ERROR%>">
              <%=org.apache.log4j.Level.ERROR%></option>
            <option <%= (selected.equals("WARN"))?"selected":""%> value="<%=org.apache.log4j.Level.WARN%>">
              <%=org.apache.log4j.Level.WARN%></option>
            <option <%= (selected.equals("INFO"))?"selected":""%> value="<%=org.apache.log4j.Level.INFO%>">
              <%=org.apache.log4j.Level.INFO%></option>
            <option <%= (selected.equals("DEBUG"))?"selected":""%> value="<%=org.apache.log4j.Level.DEBUG%>">
              <%=org.apache.log4j.Level.DEBUG%></option>
            <option <%= (selected.equals("TRACE"))?"selected":""%> value="<%=org.apache.log4j.Level.TRACE%>">
              <%=org.apache.log4j.Level.TRACE%></option>
          </select>
        </td>
      </tr>
<%
  e = cat.getAllAppenders();
  while (e.hasMoreElements()) {
    org.apache.log4j.Appender appender = (org.apache.log4j.Appender) e.nextElement(); 
%>
      <tr>
        <td colspan="3">
          Attached to <%=appenderToString(appender)%>
        </td>
      </tr>
<%
  }
%>

<%
  if (i % 20 == 0) {
%>
      <tr>
        <td colspan=3 align="right">
          <input type=submit VALUE="SUBMIT CHANGES">
        </td>
      </tr>
<% 
  }
%>

<%
  }
%>
    </table>
  </form>

      <%--
     while(enum.hasMoreElements()) {
       cat = (org.apache.log4j.Logger) enum.nextElement();

       html.append("<td>\n");
       if (cat.getName().equals(cat.getName().toLowerCase())) {
         html.append("<b>");
         html.append(cat.getName());
         html.append("</b>");
       } else {
         html.append(cat.getName());
       }
       html.append("</td>\n");


       html.append("<td>\n");
       if(cat.getLevel() == null)
         html.append("<b>" + cat.getChainedLevel().toString() + "</b> (Inherited)\n");
       else
         html.append("<b>" +  cat.getLevel().toString() + "</b>\n");
       html.append("</td>\n");

       html.append("<td>");
       html.append("<SELECT NAME=\"" + cat.getName() + "\" size=1>\n");
       String parameterValue = request.getParameter(cat.getName());
       if (parameterValue == null) parameterValue = "SELECT";
       if (parameterValue.equals("SELECT")) {
         html.append("<OPTION SELECTED VALUE=\"SELECT\">&nbsp;\n");
       } else {
         html.append("<OPTION VALUE=\"SELECT\">&nbsp;\n");
       }
       if (parameterValue.equals("INHERIT")) {
         html.append("<OPTION SELECTED VALUE=\"INHERIT\">inherit\n");
       } else {
         html.append("<OPTION VALUE=\"INHERIT\">inherit\n");
       }
       if (parameterValue.equals("DEBUG")) {
         html.append("<OPTION SELECTED VALUE=\"" + Level.DEBUG + "\">" + Level.DEBUG + "\n");
       } else {
         html.append("<OPTION VALUE=\"" + Level.DEBUG + "\">" + Level.DEBUG + "\n");
       }
       if (parameterValue.equals("INFO")) {
         html.append("<OPTION SELECTED VALUE=\"" + Level.INFO + "\">"  + Level.INFO  + "\n");
       } else {
         html.append("<OPTION VALUE=\"" + Level.INFO + "\">"  + Level.INFO  + "\n");
       }
       if (parameterValue.equals("WARN")) {
         html.append("<OPTION SELECTED VALUE=\"" + Level.WARN + "\">"  + Level.WARN  + "\n");
       } else {
         html.append("<OPTION VALUE=\"" + Level.WARN + "\">"  + Level.WARN  + "\n");
       }
       if (parameterValue.equals("ERROR")) {
         html.append("<OPTION SELECTED VALUE=\"" + Level.ERROR + "\">" + Level.ERROR + "\n");
       } else {
         html.append("<OPTION VALUE=\"" + Level.ERROR + "\">" + Level.ERROR + "\n");
       }
       if (parameterValue.equals("FATAL")) {
         html.append("<OPTION SELECTED VALUE=\"" + Level.FATAL + "\">" + Level.FATAL + "\n");
       } else {
         html.append("<OPTION VALUE=\"" + Level.FATAL + "\">" + Level.FATAL + "\n");
       }
       html.append("</SELECT>\n");
       html.append("</td>\n");
       html.append("</tr>\n");

     }

     html.append("<tr>");
     html.append("<td colspan=3 align=\"right\">");
     html.append("<input type=submit VALUE=\"SUBMIT CHANGES\">");
     html.append("</td>");
     html.append("</tr>");
     html.append("<tr>\n");

     html.append("</table>\n");
     html.append("</FORM>\n");

     html.append("</BODY>\n");
     html.append("</HTML>\n");
--%>

<%!
String appenderToString(org.apache.log4j.Appender appender) {
  if (appender instanceof org.apache.log4j.ConsoleAppender) {
    org.apache.log4j.ConsoleAppender a = (org.apache.log4j.ConsoleAppender) appender;
    return "a Console Appender (\"" + a.getName()+ "\"): "
      + a.getTarget() + ", "
      + layoutToString(a.getLayout());
  }
  
  if (appender instanceof org.apache.log4j.FileAppender) {
    org.apache.log4j.FileAppender a = (org.apache.log4j.FileAppender) appender;
    return "File Appender " 
      + "name=" + a.getName() + ", "
      + " file=" + a.getFile() + ", "                        
      + " layout=" + layoutToString(a.getLayout());
  }
  
  return appender.toString();
}


String layoutToString(org.apache.log4j.Layout layout) {
  if (layout instanceof org.apache.log4j.PatternLayout) {
    org.apache.log4j.PatternLayout l = (org.apache.log4j.PatternLayout) layout;
    return "Pattern: "
      + l.getConversionPattern();
  }
  return layout.toString();
}

%>
 
