<%@page import="java.util.*,java.util.Date,java.text.DateFormat,java.text.SimpleDateFormat,
                neo.xredsys.api.IOAPI" %>
<%@page import="java.sql.*" %>
<%@page import="neo.xredsys.content.*" %>
<%@page import="neo.dbaccess.*" %>
<%--<%@page language="java" %>--%>
<%@taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
    
    <%-- add the date-selector-scripts --%>
    <%@include file="/jscalendar/jsCalendar-header.jsp" %>
    
    <script language="JavaScript1.2"><!-- 
      function submitForm(uri){
        newUri = uri+'?date=' + document.forms[0]['startRange'].value;
        newUri = newUri + '&showAllPubs=' + document.forms[0]['allpubdates'].checked;
        newUri = newUri + '&interval=' + getRadioField('dateInterval');
        newUri = newUri + '&pubs=' + getList(document.forms[0]['publications']);
        newUri = newUri + '&atypes=' + getList(document.forms[0]['articletypes']);
        document.location = newUri;
      }
      
      function getRadioField(field){
        for (var i=0; i < document.forms[0].elements.length; i++) {
          if (document.forms[0].elements[i].name == field){
            if (document.forms[0].elements[i].type == 'radio'){
              if(document.forms[0].elements[i].checked){
                return document.forms[0].elements[i].value;
              }
            }
          }
        }
        return 0;
      }
      
      function getList(ob){
        var d = '';
        for (var i = 0; i < ob.options.length; i++){
          if (ob.options[ i ].selected){
            d = d + ob.options[i].value + ',';
          }
        }
        if (d.length >0){
          d = d.substring(0,d.length -1);  
        }
        return d;
      }
      // -->
    </script>


  <%-- cache publications and articletypes --%>
  <%@include file="initProd.jsp" %>  
  
  <%
    String date = (String)request.getParameter("date");
    DateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    boolean performSearch = true;
    
    if(date == null){
      performSearch = false;
      Date now = new Date(System.currentTimeMillis());
      date = f.format(now);
    }
    Date d = f.parse(date);
    String showAllPubDate = (String)request.getParameter("showAllPubs");
    if (showAllPubDate == null || showAllPubDate.equalsIgnoreCase("")){
      showAllPubDate = (String)session.getAttribute("defaultShowAllPublishdates");
    }
    String interval = request.getParameter("interval");
    if (interval ==null || interval.equalsIgnoreCase("")){
      interval = "day";
    }
    
    //Get the selected pubs from the parameterlist
    Collection selectedPubs = new ArrayList();
    String p = request.getParameter("pubs");
    if (p ==null || p.equalsIgnoreCase("")){
      p = "-1";
      selectedPubs.add("-1");
    } else {
      StringTokenizer t = new StringTokenizer(p,",",false);
      while (t.hasMoreTokens()){
        String tok = t.nextToken();
        if (tok.equalsIgnoreCase("-1")){
          selectedPubs.clear();
          selectedPubs.add("-1");
          break;
        } else {
          selectedPubs.add(tok);
        }
      }
    }
    
    Collection selectedTypes = new ArrayList();
    String  atypes = request.getParameter("atypes");
    if (atypes ==null || atypes.equalsIgnoreCase("")){
      atypes = "-1";
      selectedTypes.add("-1");
    } else {
      StringTokenizer t = new StringTokenizer(atypes,",",false);
      while (t.hasMoreTokens()){
        String tok = t.nextToken();
        if (tok.equalsIgnoreCase("-1")){
          selectedTypes.clear();
          selectedTypes.add("-1");
          break;
        } else {
          selectedTypes.add(tok);
        }
      }
    }
  %>
  
