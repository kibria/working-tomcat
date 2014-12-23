<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page import="neo.xredsys.api.profile.Profile,
                 neo.xredsys.api.IOAPI,
                 java.util.List,
                 neo.xredsys.content.type.ArticleType,
                 neo.xredsys.api.Article,
                 neo.xredsys.api.Person"%><!-- search.jsp -->
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-view" prefix="view" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>

<input type="hidden" name="validateButton" value="edit"/>
<input type="hidden" name="validateButton" value="editRoles"/>
<input type="hidden" name="validateButton" value="save"/>
<input type="hidden" name="validateInput"  value="editProfiles"/>
<input type="hidden" name="validateField" value="none" />
<input type="hidden" name="submitButton" value="">
<html:hidden property="parentWorkItemId" />
<html:hidden property="isGuestUser"/>

<bean:define name="neo.phoenix.person.PersonForm" id="form" scope="request" type="neo.phoenix.person.PersonForm"/>
<bean:define id="publication" name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<%@include file="../base/relatedObjects.jspf" %>
<%@include file="hiddenGroups.jspf" %>
<%@include file="hiddenGlobalRoles.jspf" %>
<%@include file="hiddenRelations.jspf" %>
<%@include file="hiddenProperties.jspf" %>
<%
  Person person = IOAPI.getAPI().getObjectLoader().getPerson(form.getIdInt(),form.getPubIdInt(-1));
  java.util.Collection profiles = new java.util.ArrayList();
  Article[] articles = person.getArticles();
    for (int i = 0; i < articles.length; i++) {
      Article art = articles[i];
      profiles.add(art);
    }
  request.setAttribute("profiles",profiles);
    
  neo.xredsys.content.type.ArticleType[] types = neo.xredsys.content.type.TypeManager.getInstance().getArticleTypes(publication.getId());
  java.util.Collection profTypes = new java.util.ArrayList();
  for (int i = 0; i < types.length; i++) {
    String prof =types[i].getParameter("com.escenic.articleType"); 
    if (prof != null && prof.equalsIgnoreCase("profile")){
      profTypes.add(types[i]);      
    }
  }
  java.util.Iterator it =profiles.iterator();
  while (it.hasNext()){
    neo.xredsys.api.Article art = (neo.xredsys.api.Article)it.next();
    if (profTypes.contains(art.getArticleType())){
      profTypes.remove(art.getArticleType());
    }
  }
  request.setAttribute("profTypes",profTypes);
  String articleAttr = "stateImage,typeImage,id,title,lastModified,homeSection,articleType,publication,delete";
%>
<table>
  <tr>
    <template:call file="../base/presentArticleHeader.jsp">
      <template:parameter key="displayedAttributes" value="<%=articleAttr%>"></template:parameter>
    </template:call>
  </tr>
  <logic:iterate id="current" name="profiles" type="neo.xredsys.api.Article">
    <tr>
      <template:call file="../base/presentArticle.jsp">
        <template:parameter key="articleId" value="<%=String.valueOf(current.getId())%>" />
        <template:parameter key="isSubmittingForm" value="true"></template:parameter>
        <template:parameter key="displayedAttributes" value="<%=articleAttr%>"></template:parameter>
      </template:call>
    </tr>
  </logic:iterate> 
</table>
<table>
  <logic:iterate id="curType" name="profTypes" type="neo.xredsys.content.type.ArticleType">
    <tr>
      <td>
        <table><tr>
          <%
            StringBuffer buffer = new StringBuffer();
            buffer.append("javascript:submitForm(\'external:/article/new.do?articleType=");
            buffer.append(curType.getName());
            buffer.append("&personId=");
            buffer.append(form.getIdInt());
            buffer.append("&pubId=");
            buffer.append(form.getPubIdInt(-1));
            buffer.append("')");
            String newProfileLink = buffer.toString(); 
          %>
          <td><a class="global-button" href="<%=newProfileLink%>"><bean:message key="m.CreateNew"/> <%=curType.getLabel()%></a></td>
        </tr></table>
      </td>
    </tr>
  </logic:iterate>
</table>