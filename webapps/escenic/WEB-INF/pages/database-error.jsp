<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<html>
  <head>
    <title>A database error occured</title>
  </head>

  <body>
    <h1>A database error occured...</h1>

    <html:errors />
    <hr>
    <html:link page="/main-menu.do">Home</html:link>
  </body>
</html>
