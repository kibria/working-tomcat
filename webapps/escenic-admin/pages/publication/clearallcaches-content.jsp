<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>

<p>
  Clearing all caches will empty all caches on the local server, ensuring that all content
  will be reloaded from the database.  As such, the load on the database will increase while
  the caches are repopulated.
</p>
<p>
  By confirming to clear the caches, all Escenic caches will be emptied.  A process will
  not be spawned to repopulate the caches. As content is being served, the
  caches will gradually build up once again.
</p>

<p>Do you really want to clear all caches?</p>

<html:form action="/publication/clearallcaches">
<html:submit property="confirm" value="Confirm" />
<html:submit property="cancel" value="Cancel" />
</html:form>

<h2>Warning</h2>
<p>
  Performing a "clear all caches" will normally increase the load which is exherted on the database.
  It is suggested that this function not be performed at peak intervals.
<p>

<hr />
<div><font color="red"><html:errors property="failure" /></font></div>
<div><html:messages id="success" /></div>
