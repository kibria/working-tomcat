<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>


<ul><html:messages id="err" property="failure">
  <li><font color="red"><bean:write name="err"/></font></li>
</html:messages></ul>

<ul><html:messages id="msg" property="success" message="true">
  <li><bean:write name="msg"/></li>
</html:messages></ul>


<html:form action="/publication/deploy">
<input type="hidden" name="submitButton" value=""/>
<table>
  <logic:iterate name="neo.phoenix.publication.PublicationSelectionForm" property="selectedItems" id="item" type="java.lang.String" length="1">
<% 
neo.xredsys.api.Publication p = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPublication(Integer.parseInt(item));
%>
    <tr><td>
    <html:checkbox property="<%= \"selected(\" + item + \")\" %>" />
    <% pageContext.setAttribute("p",p); %>
    <b><bean:write name="p" property="name" /></b>
    </td></tr>
<%
java.io.File pubroot = new java.io.File(p.getRoot());
java.io.File webXml  = new java.io.File(pubroot, "WEB-INF" + java.io.File.separator + "web.xml");

if (!webXml.exists()) {
  %>
  <tr>
    <td>Escenic does not recognise a local web-application that belongs to this publication.</td>
  </tr>
  <tr>
    <td><html:link page="/pages/publication/list.jsp">Cancel</html:link></td>
  </tr>
  <%
} else {
    %>
    <tr>
      <td colspan="4">Escenic recognises the web application in <tt><%=pubroot%></tt> to belong to this publication. The following files were found in the Escenic distribution (<tt><%=System.getProperty("templateRoot")%></tt>), that were either missing or different from the corresponding files in the publication.  Escenic recommends that these files be synchronized after a system upgrade.</td>
    </tr>
    <tr>
      <td>JAR files</td>
      <template:call file="uptodate.jsp">
        <template:parameter key="p" name="p" />
        <template:parameter key="filter" value=".jar" />
        <template:parameter key="source" value="WEB-INF/lib/" />
      </template:call>
    </tr>
    <tr>
      <td>TLD files</td>
      <template:call file="uptodate.jsp">
        <template:parameter key="p" name="p" />
        <template:parameter key="filter" value=".tld" />
        <template:parameter key="source" value="WEB-INF/" />
      </template:call>
    </tr>
    <tr>
      <td>DTD files</td>
      <template:call file="uptodate.jsp">
        <template:parameter key="p" name="p" />
        <template:parameter key="filter" value=".dtd" />
        <template:parameter key="source" value="WEB-INF/" />
      </template:call>
    </tr>
    <tr>
      <td colspan=4>
        Really update these files publication?
        <a href="javascript:document.forms[0].submitButton.value='delete'; document.forms[0].submit();">Confirm</a> |
        <html:link page="/pages/publication/list.jsp">Cancel</html:link>
      </td>
    </tr>
    <%
  
}
%>
    </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>
      </td>
    </tr>
  </logic:iterate>
</table>
</html:form>
<br>
<hr />
