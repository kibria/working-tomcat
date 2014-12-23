<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
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
<%-- Commenting out the old style sheets.  Get a bare-bones CSS
  <link rel="stylesheet" href="<html:rewrite page="/css/menuStyle.css"/>" type="text/css">
--%>
  <link rel="SHORTCUT ICON" href="<html:rewrite page="/images/escenic-content-engine-fav.png"/>">
  <template:serviceParameter name="areamap-frame-header-head" />
<logic:present name="escenic-publication" scope="session">

  <% if (request.getSession().getAttribute("escenic-publication") != null) {
    request.setAttribute("publication", request.getSession().getAttribute("escenic-publication"));
  %>
  <% } %>

</logic:present>

<script language="JavaScript1.2" type="text/javascript">
  /* Pop up the forward. */
  var currentpopup = null;
  function popupcallback() {
    alert("default pop-up callback -- no handler for the pop-up was installed.");
  }

  function popup(forward,callback) {
    if (forward && forward != 'null') {
      var name = forward.replace(/[^a-zA-Z0-9]/g,"_");
      var uri = forward.substring(1);
      if (getWorkItemName) {
        var delim = '?';
        if (uri.indexOf('?') != -1) delim = '&';
        uri = uri + delim + 'parentWorkItemName=' + getWorkItemName();
      }
      currentpopup = window.open('<html:rewrite page="/"/>' + uri, name, 'toolbar=no,statusbar=no,scrollbars=yes,resizable=yes,location=no,width=650,height=500');
      if (currentpopup.focus) {
        currentpopup.focus();
      }
      if (callback) {
        popupcallback = callback;
      }
    }
  }

</script>
<script language="JavaScript1.2" type="text/javascript"><!--
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

  function globalSearch(searchWord) {
    alert("Global search has not been implemented yet.  I'm not sure what to do if you click Go. What do you think?  Tell me about it; mogsie@escenic.com");
   /*
    if (document.forms[0]) {
      document.forms[0].globalSearchWord.value=searchWord;
      document.forms[0].submitButton.value='action:/base/globalSearch.do';
      document.forms[0].submit();
    } else {
      alert('unable to search for "' + searchWord + '"!');
    }*/
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
        
  var enterHooks = new Array();
  function registerEnterHook(fn) {
    enterHooks[enterHooks.length]=fn;
  }
        
  function handleKey(e){
    var code;
    if (!e) var e = window.event;
    code = e.keyCode;
    if(code==0){
      code = e.which;
    }
    if(code==13){
      if(document.forms[0]["enterAction"]&&document.forms[0]["enterAction"].value!=""){
        submitForm(document.forms[0]["enterAction"].value);
      }else if(enterHooks.length>0){
        for (var i = 0; i < enterHooks.length; i++) {
          var fn = enterHooks[i];
          fn();
        }
      }
    }      
   }
  //checks if the form has a duplicate relation of some type. Parameters are:
  //relationType: type of relation, for instance topic
  //objectType: the type of object to be added
  //objectId: the id of the object to be added
  //numberOfRelations: the highest key stored. This is calculated by using relations(relationType).getNextKey()
  function hasDuplicateRelation(relationType,objectType,objectId,numberOfRelations){
    for(var k=0;k<numberOfRelations;k++){
      var index = ''+k;
      for(j=index.length;j<4;j++){
        index = "0"+index;
      }
      idField = getFieldElement("relations("+relationType+").item("+index+").id");
      typeField = getFieldElement("relations("+relationType+").item("+index+").type");
      if(idField){
        tmpId = idField.value;
        tmpType = typeField.value;
        if(tmpId==objectId&&tmpType==objectType){//already added
          return true;
        }
      }
    }
    return false;
  }

  function getFieldElement(field){
    for (var i=0; i < document.forms[0].elements.length; i++) {
      if (document.forms[0].elements[i].name == field){
        return document.forms[0].elements[i];
      }
    }
    return "";
  }
        
   document.onkeypress = handleKey;
  // -->
</script>

<script language="JavaScript1.2" type="text/javascript" src='<html:rewrite page="/script/roundedbox.js"/>'></script>
<script language="JavaScript1.2" type="text/javascript" src='<html:rewrite page="/script/menu.js"/>'></script>
<script type="text/javascript" src='<html:rewrite page="/script/minmax.js"/>'></script>


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



