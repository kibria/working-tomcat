<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-view" prefix="view" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<bean:define id="publication" 
             name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<bean:define id="checker" 
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<div class="error"><html:errors property="global" /></div>
<input type="hidden" name="validateButton" value="editGroups"/>
<input type="hidden" name="validateButton" value="save"/>
<input type="hidden" name="validateInput"  value="editGroups"/>
<input type="hidden" name="validateField" value="none" />
<%@include file="hiddenProperties.jspf" %>
<%@include file="../base/relatedObjects.jspf" %>
<%@include file="hiddenGlobalRoles.jspf" %>
<%@include file="hiddenRelations.jspf" %> 
<%@include file="hiddenTags.jspf" %> 
<%@include file="hiddenContentTypes.jspf" %>
<html:hidden property="parentWorkItemId" />
<html:hidden property="isGuestUser"/>
<bean:define id="form" name="neo.phoenix.person.PersonForm" type="neo.phoenix.person.PersonForm"/>
<% 
  neo.xredsys.api.Person person = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPerson(Integer.parseInt(form.getId()), Integer.parseInt(form.getPubId()));
  boolean canEditUser = checker.isGlobalPublicationAdmin(person.getOwnerPublicationId());
  String canEditAsString = String.valueOf(canEditUser); 
  boolean isAdmin = false;
  String userName = form.getUserName();
  String pubName = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPublication(Integer.parseInt(form.getPubId())).getName();
  if(userName.equals(pubName+"_admin")){
    isAdmin = true;
  }
  String sIsAdmin = String.valueOf(isAdmin);
  boolean isReadOnly = neo.util.StringUtil.getBoolean(form.getReadOnly());
  boolean isGuestUser = neo.util.StringUtil.getBoolean(form.getIsGuestUser());
%> 

<table>
  <tr>
  <% if(!isReadOnly&&(canEditUser||isGuestUser)){ %>
      <td><a class="global-button" href="javascript:submitForm('findGroups')"><bean:message key="b.find_groups"/></a></td>
      <html:hidden property="include" value="userGroup"/>
      <%-- <td> <a href="javascript:submitForm('addFromMyClips')">AddGroupsFromMyClips</a></td> --%> 

    <% } %>
  </tr>
</table>

<bean:define id="groups" name="form" property="userGroups" type="java.util.List"/> 
<% if(groups.size()>0){ %>
  <h4><bean:message key="t.this_person_is_member_of_the_following_groups"/>:</h4>
    <table>
      
      <logic:iterate name="form" property="userGroups" id="key" type="java.lang.String">
        <tr>
          <%  String p1 = "userGroup(" + key + ").attribute(name)"; 
              String p2 = "userGroup(" + key + ").type"; 
              String p3 = "userGroup(" + key + ").publicationId";
          %>
          <html:hidden property="<%=p1%>"/>
          <html:hidden property="<%=p2%>"/>
          <html:hidden property="<%=p3%>"/>
      
          <% 
             neo.phoenix.base.RelatedObject relObj = form.getUserGroup(key);
             String name = relObj.getAttribute("name");
             int pubId = Integer.parseInt(relObj.getPublicationId());
             neo.xredsys.api.UserGroup item = (neo.xredsys.api.UserGroup)neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getUserGroup(name,pubId); %>
          <% String remove = "action:/person/RemovePersonFromUserGroup.do?name="+name+"&pubIdOfGroup="+pubId;%>
      
            <template:call file="../base/presentUserGroup.jsp">
              <% String groupName = item.getName() + ""; 
                 String pub = item.getOwnerPublicationId() + "";   
              %>
              <template:parameter key="external" value="true" />
              <template:parameter key="pubId" value="<%=pub%>" />
              <template:parameter key="groupName" value="<%=groupName%>" />
              <template:parameter key="readOnly" value="true" />
              <template:parameter key="displayedAttributes" value="icon,name,publication" />
            </template:call> 
          <% if(!isReadOnly){%>
            <%if(item.getOwnerPublicationId()==publication.getId()){%>
              <td><a href="javascript:submitForm('<%=remove%>')">
                <html:img page="/images/qw/delete.png" border="0"/>
                </a>
              </td>
            <%}%>
          <%}%>
        </tr> 
      </logic:iterate>
      </tr>
    </table>
    <table>
      <tr>
       <% if(!form.isHasFoundAllGroups()){ %>
        <td><a class="global-button" href="javascript:submitForm('action:/person/findAllGroups.do')"><bean:message key="b.view_all_groups"/></a>
        </td>
      <% } %>  
      </tr>
    </table>
<% }else{ %>
  <p><h4><bean:message key="t.this_person_is_not_member_of_any_groups"/></h4></p>
<% } %>
  <% if(form.isHasFoundAllGroups()){ %>
    <table>
      <tr>
        <th colspan="3" align="left"><bean:message key="t.All_groups"/></th>
      </tr>
      <logic:iterate name="form" property="allUserGroups" id="key" type="java.lang.String">
        <tr>
          <%  String p1 = "allUserGroup(" + key + ").attribute(name)"; 
              String p2 = "allUserGroup(" + key + ").type"; 
              String p3 = "allUserGroup(" + key + ").publicationId";
          %>
          <html:hidden property="<%=p1%>"/>
          <html:hidden property="<%=p2%>"/>
          <html:hidden property="<%=p3%>"/>
          <% 
             neo.phoenix.base.RelatedObject relObj = form.getAllUserGroup(key);
             String name = relObj.getAttribute("name");
             String pubId = relObj.getPublicationId();
          %>
          <template:call file="../base/presentUserGroup.jsp">
            <template:parameter key="external" value="false" />
            <template:parameter key="pubId" value="<%=pubId%>" />
            <template:parameter key="groupName" value="<%=name%>" />
            <template:parameter key="readOnly" value="true" />
            <template:parameter key="displayedAttributes" value="icon,name,publication" />
          </template:call>
        </tr>
      </logic:iterate>
    </table>
  <% } %>
<input type="hidden" name="submitButton" value="">
