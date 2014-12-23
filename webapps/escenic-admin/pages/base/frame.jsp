<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%-- 

  Frame.jsp -- Used by most of the pages in Phoenix.
  It accepts a lot of parameters:
    * includeMenu      : true | false (default true)
    * isSubmittingForm : true | false (default false)
    * listcolors       : a list of colors (default "#DDEEFF,#FFFFFF")

--%>
<!-- Frame begins -->
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%-- Start the struts servlet if it has not yet been started --%>
<jsp:include page="/do/nop" />
<%-- Set a few default values, if they are not set by the calling JSP. --%>
<%-- By default, include the menu... --%>
<logic:notPresent name="includeMenu" scope="request">
  <bean:define id="includeMenu" value="true" toScope="request"/>
</logic:notPresent>

<%-- 
   By default, assume we're not submitting a form in the content area.
--%>
<logic:notPresent name="isSubmittingForm" scope="request">
  <bean:define id="isSubmittingForm" value="false" toScope="request"/>
</logic:notPresent>

<%-- 
   Set up some default list colors; blue on white....
--%>
<logic:notPresent name="listcolors" scope="request">
  <bean:define id="listcolors" value="#DDEEFF,#FFFFFF" toScope="request" />
</logic:notPresent>

<%-- 
   Set up some default list colors; blue on white....
--%>
<logic:notPresent name="navigation" scope="request">
  <bean:define id="navigation" value="navigation.jsp" toScope="request" />
</logic:notPresent>

<%--
     Include the header, start the body and show the banner...  
     These could be inlined. 
 --%>
<html>
  <head>
    <title><%=System.getProperty("escenic.server")%>: <bean:message name="title"/></title>
    <link rel="stylesheet" href="<html:rewrite page="/images/basic.css"/>" type="text/css">
    <link rel="SHORTCUT ICON" href="<html:rewrite page="/images/favicon.ico"/>">
    <logic:equal name="content" value="/pages/systemproperties-content.jsp">
      <style>
        table td.centerpanel {padding-top: 10px;}
      </style>
    </logic:equal> 
    <logic:equal name="content" value="/pages/performance-content.jsp">
      <style>
        table td.centerpanel {padding-top: 10px;}
      </style>
    </logic:equal> 
    <logic:equal name="content" value="/pages/services-content.jsp">
      <style>
        table td.centerpanel {padding-top: 15px;}
      </style>
    </logic:equal> 
    <logic:equal name="content" value="/pages/support-request-content.jsp">
      <style>
        table td.centerpanel {padding-top: 10px;}
      </style>
    </logic:equal> 
    <logic:equal name="content" value="/pages/loglevels-content.jsp">
      <style>
        table td.centerpanel {padding-top: 10px;}
      </style>
    </logic:equal> 
    <logic:equal name="content" value="/pages/jsp-statistics-show-groups.jsp">
      <style>
        table td.centerpanel {padding-top: 10px;}
      </style>
    </logic:equal> 
    <logic:equal name="content" value="/pages/database/query-content.jsp">
      <style>
        table td.centerpanel {padding-top: 10px;}
      </style>
    </logic:equal> 
    <logic:equal name="content" value="/pages/classification/import-content.jsp">
      <style>
        table td.centerpanel {padding-top: 15px;}
      </style>
    </logic:equal> 
    <logic:equal name="content" value="/pages/classification-content.jsp">
      <style>
        table td.centerpanel {padding-top: 15px;}
      </style>
    </logic:equal> 
    <logic:equal name="content" value="/pages/publication/user-content.jsp">
      <style>
        table td.centerpanel {padding-top: 10px;}
      </style>
    </logic:equal> 
    <logic:equal name="content" value="/pages/publication/migrate-content.jsp">
      <style>
        table td.centerpanel {padding-top: 7px;}
      </style>
    </logic:equal> 
    <logic:equal name="content" value="/pages/publication/migrate-confirm-content.jsp">
      <style>
        table td.centerpanel {padding-top: 10px;}
      </style>
    </logic:equal> 
    <logic:equal name="content" value="/pages/publication/migrate-success-content.jsp">
      <style>
        table td.centerpanel {padding-top: 10px;}
      </style>
    </logic:equal>     

  </head>
  <logic:present name="escenic-publication" scope="session">

