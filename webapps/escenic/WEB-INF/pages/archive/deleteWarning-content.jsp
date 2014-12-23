<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<% String parentId = (String)request.getParameter("parentWorkItemId");
   Boolean used =  (Boolean)request.getAttribute("used");
   Boolean access = (Boolean)request.getAttribute("access");
   String sSearchResult = request.getParameter("searchResult");
   String clear = request.getParameter("clear");
   String commonParams = "searchResult="+sSearchResult+"&clear="+clear+"&parentWorkItemId="+parentId;
   String action = request.getParameter("deleteAction");
   String noneUrl = "/base/restoreWork.do?id=" + parentId;
   String unusedUrl = action+".do?deleteUsed=false&"+commonParams;
   String possibleUrl = action+".do?deletePossible=true&"+commonParams;

  String noAccess = String.valueOf(access.booleanValue());
  String isUsed = String.valueOf(used.booleanValue());
  request.setAttribute("noAccess",noAccess);
  request.setAttribute("isUsed",isUsed);
%>
<% if(noAccess.equals("true")) {%>
    Some of these objects cannot be deleted because of access restrictions.<br>
    <ul>
      <li><html:link page="<%= noneUrl %>">Delete none</html:link>
      <li><html:link page="<%= unusedUrl %>">Delete only unused objects</html:link>
      <li><html:link page="<%= possibleUrl %>">Delete as many objects as possible</html:link>
    </ul>
<%}else if("true".equals(isUsed)) {%>
      Some of the objects you are about to delete are used by articles.
      <ul>
        <li><html:link page="<%= noneUrl %>">Delete none</html:link>
        <li><html:link page="<%= unusedUrl %>">Delete only unused objects</html:link>
        <li><html:link page="<%= possibleUrl %>">Delete all objects</html:link>
      </ul>
<%}%>
<p><html:link page="<%= noneUrl %>">Cancel</html:link></p>

