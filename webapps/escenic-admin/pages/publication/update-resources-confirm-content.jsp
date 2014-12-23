<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="neo.util.StringUtil" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%
  List resources = new java.util.ArrayList();
  for (java.util.Enumeration e = request.getSession().getAttributeNames(); e.hasMoreElements();) {
    String name = (String) e.nextElement();
    if (name.startsWith("uploaded-publication-resource:")) {
      Map stuff = (Map)request.getSession().getAttribute(name);
      if (((Boolean) stuff.get("valid")).booleanValue()) {
        resources.add(stuff.get("type"));
      } else {
        // non-validating resources not stored
        request.setAttribute("unsupported-resources","true");        
      }
    } else if (name.startsWith("uploaded-resource:")) {
      // Only publication resources are currently supported by update publication
     request.setAttribute("unsupported-resources","true");
    }
  }
  request.setAttribute("resources",resources);
%>


<ul><html:messages id="err" property="failure">
  <li><font color="red"><bean:write name="err"/></font></li>
</html:messages></ul>

<ul><html:messages id="msg" property="success" message="true">
  <li><bean:write name="msg"/></li>
</html:messages></ul>

<% if(resources.size()>0){%>
  <html:form action="/publication/updateResources">
    <input type="hidden" name="submitButton" value=""/>
    <table>
      <tr>
        <th colspan="2">
          Uploaded resources
        </th>
        <logic:iterate name="resources" id="resource">
          <tr><td><bean:write name="resource"/></td></tr>
        </logic:iterate>
      </tr>
      <logic:present name="unsupported-resources">
        <tr>
          <td colspan="4">
            <p>
              Note that some resources may not be applied by this update.
              <i>Content</i> and <i>section parameters</i> should be imported using the appropriate interfaces of Escenic Web Studio.
              Such resources will only be applied when creating a new publication.
            </p>
          </td>
        </tr>
      </logic:present>
      <tr><th>Resources will be updated in the selected publications</th></tr>
      <logic:iterate name="neo.phoenix.publication.PublicationSelectionForm" property="selectedItems" id="item" type="java.lang.String">
    <% 
    neo.xredsys.api.Publication p = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPublication(Integer.parseInt(item));
    %>
        <tr><td>
        <html:checkbox property="<%= \"selected(\" + item + \")\" %>" />
        <% pageContext.setAttribute("p",p); %>
        <b><bean:write name="p" property="name" /></b>
        </td></tr>
      </logic:iterate>
    
      <tr>
        <td colspan=4>
          Really update resources in these publications?
          <a href="javascript:document.forms[0].submitButton.value='resources'; document.forms[0].submit();">Confirm</a> |
          <html:link page="/pages/publication/list.jsp">Cancel</html:link>
          <br/>
        </td>
      </tr>
    </table>
  </html:form>
  <br/>
  <div class="warning"><html:link page="/pages/publication/upload-resources.jsp">Upload</html:link> more resources</div>
<%}else{%>
 <div class="warning">You have to <html:link page="/pages/publication/upload-resources.jsp">upload</html:link> a resources first!</div>
<%}%>
<hr />
