<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page import="org.apache.struts.action.Action,
                 java.util.Locale,
                 java.util.Arrays"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Collection"%>  <%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
  <%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
  <%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
  <%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
  <%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
  
  <bean:define id="checker" name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
  <bean:define id="publication" name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
  <bean:define id="user" name="escenic-user" scope="session" type="neo.xredsys.api.User" />
  
  <input type="hidden" name="submitButton" value="">
  <input type="hidden" name="validateField" value="">
  <input type="hidden" name="validateInput" value="main-menu">
  
  <%
   String lang = neo.phoenix.base.Constants.LOCALE_KEY;
   String countryString= ((Locale)session.getAttribute(lang)).getLanguage();
  %>  
  

<div class="create-article content-box">
<div class="header">
<h2><bean:message key="m.admin"/></h2>
</div>
<div class="content">
  <ul>
    <li><html:link page="/base/changeLanguage.do" styleClass="frontpageLink"><bean:message key="m.admin.ChangeLanguage"/></html:link></li>
    <%if(!"oracle".equals(System.getProperty("escenic.sso.provider"))){%>
      <li><html:link page="/person/changePassword.do" styleClass="frontpageLink"><bean:message key="m.admin.ChangePassword"/></html:link></li>
    <%}%>
    <li><html:link page="/logoff.do" styleClass="frontpageLink"><bean:message key="m.admin.LogOff"/></html:link></li>
  </ul>
</div>
</div>
  
   <util:pluginResources type="internal-link" target="escenic" task="/main-menu" area="plugins" id="resources" />
   <%
     String tmp = publication.getFeature("enablePluginForSectionAdmin");
     Collection enabledPlugins =neo.util.StringUtil.parseStringCollection(tmp,",");
             
     boolean showPlugins = checker.isGlobalPublicationAdmin(publication.getId());
     if(!showPlugins){
        java.util.Iterator resIt = resources.iterator();
        while(resIt.hasNext()){
          neo.xredsys.plugin.Resource res = (neo.xredsys.plugin.Resource)resIt.next();
          if(res.containsRoleNamed("all")||
                  enabledPlugins.contains(res.getPlugin().getName()) && checker.hasRole("administrator")){
            showPlugins = true;
            break;
          }
        }
     }
   %>
   <% if(showPlugins){ %>

<% if (checker.canDoPersonSearch() || checker.canDoGroupSearch() || checker.isGlobalPublicationAdmin(publication.getId())) { %>
<div class="create-article content-box">
<div class="header">
  <h2><bean:message key="l.User_administration"/></h2>
</div>
<div class="content">
  <ul>
      <%if(checker.isGlobalPublicationAdmin(publication.getId())){%>
        <li><html:link page="/user/new.do"><bean:message key="b.createNewUser"/></html:link>
        <li><html:link page="/userGroup/new.do"><bean:message key="b.createNewUsergroup"/></html:link>
      <%}%>
      <%if(checker.canDoPersonSearch()){%>
        <li><a href="javascript:submitForm('person-archive')" class="frontpageLink"><bean:message key="m.archive.Person"/></a></li>
      <%}%>
      <%if(checker.canDoGroupSearch()){%>
        <li><a href="javascript:submitForm('userGroup-archive')" class="frontpageLink"><bean:message key="m.archive.UserGroup"/></a></li>
      <%}%>
  </ul>
</div>
</div>
<% } %>


  
  
  <%	/* Collection  Start */%>
   <% if (!resources.isEmpty()) { %>
    <div class="create-article content-box">
    <div class="header">
     <h2><bean:message key="m.Components"/></h2>
    </div>
    <div class="content">
      <ul>
   <% } %>
  
   <logic:iterate name="resources" id="resource" type="neo.xredsys.plugin.Resource" >
      <% if (resource.getPlugin().isEnabledForPublication(publication)) { %>
        <%
          boolean show =checker.isGlobalPublicationAdmin(publication.getId());
          if(resource.containsRoleNamed("all")||
                  enabledPlugins.contains(resource.getPlugin().getName()) && checker.hasRole("administrator")){
            show = true;
          }
        %>
       <% if(show){ %>
         <li><html:link styleClass="frontpageLink" page="<%=resource.getUri()%>"><bean:write name="resource" property="label"/></html:link></li>
      <% } %>
     <%}%>
    </logic:iterate>
  
     <% if (!resources.isEmpty()) { %>
     </ul>
     </div>
     </div>
    <% } %>
    <%	/* Collection  End */%> 
    
    <%} // GlobalAdminCheck%>   


<%-- FIXME this must go into the new front page!
 <div class="content-box">
       <h>2<bean:message key="m.Components"/></h2>
  <ul>
      <util:pluginResources type="internal-link" target="escenic" task="/archive-menu" area="menu" id="resources2" />
      <logic:iterate name="resources2" id="resource" type="neo.xredsys.plugin.Resource" >
        <% if (resource.getPlugin().isEnabledForPublication(publication)) { %>
          <% String uri ="javascript:submitForm('external:" + resource.getUri() + "')"; %>
          <li><a href="<%=uri%>" class="frontpageLink"><%=resource.getLabel()%></a></li>
        <% } %>
      </logic:iterate>
  </ul>
</div>
--%>

<%-- FIXME this must go into the global menu!!
  <%
    String supportUrl = publication.getFeature("support.url");
    if(!neo.util.StringUtil.isEmpty(supportUrl)){
  %>
    <bean:message key="m.help"/>
     <%
        try{
          String label = supportUrl.substring(0,supportUrl.indexOf("="));
          String url = supportUrl.substring(supportUrl.indexOf("=")+1);
      %>
      <a href="<%=url%>" target="_new"><%=label%></a>
  <%}catch(Exception e){}%>

  <%}%>
 --%>

