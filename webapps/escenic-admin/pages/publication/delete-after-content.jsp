<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<% 
  request.setAttribute("publishers", neo.xredsys.content.PublicationManager.getPublicationManager().getPublishers());
%>


<h2>Publication deleted</h2>
<ul>
  <p>All content was successfully deleted from the publication, and the publication no longer exists in the Escenic Content Engine database.</p>
</ul>
<h3>Action required</h3>
<p>All caches should be cleared. Although the publication has been deleted from the database, some objects may still remain in the cache. Please proceed to <a href="clearallcaches">clear all caches</a> on server side.</p>
<p>Note that client side caches must also be cleared</p>
<p>Although the publication was deleted, the actual web application associated with it has not been deleted.
The web application, although still present in the file system, will not work, because it references 
internal Escenic objects that no longer exist.  The web application should be
<ul>
<li>Undeployed from the application server(s) where it is deployed.  Since there is no way to (automatically) undeploy a web application in the application server this must be done manually.</li>
<li>Removed from the file system.  The reason why the application is not removed from the file system is that the template files (and other customizations done on the file system) could represent many man-hours of work.  The decision to actually remove the template files, and so on, is left to the system administrator.</li>
</ul>
<hr />
<div><font color="red"><html:errors property="failure" /></font></div>
<div><html:messages id="success" /></div>
