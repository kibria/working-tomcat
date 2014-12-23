<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>	/*
	*****************************************************************************************************
	Author : Lea Smart
	Source : www.totallysmartit.com
	Date : 7/3/2001
	DHTML Calendar
	Version 1.2

	You are free to use this code if you retain this header.
	You do not need to link to my site (be nice though!)

	Amendments
	22 Jan 2002; Added ns resize bug code; rewrote date functions into Date 'class';
				 Added support for yyyy-mm-dd date format
				 Added support for calendar beginning on any day
	7th Feb 2002 Fixed day highlight when year wasn't current year bug
	9th Jun 2002 Fixed bug with weekend colour
				 Amended the code for the date functions extensions.  Shortened addDays code considerably
	*****************************************************************************************************
	*/
var timeoutDelay = 10000; // milliseconds, change this if you like, set to 0 for the calendar to never auto disappear
var g_startDay = 1// 0=sunday, 1=monday
// preload images
var imgUp = new Image(12,12);
imgUp.src = '<html:rewrite page='/images/studio/S_pick_left.gif'/>';
var imgDown = new Image(12,12);
imgDown.src = '<html:rewrite page='/images/studio/S_pick_right.gif'/>';

// used by timeout auto hide functions
var timeoutId = false;

// the now standard browser sniffer class
function Browser(){
  this.dom = document.getElementById?1:0;
  this.ie4 = (document.all && !this.dom)?1:0;
  this.ns4 = (document.layers && !this.dom)?1:0;
  this.ns6 = (this.dom && !document.all)?1:0;
  this.ie5 = (this.dom && document.all)?1:0;
  this.ok = this.dom || this.ie4 || this.ns4;
  this.platform = navigator.platform;
}
var browser = new Browser();

var g_Calendar;  // global to hold the calendar reference, set by constructor

function calendarTimeout(){
  if (browser.ie4 || browser.ie5){
    if (window.event.srcElement && window.event.srcElement.name!='month') timeoutId=setTimeout('g_Calendar.hide("calendarTimeout");',timeoutDelay);
  }
  if (browser.ns6 || browser.ns4){
    timeoutId=setTimeout('g_Calendar.hide("calendarTimeout");',timeoutDelay);
  }
}

// constructor for calendar class
function Calendar(){
  g_Calendar = this;
  // some constants needed throughout the program
  this.daysOfWeek = new Array("Su","Mo","Tu","We","Th","Fr","Sa");
  this.months = new Array("January","February","March","April","May","June","July","August","September","October","November","December");
  this.daysInMonth = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

  if (browser.ns4){
    var tmpLayer = new Layer(127);
		if (timeoutDelay){
		  tmpLayer.captureEvents(Event.MOUSEOVER | Event.MOUSEOUT);
		  tmpLayer.onmouseover = function(event) { if (timeoutId) clearTimeout(timeoutId); };
		  tmpLayer.onmouseout = function(event) { timeoutId=setTimeout('g_Calendar.hide("Calendar")',timeoutDelay);};
		}
    tmpLayer.x = 100;
    tmpLayer.y = 100;
    tmpLayer.bgColor = "#ffffff";
  }
  if (browser.dom || browser.ie4){
		var tmpLayer = browser.dom?document.getElementById('calendarContainer'):document.all.calendarContainer;
  }
  this.containerLayer = tmpLayer;
  if (browser.ns4 && browser.platform=='Win32') {
    this.containerLayer.clip.height=134;
    this.containerLayer.clip.width=127;
  }
}

Calendar.prototype.getFirstDOM = function() {
  var thedate = new Date();
  thedate.setDate(1);
  thedate.setMonth(this.month);
  thedate.setFullYear(this.year);
  return thedate.getDay();
}

Calendar.prototype.getDaysInMonth = function (){
  if (this.month!=1) {
    return this.daysInMonth[this.month]
  }
  else {
    // is it a leap year
    if (Date.isLeapYear(this.year)) {
      return 29;
    }
    else {
      return 28;
    }
  }
}

