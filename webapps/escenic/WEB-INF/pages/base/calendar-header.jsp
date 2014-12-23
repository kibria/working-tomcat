<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<style>
  #calendarContainer { 
    position : absolute;
    z-index: 50;
    left : 100px;
    top : 100px;
    width : 134px;
    height : 145px;
    clip:rect(0px 234px 245px 0px);
    visibility : hidden;
    background: none;
  }

  #calendarContainer a {
    color : #333366;
    text-decoration: none;
  }

  #calendarContainer a:hover {
    color : #993333;
  }

  input.calendarYear {
    font-family : Arial,Helvetica,Sans-serif;
    font-size : 10px;
    color : #000000;
    width : 38px;
  }

  select.calendarMonth {
    font-family : Arial,Helvetica,Sans-serif;
    font-size : 10px;
    color : #000000;
    width : 94px;
  }

  table.calendarOuterTable {
    background: #000000;
  }

  table.calendarTable {
    background: #ddddee;
  }

  td.calendarWeekend {
    background: #ffeecc
  }

  td.calendarHighlighted {
    font-weight: bold;
  }

  td.calendarDays {
    background: #cccccc;
  }

  td.calendarTd {
    background: #eeeeee;
  }

  td.calendarTdHeader {
    background: #eeeeee;
    text-align: left;
  }

  td.calendarDays,  td.calendarHighlighted,  td.calendarWeekend,  td.calendarTd {
    text-align: right;
  }

  td.calendarTransparent {
    background: none;
  }

  td.calendarShadow {
    background-color: red;
  }
  
  #calendarContainer td {
    font-family : Arial,Helvetica,Sans-serif;
    font-size : 12px;
    color : #000000;
  }
  input.time {
    font-family : Arial,Helvetica,Sans-serif;
    font-size : 10px;
    color : #000000;
    width : 25px;
  }
</style>

<div id="calendarContainer" onmouseout="calendarTimeout();" onmouseover="if (timeoutId) clearTimeout(timeoutId);">XYZZY</div>
<script language="JavaScript" src="<html:rewrite page='/script/calendar.jsp' />" type="text/javascript"></script>
<script>
  function calendarInitHook() {
    calendarInit();
    return true;
  }
  registerHook('onLoad',calendarInitHook);
</script>
