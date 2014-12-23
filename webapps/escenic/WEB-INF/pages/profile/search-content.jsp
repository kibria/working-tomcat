<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page import="java.util.Locale,
              org.apache.struts.action.Action,
                 com.escenic.profile.ProfileManagerLocator,
                 neo.phoenix.base.WorkItemForm,
                 neo.xredsys.api.*,
                 neo.xredsys.api.profile.Profile,
                 java.util.List"%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<script language="JavaScript1.2"><!--
  function confirmDeleteProfiles(){
    if(confirm('<bean:message key="t.confirm_delete_profiles"/>')){
      url = "action:/profile/search/deleteProfiles.do";
      submitForm(url);
    }
  }

  function confirmReset(){
    if(confirm('<bean:message key="t.confirm_reset_password"/>')){
      url = "action:/profile/search/resetPasswords.do";
      submitForm(url);
    }
  }

  function confirmBan(){
    if(confirm('<bean:message key="t.confirm_ban_profiles"/>')){
      url = "action:/profile/search/ban.do";
      submitForm(url);
    }
  }
  function confirmPardon(){
    if(confirm('<bean:message key="t.confirm_pardon_profiles"/>')){
      url = "action:/profile/search/pardon.do";
      submitForm(url);
    }
  }
  // -->
</script>

<input type="hidden" name="enterAction" value="action:/profile/search/perform.do"/>
<input type="hidden" name="submitButton" value="success">
<input type="hidden" name="validateInput" value="success">
<bean:define id="checker" name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<html:hidden property="pageStart" />
<html:hidden property="pageLength" />
<html:hidden property="parentWorkItemId"/>

<bean:define name="publication" id="publication" type="neo.xredsys.api.Publication" />
<bean:define name="neo.phoenix.profile.ProfileSearchForm" scope="request" type="neo.phoenix.profile.ProfileSearchForm" id="form"/>
 
<div class="error">
  <html:errors property="global" />
</div>

 <%   
   // Get correct locale
   String lang = neo.phoenix.base.Constants.LOCALE_KEY;
   String countryString= ((Locale)session.getAttribute(lang)).getLanguage();
   
   //remember paging
   request.getSession().setAttribute("escenic-profileSearch-currentPage",form.getPageStart());

  java.util.List displayedItems = new java.util.ArrayList();
  request.setAttribute("displayedItems", displayedItems);
 %>

<table border="0">
  <tr>
    <td><bean:message key="t.Search_for_colon"/></td>
    <td><html:text property="searchWord"/></td>

    <td><bean:message key="t.id"/>:</td>
    <td><html:text property="searchId"/><html:errors property="searchId"/></td>
  </tr>
  <tr>
    <td>
      <bean:message key="t.From_colon" bundle="org.apache.struts.action.MESSAGE"/>
    </td>
    <td>
      <input type="text" name="createdDateFromDisplay" id="createdDateFromDisplay" disabled="true" value="<%=form.getCreatedDateFrom()%>"/>
      <html:hidden property="createdDateFrom" styleId="createdDateFrom"/>
      <input type="button" onclick="javascript:showCalendar('createdDateFromDisplay','createdDateFrom')"  value="..."></input>
    </td>
    <td>
      <bean:message key="t.To_colon" bundle="org.apache.struts.action.MESSAGE"/>
    </td>
    <td>
      <input type="text" name="createdDateToDisplay" id="createdDateToDisplay" disabled="true" value="<%=form.getCreatedDateTo()%>"/>
      <html:hidden property="createdDateTo" styleId="createdDateTo"/>
      <input type="button" onclick="javascript:showCalendar('createdDateToDisplay','createdDateTo')"  value="..."></input>
    </td>
  </tr>
  <tr>
    <td>
      <bean:message key="t.Last_login_colon" bundle="org.apache.struts.action.MESSAGE"/>
    </td>
    <td>
      <input type="text" name="loginDateFromDisplay" id="loginDateFromDisplay" disabled="true" value="<%=form.getLoginDateFrom()%>"/>
      <html:hidden property="loginDateFrom" styleId="loginDateFrom"/>
      <input type="button" onclick="javascript:showCalendar('loginDateFromDisplay','loginDateFrom')"  value="..."></input>
    </td>
    <td>
      &nbsp;
    </td>
    <td>
      <input type="text" name="loginDateToDisplay" id="loginDateToDisplay" disabled="true" value="<%=form.getLoginDateTo()%>"/>
      <html:hidden property="loginDateTo" styleId="loginDateTo"/>
      <input type="button" onclick="javascript:showCalendar('loginDateToDisplay','loginDateTo')"  value="..."></input>
    </td>
  </tr>
  <tr>
    <td valign="top">
      <bean:message key="h.Profile_types"/>:
    </td>
    <td>
      <html:select size="4" property="types" multiple="multiple">
        <%
        neo.xredsys.content.type.ArticleType[] types = ProfileManagerLocator.getInstance().getProfileManager().getProfileTypes(publication.getId());
        request.setAttribute("types",types);
        %>
        <logic:iterate id="currentType" name="types" type="neo.xredsys.content.type.ArticleType">
          <html:option value="<%=currentType.getName()%>"><%=currentType.getLabel(countryString)%></html:option>
        </logic:iterate>
      </html:select>
    </td>
  </tr>
  <tr>
    <td></td><!-- Align with input fields -->
    <td colspan="2">
      <table border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td>
            <a class="global-button" href="javascript:submitForm('action:/profile/search/perform.do')"><bean:message key="b.search"/></a>
          </td>
          <td>&nbsp;</td>
          <td>
            <a class="global-button" href="javascript:submitForm('reset')"><bean:message key="b.clear_search"/></a>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<logic:present name="neo.phoenix.profile.SearchResult" scope="session">
