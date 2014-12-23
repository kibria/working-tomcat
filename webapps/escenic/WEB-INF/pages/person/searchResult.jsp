<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page import="neo.xredsys.api.profile.Profile,
                 com.escenic.profile.ProfileManagerLocator, neo.xredsys.api.IOAPI"%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<bean:define id="checker" 
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<bean:define name="neo.phoenix.person.PersonSearchForm" scope="request"
              type="neo.phoenix.person.PersonSearchForm" id="form"/>
<html:hidden property="pageStart" />
<html:hidden property="pageLength" />

<bean:define id="popup">false</bean:define>
<logic:present name="neo.phoenix.person.SearchResult" scope="session">
  <%
    java.util.List displayedItems = new java.util.ArrayList();
    request.setAttribute("displayedItems", displayedItems);
  %>
<div class="output-box output-box-full">
  <div class="header">
  <util:pager name="neo.phoenix.person.SearchResult" length="<%=form.getPageLength()%>" startIndex="<%=form.getPageStart()%>"/>
  <bean:define id="start" name="startIndex" type="java.lang.String"/>
  <bean:define id="size" name="totalSize" type="java.lang.String"/>
    <template:call file="../base/pageCounter.jsp">
      <template:parameter key="formName" value="neo.phoenix.person.PersonSearchForm"/>
      <template:parameter key="searchResult" value="neo.phoenix.person.SearchResult"/>
      <template:parameter key="renderMode" value="css"/>
    </template:call>
  </div>
  <div id="searchresults-collapsible-list" class="collapsed-list content"> 
  <bean:define id="persons" name="neo.phoenix.person.SearchResult" scope="session" type="java.util.List"/>
   <% request.setAttribute("resultSize",new Integer(persons.size()));%>
   <logic:greaterThan name="resultSize" value="0">
  <% String nextUrl = "javascript:submitForm('action:" + (String)request.getAttribute("nextUrl") + ".do')"; %>
  <% String prevUrl = "javascript:submitForm('action:" + (String)request.getAttribute("prevUrl") + ".do')"; %>
  <% 
    String pagerUrl = (String)request.getAttribute("pagerUrl");
    if (pagerUrl==null) pagerUrl="/person/search/pager";
    pagerUrl="javaScript:submitForm('action:" + pagerUrl + ".do";
   %>
  <bean:define id="next" value="<%=nextUrl%>"/>
  <bean:define id="previous" value="<%=prevUrl%>"/>
  <bean:define id="pageKey" value="b.Add_person.src"/>
  <bean:define id="altKey" value="b.Add_person.alt"/>
  <template:call file="../base/pager.jsp">
    <template:parameter key="formName" value="neo.phoenix.person.PersonSearchForm"/>
    <template:parameter key="searchResult" value="neo.phoenix.person.SearchResult"/>
    <template:parameter key="previous" value="<%=prevUrl%>"/>
    <template:parameter key="next" value="<%=nextUrl%>"/>
    <template:parameter key="pager" value="<%=pagerUrl%>"/>        
  </template:call>
    <util:toggle id="toggle" name="textmap-liststyles"/>
    <table class="full" cellspacing="0" cellpadding="0" border="0">
      <tr>
        <th></th>
        <th align="left"><bean:message key="t.id" bundle="org.apache.struts.action.MESSAGE"/></th>
        <th align="left"><bean:message key="t.Name" bundle="org.apache.struts.action.MESSAGE"/></th>
        <th align="left"><bean:message key="t.Last_Modified" bundle="org.apache.struts.action.MESSAGE"/></th>
        <th align="left"><bean:message key="t.Publication" bundle="org.apache.struts.action.MESSAGE"/></th>
        <th></th>
      </tr>
      <% 
       int length = Integer.parseInt(form.getPageLength());
       int offset = Integer.parseInt(form.getPageStart());
       length += offset; 
       for (; offset < length && offset < persons.size(); offset++) {
         neo.xredsys.api.Person item = (neo.xredsys.api.Person)persons.get(offset);
         if (item == null) {
           continue;
         }
         %>
        <% displayedItems.add("" + item.getId()+":"+item.getOwnerPublicationId() ); %>
        <tr class="<bean:write name="toggle" property="value" />">
          <% String id = "selected(" + item.getId() +":" + item.getOwnerPublicationId()+ ")";
             //String delete = "/person/delete.do?id=" + item.getId() + "&objectType=" + neo.xredsys.api.IOAtom.OBJECTTYPE_PERSON;
             //String delete = "action:/person/search/deletePersons.do?searchResult=neo.phoenix.person.SearchResult&clear=true&deleteId="+item.getId()+"&deletePubId="+item.getOwnerPublicationId();
          %>
       <logic:notPresent name="hideSelect" scope="request"><%-- jf: optionally turn off select box --%>
          <td>  
            <html:checkbox property="<%=id%>"></html:checkbox>
          </td>
       </logic:notPresent>
       <logic:present name="hideSelect" scope="request"><td>&nbsp;&nbsp;&nbsp;</td></logic:present>
          <% 
          String presentationPath=(String)request.getAttribute("presentationPage");
          if (presentationPath==null) presentationPath="../base/presentPerson.jsp";
        %><template:call file="<%=presentationPath%>">
            <% String perId = item.getId() + ""; %>
            <% String pubId = item.getOwnerPublicationId() + ""; %>
            <util:logMessage message="<%=perId%>"/> 
            <template:parameter key="personId" value="<%=perId%>" />
            <template:parameter key="pubId" value="<%=pubId%>" />
            <template:parameter key="hideEditLink" value="false" />
            <template:parameter key="showAttributes" value="true" />
            <template:parameter key="popup" value="<%=popup%>" />
            <template:parameter key="displayedAttributes" value="id,name,lastModified,publication,view" />
          </template:call>
           
        </tr>
        <util:toggleNext name="toggle" />
      <%}%>
    </table>
   </logic:greaterThan>
  <br>
  
  <%--@include file="../base/previous_next.jspf" --%>
<logic:notPresent name="hidePrevious" scope="request"><%-- jf: optionally turn off 'view previous hits' --%>  
  <hr>
  <%if(form.getSelectedItems().size()>0){%>
  <i><bean:message key="t.Previous_selected_items" bundle="org.apache.struts.action.MESSAGE"/></i><br>

  <table> 
  <logic:iterate name="form" property="selectedItems" id="item" type="java.lang.String">
   <% if(!displayedItems.contains(item)) { %>
     <tr>
       <td><html:checkbox property="<%= \"selected(\" + item + \")\"%>"/></td>
        <template:call file="../base/presentPerson.jsp">
          <template:parameter key="personId" value="<%=item%>" />
        </template:call>
     </tr>
   <% } %>
  </logic:iterate>
  </table>
  <%}%>
</logic:notPresent>  
  </div>
</div>
</logic:present>
