<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<bean:define name="neo.phoenix.base.DeleteObjectsForm" id="form" type="neo.phoenix.base.DeleteObjectsForm" />
<input type="hidden" name="validateButton" value="warning">
<input type="hidden" name="validateInput"  value="warning">
<input type="hidden" name="validateField"  value="none">
<input type="hidden" name="submitButton" value="">
<%
   String parentId = (String)request.getParameter("parentWorkItemId");
   Boolean used =  (Boolean)request.getAttribute("used");
   Boolean access = (Boolean)request.getAttribute("access");
   String sSearchResult = request.getParameter("searchResult");
   String clear = request.getParameter("clear");
   String action = request.getParameter("deleteAction");

   if(used==null){
     used = new Boolean(form.getUsed());
     access = new Boolean(form.getAccess());
     sSearchResult = form.getSearchResult();
     clear = form.getClear();
     parentId = form.getParentWorkItemId();
     action = form.getAction();
   }
  action="/person/search/deletePersons";
  form.setUsed(String.valueOf(used));
  form.setAccess(String.valueOf(access));
  form.setAction(action);
  form.setClear(clear);
  form.setParentWorkItemId(parentId);
  form.setSearchResult(sSearchResult);
  String commonParams = "searchResult="+sSearchResult+"&clear="+clear+"&parentWorkItemId="+parentId;
  String noneUrl = "/base/restoreWork.do?id=" + parentId;
  String unusedUrl = action+".do?deleteUsed=false&"+commonParams;
  String possibleUrl = action+".do?deletePossible=true&"+commonParams;
  String replaceUrl = "javascript:submitForm('action:/person/search/deletePersons/replace.do')";

  String noAccess = String.valueOf(access.booleanValue());
  String isUsed = String.valueOf(used.booleanValue());
  request.setAttribute("noAccess",noAccess);
  request.setAttribute("isUsed",isUsed);
  String showAuthors = String.valueOf((used.booleanValue()||access.booleanValue())&& form.getRelations("author").size()>0);
  String showFindAuthors = String.valueOf((used.booleanValue()||access.booleanValue()));
%>
<% if("true".equals(noAccess)) {%>
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
<%} else { %>
        All references removed.
        <html:link page="<%= possibleUrl %>">Delete Person</html:link>
<%}%>

<%if("true".equals(showAuthors)) { %>
    <table>
      <tr>
        <td colspan="10">
          You have selected to replace authors with these:
        </td>
      </tr>
      <logic:iterate name="form" property="relations(author).keys" id="_img" type="java.lang.String">
        <% String p1 = "relations(author).item(" + _img + ").id";
          String p2 = "relations(author).item(" + _img + ").type";
          String p3 = "relations(author).item(" + _img + ").publicationId";
        %>
        <html:hidden property="<%=p1%>"/>
        <html:hidden property="<%=p2%>"/>
        <html:hidden property="<%=p3%>"/>
        <% neo.phoenix.base.RelatedObject relObj = form.getRelations("author").getItem(_img);%>
        <tr>
          <template:call file="../base/presentPerson.jsp">
            <% String perId = relObj.getId() + ""; %>
            <% String pubId = relObj.getPublicationId() + ""; %>
            <template:parameter key="personId" value="<%=perId%>" />
            <template:parameter key="pubId" value="<%=pubId%>" />
            <template:parameter key="hideEditLink" value="true" />
            <template:parameter key="showAttributes" value="true" />
            <template:parameter key="displayedAttributes" value="id,name,publication" />
           </template:call>
          </tr>
        </logic:iterate>
    </table>
    <table><tr><td>
    <a href="<%=replaceUrl%>" class="global-button">Replace authors</a>
    </td></tr></table>
<%}else if("true".equals(showFindAuthors)) {%>
      <table><tr><td>
      <a href="javascript:submitForm('person-archive')" class="global-button">Find replacement author</a>
      </td></tr></table>
<%}%>
<logic:present name="articlesWithErrors">
  Failed updating these articles: <%=request.getAttribute("articlesWithErrors")%>
</logic:present>
<p><html:link page="<%= noneUrl %>">Cancel</html:link></p>

<html:hidden property="parentWorkItemId"/>
<html:hidden property="searchResult"/>
<html:hidden property="clear"/>
<html:hidden property="used"/>
<html:hidden property="access"/>