<% if (request.getSession().getAttribute("escenic-publication") != null) {
   request.setAttribute("publication", request.getSession().getAttribute("escenic-publication"));
 } %>

  </logic:present>
    <script language="JavaScript1.2"><!-- 
  function submitForm(button) {
    if(document.forms[0]) {
      if(document.forms[0].submitButton) {
        document.forms[0].submitButton.value=button;
        document.forms[0].submit();
      } else {
        window.location.href='<html:rewrite page="/do/base/forward"/>?forward=' + button;
      }
    } else {
      window.location.href='<html:rewrite page="/do/base/forward"/>?forward=' + button;
    }
  }

  function globalSearch(searchWord) {
    alert("Global search has not been implemented yet.  I'm not sure what to do if you click Go. What do you think?  Tell me about it; mogsie@escenic.com");
   /*
    if (document.forms[0]) {
      document.forms[0].globalSearchWord.value=searchWord;
      document.forms[0].submitButton.value='action:/do/base/globalSearch';
      document.forms[0].submit();
    } else {
      alert('unable to search for "' + searchWord + '"!');
    }*/
  }

  var init=new Function();

  // -->
</script>

<template:serviceParameter name="content-beforeBody" />

<body onload="init();" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" >
<%--
<table width="100%" class="banner" cellspacing="0" callpadding="0">
<tr>
<td><html:img align="middle" page="/images/nothing.gif" width="20" height="20"/><span class="bannertext">&nbsp;<bean:message name="title"/></span></td>
<td align="right">
<logic:present name="escenic-user" scope="session"><span class="topmenu">Logged in as <bean:write name="escenic-user" scope="session" property="userName"/></span></logic:present>
<html:img page="/images/bar01.png" width="3" height="18" align="middle" />
<logic:present name="escenic-publication" scope="session">

<a href="javascript:submitForm('main-menu')"><html:img page="/images/house01.gif" border="0" align="middle"/>&nbsp;<span class="topmenu">Home</span></a>&nbsp;</logic:present><html:img page="/images/logo.gif" align="middle"/></td>
</tr>
</table>
--%>
<table cellspacing="0" cellpadding="0" width="100%" height="100%">
<%--
<tr>
  <td width="40"><html:img page="/images/nothing.gif" width="40" height="1" /></td>
  <td width="5"><html:img page="/images/nothing.gif" width="5" height="1"/></td>
  <td width="1"><html:img page="/images/nothing.gif" width="1" height="1"/></td>
  <td width="100%"><html:img page="/images/nothing.gif" width="740" height="1"/></td>
</tr>
--%>
<tr>
  <td valign="top" class="leftPanel">
    <div class="nav-header">Administration</div>
    <html:img page="/images/nothing.gif" width="180" height="1" />
    <!-- Servicing content -->
    <template:serviceParameter name="navigation" />
    <!-- Finished servicing content -->
  </td>
<%--
  <!-- Spacer -->
  <td>&nbsp;</td>
  <td style=" background-image: url(<html:rewrite page="/images/line_dot_vertical.gif"/>); background-repeat: repeat-y;"></td>
--%>
  <td valign="top" class="centerPanel">
      <%-- <h1>Administration</h1> --%>
      <!-- Servicing content -->
      <jsp:include page='<%=(String)request.getAttribute("content")%>' />
      <!-- Finished servicing content -->
  </td>
</tr>
</table>

  <logic:present name="returnToThisPage" scope="request">
    <html:form action="/base/dispatch">
      <%-- submitButton will be populated by the javascript submitForm function. --%>
      <input type="hidden" name="submitButton"       value="">

      <jsp:include page="common-form-fields.jsp" />

      <%-- the value of the validateInputAction parameter will determine which action
           that will be used if things go well. --%>
      <input type="hidden" name="validateInputAction" value="<bean:write name="returnToThisPage" scope="request" />" >
    </html:form>
  </logic:present>

  <logic:present name="returnToThisForward" scope="request">
    <html:form action="/base/dispatch">
      <%-- submitButton will be populated by the javascript submitForm function. --%>
      <input type="hidden" name="submitButton"       value="">

      <jsp:include page="common-form-fields.jsp" />

      <%-- the value of the validateInput parameter will determine which forward
           that will be used if things go well. --%>
      <input type="hidden" name="validateInput" value="<bean:write name="returnToThisForward" scope="request" />" >
    </html:form>
  </logic:present>

  </body>
</html>
<!-- Frame ends -->
