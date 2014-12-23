<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%--
  <head> element for popups.
  Popups are self contained files which interact with their
 'opener' via javascript.
 The <head> element sets up a 'submitForm' which doesn't
 submit the form, but which sends the form object to the
 'window.opener' which should have an 'acceptpopupform'
 handler.
--%>
<head>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8"> 
  <meta http-equiv="Expires" content="0">
  <meta http-equiv="Pragma" content="no-cache">
  <title><template:serviceParameter name="areamap-frame-header-title"/></title>
<!--
  <style>
    div { border: 1px solid green; margin: 2px; padding: 2px; }
    table { border: 1px solid red; margin: 2px; padding: 2px; }
    td { border: 1px dotted red; margin: 2px; padding: 2px; }
  </style>
-->
  <link rel="stylesheet" href="<html:rewrite page="<%=(String)pageContext.findAttribute(\"textmap-style-global\")%>"/>" type="text/css">
  <link rel="stylesheet" href="<html:rewrite page="<%=(String)pageContext.findAttribute(\"textmap-style-context\")%>"/>" type="text/css">

  <link rel="SHORTCUT ICON" href="<html:rewrite page="/images/favicon.ico"/>">
  <template:serviceParameter name="areamap-frame-header-head" />
<logic:present name="escenic-publication" scope="session">

  <% if (request.getSession().getAttribute("escenic-publication") != null) {
    request.setAttribute("publication", request.getSession().getAttribute("escenic-publication"));
  %>
  <% } %>
</logic:present>

<script language="JavaScript1.2" type="text/javascript"><!--
  function callback() {
     alert("default callback ...  Something went wrong.");
  }
  function submitForm(button,anchor) {
    if(callHooks('beforeSubmit')){
      if(document.forms[0]) {
        if(document.forms[0].submitButton) {
          document.forms[0].submitButton.value=button;
          if (anchor && anchor != 'null') {
            document.forms[0].action=document.forms[0].action + '#' + anchor;
          }
          document.forms[0].submit();
        } else {
          window.location.href='<html:rewrite page="/base/forward.do"/>?forward=' + button;
        }
      } else {
        window.location.href='<html:rewrite page="/base/forward.do"/>?forward=' + button;
      }
    }
  }

  function submitPopup(button,anchor) {
    if(callHooks('beforeSubmit')) {
      if (window.opener && !window.opener.closed) {
        if (window.callback) {
          callback = window.callback;
        }
        if (document.callback) {
          callback = document.callback;
        }
        if (window.opener.popupcallback) {
          callback = window.opener.popupcallback;
        }
        if (window.opener.document.popupcallback) {
          callback = window.opener.document.popupcallback;
        }
        callback(document.forms[0], button, anchor);
      } else {
        alert("The originating window is gone.");
      }
    }
    window.close();
  }

  //will submit the parent window without using provided callback 
  function submitParentWindow(button,anchor) {
    if(callHooks('beforeSubmit')) {
      if (window.opener && !window.opener.closed) {
        window.opener.submitForm(button,anchor);
      } else {
        alert("The originating window is gone.");
      }
    }
    window.close();
  }

  var eventHooks = new Object();
  function registerHook(where,fn) {
    if (!eventHooks[where]) {
      eventHooks[where] = new Array()
    }
    eventHooks[where][eventHooks[where].length] = fn;
  }

  function callHooks(where) {
    if (eventHooks[where]) {
      for (var i = 0; i < eventHooks[where].length; i++) {
        var fn = eventHooks[where][i];
        result = fn();
        if (! result) {
          
          return false;
        }
      }
    } else {
    }
    return true;
  }
  // -->
</script>

<script language="JavaScript1.2" type="text/javascript" src='<html:rewrite page="/script/roundedbox.js"/>'></script>

<script>
registerHook("afterLoad",
  function() {
    var body = document.getElementById('body');
    if(!body){
      body = document.getElementsByName('body')[0];
    }
    if(!body){
      body = document.getElementsByTagName('body')[0];
    }
    morphclass(body,'invisible','');
    return true;
  }
);
</script>


<template:serviceParameter name="areamap-frame-header-prebody" />

</head>



