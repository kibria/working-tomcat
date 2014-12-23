<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>

<bean:define id="checker" 
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<bean:define name="neo.phoenix.userGroup.UserGroupSearchForm" scope="request"
              type="neo.phoenix.userGroup.UserGroupSearchForm" id="form"/>
<html:hidden property="pageStart" />
<html:hidden property="pageLength" />
<logic:present name="neo.phoenix.usergroup.SearchResult" scope="session">
  <%
    java.util.List displayedItems = new java.util.ArrayList();
    request.setAttribute("displayedItems", displayedItems);
  %>
  <util:pager name="neo.phoenix.usergroup.SearchResult" length="<%=form.getPageLength()%>" startIndex="<%=form.getPageStart()%>"/>
  <bean:define id="start" name="startIndex" type="java.lang.String"/>
  <bean:define id="size" name="totalSize" type="java.lang.String"/>
  <template:call file="../base/pageCounter.jsp">
    <template:parameter key="formName" value="neo.phoenix.userGroup.UserGroupSearchForm"/>
    <template:parameter key="searchResult" value="neo.phoenix.usergroup.SearchResult"/>
  </template:call>
 <bean:define id="groups" name="neo.phoenix.usergroup.SearchResult" scope="session" type="java.util.Collection"/>
 <% request.setAttribute("resultSize",new Integer(groups.size()));%>
 <logic:greaterThan name="resultSize" value="0">
  <% String nextUrl = "javascript:submitForm('action:" + (String)request.getAttribute("nextUrl") + ".do')"; %>
  <% String prevUrl = "javascript:submitForm('action:" + (String)request.getAttribute("prevUrl") + ".do')"; %>
    <% 
      String pagerUrl = (String)request.getAttribute("pagerUrl");
      if (pagerUrl==null) pagerUrl="/userGroup/search/pager";
      pagerUrl="javaScript:submitForm('action:" + pagerUrl + ".do";
   %>
    <bean:define id="next" value="<%=nextUrl%>"/>
    <bean:define id="previous" value="<%=prevUrl%>"/>
    <bean:define id="pageKey" value="b.Add_group.src"/>
    <bean:define id="altKey" value="b.Add_group.alt"/>
    <template:call file="../base/pager.jsp">
      <template:parameter key="formName" value="neo.phoenix.userGroup.UserGroupSearchForm"/>
      <template:parameter key="searchResult" value="neo.phoenix.usergroup.SearchResult"/>
      <template:parameter key="previous" value="<%=prevUrl%>"/>
      <template:parameter key="next" value="<%=nextUrl%>"/>
      <template:parameter key="pager" value="<%=pagerUrl%>"/>        
    </template:call>
  <table cellspacing="0" cellpadding="0" border="0" width="100%">
    <tr>
      <th align="left"></th>
      <th align="left"><bean:message key="t.Name" bundle="org.apache.struts.action.MESSAGE"/></th>
      <th align="left"><bean:message key="t.Publication" bundle="org.apache.struts.action.MESSAGE"/></th>
      <th align="left"></th>
    </tr>
    <util:toggle id="toggle" name="textmap-liststyles"/>
    <logic:iterate name="groups" id="item" type="neo.xredsys.api.UserGroup" length="<%=form.getPageLength()%>" offset="<%=form.getPageStart()%>">
      <% displayedItems.add("" + item.getName()+":"+item.getOwnerPublicationId() ); %>
      <tr class="<bean:write name="toggle" property="value" />">
        <% String delete = "/userGroup/delete.do?name=" + item.getName(); %>            
        <% String id = "selected(" + item.getName() +":" + item.getOwnerPublicationId() + ")"; %>
        <logic:notPresent name="hideSelect" scope="request"><%-- jf: optionally turn off select box --%>
        <td>  
          <html:checkbox property="<%=id%>"></html:checkbox>
        </td>
        </logic:notPresent>
        <logic:present name="hideSelect" scope="request"><td>&nbsp;&nbsp;&nbsp;</td></logic:present>
          <% String name = item.getName() + ""; 
             String pubId = item.getOwnerPublicationId() + "";   
             String presentationPath=(String)request.getAttribute("presentationPage");
            if (presentationPath==null) presentationPath="../base/presentUserGroup.jsp";
      %><template:call file="<%=presentationPath%>">
          <template:parameter key="pubId" value="<%=pubId%>" />
          <template:parameter key="groupName" value="<%=name%>" />
        </template:call> 
        </td> 
<%--     <logic:notPresent name="hideDelete" scope="request">        
        <%
          neo.xredsys.api.UserGroup group = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getUserGroup(name,Integer.parseInt(pubId)); 
          if(checker.isGlobalPublicationAdmin(group.getOwnerPublicationId())){ %>
          <td>                
            <html:link page="<%=delete%>">
              <html:img page="/images/qw/delete.png" border="0"/>
            </html:link>
          </td>
        <% }else{ %>
          <td>&nbsp;</td>
        <% } %>
   </logic:notPresent>   --%>     
    <util:toggleNext name="toggle" />
      </tr>
    </logic:iterate>
  </table>
  </logic:greaterThan>
  <br>

  <%--@include file="../base/previous_next.jspf" --%>
<logic:notPresent name="hidePrevious" scope="request"><%-- jf: optionally turn off 'view previous hits' --%>    
  <hr>
  <i><bean:message key="t.Previous_selected_items" bundle="org.apache.struts.action.MESSAGE"/></i><br>
  <table> 
  <logic:iterate name="form" property="selectedItems" id="item" type="java.lang.String">
   <% if(!displayedItems.contains(item)) { %>
     <tr>
       <td>
        <html:checkbox property="<%= \"selected(\" + item + \")\"%>"/>
        <% String url = "/userGroup/edit.do?name=" + item; %>
        <html:link page="<%=url%>">
          <%=item%> 
        </html:link>
       </td>             
     </tr>
   <% } %>
  </logic:iterate>
  </table>
</logic:notPresent>
</logic:present>
