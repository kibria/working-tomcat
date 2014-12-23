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
<html>
  <template:serviceParameter name="areamap-frame-popup-header"/>
  <bean:define id="bodyclass" name="bodyclass" type="java.lang.String" />
  <body onload="callHooks('onLoad'); callHooks('afterLoad');" class='frame-popup <%=bodyclass%> invisible'>
  <div id="body-container">
    <bean:define id="form" name="textmap-form" type="java.lang.String" />
    <bean:define id="enctype" name="enctype" type="java.lang.String" />
    <html:form action="<%=form%>" enctype="<%=enctype%>" onsubmit="callHooks('onSubmit');">
<div id="area-frame-top"><template:serviceParameter name="areamap-frame-top" /></div>
<div id="area-frame-left"><template:serviceParameter name="areamap-frame-left" /></div>
<div id="area-frame-main"><template:serviceParameter name="areamap-frame-main" /></div>
<div id="area-frame-right"><template:serviceParameter name="areamap-frame-right" /></div>
    </html:form>
  </div>
  </body>
</html>
