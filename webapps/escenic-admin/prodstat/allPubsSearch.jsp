<%@ page import="java.util.*,
                 java.text.DateFormat,
                 java.text.SimpleDateFormat,
                 java.util.Date,
                 java.io.IOException,
                 neo.xredsys.api.IOAPI,
                 neo.xredsys.api.Section,
                 java.text.ParseException" %>
<%@page import="java.sql.*" %>
<%@page import="neo.xredsys.content.*" %>
<%@page import="neo.dbaccess.*" %>
<%@ page language="java" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>

<bean:define id="date" name="searchDate" type="java.lang.String"/>
<bean:define id="interval" name="searchInterval" type="java.lang.String"/>
<bean:define id="pubs" name="searchPublications" type="java.lang.String"/>
<bean:define id="atypes" name="searchArticleTypes" type="java.lang.String"/>
<bean:define id="showAll" name="searchShowAll" type="java.lang.String"/>

<%
  if (atypes == null || atypes.equalsIgnoreCase("")){
    atypes = "-1";
  }
  if (pubs == null || pubs.equalsIgnoreCase("")){
    pubs = "-1";
  }
  if (showAll==null || showAll.equalsIgnoreCase("") ){
    showAll ="true";
  }
  boolean tmpShow = true;
  try {
    tmpShow = Boolean.valueOf(showAll).booleanValue();
  }
  catch (Exception ex) {
  }
  
  final boolean showAllDates = tmpShow;
  final javax.servlet.jsp.JspWriter writer = out;
  final HttpSession sess = session;
  DateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm");
  Date d = f.parse(date);
  Calendar time = Calendar.getInstance();
  time.setTime(d);
  time.set(Calendar.HOUR_OF_DAY,0);
  time.set(Calendar.MINUTE,0);
  Timestamp fromDate = new Timestamp(time.getTime().getTime());
  time.set(Calendar.HOUR_OF_DAY,23);
  time.set(Calendar.MINUTE,59);
  Timestamp toDate = new Timestamp(time.getTime().getTime());
  
  if (interval.equalsIgnoreCase("week")){
    time.add(Calendar.DATE,6);
    toDate = new Timestamp(time.getTime().getTime());
  } else if (interval.equalsIgnoreCase("month")){
    time.set(Calendar.DAY_OF_MONTH,1);
    time.set(Calendar.HOUR_OF_DAY,0);
    time.set(Calendar.MINUTE,0);
    fromDate = new Timestamp(time.getTime().getTime());
    time.set(Calendar.DAY_OF_MONTH,1);
    time.set(Calendar.HOUR_OF_DAY,0);
    time.set(Calendar.MINUTE,0);
    time.add(Calendar.MONTH,1);
    time.add(Calendar.MINUTE,-1);
    toDate = new Timestamp(time.getTime().getTime());
    
  }
  
  boolean allPubs = false;
  StringTokenizer t = new StringTokenizer(pubs,",",false);
  while (t.hasMoreTokens()){
    if (t.nextToken().equalsIgnoreCase("-1")){
      allPubs = true;
    }
  }
  
  boolean allTypes = false;
  t = new StringTokenizer(atypes,",",false);
  while (t.hasMoreTokens()){
    if (t.nextToken().equalsIgnoreCase("-1")){
      allTypes = true;
    }
  }
  
  final Timestamp from = fromDate;
  final Timestamp to = toDate;
  final DateFormat dateF = new SimpleDateFormat("yyyy-MM-dd");
  final boolean addPubs = allPubs;
  final boolean addTypes = allTypes;
  final String typesToAdd = atypes;
  final String pubsToAdd = pubs;
  
  
  ContentManager.getContentManager().doTransaction( new TransactionOperation() {
    public void execute(Transaction t) throws SQLException {
      PreparedStatement stmt = null;
      StringBuffer sq2 = new StringBuffer( "select s.referenceid, to_char(amc.publishdate, 'YYYY-MM-DD'), count(*) from  section s, ArticleSection ase, ArticleMetaContent amc where s.codeid=5 and s.sectionid=ase.sectionid ");
      if(!addPubs){
        sq2.append("and s.referenceid in (" + pubsToAdd + ") ");
      }
      sq2.append("and ase.articleid=amc.articleid ");
      if(!addTypes){
        sq2.append("and amc.codeid in (" + typesToAdd + ") ");
      }
      sq2.append("and amc.publishdate between ? and ? group by s.referenceid, to_char(amc.publishdate, 'YYYY-MM-DD') order by s.referenceid, to_char(amc.publishdate, 'YYYY-MM-DD')");                      
      try {
        stmt = t.getConnection().prepareStatement(sq2.toString());
        stmt.setTimestamp(1, from);
        stmt.setTimestamp(2, to);
        ResultSet rs=stmt.executeQuery();
        sess.setAttribute("all_prod_search",rs);
        printMainResult(rs);
      } catch(Exception e) {
        e.printStackTrace();
      } finally {
        if(stmt!=null) stmt.close();
      }
    }
    
    Map createMainSearchMap(ResultSet set){
      Map retMap = new HashMap();
      try {
        while(set.next()) {
          String key = String.valueOf(set.getInt(1));
          Map m = (Map)retMap.get(key);
          if (m ==null){
            m = new HashMap();
            retMap.put(key,m);
          }
          m.put(set.getString(2),String.valueOf(set.getInt(3)));
        }
      } catch (SQLException e) {
        e.printStackTrace();
      }
      return retMap;
    }
    
    void printMainResult(ResultSet set){
      Calendar tmpCal = Calendar.getInstance();
      Calendar toCal = Calendar.getInstance();
      toCal.setTime(to);
      tmpCal.setTime(from);
      DateFormat dayF = new SimpleDateFormat("dd");
      DateFormat dayMF = new SimpleDateFormat("dd/MMM-yy");
      Collection dates = new ArrayList();
      Map resultMap = createMainSearchMap(set);
      try {
        writer.println("<p>&nbsp;</p>");
      } catch (IOException e) {
        e.printStackTrace();
      }
      if (resultMap.keySet().size() == 0){
        try {
          writer.println("<p>No data for this period!</p>");
          return;
        } catch (IOException e) {
          e.printStackTrace();
        }
      }
      try {
        writer.println("<table id=\"res1\" cellspacing=\"0\" cellpadding=\"2\">");
        writer.println("<tr><th>Publication</th>");
        int count =0;
        do {
          writer.println("<th>");
          if (count == 0 || tmpCal.get(Calendar.DAY_OF_MONTH)==1){
            writer.print(dayMF.format(tmpCal.getTime()));
          } else {
            writer.print(dayF.format(tmpCal.getTime()));            
          }
          writer.println("</th>");
          dates.add(dateF.format(tmpCal.getTime()));
          tmpCal.add(Calendar.DAY_OF_MONTH,1);
          count++;
        } while (tmpCal.before(toCal));
        writer.println("<th>Tot</th>");
        writer.println("</tr>");
        
        Collection pubColl = (Collection)sess.getAttribute("publicationCollection");
        Iterator pubIt = pubColl.iterator();
        Map publications = (Map)sess.getAttribute("publicationMap");
        int allTot = 0;
        while (pubIt.hasNext()) {
          String allSecId = (String) pubIt.next();
          if (!resultMap.containsKey(allSecId)){
            continue;
          }
          writer.print("<tr><td class=\"weekday\"><a href=\"#" +allSecId+ "\">" + publications.get(allSecId) + "</a></td>");
          Map map = (Map)resultMap.get(allSecId);
          
          Iterator dateIt = dates.iterator();
          int tot = 0;
          while (dateIt.hasNext()) {
            String h = (String)dateIt.next();
            writer.print("<td");
              try {
                tmpCal.setTime(dateF.parse(h));
                if (tmpCal.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY){
                  writer.print(" class=\"sunday\"");
                } else if (tmpCal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY){
                  writer.print(" class=\"saturday\"");
                } else {
                  writer.print(" class=\"weekday\"");
                }
              } catch (ParseException e) {
              }
            if (map.containsKey(h)){
              try {
                tot = tot + Integer.parseInt((String)map.get(h));
                
              }
              catch (Exception ex) {
              }
              writer.print(">"+ map.get(h) + "</td>");
            } else {
              writer.print(">&nbsp;</td>");
            }
          }
          allTot += tot;
          writer.println("<td class=\"total\">" + tot + "</td>");
          writer.println("</tr>");
        }
        writer.print("<tr><td class=\"weekday\">Total</td><td class=\"weekday\" colspan=\"" +dates.size()+"\"></td><td class=\"total\">" + allTot + "</td></tr>");
        writer.println("</table>");
        writer.println("");
      } catch (IOException e) {
        e.printStackTrace();
      }
    }
  }
  );

  //  The second search
  
  ContentManager.getContentManager().doTransaction( new TransactionOperation() {
    
    public void execute(Transaction t) throws SQLException {
      PreparedStatement stmt = null;
      StringBuffer sqlBuffer = new StringBuffer("select s.referenceid, s.sectionid, s.sectionname, amc.publishdate from section s, ArticleSection ase, ArticleMetaContent amc where s.codeid!=5 and s.sectionid=ase.sectionid ");
      if(!addPubs){
        sqlBuffer.append("and s.referenceid in (" + pubsToAdd + ") ");
      }
      sqlBuffer.append("and ase.articleid=amc.articleid and ase.priority=1 ");
      if(!addTypes){
        sqlBuffer.append("and amc.codeid in (" + typesToAdd + ") ");
      }
      sqlBuffer.append("and amc.publishdate between ? and ? order by s.referenceid, s.sectionid, amc.publishdate");
      try {
        stmt = t.getConnection().prepareStatement(sqlBuffer.toString());
        stmt.setTimestamp(1, from);
        stmt.setTimestamp(2, to);
        ResultSet rs=stmt.executeQuery();
        sess.setAttribute("all_prod_search",rs);
        printResult(rs);
      } catch(Exception e) {
        e.printStackTrace();
      } finally {
        if(stmt!=null) stmt.close();
      }
    }
    
    Map createSearchMap(ResultSet set){
      Map pubMap = new HashMap();
      try {
        while(set.next()) {
          String pub = String.valueOf(set.getInt(1));
          String secId = String.valueOf(set.getInt(2));
          String sectionName = set.getString(3);
          Date pDate = set.getTimestamp(4);
          Map sectionIdMap = (Map)pubMap.get(pub);
          if (sectionIdMap ==null){
            sectionIdMap = new HashMap();
            pubMap.put(pub,sectionIdMap);
          }
          Map sectionMap = (Map)sectionIdMap.get(secId);
          if (sectionMap ==null){
            sectionMap = new HashMap();
            sectionIdMap.put(secId,sectionMap);
          }
          Collection dates = (Collection)sectionMap.get(sectionName);
          if (dates == null){
            dates = new ArrayList();
            sectionMap.put(sectionName,dates);
          }
          dates.add(pDate);
        }
      } catch (SQLException e) {
        e.printStackTrace();
      }
      return pubMap;
    }
    
    void printResult(ResultSet set){
      DateFormat timeFormat = new SimpleDateFormat("dd/MM-yyyy HH:mm");
      Map publications = (Map)sess.getAttribute("publicationMap");
      Collection pubColl = (Collection)sess.getAttribute("publicationCollection");
      Map pubMap = createSearchMap(set);
      if (pubMap.size() == 0){
        return;
      }
      Iterator pubIt = pubColl.iterator();
      try {
        writer.println("<p>&nbsp;</p>");
        writer.println("<table id=\"res2\" cellspacing=\"0\" cellpadding=\"0\"><tr><td>");
      } catch (IOException e) {
        e.printStackTrace();
      }
      while (pubIt.hasNext()) {
        String pubId = (String)pubIt.next();
        if(!pubMap.containsKey(pubId)){
          continue;
        }
        try {
          writer.println("<tr bgcolor=\"#000000\">");
          writer.println("<td colspan=\"4\">");
          writer.println("<table border=\"0\" width=\"100%\">");
          writer.println("<th class=\"pubname\" align=\"left\"><a name=\"" +pubId +"\">" +publications.get(pubId)+"</a></th>");
          writer.println("<th align=\"right\"><a class=\"white\" href=\"#top\">Go to search</th>");
          writer.println("</table></td>");
          writer.println("</tr>");
          writer.println("<tr bgcolor=\"#000000\">");
          writer.println("<th>Section</th>");
          writer.println("<th>Count</th>");
          writer.println("<th>&nbsp;</th>");
          writer.println("<th>Publish-dates</th>");
          writer.println("</tr>");
        } catch (IOException e) {
          e.printStackTrace();
        }
        
        Map secIdMap = (Map)pubMap.get(pubId);
        Iterator secIdIt = secIdMap.keySet().iterator();
        int count = 2;
        int tot = 0;
        while (secIdIt.hasNext()) {
          String secId = (String)secIdIt.next();
          Map secnameMap = (Map)secIdMap.get(secId);
          Iterator nameIt = secnameMap.keySet().iterator();
          while (nameIt.hasNext()) {
            try {
              writer.print("<tr");
              if ((count %2) ==0){
                writer.print(" class=\"evenrow\"");
              } else {
                writer.print(" class=\"oddrow\"");
              }
              writer.println(">");
              String secName = (String)nameIt.next();
              writer.println("<td class=\"section-col\">"+ secName + "</td>");
              Collection c = (Collection)secnameMap.get(secName);
              tot += c.size();
              writer.println("<td class=\"count-col\">"+ c.size() + "</td>");
              writer.println("<td class=\"empty-col\">&nbsp;&nbsp;</td>");
              Iterator dateIt = c.iterator();
              writer.println("<td class=\"pubdate-col\">");
              int dCount=0;
              int maxCount = -1;
              try {
                maxCount = Integer.parseInt((String)sess.getAttribute("maxPublishDates"));
              } catch (NumberFormatException e) {
                e.printStackTrace();
              }
              while (dateIt.hasNext()) {
                Date pDate = (Date)dateIt.next();
                writer.print(timeFormat.format(pDate) +", ");
                dCount++;
                if (!showAllDates && maxCount >0 && dCount>=maxCount){
                  break;
                }
              }
              writer.println("</td>");
              writer.println("</tr>");
              
            } catch (IOException e) {
              e.printStackTrace();
            }
            
          }
          count++;
        }
        try {
          writer.println("<tr><td class=\"section-col-tot\">Total</td><td class=\"count-col-tot\">" + tot + "</td><td class=\"empty-col-tot\">&nbsp;</td><td class=\"pubdate-col-tot\">&nbsp;</td></tr>");
          writer.println("<tr><td class=\"table-divider\" colspan=\"4\">&nbsp;</td></tr>");
        } catch (IOException e) {
          e.printStackTrace();
        }
      }
      try {
        writer.println("</td></tr></table>");
      } catch (IOException e) {
        e.printStackTrace();
      }
    }
  }
  );
%>					  