Calendar.prototype.buildString = function(){
  var tmpStr = '<table width="100%" border="0" cellspacing="0" cellpadding="2" class="calendarOuterTable"><tr><td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="1" class="calendarTable">';
  tmpStr += '<tr>';
  tmpStr += '<td width="100%" class="calendarTdHeader">';
  tmpStr += '<table border="0" cellspacing="0" cellpadding="0"><tr><td><a href="javascript: g_Calendar.changeMonth(-1);"><img name="calendar" src="<html:rewrite page='/images/studio/S_pick_left.gif'/>" width="8" height="12" border="0" alt=""></a></td><td class="calendarTd" width="100%" align="center">' + this.months[this.month] + '  ' + this.year+ '</td><td class="calendarTd"><a href="javascript: g_Calendar.changeMonth(+1);"><img name="calendar" src="<html:rewrite page='/images/studio/S_pick_right.gif'/>" width="8" height="12" border="0" alt=""></a></td></tr></table>';
  tmpStr += '</td>';
  /* observation : for some reason if the below event is changed to 'onChange' rather than 'onBlur' it totally crashes IE (4 and 5)!
   */
  tmpStr += '</tr>';
  tmpStr += '</table>';
  var iCount = 1;

  var iFirstDOM = (7+this.getFirstDOM()-g_startDay)%7; // to prevent calling it in a loop

  var iDaysInMonth = this.getDaysInMonth(); // to prevent calling it in a loop

  tmpStr += '<table width="100%" border="0" cellspacing="0" cellpadding="1" class="calendarTable">';
  tmpStr += '<tr>';
  for (var i=0;i<7;i++){
    tmpStr += '<td class="calendarDays">' + this.daysOfWeek[(g_startDay+i)%7] + '</td>';
  }
  tmpStr += '</tr>';
  var tmpFrom = parseInt('' + this.dateFromYear + padZero(this.dateFromMonth) + padZero(this.dateFromDay),10);
  var tmpTo = parseInt('' + this.dateToYear + padZero(this.dateToMonth) + padZero(this.dateToDay),10);
  var tmpCompare;
  for (var j=1;j<=6;j++){
    tmpStr += '<tr>';
    for (var i=1;i<=7;i++){
      tmpStr += '<td width="16" '
        if ( (7*(j-1) + i)>=iFirstDOM+1  && iCount <= iDaysInMonth){
          if (iCount==this.day && this.year==this.oYear && this.month==this.oMonth) tmpStr += 'class="calendarHighlighted"';
          else {
            if (i==7-g_startDay || i==((7-g_startDay)%7)+1) tmpStr += 'class="calendarWeekend"';
            else tmpStr += 'class="calendarTd"';
          }
          tmpStr += '>';
          /* could create a date object here and compare that but probably more efficient to convert to a number
             and compare number as numbers are primitives */
          tmpCompare = parseInt('' + this.year + padZero(this.month) + padZero(iCount),10);
<%--          alert("from"+tmpFrom + " to:"+tmpTo + " comp:"+tmpCompare + " month:"+padZero(this.month) + " to:"+padZero(this.dateToDay)+" date:"+this.dateToDay);--%>
          if (tmpCompare >= tmpFrom && tmpCompare <= tmpTo) {
            tmpStr += '<a class="calendarLink" href="javascript: g_Calendar.clickDay(' + iCount + ');">' + iCount + '</a>';
          } else {
            tmpStr += '<span class="calendarDisabled">' + iCount + '</span>';
          }
          iCount++;
        } else {
          if  (i==7-g_startDay || i==((7-g_startDay)%7)+1) tmpStr += 'class="calendarWeekend"'; else tmpStr +='class="calendarTd"';
          tmpStr += '>&nbsp;';
        }
      tmpStr += '</td>'
        }
    tmpStr += '</tr>'
      }
  if(this.useTime){
    tmpStr += '<tr><td colspan="6">Time:<input name="hour" onkeypress="g_Calendar.validateTime(this)" onBlur="g_Calendar.hourChanged(this.value);" value="' + this.iHour + '" class="hour" type="text" size="2"/>:<input name="minute"  class="minute" type="text" size="2" value="' + this.iMinute + '" onkeypress="g_Calendar.validateTime(this)" onBlur="g_Calendar.minuteChanged(this.value);"/></td></tr>';
    tmpStr += '<tr><td><a href="javascript: g_Calendar.close();">close</a></td><td><a href="javascript: g_Calendar.clear();">clear</a></td><td><a href="javascript: g_Calendar.end();">ok</a></td></tr>'
  }
  tmpStr += '</table></td></tr></table>'
  return tmpStr;
}