<%-- Rendering the search form --%>
  <form method="POST" action="<%=request.getRequestURI()%>">
  <h3>Statistics of production</h3>
  <table border="0" cellspacing="0" cellpadding="2">
    <tr>
      <th width="220" valign="top" bgcolor="#000000"><a name="top">Select date</a></th>
      <th bgcolor="#000000">&nbsp;</th>
      <th bgcolor="#000000">Select interval</th>
      <th bgcolor="#000000">&nbsp;</th>
      <th valign="top" bgcolor="#000000">Select publications</th>
      <th bgcolor="#000000">&nbsp;</th>
      <th valign="top" bgcolor="#000000">Select articletypes</th>
    </tr>
    <tr>
      <td width="220" valign="top">
        <input type="text" name="startRangeDisplay" id="startRangeDisplay" disabled="true" value="<%=date%>"/>
        <input type="hidden" id="startRange" name="startRange" value="<%=date%>"/>
        <input type="button" onclick="javascript:showCalendar('startRangeDisplay','startRange')"value="..."></input>
      </td>
      <td>&nbsp;</td>
      <td valign="top">
        <input type="radio" value="day" name="dateInterval" <%if (interval.equalsIgnoreCase("day")){out.print("checked");}%> > Only selected date<br/>
        <input type="radio" value="week" name="dateInterval" <%if (interval.equalsIgnoreCase("week"))out.print("checked");%>> One week from selected date<br/>
        <input type="radio" value="month" name="dateInterval" <%if (interval.equalsIgnoreCase("month"))out.print("checked");%>> Selected Month.
      </td>
      <td>&nbsp;</td>
      <%--  Render the publication-list    --%>
      <td valign="top"><select size="10" name="publications" multiple>
          <option value="-1" <%if (selectedPubs.contains("-1"))out.print("selected");%>>&lt;All&gt;</option>
          <%
            Map m = (Map)session.getAttribute("publicationMap");
            
            Set set = m.entrySet();
            Map.Entry [] entries =(Map.Entry[])set.toArray(new Map.Entry[set.size()]);
            Arrays.sort(entries, new Comparator(){
               public int compare(Object o1, Object o2) {
                 String s1 = ((Map.Entry)o1).getValue().toString().toLowerCase();
                 String s2 = ((Map.Entry)o2).getValue().toString().toLowerCase();
                 return s1.compareTo(s2);
               }
               public boolean equals(Object that) {
                 return this==that;
               }
             });
            
            for (int i = 0; i < entries.length; i++) {
              String id=entries[i].getKey().toString();
              out.print("<option value=\"" +id+"\""+ (selectedPubs.contains(id)?"selected":"") +">" +m.get(id) + "</option>");
            }
          %>
        </select>
      </td>
      <td>&nbsp;</td>
      <%-- Render the articletype-list --%>
      <td valign="top"><select size="10" name="articletypes" multiple>
          <option value="-1" <%if (selectedTypes.contains("-1"))out.print("selected");%>>&lt;All&gt;</option>
          <%
            Map aTypeMap = (Map)session.getAttribute("articleTypeMap");
            Set aSet = aTypeMap.entrySet();
            Map.Entry [] entr =(Map.Entry[])aSet.toArray(new Map.Entry[aSet.size()]);
            Arrays.sort(entr, new Comparator(){
               public int compare(Object o1, Object o2) {
                 ArticleType t1 = (ArticleType)((Map.Entry)o1).getValue();
                 ArticleType t2 = (ArticleType)((Map.Entry)o2).getValue();
                 return t1.getLabel().toLowerCase().compareTo(t2.getLabel().toLowerCase());
               }
               public boolean equals(Object that) {
                 return this==that;
               }
             });
            for (int i = 0; i < entr.length; i++) {
              String id=(String)entr[i].getKey().toString();
              out.println("<option value=\"" +id+"\""+ (selectedTypes.contains(id)?"selected":"") +">" +((ArticleType)aTypeMap.get(id)).getLabel() + "</option>");
            }
          %>
        </select>
      </td>      
    </tr>
  </table>
<%--  <p><input type="submit" value="Søk" name="B1"></p>--%>
  <p><input type="button" onclick="javascript:submitForm('<%=request.getRequestURI()%>')" value="Search"></input>
  &nbsp;&nbsp;<input type="checkbox" name="allpubdates" <%if (Boolean.valueOf(showAllPubDate).booleanValue())out.print("checked");%>>Show all publish-dates
  </p>
  
  </form>
  
  <hr>
  <%--Show the resutl --%>
  <%if (performSearch){%>
  <template:call file="allPubsSearch.jsp">
    <template:parameter key="searchDate" value="<%=date%>"/>
    <template:parameter key="searchInterval" value="<%=interval%>"/>
    <template:parameter key="searchPublications" value="<%=p%>"/>
    <template:parameter key="searchArticleTypes" value="<%=atypes%>"/>
    <template:parameter key="searchShowAll" value="<%=showAllPubDate%>"/>
  </template:call>
  <%}%>
  
