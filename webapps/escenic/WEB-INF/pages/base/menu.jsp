<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<bean:define id="checker" 
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<%-- Menu.jsp --%>
<!-- Menu.jsp begin -->
<% if ("true".equals(request.getAttribute("includeMenu"))) { %>
<table class="menu">

<!-- When simply viewing a page with lots of A href links:
     the following items are available in the menu -->
<% if (! "true".equals(request.getAttribute("isSubmittingForm"))) { %>
<%--logic:notEqual name="isSubmittingForm" value="true" scope="request"--%>
<tr><td><html:link page="/main-menu.do"><bean:message bundle="org.apache.struts.action.MESSAGE" key="t.Main_page"/></html:link></td></tr>
<tr><td><h3><bean:message bundle="org.apache.struts.action.MESSAGE" key="t.Archives"/></h3></td></tr>
<tr><td><html:link page="/article/search.do"><bean:message bundle="org.apache.struts.action.MESSAGE" key="l.Article_archive"/></html:link></td></tr>
<tr><td><html:link page="/image/search.do">Image archive</html:link></td></tr>
<tr><td><html:link page="/media/search.do">Media archive</html:link></td></tr>
<tr><td><html:link page="/link/search.do">Link archive</html:link></td></tr>
<tr><td><html:link page="/person/search.do">Person archive</html:link></td></tr>
<tr><td><html:link page="/userGroup/search.do">Usergroup archive</html:link></td></tr>
<tr><td><h3>Objects</h3></td></tr>
<bean:define name="escenic-publication" id="publication" scope="session" type="neo.xredsys.api.Publication" />
<% neo.xredsys.content.type.ArticleType[] types =  neo.xredsys.content.type.TypeManager.getInstance().getArticleTypes(publication.getId()); 
   for (int i = 0; i < types.length; i++) { %>
<tr><td><html:link page="<%=\"/article/new.do?type=\" + types[i].getName() %>">Create <%=types[i].getName()%></html:link></td></tr>
<% } %>
<tr><td><html:link page="/image/new.do">Create image</html:link></td></tr>
<tr><td><html:link page="/media/new.do">Create media</html:link></td></tr>
<tr><td><html:link page="/link/new.do">Create link</html:link></td></tr>
<tr><td><html:link page="/person/new.do">Create person</html:link></td></tr>
<% if(checker.isPublicationAdmin()){ %>
  <tr><td><html:link page="/userGroup/new.do">Create usergroup</html:link></td></tr>
<% } %>
<tr><td><h3>Basket</h3></td></tr>
<tr><td><html:link page="/basket/edit.do">Edit basket</html:link></td></tr>
<tr><td><h3><bean:message bundle="org.apache.struts.action.MESSAGE" key="t.Administration"/></h3></td></tr>
<tr><td><html:link page="/publication/view.do"><bean:message bundle="org.apache.struts.action.MESSAGE" key="h.Administer_Publication"/></html:link></td></tr>
<tr><td><html:link page="/section/search.do"><bean:message bundle="org.apache.struts.action.MESSAGE" key="h.Administer_Section"/></html:link></td></tr>
<%--/logic:notEqual--%>
<%  }  %>


<!-- When submitting a form [typically when editing an item], 
     the following items are available in the menu -->
<% if ( "true".equals(request.getAttribute("isSubmittingForm"))) { %>
<%--logic:equal name="isSubmittingForm" value="true" --%>
<tr><td><a href="javascript:submitForm('main-menu')"><bean:message bundle="org.apache.struts.action.MESSAGE" key="t.Main_page"/></a></tr></td>
<tr><td><a href="javascript:submitForm('article-archive')"><bean:message bundle="org.apache.struts.action.MESSAGE" key="l.Article_archive"/></a></tr></td>
<%--/logic:equal--%>
<%  }  %>





<%-- <tr><td><html:link page="/test/TestAction.do">Test</html:link></td></tr>--%>
<tr><td><html:link page="/logoff.do">Log off...</html:link></td></tr>
    <logic:present name="WorkItemManager" scope="session">
      <logic:iterate name="WorkItemManager" scope="session" property="workItems" id="workItem" type="neo.phoenix.base.WorkItem">
        <% String url = "/base/restoreWork.do?id=" + workItem.getId(); %>
<tr><td>Working on <html:link page="<%= url %>"><bean:write name="workItem" property="name"/></html:link></td></tr>
      </logic:iterate>
    </logic:present>
</table>
<%  }  %>
<!-- Menu.jsp end -->
