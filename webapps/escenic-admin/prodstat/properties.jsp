
<%
  
  //modify this line to change default max number of publish-dates to show in table
  int pubDatesToView = 50; 
  /*
  *modify this to change the default value of the "Show all publication-dates" checkbox
  *Possible values: true,false 
  */
  boolean defaultShowAllPublishdates = false;
  
  
  session.setAttribute("maxPublishDates",String.valueOf(pubDatesToView));
  session.setAttribute("defaultShowAllPublishdates",String.valueOf(defaultShowAllPublishdates));
%>