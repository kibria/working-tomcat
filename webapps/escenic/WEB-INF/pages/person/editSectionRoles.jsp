<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<bean:define id="publication" 
             name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<bean:define id="form" name="neo.phoenix.person.PersonForm" type="neo.phoenix.person.PersonForm"/>
<bean:define id="checker" 
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />

<h3><bean:message key="t.Section_roles"/></h3>
<%-- make this a tag or something like that --%>
<%
    java.util.Collection roles = new java.util.HashSet(neo.phoenix.base.RoleUtil.getInstance().getSectionRoles());
%>
<% 
  neo.xredsys.api.Person person = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPerson(Integer.parseInt(form.getId()), Integer.parseInt(form.getPubId()));
  boolean canEditUser = checker.isGlobalPublicationAdmin(person.getOwnerPublicationId());
  String canEditAsString = String.valueOf(canEditUser); 
  boolean isAdmin = false;
  String userName = form.getUserName();
  String pubName = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPublication(Integer.parseInt(form.getPubId())).getName();
  boolean isReadOnly = neo.util.StringUtil.getBoolean(form.getReadOnly());
  if(isReadOnly && neo.util.StringUtil.getBoolean(form.getEditRoles())){
    isReadOnly = false;
  }
  if(userName.equals(pubName+"_admin")||isReadOnly){
    isAdmin = true;
    if(person.getOwnerPublicationId()!=publication.getId()){
      isAdmin = false;
    }
  }
  java.util.List roleList = new java.util.ArrayList();
  roleList.add(neo.phoenix.access.AccessChecker.ADMINISTRATOR);   
  roleList.add(neo.phoenix.access.AccessChecker.USER_ADMIN);
  roleList.add(neo.phoenix.access.AccessChecker.EDITOR);
  roleList.add(neo.phoenix.access.AccessChecker.JOURNALIST);
  roleList.add(neo.phoenix.access.AccessChecker.READER);
  roleList.add(neo.phoenix.access.AccessChecker.FORUM_ADMIN);
  request.setAttribute("roleList",roleList);
%> 

<table class="listing" cellpadding="0" cellspacing="0">
  <tr class="labels">
    <th>
      <bean:message key="t.Roles"/>:
    </th>
    <logic:iterate id="role" type="java.lang.String" name="roleList">
      <%if(roles.contains(role)){%>
        <th>
        	 <% String key = "r." + role; %>
      	<bean:message key="<%=key%>"/>		
        </th>
      <%}%>
    </logic:iterate>
  </tr>
  <%
    java.util.List rel = form.getRelatedObjects();
    
    if(rel==null||rel.size()==0){   
      java.util.Collection sections = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getNonInheritSections(publication.getId());
      java.util.Iterator i = sections.iterator();
      while(i.hasNext()){
        neo.xredsys.api.Section section = (neo.xredsys.api.Section)i.next();
        if(!checker.isUserAdmin(section)){
          continue;
        }
        neo.xredsys.api.IOHashKey secKey = section.getHashKey();
        neo.phoenix.base.RelatedObject current = null;
        if(!form.containsRelatedObject(secKey)){
          current = form.addRelatedObject(secKey);
        }else{   
          current = form.getRelatedObject(secKey);
        }
      }
    }    
  %>           
  <logic:iterate name="neo.phoenix.person.PersonForm" property="relatedObjects" id="item" >
    <% String p1 = "relatedObject(" + item + ").id"; 
    String p2 = "relatedObject(" + item + ").type"; 
    String p3 = "relatedObject(" + item + ").publicationId"; 
    String p4 = "relatedObject(" + item + ").attributeNames";
    %>
    <html:hidden property="<%=p1%>"/>
    <html:hidden property="<%=p2%>"/>
    <html:hidden property="<%=p3%>"/>
    <bean:define id="sectionId" name="form" property="<%=p1%>" type="java.lang.String"/>
    <tr>
      <td>
      <% neo.xredsys.api.Section section = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getSection(Integer.parseInt(sectionId));
      %>
      <template:call file="../base/presentSection.jsp">
        <% 
           String pubId = section.getOwnerPublicationId() + "";       
        %>
        <template:parameter key="sectionId" value="<%=sectionId%>" />
        <template:parameter key="noTable" value="true" />
        <template:parameter key="external" value="true" />
        <template:parameter key="pubId" value="<%=pubId%>" />
        <template:parameter key="showPath" value="true"/>
      </template:call>
      </td>
      <logic:iterate id="role" name="roleList" type="java.lang.String" >
      <%if(roles.contains(role)){%>
        <td>
          <% String key = "relatedObject(" + item + ").attribute("+ role + ")"; %>
          <html:checkbox property="<%=key%>" disabled="<%=isAdmin%>"/>
          <%if(isAdmin){%>
            <html:hidden property="<%=key%>"/>
          <%}%>
        </td>
      <%}%>  
      </logic:iterate>
    </tr>
  </logic:iterate>
</table>
