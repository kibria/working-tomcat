<%@ page language="java"  import="neo.util.StringUtil, java.util.Map, org.apache.commons.lang.StringEscapeUtils"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>

<div class="error"><html:errors property="global" /></div>

<div class="info"><h2>Uploading resources</h2>
  This page allows you to upload resources to the server.  Once you have
  uploaded the required resources, you will be able to create publications.
</div>

<%
  Map resources = new java.util.TreeMap();
  for (java.util.Enumeration e = request.getSession().getAttributeNames(); e.hasMoreElements();) { String name = (String)e.nextElement();
    if (name.startsWith("uploaded-publication-resource:") || name.startsWith("uploaded-resource:")) {
      resources.put(name, request.getSession().getAttribute(name));
    }
  }
  java.util.List reasons = new java.util.ArrayList();
  java.util.Map contenttypes = (java.util.Map) request.getSession().getAttribute("uploaded-publication-resource:/escenic/content-type");
  java.util.Map layouts = (java.util.Map) request.getSession().getAttribute("uploaded-publication-resource:/escenic/layout");

  if (contenttypes == null || ! Boolean.TRUE.equals(contenttypes.get("valid")) ) {
    reasons.add("Content Type Definition");
  }
  if (layouts == null || ! Boolean.TRUE.equals(layouts.get("valid"))){
    reasons.add("Layout Definition");
  }
  if (reasons.size() == 0) {
    %>
    <h2>Create Publication</h2>
    You now have enough resources to <html:link page="/pages/publication/new.jsp">create a publication</html:link>
    <%
  }
%>

<% if (resources.size() > 0) { %>
<h2>Available resources</h2>
You have now uploaded the following resources.  Once you have uploaded enough valid resources, you can create your publication.
<table>
 <tr>
 <th>Type</th>
 <th>Age</th>
 <th>Uploaded Content Type</th>
 <th>File name</th>
 <th>Size (bytes)</th>
 <th>Valid</th>
 <th>&nbsp;</th>
 </tr>
<% for (java.util.Iterator i = resources.keySet().iterator(); i.hasNext();) { String name = (String)i.next(); %>
 <tr>

   <% Map stuff = (Map) resources.get(name); %>
   <td><%=stuff.get("type")%></td>
   <td><%=StringUtil.formatDuration(System.currentTimeMillis() - ((Long)stuff.get("date")).longValue()) %></td>
   <td><%=stuff.get("content-type")%></td>
   <td><%=stuff.get("file-name")%></td>
   <td><%=stuff.get("file-size")%></td>
   <td><%=((Boolean)stuff.get("valid")).booleanValue() ? "Validated" : "Not valid"%></td>
   <td><html:link page='<%="/do/publication/deleteResource?resource=" + stuff.get("type")%>'>Remove uploaded resource</html:link> </td>
 </tr>
  <% if (stuff.get("exception") != null) { %>
   <tr>
     <td colspan="6" class="error"><%=StringEscapeUtils.escapeHtml(((Exception) stuff.get("exception")).getMessage())%></td>
   </tr>
  <% } %>
<% } %>
</table>
<% } %>

<h2>Upload or overwrite a resource</h2>
<html:form action="/publication/resource"
           method="post"
           enctype="multipart/form-data"
           onsubmit="if (document.getElementById('otherradio').checked) document.getElementById('type').value = document.getElementById('other').value; ">
 <table><tr><td valign="top">
  Type of resource:
 </td>
 <td>

   <input checked="checked" type="radio" name="typetmp" value="webapp" id="webapp"
          onClick="document.getElementById('type').value='webapp'"/>
   <label for="webapp">Publication Definition
     <% if (! resources.isEmpty()) { %>
       (will replace any current definitions)
     <% } %>
   </label><br>

   <input type="radio" name="typetmp" value="/escenic/content-type" id="content-type"
          onClick="document.getElementById('type').value='/escenic/content-type'"/>
   <label for="content-type">Content Type definitions
     <% if (resources.containsKey("/escenic/content-type")) { %>
       (will replace the current content type definition)
     <% } %>
   </label><br>

   <input type="radio" name="typetmp" value="/escenic/feature" id="feature"
          onClick="document.getElementById('type').value='/escenic/feature'"/>
   <label for="feature">Feature definitions (optional)
       <% if (resources.containsKey("/escenic/feature")) { %>
       (will replace the current feature definition)
       <% } %>
   </label><br>

  <input type="radio" name="typetmp" value="/escenic/image-version"
         id="image-version"
         onClick="document.getElementById('type').value='/escenic/image-version'"/>
  <label for="image-version">Image Version definitions (optional)
    <% if (resources.containsKey("/escenic/image-version")) { %>
      (will replace the current image version definition)
    <% } %>
  </label><br>

   <input type="radio" name="typetmp" value="/escenic/layout" id="layout"
          onClick="document.getElementById('type').value='/escenic/layout'"/>
   <label for="layout">Layout definitions
     <% if (resources.containsKey("/escenic/layout")) { %>
       (will replace the current layout definition)
     <% } %>
   </label><br>
   <input type="radio" name="typetmp" value="/escenic/layout-group" id="layout-group"
          onClick="document.getElementById('type').value='/escenic/layout-group'"/>
   <label for="layout-group">Layout-group definitions
     <% if (resources.containsKey("/escenic/layout-group")) { %>
       (will replace the current layout-group definition)
     <% } %>
   </label><br>

   <input type="radio" name="typetmp" value="/escenic/content" id="content"
          onClick="document.getElementById('type').value='/escenic/content'"/>
   <label for="content">Content definitions (optional)
       <% if (resources.containsKey("/escenic/content")) { %>
       (will replace the current content definition)
       <% } %>
   </label><br>

   <%--<input type="radio" name="typetmp" value="/escenic/teaser-type" id=teaser-type
          onClick="document.getElementById('type').value='/escenic/teaser-type'"/>
   <label for="teaser-type">Teaser Type definitions
     <% if (resources.containsKey("/escenic/teaser-type")) { %>
       (will replace the current teaser type definition)
     <% } %>
   </label><br>
  --%>
  <input type="radio" name="typetmp" value="other" id="otherradio"/>
  <label for="otherradio">Other type of resource</label><br>
  Please specify: <input type="text" id="other"
    onfocus="document.getElementById('otherradio').click(); return true;">
  <html:hidden property="type" styleId="type" value="webapp"/>
 </td>
</tr>
<tr>
 <td valign="top">
  File to upload
 </td>
 <td>
  <html:file property="resourceFile"/>
  <html:submit value="Upload"/>
 </td>
</tr>
</table>
</html:form>
