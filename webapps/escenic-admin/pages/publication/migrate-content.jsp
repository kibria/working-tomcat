<%@ page language="java"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html"
	prefix="html"%>
<%@ page import="java.lang.StringBuffer"%>
<%@ page import="java.io.OutputStream"%>
<%@ page import="java.io.FileOutputStream"%>

<script language="JavaScript1.2">
<!--
function isNumberKey(evt){
   var charCode = (evt.which) ? evt.which : event.keyCode
   if (charCode > 31 && (charCode < 48 || charCode > 57))
      return false;

   return true;
}

function checkDate(field){
  var checkstr = "0123456789";
  var DateField = field;
  var DateValue = "";
  var DateTemp = "";
  var seperator = "-";
  var day;
  var month;
  var year;
  var leap = 0;
  var err = 0;
  var i;

  err = 0;
  DateValue = DateField.value;

  for (i = 0; i < DateValue.length; i++) {
    if (checkstr.indexOf(DateValue.substr(i,1)) >= 0) {
      DateTemp = DateTemp + DateValue.substr(i,1);
    }
  }
  DateValue = DateTemp;
     
  if (DateValue.length == 6) {
    DateValue = '20' + DateValue.substr(0,2) + DateValue.substr(2,4);
  }

  if (DateValue.length != 8) {
    err = 19;
  }

  year = DateValue.substr(0,4);
  if (year == 0) {
    err = 20;
  }

  month = DateValue.substr(4,2);
  if ((month < 1) || (month > 12)){
    err = 21;
  }

  day = DateValue.substr(6,2);
  if (day < 1){
    err = 22;
  }

  /* Validation leap-year / february / day */
  if ((year % 4 == 0) || (year % 100 == 0) || (year % 400 == 0)) {
    leap = 1;
  }

  if ((month == 2) && (leap == 1) && (day > 29)) {
    err = 23;
  }

  if ((month == 2) && (leap != 1) && (day > 28)) {
    err = 24;
  }

  /* Validation of other months */
  if ((day > 31) && ((month == "01") || (month == "03") || (month == "05") || (month == "07") || (month == "08") || (month == "10") || (month == "12"))) {
    err = 25;
  }
  if ((day > 30) && ((month == "04") || (month == "06") || (month == "09") || (month == "11"))) {
    err = 26;
  }

  if ((day == 0) && (month == 0) && (year == 00)) {
    err = 0; day = ""; month = ""; year = ""; seperator = "";
  }

  /* if no error, write the completed date to Input-Field (e.g. 13.12.2001) */
  if (err == 0) {
    DateField.value = year + seperator + month + seperator + day;
  }
  else {
    alert("Date is incorrect!");
    DateField.select();
    DateField.focus();
  }
}

function checkTime(field){
  var checkstr = "0123456789";
  var TimeField = field;
  var TimeValue = "";
  var TimeTemp = "";
  var seperator = ":";
  var hour;
  var min;
  var err = 0;
  var i;

  err = 0;
  TimeValue = TimeField.value;
     /* Delete all chars except 0..9 */
     for (i = 0; i < TimeValue.length; i++) {
  if (checkstr.indexOf(TimeValue.substr(i,1)) >= 0) {
     TimeTemp = TimeTemp + TimeValue.substr(i,1);
  }
   }
   
   if (TimeTemp.length == 0){
   return;
   }

   TimeValue = TimeTemp;
   
   if (TimeValue.length != 4) {
    err = 1;}

   // hour
   hour = TimeValue.substr(0,2);
   if ((hour < 0) || (hour> 24)) {
    err = 3;
   }

   // min
   min = TimeValue.substr(2,2);
   if ( min< 0 || min > 60) {
    err = 4;
   }

   if ( hour == 24 && min > 0 ) {
     err = 5;
  }
   
   if (err == 0) {
    TimeField.value = hour + seperator + min;
   }
   /* Error-message if err != 0 */
   else {
    alert("Time  is incorrect!" + err);
    TimeField.select();
  TimeField.focus();
   }
  }

  function manageSectionSelection(checked){
    if (checked){
        //document.getElementById('').readOnly = false;
    }
    else{
    	//document.getElementById('').readOnly = true;
    }
        
	}
//-->

</script>

<html:errors/>
<html:form method="post" action="/publication/export">

  <input type="hidden" name="confirmed">
  <table width="600" border="0" cellpadding="2" cellspacing="1">
  <tr>
  <td colspan="2">
  <h2>Export from publication</h2>
  </td>
  </tr>
  <tr>
  <td colspan="2">This page makes it possible to export most of the data from a publication. It will export
  <ul>
  <li>Sections</li>
  <li>Section pages</li>
  <li>Content items</li>
  <li>Inboxes</li>
  <li>Lists</li>
  </ul>

  but it will <b>not</b> export
  <ul>
  <li>Persons</li>
  <li>Usergroups</li>
  </ul>
  When finished exporting please follow the instructions on the following pages.</td>
  </tr>
  <tr>
  <td>Publication ID:</td>
  <td><html:text property="publicationId" value="<%= request.getParameter(\"publicationId\")%>" onkeypress="return isNumberKey(event)"/></td>
  </tr>
  
  <tr>
  <td valign="top">Section IDs:</td>
    <td>
      <html:text property="sectionIds"/>

      <font size="-2">(Comma separated id)</font>
      <br>
      <html:checkbox property="includeChilds"/>&nbsp;Include subsections &nbsp;
    </td>
  </tr>
  
  <tr>
  <td>Folder name:</td>
  <td><html:text property="directoryName" /></td>
  </tr>
  <tr>
  <td>Group files by object type:</td>
  <td><html:checkbox property="groupBy" /></td>
  </tr>
  <tr>
  <td>Maximum items per file:</td>
  <td><html:text property="maxNumberOfObjects" /></td>
  </tr>
  <tr>
  <td>&nbsp;</td>
  <td><font size="-2">(0 or less will export to a single file)</font></td>
  </tr>
  <tr>
    <td>Export sections:</td>
    <td>
      <html:checkbox property="sections" onclick="manageSectionSelection(this.checked)"/>
    </td>
  </tr>
  <tr>
  <td>Export Content items:</td>
    <td>
      <html:checkbox property="articles" />
      &nbsp;Content types:&nbsp;<html:text property="contentTypes"/>
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="-2">(Comma separated id and/or name)</font>
      <br>
      <html:checkbox property="includeStagedContent"/>&nbsp;Include
      staged content items &nbsp;
    </td>
  </tr>
  <tr>
  <td>Export section pages, inbox, list :</td>
  <td><html:checkbox property="pools" /></td>
  <td><html:checkbox property="pools" /></td>
  </tr>
  <tr>
  <td>Export from time :</td>
  <td nowrap>
    <html:text property="fromDate" onblur="checkDate(this)" size="10" />
    <font size="-2">(yyyy/mm/dd)</font>
    <html:text property="fromTime" onblur="checkTime(this)" size="5" />
    <font size="-2">(hh:mm)</font></td>
  </tr>
  <tr>
  <td>Export to time :</td>
  <td nowrap>
    <html:text property="toDate" onblur="checkDate(this)" size="10" />
    <font size="-2">(yyyy/mm/dd)</font>
    <html:text property="toTime" onblur="checkTime(this)" size="5" />
    <font size="-2">(hh:mm)</font></td>
  </tr>
  <tr>
  <td colspan=2 align=middle><input type="submit" name="Submit"
  value="Export" style="width: 100px;"></td>
  </tr>
  </table>
</html:form>