Calendar.prototype.selectChange = function(){
  this.month = document.getElementById('calendarMonth').selectedIndex;
  this.writeString(this.buildString());
}

Calendar.prototype.inputChange = function(){
  var tmp = document.getElementById('calendarYear');
  if (tmp.value >=1900 || tmp.value <=2100){
    this.year = tmp.value;
    this.writeString(this.buildString());
  } else {
    tmp.value = this.year;
  }
}
Calendar.prototype.changeYear = function(incr){
  (incr==1)?this.year++:this.year--;
  if(this.year<=this.dateFromYear){
    this.year=this.dateFromYear;
    if(this.month<this.dateFromMonth){
      this.month = this.dateFromMonth;
      if(this.day<this.dateFromDay){
        this.day = this.dateFromDay;
      }
    }
  }
  if(this.year>=this.dateToYear){
    this.year=this.dateToYear;
    if(this.month>this.dateToMonth){
      this.month = this.dateToMonth;
      if(this.day>this.dateToDay){
        this.day = this.dateToDay;
      }
    }
  }
  this.oYear=this.year;
  this.oMonth = this.month;
  this.oDay = this.day;
  this.writeString(this.buildString());
}
Calendar.prototype.changeMonth = function(incr){
  if (this.month==11 && incr==1){
    this.month = 0;
    this.year++;
  } else {
    if (this.month==0 && incr==-1){
      this.month = 11;
      this.year--;
    } else {
      (incr==1)?this.month++:this.month--;
    }
  }
  if(this.year==this.dateFromYear){
    if(this.month<this.dateFromMonth){
      this.month=this.dateFromMonth;
    }
  }
  if(this.year==this.dateToYear){
    if(this.month>this.dateToMonth){
      this.month=this.dateToMonth;
    }
  }
  this.oMonth = this.month;
  this.debugDate();
  this.writeString(this.buildString());
}

Calendar.prototype.debugDate = function(){
//  alert(this.year + this.dateDelim + this.month + this.dateDelim + this.day + "T"+this.time);
}
Calendar.prototype.clickDay = function(day){
  var tmp = document[this.target][this.property];
  if (tmp) {
  } else {
    var tmpYear = document[this.target]["year" + this.property];
    var tmpMonth = document[this.target]["month" + this.property];
    var tmpDay = document[this.target]["day" + this.property];
    if (tmpYear && tmpMonth && tmpDay) {
      tmpYear.value = this.year;
      tmpMonth.value = this.month;
      tmpDay.value = day;
    } else {
      alert("The form is missing some fields...");
    }
    this.year = tmpYear;
    this.month = tmpMonth;
    this.day = tmpDay;
  }
  this.day = day;
  if(this.useTime){
    this.writeString(this.buildString());
  }else{
    this.end();
  }
}
Calendar.prototype.hourChanged = function(value){
  this.iHour=value;
}
Calendar.prototype.minuteChanged = function(value){
  this.iMinute=value;
}

Calendar.prototype.validateTime = function(field){
	strWork = '01234567890'
	blnValidChar = false;					// Valid character flag
  
	// Part 1: Validate input
	if(window.event){
		for(i=0;i < strWork.length;i++)
      if(window.event.keyCode == strWork.charCodeAt(i)) {
        blnValidChar = true;
        break;
      }
   }
  if(field.value.length>1){
    blnValidChar = false;
  }
	// Part 2: Build error message
	if(!blnValidChar) {
    if(window.event){
  		window.event.returnValue = false;		// Clear invalid character
  		field.focus();						// Set focus
      return;
    }
	}
}