<hr>
  <util:pager name="neo.phoenix.profile.SearchResult" length="<%=form.getPageLength()%>" startIndex="<%=form.getPageStart()%>"/>
  <bean:define id="start" name="startIndex" type="java.lang.String"/>
  <bean:define id="size" name="totalSize" type="java.lang.String"/>
  <template:call file="../base/pageCounter.jsp">
    <template:parameter key="formName" value="neo.phoenix.profile.ProfileSearchForm"/>
    <template:parameter key="searchResult" value="neo.phoenix.profile.SearchResult"/>
  </template:call>

  <bean:define id="result" name="neo.phoenix.profile.SearchResult" type="java.util.Collection"/>
  <% request.setAttribute("resultSize",new Integer(result.size()));%>
  <%
    String articleProperties = "typeImage,title,lastModified,homeSection,articleType";
    String personProperties = "icon,name,loginDate,status";
  %>
  <logic:greaterThan name="resultSize" value="0">
    <table cellspacing="0" cellpadding="0" border="0" width="100%">
      <tr>
        <td>&nbsp;</td>
        <th>&nbsp;</th>
        <th align="left"><bean:message key="t.Name" bundle="org.apache.struts.action.MESSAGE"/></th>
        <th align="left"><bean:message key="t.Last_login" bundle="org.apache.struts.action.MESSAGE"/></th>
        <th align="left"><bean:message key="t.User_status" bundle="org.apache.struts.action.MESSAGE"/></th>
        <template:call file="/WEB-INF/pages/base/presentArticleHeader.jsp">
          <template:parameter key="displayedAttributes" value="<%=articleProperties%>"/>
        </template:call>
      </tr>
      <util:toggle id="toggle" name="textmap-liststyles"/>
      <logic:iterate name="neo.phoenix.profile.SearchResult" id="item" type="neo.xredsys.content.search.SearchHit" length="<%=form.getPageLength()%>" offset="<%=form.getPageStart()%>">
        <% displayedItems.add("" + item.getField("docId") ); %>
          <%
            try{
              Profile p = ProfileManagerLocator.getInstance().getProfileManager().getProfile(Integer.parseInt((String)item.getField("REFERENCEID")));
          %>
          <tr class="<bean:write name="toggle" property="value" />">
            <td> 
              <% String selected = "selected("+item.getField("docId")+")";%>
              <html:checkbox property="<%=selected%>"/>
            </td>
            <template:call file="../base/presentPerson.jsp">
              <template:parameter key="personId" value="<%=String.valueOf(p.getProfilePerson().getId())%>" />
              <template:parameter key="isSubmittingForm" value="true" />
              <template:parameter key="hideEditLink" value="false" />
              <template:parameter key="showAttributes" value="true" />
              <template:parameter key="loadUser" value="true" />
              <template:parameter key="displayedAttributes" value="<%=personProperties%>"/>
            </template:call>
            <template:call file="../base/presentArticle.jsp">
              <template:parameter key="articleId" value="<%= \"\" + item.getField(\"docId\")%>" />
              <template:parameter key="isSubmittingForm" value="true" />
              <template:parameter key="displayedAttributes" value="<%=articleProperties%>"/>
            </template:call>
            <util:toggleNext name="toggle" />
          </tr>
        <%}catch(Throwable e){}%>
      </logic:iterate>
    </table>
  </logic:greaterThan>
  <br>
  <% String nextUrl = "javascript:submitForm('action:/profile/search/next.do')"; %>
  <% String prevUrl = "javascript:submitForm('action:/profile/search/prev.do')"; %>
  <bean:define id="next" value="<%=nextUrl%>"/>
  <bean:define id="previous" value="<%=prevUrl%>"/>
  <template:call file="../base/pager.jsp">
    <template:parameter key="formName" value="neo.phoenix.profile.ProfileSearchForm"/>
    <template:parameter key="searchResult" value="neo.phoenix.profile.SearchResult"/>
    <template:parameter key="previous" value="<%=prevUrl%>"/>
    <template:parameter key="next" value="<%=nextUrl%>"/>
    <template:parameter key="pager" value="javaScript:submitForm('action:/profile/search/pager.do"/>
  </template:call>
  <logic:iterate name="form" property="selectedItems" id="articleId" type="java.lang.String">
    <%if (!displayedItems.contains(articleId)) {%>
        <input type="hidden" name="selected(<%=articleId%>)" value="on">
    <%}%>
  </logic:iterate>
  <logic:greaterThan name="resultSize" value="0">
    <% String clear = "javascript:submitForm('action:/profile/search/clearSelection.do')"; %>
    <% String selectAll = "javascript:submitForm('action:/profile/search/selectAll.do?searchResult=neo.phoenix.profile.SearchResult')"; %>
    <table>
      <tr>
        <td>
          <a href="<%=clear%>" class="global-button"><bean:message key="t.Clear_selection"/></a>
        </td>
        <td>
          <a href="<%=selectAll%>" class="global-button"><bean:message key="t.Select_all"/></a>
        </td>
      </tr>
    </table>
    <hr>
    <% if(checker.isPublicationAdmin()){%>
      <table>
        <tr>
          <td>
            <a href="javascript:confirmDeleteProfiles()" class="global-button">
              <bean:message key="t.Delete_profiles"/>
            </a>
          </td>
        </tr>
      </table>
      <table>
        <tr>
          <td>
            <a href="javascript:confirmReset()" class="global-button">
              <bean:message key="t.reset_password_for_profiles"/>
            </a>
          </td>
        </tr>
      </table>
      <table>
        <tr>
          <td>
            <a href="javascript:confirmBan()" class="global-button">
              <bean:message key="t.ban_profiles"/>
            </a>
          </td>
        </tr>
      </table>
      <table>
        <tr>
          <td>
            <a href="javascript:confirmPardon()" class="global-button">
              <bean:message key="t.pardon_profiles"/>
            </a>
          </td>
        </tr>
      </table>
    <%}%>
  </logic:greaterThan>
