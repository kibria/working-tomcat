<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<table border="0">
<tr>
  <th class="edit-propertyname" width="30%" align="left">Property</th><th class="edit-propertyvalue" align="left">Value</th>
</tr>
<tr>
  <td class="edit-propertyname"><bean:message key="t.Name"/></td>
  <td class="edit-propertyvalue"><bean:write name="escenic-publication" property="name" /></td>
</tr>
<tr>
  <td class="edit-propertyname">Root</td>
  <td class="edit-propertyvalue"><bean:write name="escenic-publication" property="root"/></td>
</tr>
<tr>
  <td class="edit-propertyname">URL</td>
  <td class="edit-propertyvalue"><bean:write name="escenic-publication" property="url" /></td>
</tr>
<tr>
  <td class="edit-propertyname">Id</td>
  <td class="edit-propertyvalue"><bean:write name="escenic-publication" property="id"/></td>
</tr>
</table>

<p>The publication's vital attributes, such as "URL" and "Root" are calculated on the
	
basis of the "<code>/ServerConfig</code>" component's <code>webPublicationRoot</code>
property and <code>filePublicationRoot</code> property.  To change these values, you
need to configure this in your local configuration layer (typically
"<code><em>$escenic.root</em>/localconfig/</code>") and restart the system.  Here is an example
of such a component, given a publication name of "xyzzy" where we will set the url to <code>www.xyzzy.com</code> and set the publication root to <code>/var/webapps/xyzzy/</code></p>

<ul>
<li>Create a file in your local configuration layer, called "/neo/publications/Pub-xyzzy.properties"</li>
<li>Insert the following line into the file
  <pre>$class=neo.xredsys.config.SimplePublicationSupport</pre>
</li>

<li>The most common reason for doing this is to set a new publication URL.  Specify this URL by insert the following line into the file:
<pre>url=http://www.xyzzy.com/</pre>
where <code>xyzzy.com</code>  is the domain name you want the publication to expose itself as.
</li>

<li>It is also possible to relocate the multimedia directory.  For example,
to physically place the multimedia directory on a shared directory /nfs/somewhere/,
simply add the following line:
<pre>mediaDirectory=/nfs/shared/multimedia/xyzzy/</pre>
If you do this,88 you are responsible for actually moving the multimedia
archive from the old location to the new location.
</li>

<li>You might also want to host the multimedia files using a different URL,
so that the images are served off-site or using a different host name: 
<pre>mediaUrl=http://multimedia.xyzzy.com/</pre>
Again, it is your responsibility to ensure that you have proper handling in
your HTTP server so that requests within the mediaUrl are forwarded to the
mediaDirectory.
</li>

</ul>

<p>Note that simply setting the URL in this way is not enough for a
publication to actually work with this URL.  Setting the URL will only
affect the URLs that Escenic generates in its JSP templates and tags.
You need to tell the application server and/or web server that calls
to the URL should be forwarded to the correct web-app.  This is often
referred to as virtual hosts.  You also need to add DNS records for
the domain name, so that they reference the correct IP address..</p>

<p>If you have many different web applications, it is possible to
change change Escenic's default behaviour of appending the publication
name to <code>filePublicationRoot</code> or
<code>webPublicationRoot</code>.  This is expressed in the
<code>/neo/publications/GenericPublication</code> component in your local configuration layer.</p>