Calendar.prototype.setDate = function(){
  var tmp = document[this.target][this.property];
  if(tmp!=null){
    if(this.saveTime){
      this.time=this.getValue('hour')+":"+this.getValue('minute')+":00";
    }
      if (this.dateFormat=='dd-mmm-yyyy' || this.dateFormat=='dd/mmm/yyyy') tmp.value = this.leadingZero(this.day) + this.dateDelim + this.months[this.month].substr(0,3) + this.dateDelim + this.year;
      if (this.dateFormat=='dd/mm/yyyy' || this.dateFormat=='dd-mm-yyyy') tmp.value = this.leadingZero(this.day) + this.dateDelim + this.leadingZero(this.month+1) + this.dateDelim + this.year;
      if (this.dateFormat=='mm/dd/yyyy' || this.dateFormat=='mm-dd-yyyy') tmp.value = this.leadingZero(this.month+1) + this.dateDelim + this.leadingZero(this.day) + this.dateDelim + this.year;
      if (this.dateFormat=='yyyy-mm-dd') tmp.value = this.year + this.dateDelim + this.leadingZero(this.month+1) + this.dateDelim + this.leadingZero(this.day);
      if (this.saveTime &&  this.time != '') tmp.value = tmp.value + 'T' + this.time;
  }
}
Calendar.prototype.clear = function(){
    this.day="";
    this.month="";
    this.year="";
    this.setValue('hour','');
    this.setValue('minute','');
    var tmp = document[this.target][this.property];
    if(tmp!=null){
      tmp.value="";
    }
    this.close();
}


Calendar.prototype.end = function(){
  this.setDate();
  validInput = true;
  if(this.useTime){
    if(this.iHour>23){
      alert("Hour cannot be > 23");
      validInput = false;
    }else if(this.iMinute>59){
      alert("Minute cannot be > 59");
      validInput = false;
    }else{
      if(this.dateFromDay==this.day&&this.dateFromMonth==this.month&&this.dateFromYear==this.year){
        if(this.iHour<this.dateFromHour || (this.iHour==this.dateFromHour&&this.iMinute<this.dateFromMin)){
          alert("Time is before from date");
          validInput = false;
        }
      }
      if(this.dateToDay==this.day&&this.dateToMonth==this.month&&this.dateToYear==this.year){
        if(this.iHour>this.dateToHour || (this.iHour==this.dateToHour&&this.iMinute>this.dateToMin)){
          alert("Time is after end date");
          validInput = false;
        }
      }
    }
  }
  if(validInput){
    this.debugDate();
    this.close();
  }
}
Calendar.prototype.close = function(){
  if (this.callback) this.callback(this.target, this.property);
  if (browser.ns4) this.containerLayer.hidden=true;
  if (browser.dom || browser.ie4){
    this.containerLayer.style.visibility='hidden'
      Calendar.prototype.writeString('');
  }
}

Calendar.prototype.leadingZero = function(number) {
  if (number < 10) return "0" + number
  return number;
}

Calendar.prototype.writeString = function(str){
  if (this.containerLayer) {
	  if (browser.ns4){
	    this.containerLayer.document.open();
	    this.containerLayer.document.write(str);
	    this.containerLayer.document.close();
	  }
	  if (browser.dom || browser.ie4){
      this.containerLayer.innerHTML = str;
    }
  }
  if(!this.iHour)this.iHour="00";
  if(!this.iMinute)this.iMinute="00";
  if(this.useTime){
    this.setValue('hour',this.iHour);
    this.setValue('minute',this.iMinute);
  }
}

Calendar.prototype.setValue = function(property,value){
  if(document.getElementById(property)){
    document.getElementById(property).value=value;
    return;
  }
}
Calendar.prototype.getValue = function(property){
  if(document.getElementById(property)){
    return document.getElementById(property).value;
  }
  if(property=="hour"){
    return this.iHour;
  }
  if(property=="minute"){
    return this.iMinute;
  }
  return "00";
}


