<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<% 
  request.setAttribute("publishers", neo.xredsys.content.PublicationManager.getPublicationManager().getPublishers());
%>

<html:form action="/publication/delete">
<input type="hidden" name="submitButton" value=""/>
<table>
  <logic:iterate name="neo.phoenix.publication.PublicationSelectionForm" property="selectedItems" id="item" type="java.lang.String">
    <tr><td>
    <html:checkbox property="<%= \"selected(\" + item + \")\" %>" />
    <% neo.xredsys.api.Publication p = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPublication(Integer.parseInt(item)); %>
    <% pageContext.setAttribute("p",p); %>
    <b><bean:write name="p" property="name" /></b>
    </td><td>
      root=<%=p.getRoot() %>
      url=<%=p.getUrl() %>
    </td>
    </tr>
  </logic:iterate>
</table>

Really delete these publications?
<table><tr><td><a styleClass="global-button" href="javascript:document.forms[0].submitButton.value='delete'; document.forms[0].submit();">Confirm</a></td>
<td><html:link styleClass="global-button" page="/pages/publication/list.jsp">Cancel</html:link></td></tr></table>
</html:form>

<h2>Warning</h2>
<ul>
  <li>All articles owned by the publications will be deleted</li>
  <li>All images uploaded to the publications will be deleted</li>
  <li>All media uploaded to the publications will be deleted</li>
  <li>All links in the publications will be deleted</li>
  <li>All sections in the publications will be deleted</li>
  <li>All publication resources in the publications will be deleted</li>
</ul>
<h3>Note</h3>
<ul>
  <li>
    No files will be removed from the application server. The web application must be removed from Assembly Tool's list
    of publications and a new EAR should be deployed to the server.
   </li>
</ul>
<hr />
<div><font color="red"><html:errors property="failure" /></font></div>
<div><html:messages id="success" /></div>
