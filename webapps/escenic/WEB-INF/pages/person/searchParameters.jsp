<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page import="org.apache.struts.action.Action,
                 java.util.Locale"%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<bean:define id="formName" name="formName" type="java.lang.String"/>
<bean:define id="form" name="<%=formName%>" type="neo.phoenix.person.PersonSearchForm"/>
<bean:define id="checker"
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<bean:define id="publication"
             name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />

<bean:define id="popup">false</bean:define>

<%
  String popupPrefix = neo.util.StringUtil.getBoolean(popup)?"/popup":"";
  String visible = "Display";
  String hidden = "Hide";
%>             
<script language="JavaScript1.2"><!--
  function clickMe(box){
    submitForm("action:/person/search<%=popupPrefix%>/switchMode.do");
  }
  // -->
</script>

<%
// Get correct locale
String lang = neo.phoenix.base.Constants.LOCALE_KEY;
String countryString= ((Locale)session.getAttribute(lang)).getLanguage();
String searchUrl=(String)request.getAttribute("searchUrl");
if (searchUrl==null){
  searchUrl="/person/search/perform";
}
searchUrl="javascript:submitForm('action:" + searchUrl + ".do')";

%>             
  <fieldset class="unstyled searchword">
    <label><span><bean:message key="t.Searchword" bundle="org.apache.struts.action.MESSAGE"/>:</span>
    <html:text property="searchWord"/></label> 
    <span class="error"><html:errors property="searchWord"/></span>
  </fieldset>
  <fieldset class="unstyled id">
    <label><span><bean:message key="t.id" bundle="org.apache.struts.action.MESSAGE"/>:</span>
    <html:text property="searchId"/></label>
    <span class="error"><html:errors property="searchId"/></span>
  </fieldset>
  <% if(checker.isUserAdmin(publication)){ %>
    <fieldset class="unstyled publication">
      <label>
        <span><bean:message key="t.Publication" bundle="org.apache.struts.action.MESSAGE"/>:</span>
        <%
          java.util.Collection friendly = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getFriendlyIds(publication.getId());
          java.util.Iterator it = friendly.iterator();
          neo.xredsys.api.Publication[] pubs = new neo.xredsys.api.Publication[friendly.size()+1];
          for (int i = 0; it.hasNext(); i++) {
            pubs[i] = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPublication(((Integer)it.next()).intValue());
          }
          pubs[pubs.length-1]=publication;
          request.setAttribute("pubs",pubs);
        %>

        <html:select multiple="true" property="publications" styleClass="selectPublication">
          <logic:iterate id="item" name="pubs" type="neo.xredsys.api.Publication">
              <html:option value="<%=new Integer(item.getId()).toString()%>"> 
                <%=item.getName()%>
              </html:option>
          </logic:iterate>
        </html:select>
      </label>
    </fieldset>
  <% } %>
    <% if(checker.canDoGroupSearch()){%>  
      <fieldset class="unstyled user">
        <label><span><bean:message key="t.Search_for_users" bundle="org.apache.struts.action.MESSAGE"/></span>
        <html:checkbox property="includeUsers" value="true"/></label>
      </fieldset>
      <fieldset class="unstyled person">
        <label><span><bean:message key="t.Search_for_persons" bundle="org.apache.struts.action.MESSAGE"/></span>
        <html:checkbox property="includePersons" value="true"/></label>
      </fieldset>
    <%}%>
  <%if(true){%>
    <%@include file="../base/dateSearch.jspf" %>
  <%}%>
    
  <%-- adds search buttons --%>
     <fieldset class="unstyled buttons">
       <input type="button" class="important-button" onClick="<%=searchUrl%>" value='<bean:message key="b.search"/>' />
       <input type="button" class="link" onClick="javascript:submitForm('reset')" value='<bean:message key="b.clear_search"/>' />
       <logic:notPresent name="hideExtraOperations" scope="request">
          <%
            boolean journalist =checker.isJournalist();
            boolean global =checker.isGlobalPublicationAdmin(publication.getId());
            request.setAttribute("isJournalist",String.valueOf(journalist));
            request.setAttribute("isAdministrator",String.valueOf(global));
            if(journalist) {
          %>
              <input type="button" class="link" onClick="javascript:submitForm('external:/person<%=popupPrefix%>/new.do')" value='<bean:message key="b.createNewPerson"/>' />
          <%}%>
       </logic:notPresent>
     </fieldset>
  <%-- end add search buttons --%>
