<%@ page import="java.util.Map" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>

<h3>Delete tag structure - Are you SURE?</h3>
<html:errors name="org.apache.struts.action.GLOBAL_MESSAGE" />

<p>
  You are about to delete the <em>${name}</em> tag structure and all of its <strong>${count}</strong> tags. Are you sure you will do that?
</p>

<html:form action="/classification/delete" method="post">
  <html:hidden property="identifier" />
  <html:hidden property="confirmed" value="true" />
  <html:submit value="Yes" /><html:cancel value="No"/>
</html:form>
