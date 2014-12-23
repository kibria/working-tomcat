<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<% 
String parentId = (String)request.getParameter("parentWorkItemId"); 
   String commonParams = "&parentWorkItemId="+parentId+"&isConfirmed=true";
   Boolean used =  (Boolean)request.getAttribute("used");
   Boolean access = (Boolean)request.getAttribute("access");
   String action = "/userGroup/search/deleteUserGroups";       
   String noneUrl = "/userGroup/search.do";
   String unusedUrl = action+".do?deleteUsed=false"+commonParams;
   String possibleUrl = action+".do?deletePossible=true"+commonParams ;
   if(access!=null&&access.booleanValue()){%>
    One or more groups cannot be deleted because of access restrictions.<br>
    <ul>
      <li><html:link page="<%= noneUrl %>">Delete none</html:link>
      <li><html:link page="<%= unusedUrl %>">Delete empty groups only</html:link>
      <li><html:link page="<%= possibleUrl %>">Delete as many groups as possible</html:link>
    </ul>
   <%}else if(used.booleanValue()){%>
    One or more groups contains members or groups.   
    <ul>
      <li><html:link page="<%= noneUrl %>">Delete none</html:link>
      <li><html:link page="<%= unusedUrl %>">Delete empty groups only</html:link>
      <li><html:link page="<%= possibleUrl %>">Delete all groups</html:link>
    </ul>
   <%}%>
   <p><html:link page="<%= noneUrl %>">Cancel</html:link></p> 