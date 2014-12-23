<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page import="org.apache.struts.action.Action,
                 java.util.Locale,
                 java.util.Arrays"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.HashSet"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>

<input type="hidden" name="validateInput" value="input">
<input type="hidden" name="validateField" value="value">
<input type="hidden" name="validateField" value="key">
<input type="hidden" name="validateButton" value="change">
<input type="hidden" name="submitButton" value="change">
<bean:define name="neo.phoenix.base.SettingsForm" type="neo.phoenix.base.SettingsForm" id="form" />

<bean:define id="publication" name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
  <%
   String lang = neo.phoenix.base.Constants.LOCALE_KEY;
   String countryString= ((Locale)session.getAttribute(lang)).getLanguage();
   Set selected = new HashSet();
   String attributeName = "home-page-article-types-"+publication.getId();
   if (session.getAttribute("settings") != null) {
     if (((java.util.List) session.getAttribute("settings")).contains(attributeName)){
       String[] articleTypes = neo.phoenix.base.SessionAttributeUtil.attributeAsStringArray(attributeName, request);
       if(articleTypes!=null){
         for(int i=0;i<articleTypes.length;i++) {
           selected.add(articleTypes[i]);
         }
       }
     }
   }
  %>  

<br>

<h2><bean:message key="t.Article_type"/>:</h2>
<!-- FIXME: whitespace here -->
<div class="explanatory-text"><bean:message key="t.Explanation_for_article_type_chooser_on_home_page"/></div>
<ul>
     <%
neo.xredsys.content.type.ArticleType[] types =  neo.xredsys.content.type.TypeManager.getInstance().getArticleTypes(publication.getId());
if (types != null) {
  Arrays.sort(types,new neo.xredsys.content.type.ArticleTypeComparator(countryString));
  for (int i = 0; i < types.length; i++) { 
    if(types[i].isCreateable()){%>
      <li><label>
        <input type="checkbox" name="value" value="<%=types[i].getName()%>" <%=selected.contains(types[i].getName())?"checked='true'":""%>></input><%=types[i].getLabel(countryString)%></label></li>
     <%}
  }
} %>		      
</ul>
 <b><html:errors property="value"/></b>

<input type="hidden" name="key" value="home-page-article-types-<%=publication.getId()%>" />
<input type="button" class="important-button" onClick="javascript:submitForm('change')" value='<bean:message key="t.Change"/>' />
<input type="button" class="link" onClick="javascript:submitForm('main-menu')" value='<bean:message key="b.cancel"/>' />
