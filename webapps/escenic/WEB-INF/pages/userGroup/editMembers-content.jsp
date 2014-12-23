<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-view" prefix="view" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<script language="JavaScript1.2"><!-- 
  function enableShowAllMembers(value){
    var name = "showAllMembers";
    setField(name,value);
    submitForm("editMembers");
  }
  function setField(name,value){
    for(var i = 0; i < document.forms[0].elements.length;i++){
      if(document.forms[0].elements[i].name==name){
        document.forms[0].elements[i].value=value;
        break;
      }
    }
  }
  // --> 
</script>
<div class="error"><html:errors property="global" /></div>
<bean:define id="publication" 
             name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<bean:define id="checker" 
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<bean:define name="neo.phoenix.userGroup.UserGroupForm" id="form" scope="request" type="neo.phoenix.userGroup.UserGroupForm"/>
<% boolean readOnly = neo.util.StringUtil.getBoolean(form.getReadOnly());%>
<table>
  <tr>
    <td>
      <bean:message key="t.Name"/>
    </td>
    <td>
      <html:text property="newName" disabled="<%=readOnly%>"/>
    </td>
    <td>
      <html:errors property="newName"/>
    </td>
  </tr>
</table>
<hr/>
<html:hidden property="pubId" />
<html:hidden property="readOnly" />
<html:hidden property="editRoles" />
<html:hidden property="name" />
<html:hidden property="parentWorkItemId"/>

<%@include file="../base/relatedObjects.jspf" %>
<%@include file="hiddenGroups.jspf" %>
<%@include file="hiddenRelations.jspf" %>
<%@include file="hiddenGlobalRoles.jspf" %>
<%@include file="../person/hiddenTags.jspf" %>
<%@include file="../person/hiddenContentTypes.jspf" %>
<input type="hidden" name="validateButton" value="editMembers"/>
<input type="hidden" name="validateButton" value="save"/>
<input type="hidden" name="validateInput"  value="editMembers"/>
<input type="hidden" name="validateInput"  value="save"/>
<input type="hidden" name="validateField" value="newName" />
<h3></h3>
 <table><tr>
  <%
    neo.xredsys.api.UserGroup group = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getUserGroup(form.getName(),Integer.parseInt(form.getPubId()));
    boolean canAddUser = true;
    if(canAddUser&&!readOnly){ 
  %>
    <td><a class="global-button"  href="javascript:submitForm('findUsers')"><bean:message key="b.find_users"/></a></td>
  <% } %>
  <%
  String value = null;
  if(canAddUser){
    value="person";
  }
  %>
  <html:hidden property="include" value="<%=value%>"/>
  <%if(value!=null){%>
    <%-- <td> <a class="global-button" href="javascript:submitForm('addFromMyClips')">AddUsersFromMyClips</a></td> --%>
  <% } %> 
  </tr>
</table>
<input type="hidden" name="submitButton" value="">
<html:hidden property="pageStart" />
<html:hidden property="pageLength" />

<% int pubID = publication.getId(); %>
<p><h3><bean:message key="t.Members"/></h3>
  <bean:define id="members" name="neo.phoenix.userGroup.UserGroupForm" property="users" scope="request" type="java.util.List"/>
  <% if(members.size()>0){ %>
    <% request.setAttribute("members", members); %>
    <table>
      <tr>
        <% String nextUrl = "javascript:submitForm('action:/userGroup/edit/members/next.do')"; %>
        <% String prevUrl = "javascript:submitForm('action:/userGroup/edit/members/prev.do')"; %>
        <td colspan="3" align="right">
          <template:call file="../base/pager.jsp">
            <template:parameter key="formName" value="neo.phoenix.userGroup.UserGroupForm"/>
            <template:parameter key="searchResult" value="members"/>
            <template:parameter key="previous" value="<%=prevUrl%>"/>
            <template:parameter key="next" value="<%=nextUrl%>"/>
            <template:parameter key="pager" value="javaScript:submitForm('action:/userGroup/edit/members/pager.do"/>
            <template:parameter key="scope" value="request"/>
          </template:call>
        </td>
      </tr>
      <% int count = 0; %>
      <logic:iterate name="members" id="key" type="java.lang.String">
        <%  String p1 = "user(" + key + ").id"; 
            String p2 = "user(" + key + ").type"; 
            String p3 = "user(" + key + ").publicationId";
        %>
        <html:hidden property="<%=p1%>"/>
        <html:hidden property="<%=p2%>"/>
        <html:hidden property="<%=p3%>"/>
        <%
          if(count >= Integer.parseInt(form.getPageStart()) && count < (Integer.parseInt(form.getPageStart()) + Integer.parseInt(form.getPageLength())) ) {
        %>
        <% 
           neo.phoenix.base.RelatedObject relObj = form.getUser(key);
           neo.xredsys.api.Person item = (neo.xredsys.api.Person)neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPerson(Integer.parseInt(relObj.getId()),Integer.parseInt(relObj.getPublicationId())); %>
        <% String remove = "action:/userGroup/RemovePersonFromUserGroup.do?id=" + item.getId();%>
        <tr>
          <template:call file="../base/presentPerson.jsp">
            <% String perId = item.getId() + "";
               String pubId = item.getOwnerPublicationId() + "";       
            %>
            <template:parameter key="personId" value="<%=perId%>" />
            <template:parameter key="external" value="true" />
            <template:parameter key="pubId" value="<%=pubId%>" />
            <template:parameter key="displayedAttributes" value="icon,name,publication" />
          </template:call>
            <td>
              <%if(item.getUserName().equals(publication.getName()+"_admin") || readOnly){%>
                &nbsp;
              <%}else{%>                              
                <a href="javascript:submitForm('<%=remove%>')">
                  <html:img page="/images/qw/delete.png" border="0"/>
                  </a>
              <%}%>  
            </td>
        </tr>
        <%
          }
          count++;
        %>
      </logic:iterate>
    </table>
  <% } %> 