Calendar.prototype.show = function(event, target, property, bHasDropDown, dateFormat, dateFrom, dateTo, callback){
        this.year = '';
        this.month= '';
        this.day  = '';
        this.iHour='00';
        this.iMinute='00';
        this.timeDelim = ":";
  this.target = target;
  this.property = property;
  this.callback = callback;
<%--  if(!document.all){--%>
<%--    return;--%>
<%--  }--%>
	if (dateFormat) this.dateFormat = dateFormat; else this.dateFormat = 'yyyy-mm-dd';
	switch (this.dateFormat){
      case 'dd-mmm-yyyy':
      case 'dd-mm-yyyy':
      case 'yyyy-mm-dd':
      case 'dd-mmm-yyyyT':
      case 'dd-mm-yyyyT':
      case 'yyyy-mm-ddT':
        this.dateDelim = '-';
        break;
      case 'dd/mm/yyyy':
      case 'mm/dd/yyyy':
      case 'dd/mmm/yyyy':
      case 'dd/mm/yyyyT':
      case 'mm/dd/yyyyT':
      case 'dd/mmm/yyyyT':
        this.dateDelim = '/';
        break;
	}
    this.saveTime=true;
      if (this.dateFormat.indexOf('T') != -1) {
        this.dateFormat = this.dateFormat.substring(0,dateFormat.length-1);
        this.useTime = true;
      } else {
        this.useTime = false;
        this.saveTime=false;
      }
<%--    if (!(browser.ie5)){--%>
<%--      this.useTime=false;--%>
<%--    }--%>
	// calendar can restrict choices between 2 dates, if however no restrictions
	// are made, let them choose any date between 1900 and 3000
	if (dateFrom){
    this.parseDateLimit(dateFrom,'true');
	}else{
    this.dateFrom = new Date(1900,0,1);
    this.dateFromDay = padZero(this.dateFrom.getDate());
    this.dateFromMonth = padZero(this.dateFrom.getMonth());
    this.dateFromYear = this.dateFrom.getFullYear();
	}
	if (dateTo){
    this.parseDateLimit(dateTo,'false');
	}else{
    this.dateTo = new Date(3000,0,1);
    this.dateToDay = padZero(this.dateTo.getDate());
    this.dateToMonth = padZero(this.dateTo.getMonth());
    this.dateToYear = this.dateTo.getFullYear();
	}
	this.hasDropDown = bHasDropDown;


  if (browser.ns4) {
    if (!this.containerLayer.hidden) {
		  this.containerLayer.hidden=true;
		  return;
		}
  }
  if (browser.dom || browser.ie4){
    if (this.containerLayer.style.visibility=='visible') {
		  this.containerLayer.style.visibility='hidden';
      Calendar.prototype.writeString('');
		  return;
		}
  }
  if (browser.ie5 || browser.ie4){
    var event = window.event;
  }
  if (browser.ns4){
    this.containerLayer.x = event.x+10;
    this.containerLayer.y = event.y-5;
  }
  if (browser.ie5 || browser.ie4){
    var obj = event.srcElement;
    x = 0;
    while (obj.offsetParent != null) {
      x += obj.offsetLeft;
      obj = obj.offsetParent;
    }
    x += obj.offsetLeft;
    y = 0;
		var obj = event.srcElement;
    while (obj.offsetParent != null) {
      y += obj.offsetTop;
      obj = obj.offsetParent;
    }
    y += obj.offsetTop;

    this.containerLayer.style.left = x+35;
		if (event.y>0)this.containerLayer.style.top = y;
  }
  if (browser.ns6){
    this.containerLayer.style.left = event.pageX+10;
		this.containerLayer.style.top = event.pageY-5;
  }

  if (document[this.target][property]) {
   var tmp = document[this.target][property];
   if (this.saveTime) {
     if (tmp && tmp.value && tmp.value.indexOf('T') != -1) {
       this.time = tmp.value.substring(tmp.value.indexOf('T')+1);
     } else {
       this.time = '00:00:00';
     }
   }
   if (tmp && tmp.value) {
    if (tmp.value.indexOf('T') != -1) {
      var atmp = tmp.value.substring(0,tmp.value.indexOf('T')).split(this.dateDelim);
      var timeTmp = tmp.value.substring(tmp.value.indexOf('T')+1).split(this.timeDelim);
      this.iHour = timeTmp[0];
      this.iMinute = timeTmp[1];
    } else {
      var atmp = tmp.value.split(this.dateDelim);
    }
    if (atmp.length==3 && tmp.value.indexOf('d')==-1){
      switch (this.dateFormat){
        case 'dd-mmm-yyyy':
        case 'dd/mmm/yyyy':
        for (var i=0;i<this.months.length;i++){ //>
          if (atmp[1].toLowerCase()==this.months[i].substr(0,3).toLowerCase()){
            this.month = this.oMonth = i;
            break;
          }
        }
        this.day = parseInt(atmp[0],10);
        this.year = this.oYear = parseInt(atmp[2],10);
        break;
        case 'dd/mm/yyyy':
        case 'dd-mm-yyyy':
        this.month = this.oMonth = parseInt(atmp[1]-1,10);
        this.day = parseInt(atmp[0],10);
        this.year = this.oYear = parseInt(atmp[2],10);
        break;
        case 'mm/dd/yyyy':
        case 'mm-dd-yyyy':
        this.month = this.oMonth = parseInt(atmp[0]-1,10);
        this.day = parseInt(atmp[1],10);
        this.year = this.oYear = parseInt(atmp[2],10);
        break;
        case 'yyyy-mm-dd':
        this.month = this.oMonth = parseInt(atmp[1]-1,10);
        this.day = parseInt(atmp[2],10);
        this.year = this.oYear = parseInt(atmp[0],10);
        break;
      }
   }
   this.debugDate();
  }
  } else if (document[this.target]["year" + this.property] && document[this.target]["month" + this.property] && document[this.target]["day" + this.property] ) {
    this.year = this.oYear = document[this.target]["year" + this.property].value;
    this.month = this.oMonth = document[this.target]["month" + this.property].value;
    this.day = document[this.target]["day" + this.property].value;
  }
  testMonth = ""+this.month;
  if (this.year == '' || parseInt(this.year) == NaN
      || this.testMonth == '' || parseInt(this.month) == NaN
      || this.day == '' || parseInt(this.day) == NaN) { // no date set, default to today
    var theDate = new Date();
    this.year = this.oYear = theDate.getFullYear();
    this.month = this.oMonth = theDate.getMonth();
    this.day = this.oDay = theDate.getDate();
  }
  this.writeString(this.buildString());

  // and then show it!
  if (browser.ns4) {
    this.containerLayer.hidden=false;
  }
  if (true || browser.dom || browser.ie4){
    this.containerLayer.style.visibility='visible';
  }
}
Calendar.prototype.parseDateLimit = function(prop,from){
  var t = null;
  var h = null;
  var min = null;
  var y = null;
  var m = null;
  var d = null;
  if (document[this.target][prop]) {
   var tmp = document[this.target][prop];
   if (this.saveTime) {
     if (tmp && tmp.value && tmp.value.indexOf('T') != -1) {
       t = tmp.value.substring(tmp.value.indexOf('T')+1);
     } else {
       t = '00:00:00';
       h = '00';
       min = '00';
     }
   }
   if (tmp && tmp.value) {
    if (tmp.value.indexOf('T') != -1) {
      var atmp = tmp.value.substring(0,tmp.value.indexOf('T')).split(this.dateDelim);
      var timeTmp = tmp.value.substring(tmp.value.indexOf('T')+1).split(this.timeDelim);
      h = timeTmp[0];
      min = timeTmp[1];
    } else {
      var atmp = tmp.value.split(this.dateDelim);
    }
    if (atmp.length==3 && tmp.value.indexOf('d')==-1){
      switch (this.dateFormat){
        case 'dd-mmm-yyyy':
        case 'dd/mmm/yyyy':
        for (var i=0;i<this.months.length;i++){ //>
          if (atmp[1].toLowerCase()==this.months[i].substr(0,3).toLowerCase()){
            m = i;
            break;
          }
        }
        d = parseInt(atmp[0],10);
        y = parseInt(atmp[2],10);
        break;
        case 'dd/mm/yyyy':
        case 'dd-mm-yyyy':
        m = parseInt(atmp[1]-1,10);
        d = parseInt(atmp[0],10);
        y = parseInt(atmp[2],10);
        break;
        case 'mm/dd/yyyy':
        case 'mm-dd-yyyy':
        m = parseInt(atmp[0]-1,10);
        d = parseInt(atmp[1],10);
        y = parseInt(atmp[2],10);
        break;
        case 'yyyy-mm-dd':
        m = parseInt(atmp[1]-1,10);
        d = parseInt(atmp[2],10);
        y = parseInt(atmp[0],10);
        break;
      }
   }

  }else{
    if(from=='true'){
      this.dateFrom = new Date(1900,0,1);
      d = padZero(this.dateFrom.getDate());
      m = padZero(this.dateFrom.getMonth());
      y = this.dateFrom.getFullYear();
      t = '00:00:00';
      h = '00';
      min = '00';
      
    }else{
      this.dateTo = new Date(3000,0,1);
      d = padZero(this.dateTo.getDate());
      m = padZero(this.dateTo.getMonth());
      y = this.dateTo.getFullYear();
      t = '00:00:00';
      h = '00';
      min = '00';
    }
  }
  if(from=='true'){
    this.dateFromDay = d;
    this.dateFromMonth = m;
    this.dateFromYear = y;
    this.dateFromHour = h;
    this.dateFromMin = min;
  }else{
    this.dateToDay = d;
    this.dateToMonth = m;
    this.dateToYear = y;
    this.dateToHour = h;
    this.dateToMin = min;
  }
  }
}

