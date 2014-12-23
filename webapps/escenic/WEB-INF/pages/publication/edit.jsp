<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%-- The form... --%>
<bean:define  id="pub"
              toScope="page"
              name="neo.phoenix.publication.PublicationForm"
              type="neo.phoenix.publication.PublicationForm" />

<html:html locale="true">
  <head>
    <title>Edit <bean:write name="pub" property="name"/></title>
    <html:base/>
  </head>

  <body  bgcolor="white">
    <h1>Editing the <bean:write name="pub" property="name"/> publication</h1>
    <html:form action="/publication/save" >
      Publication ID = "<bean:write name="pub" property="id"/>"
      Root = "<bean:write name="pub" property="root"/>"
      <html:text property="root" />
      <br/>
      <html:submit />
    </html:form>
    <hr />
    <html:errors />
  </body>
</html:html>