</p>
    <%
      if(neo.util.StringUtil.getBoolean(form.getShowAllMembers())){
      %>  
      <table>
        <tr><th align="left"><bean:message key="t.All_members"/></th></tr>
          <tr>
            <td><table>
            <%
              java.util.HashSet visited = new java.util.HashSet();
              java.util.HashMap memberMap = new java.util.HashMap();
              findMembers(group,visited,memberMap);
              java.util.Iterator memIt = memberMap.keySet().iterator();
              while(memIt.hasNext()){
                neo.xredsys.api.Person key = (neo.xredsys.api.Person)memIt.next();
                //String tmpValue = findGroups((java.util.HashSet)memberMap.get(key));
                out.print("<tr>");
                %><template:call file="../base/presentPerson.jsp">
                  <% String perId = key.getId() + "";
                     String pubId = key.getOwnerPublicationId() + "";       
                  %>
                  <template:parameter key="personId" value="<%=perId%>" />
                  <template:parameter key="external" value="true" />
                  <template:parameter key="pubId" value="<%=pubId%>" />
                  <template:parameter key="displayedAttributes" value="icon,name,publication" />
                </template:call>
                <%out.print("</tr>");
                java.util.Iterator groupIt = ((java.util.HashSet)memberMap.get(key)).iterator();
                while(groupIt.hasNext()){
                  neo.xredsys.api.UserGroup tmpGr = (neo.xredsys.api.UserGroup)groupIt.next();
                  out.print("<tr><td></td><td><table><tr>");
                  %><template:call file="../base/presentUserGroup.jsp">
                    <% String groupName = tmpGr.getName() + ""; 
                       String pub = tmpGr.getOwnerPublicationId() + "";   
                    %>
                    <template:parameter key="external" value="true" />
                    <template:parameter key="pubId" value="<%=pub%>" />
                    <template:parameter key="groupName" value="<%=groupName%>" />
                    <template:parameter key="readOnly" value="true" />
                  </template:call><%
                  out.print("</tr></table></td>");
                }
              }
          %>
          </table>
          </td></tr>
        <tr><td><a class="global-button"  href="javascript:enableShowAllMembers('false')"><bean:message key="b.hide_inherited_users"/></a></td></tr>
      </table >
      <%}else{%>
        <table><tr><td><a class="global-button"  href="javascript:enableShowAllMembers('true')"><bean:message key="b.show_all_users"/></a></td></tr></table>
      <%}%>
</p>
<html:hidden property="showAllMembers"/>
<%!
  public void findMembers(neo.xredsys.api.UserGroup group, java.util.HashSet visitedGroups,java.util.HashMap membersMap){
    if(!visitedGroups.contains(group)){
      visitedGroups.add(group);
      java.util.Collection members = group.getUserMembers();
      java.util.Iterator mIt = members.iterator();
      while(mIt.hasNext()){
        neo.xredsys.api.Person person = (neo.xredsys.api.Person)mIt.next();
        java.util.HashSet groups = null;
        if(membersMap.containsKey(person)){
          groups = (java.util.HashSet)membersMap.get(person);
        }else{
          groups = new java.util.HashSet();
          membersMap.put(person,groups);
        }
        groups.add(group);
      }
      java.util.Collection children = group.getUserGroupMembers();
      java.util.Iterator i = children.iterator();
      while(i.hasNext()){
        findMembers((neo.xredsys.api.UserGroup)i.next(), visitedGroups,membersMap);            
      }
    }
  }
  public String findGroups(java.util.HashSet groups){
    java.lang.StringBuffer buffer = new java.lang.StringBuffer();
    if(groups.size()==0){
      buffer.append("()");
    }else{
      java.util.Iterator i = groups.iterator();
      buffer.append("(");
      while(i.hasNext()){
        neo.xredsys.api.UserGroup group = (neo.xredsys.api.UserGroup)i.next();
        buffer.append(group.getName()+",");
      }
      buffer.setCharAt(buffer.length()-1,')');
    }
    return buffer.toString();
  }
%>