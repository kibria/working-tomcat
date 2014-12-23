<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!-- Frame begins -->
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>

<html:html lang=""><%-- What on earth to put the 'lang' tag to???--%>
<template:serviceParameter name="areamap-frame-header"/>
<bean:define id="bodyclass" name="bodyclass" type="java.lang.String" />
<body id="body" onload="callHooks('onLoad'); callHooks('afterLoad');" class='frame-basketcolumn <%=bodyclass%> invisible'>
<script type="text/javascript">
  window.name="escenicMain";
</script>
<div id="body-container">
<bean:define id="form" name="textmap-form" type="java.lang.String" />
<bean:define id="enctype" name="enctype" type="java.lang.String" />
<html:form action="<%=form%>" enctype="<%=enctype%>" onsubmit="callHooks('onSubmit');">



<div id="area-frame-top-bordermargin">
  <div id="area-frame-top"  class="roundedtop">
    <template:serviceParameter name="areamap-frame-top" />
  </div>
</div>
<div id="area-frame-left-bordermargin">
  <div id="area-frame-left">
  <template:serviceParameter name="areamap-frame-left" />
  </div>
</div>
<div id="area-frame-main-bordermargin-bg" >
<div id="area-frame-main-bordermargin-tl" >
<div id="area-frame-main-bordermargin-tr" >
<div id="area-frame-main-bordermargin-bl" >
<div id="area-frame-main-bordermargin-br" >
  <div id="area-frame-main">
    <template:call file="frame/menu.jsp"/>
    <template:serviceParameter name="areamap-frame-main" />
    <div id="footer"><html:img page="/images/default/bottomLogo.gif"/></div>
  </div>
</div>
</div>
</div>
</div>
</div>
<div id="area-frame-right-bordermargin">
  <div id="area-frame-right">
    <template:serviceParameter name="areamap-frame-right" />
  </div>
</div>



</html:form>
</div>
</body>
</html:html>