Calendar.prototype.hide = function(fromwhere){
  Calendar.prototype.writeString('');
  if (browser.ns4) this.containerLayer.hidden = true;
  if (browser.dom || browser.ie4){
    this.containerLayer.style.visibility='hidden';
  }
}

function handleDocumentClick(e){
  if (browser.ie4 || browser.ie5) e = window.event;

  if (browser.ns6){
    var bTest = (e.pageX >= parseInt(g_Calendar.containerLayer.style.left,10) && e.pageX <=  (parseInt(g_Calendar.containerLayer.style.left,10)+125) && e.pageY <= (parseInt(g_Calendar.containerLayer.style.top,10)+125) && e.pageY >= parseInt(g_Calendar.containerLayer.style.top,10));
    <!--alert("bTest:"+bTest+ "pageX "+ e.pageX+ "pageY "+ e.pageY + " styleLeft"+parseInt(g_Calendar.containerLayer.style.left,10)+ " styleTop"+parseInt(g_Calendar.containerLayer.style.top,10));-->
    if (e.target.name!='hour'&&e.target.name!='minute'&& e.target.name!='imgCalendar' && e.target.name!='calendarMonth'  && e.target.name!='calendarYear' && e.target.name!='calendar' && !bTest){
		  <!--g_Calendar.hide("handleDocumentClick1");-->
      return;
		}else{return;}
  }
  if (browser.ie4 || browser.ie5){
		// extra test to see if user clicked inside the calendar but not on a valid date, we don't want it to disappear in this case
    var bTest = (e.x > parseInt(g_Calendar.containerLayer.style.left,10) && e.x <  (parseInt(g_Calendar.containerLayer.style.left,10)+125) && e.y < (parseInt(g_Calendar.containerLayer.style.top,10)+125) && e.y > parseInt(g_Calendar.containerLayer.style.top,10));
    if (e.srcElement.name!='hour'&&e.srcElement.name!='minute'&& e.srcElement.name!='imgCalendar' && e.srcElement.name!='calendarMonth' && e.srcElement.name!='calendarYear' && !bTest & typeof(e.srcElement)!='object'){
		  g_Calendar.hide("handleDocumentClick2");
      return;
		}else{return;}
  }
  if (browser.ns4) g_Calendar.hide("handleDocumentClick3");
}

