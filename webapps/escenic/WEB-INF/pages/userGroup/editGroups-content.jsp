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
  function enableShowAllGroups(value){
    var name = "showAllGroups";
    setField(name,value);
    submitForm("editGroups");
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

<%@include file="../base/relatedObjects.jspf" %>
<%@include file="hiddenProps.jspf" %>
<%@include file="../person/hiddenTags.jspf" %>
<%@include file="../person/hiddenContentTypes.jspf" %>
<%@include file="hiddenRelations.jspf" %>
<%@include file="hiddenMembers.jspf" %>
<%@include file="hiddenGlobalRoles.jspf" %>

<input type="hidden" name="validateButton" value="editGroups"/>
<input type="hidden" name="validateButton" value="save"/>
<input type="hidden" name="validateInput"  value="editGroups"/>
<input type="hidden" name="validateField" value="none" />
<html:hidden property="parentWorkItemId"/>
<h3></h3>
 <table><tr>
  <%
    neo.xredsys.api.UserGroup group = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getUserGroup(form.getName(),Integer.parseInt(form.getPubId()));
    boolean canAddGroup = true;
    if(canAddGroup && !readOnly){ 
  %>
    <td><a class="global-button"  href="javascript:submitForm('findGroups')"><bean:message key="b.find_groups"/></a></td>
  <% } 
  String value = null;
  if(canAddGroup){
    value="userGroup";
  }
  %>
  <html:hidden property="include" value="<%=value%>"/>
  <% if(value!=null){ %>
    <%-- <td> <a class="global-button"  href="javascript:submitForm('addFromMyClips')">Add Groups From Clips</a></td> --%> 
  <%}%>
  </tr>
</table>
<input type="hidden" name="submitButton" value="">



<% int pubID = publication.getId(); %>
  <bean:define id="groups" name="neo.phoenix.userGroup.UserGroupForm" property="userGroups" scope="request" type="java.util.Collection"/>
  <h3><bean:message key="t.Groups"/></h3>
  <table>
    <% if(groups.size()>0){%>
      <logic:iterate name="groups" id="key" type="java.lang.String">
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
        <% String remove = "action:/userGroup/RemoveGroupFromUserGroup.do?groupName="+name+"&pubId="+pubId;%>

          <template:call file="../base/presentUserGroup.jsp">
            <% String groupName = item.getName() + ""; 
               String pub = item.getOwnerPublicationId() + "";   
            %>
            <template:parameter key="external" value="true" />
            <template:parameter key="pubId" value="<%=pub%>" />
            <template:parameter key="groupName" value="<%=groupName%>" />
            <template:parameter key="readOnly" value="true" />
          </template:call>
          <% if(!readOnly){ %> 
            <td><a href="javascript:submitForm('<%=remove%>')">
              <html:img page="/images/qw/delete.png" border="0"/>
            </td></a>
          <% } %>
        </tr> 
      </logic:iterate>
     <% } %> 
    </table>
    <%
      if(neo.util.StringUtil.getBoolean(form.getShowAllGroups())){
      %>  
      <table>
        <tr><th><bean:message key="t.All_groups"/></th></tr>
            <%
              java.util.Iterator it = groups.iterator();
              javax.servlet.jsp.JspWriter writer = pageContext.getOut(); 
              while(it.hasNext()){
                java.util.HashSet visited = new java.util.HashSet();
                String key = (String)it.next();
                neo.phoenix.base.RelatedObject relObj = form.getUserGroup(key);
                neo.xredsys.api.UserGroup tmpGroup = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getUserGroup(relObj.getAttribute("name"),Integer.parseInt(relObj.getPublicationId()));
                printChildren(tmpGroup,writer,"--",visited);
              }
          %>
        <tr><td><a class="global-button"  href="javascript:enableShowAllGroups('false')"><bean:message key="b.hide_all_groups"/></a></td></tr>
      </table >
      <%}else{%>
        <table><tr><td><a class="global-button"  href="javascript:enableShowAllGroups('true')"><bean:message key="b.show_all_groups"/></a></td></tr></table>
      <%}%>
</p>
<html:hidden property="showAllGroups"/>
<%!
  public void printChildren(neo.xredsys.api.UserGroup group, javax.servlet.jsp.JspWriter writer, String indent,java.util.HashSet visited){
    try{
      java.util.Collection children = group.getUserGroupMembers();
      writer.print("<tr><td>"+indent+group.getName()+"</td></tr>");
      if(!visited.contains(group)){
        visited.add(group);
        java.util.Iterator i = children.iterator();
        while(i.hasNext()){
          printChildren((neo.xredsys.api.UserGroup)i.next(), writer, indent + indent,visited);            
        }
      }
    }catch(Exception e){
      e.printStackTrace();
    }
  }
%>