</logic:present>
<logic:present name="neo.phoenix.profile.reset.success">
  <% List success = (List)request.getAttribute("neo.phoenix.profile.reset.success");%>
  <br><bean:message key="t.Profile_resetpassword_success" arg0="<%=String.valueOf(success.size())%>"/>
</logic:present>
<logic:present name="neo.phoenix.profile.reset.failure">
  <% List failure = (List)request.getAttribute("neo.phoenix.profile.reset.failure");%>
  <br><bean:message key="t.Profile_resetpassword_failure" arg0="<%=String.valueOf(failure.size())%>" arg1="<%=failure.toString()%>"/>
</logic:present>
<logic:present name="neo.phoenix.profile.delete.success">
  <% List deleted = (List)request.getAttribute("neo.phoenix.profile.delete.success");%>
  <br><bean:message key="t.Profile_delete_success" arg0="<%=String.valueOf(deleted.size())%>"/>
</logic:present>
<logic:present name="neo.phoenix.profile.delete.failure">
  <% List deleteFailure = (List)request.getAttribute("neo.phoenix.profile.delete.failure");%>
  <br><bean:message key="t.Profile_delete_failure" arg0="<%=String.valueOf(deleteFailure.size())%>" arg1="<%=deleteFailure.toString()%>"/>
</logic:present>

<logic:present name="neo.phoenix.profile.ban.success">
  <% List banned = (List)request.getAttribute("neo.phoenix.profile.ban.success");%>
  <br><bean:message key="t.Profile_ban_success" arg0="<%=String.valueOf(banned.size())%>"/>
</logic:present>
<logic:present name="neo.phoenix.profile.ban.failure">
  <% List bannedFailure = (List)request.getAttribute("neo.phoenix.profile.ban.failure");%>
  <br><bean:message key="t.Profile_ban_failure" arg0="<%=String.valueOf(bannedFailure.size())%>" arg1="<%=bannedFailure.toString()%>"/>
</logic:present>

<logic:present name="neo.phoenix.profile.pardon.success">
  <% List pardon = (List)request.getAttribute("neo.phoenix.profile.pardon.success");%>
  <br><bean:message key="t.Profile_pardon_success" arg0="<%=String.valueOf(pardon.size())%>"/>
</logic:present>
<logic:present name="neo.phoenix.profile.pardon.failure">
  <% List pardonFailure = (List)request.getAttribute("neo.phoenix.profile.pardon.failure");%>
  <br><bean:message key="t.Profile_pardon_failure" arg0="<%=String.valueOf(pardonFailure.size())%>" arg1="<%=pardonFailure.toString()%>"/>
</logic:present>

<logic:present name="WorkItemManager" scope="session">
  <logic:notEqual name="parentWorkItemId" value="empty" >
    <%
    neo.phoenix.base.WorkItemManager manager = (neo.phoenix.base.WorkItemManager)request.getSession().getAttribute("WorkItemManager");
    neo.phoenix.base.WorkItem workItem = manager.getWorkItem(form.getParentWorkItemId());
    if(workItem!=null&&((WorkItemForm)workItem.getForm()).displayInLists()){%>
      <hr>
        <table>
          <tr>
            <td>
              <a class="global-button" href="javascript:submitForm('finished')"><bean:message key="b.return_to" arg0="<%=workItem.getName()%>"/></a>
            </td>
          </tr>
        </table>
    <%}%>
  </logic:notEqual>
</logic:present>