// utility function
function padZero(num) {
  if(num==null){
    return "00";
  }
  if(num==00||num==0){
    return "00";
  }
  if(num.length>1){
    return num;
  }
  return ((num <= 9) ? ("0" + num) : num);
}
// Finally licked extending  native date object;
Date.isLeapYear = function(year){ if (year%4==0 && ((year%100!=0) || (year%400==0))) return true; else return false; }
Date.daysInYear = function(year){ if (Date.isLeapYear(year)) return 366; else return 365;}
var DAY = 1000*60*60*24;
Date.prototype.addDays = function(num){
  return new Date((num*DAY)+this.valueOf());
}

// events capturing, careful you don't override this by setting something in the onload event of
// the body tag
function calendarInit(){
  new Calendar(new Date());
  if (browser.ns4){
    if (typeof document.NSfix == 'undefined'){
		  document.NSfix = new Object();
      document.NSfix.initWidth=window.innerWidth;
		  document.NSfix.initHeight=window.innerHeight;
		}
  }
}
if (browser.ns4) window.onresize = function(){
  if (document.NSfix.initWidth!=window.innerWidth || document.NSfix.initHeight!=window.innerHeight) window.location.reload(false);
} // ns4 resize bug workaround
window.document.onclick=handleDocumentClick;
window.onerror = function(msg,url,line){
}
