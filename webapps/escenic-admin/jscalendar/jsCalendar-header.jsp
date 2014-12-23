<%@ page import="org.apache.struts.action.Action,
                 java.util.Locale"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<% 
  String language = "calendar-en.js";//defaults to english
  language = "/jscalendar/"+language;
%>  
<link rel="stylesheet" href="<html:rewrite page='/jscalendar/calendar-win2k-1.css' />" type="text/css">
<script type="text/javascript" src="<html:rewrite page='/jscalendar/calendar.js' />"></script>
<script type="text/javascript" src="<html:rewrite page='<%=language%>' />"></script>
<script type="text/javascript" src="<html:rewrite page='/jscalendar/calendar-setup.js' />"></script>
<script type="text/javascript">


function selected(cal, date) {
<%--  cal.sel.value = cal.date.print("%d %B %Y %H:%M"); // just update the date in the input field.--%>
  cal.sel.value = date;
  if (cal.dateClicked){
    if(cal.displayArea){
      var element = document.getElementById(cal.displayArea);
      element.value=date;
    }
    cal.callCloseHandler();
  }
  //cal.params.displayArea.innerHTML = cal.date.print(cal.params.daFormat);
    
    
}

// And this gets called when the end-user clicks on the _selected_ date,
// or clicks on the "Close" button.  It just hides the calendar without
// destroying it.
function closeHandler(cal) {
  cal.hide();                        // hide the calendar
  cal.destroy();
  calendar = null;
}

function showCalendar(id, hidden,showsTime, format) {
  //sets default values of the calendar if showtime and format is undefined
  if(!showsTime){
    showsTime = "24";
  }
  if(!format){
    format = '%Y-%m-%d %H:%M';
  }
  //finds the inputelement 
  var el = document.getElementById(hidden);
  //do we already have a calendar? If we do we close it
  if (calendar != null) {
  calendar.hide();
  } else {
    // first-time call, create the calendar.
    var cal = new Calendar(true, null, selected, closeHandler);
    // uncomment the following line to hide the week numbers
    cal.weekNumbers = false;
    if (typeof showsTime == "string") {
      cal.showsTime = true;
      cal.time24 = (showsTime == "24");
    }
    calendar = cal;                  // remember it in the global var
    cal.setRange(1900, 2070);        // min/max year allowed.
    cal.create();
  }
  calendar.setDateFormat(format);    // set the specified date format
  calendar.parseDate(el.value);      // try to parse the text in field
  calendar.sel = el;                 // inform it what input field we use
  calendar.displayArea = id;
//  var element = document.getElementById(cal.displayArea);
//  element.value=cal.date.print("%d %B %Y %H:%M");
  // the reference element that we pass to showAtElement is the button that
  // triggers the calendar.  In this example we align the calendar bottom-right
  // to the button.
  calendar.showAtElement(document.getElementById(id));        // show the calendar
  return false;
}
</script>
