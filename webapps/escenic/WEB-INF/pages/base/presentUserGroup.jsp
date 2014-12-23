<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<bean:define id="groupName" name="groupName" type="java.lang.String" />
<bean:define id="publication" 
             name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<bean:define id="checker" 
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<%
  String pubId = (String)request.getAttribute("pubId"); 
  if(pubId==null||pubId.length()==0){
    pubId = publication.getId() + "";
  }
  String displayed = (String)request.getAttribute("displayedAttributes");
  if(displayed==null){
    displayed="name,publication,view";
  }

  boolean readOnly = neo.util.StringUtil.getBoolean((String)request.getAttribute("readOnly"));
  
  int index = groupName.indexOf(":");
  if(index>0){
    pubId = groupName.substring(index+1); 
    groupName = groupName.substring(0,index);
  }
  request.setAttribute("pubId",pubId);
  neo.xredsys.api.UserGroup group = null;
  try{
    group = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getUserGroup(groupName,Integer.parseInt(pubId));
    request.setAttribute("group",group);
  }catch(neo.xredsys.api.NoSuchObjectException nsoe){
  }

  String external = (String)request.getAttribute("external");
  String editUrl = null;
  boolean isExternal = false;
  boolean isLocked = false; 
  String viewUrl = null;
  boolean canView = false;
  String imageSrc = null;
  if(external!=null&&external.equalsIgnoreCase("true")){
    isExternal = true;
  }
  boolean canModify = false;
  if(group!=null){
     neo.phoenix.base.WorkItemManager workItemManager = (neo.phoenix.base.WorkItemManager) session.getAttribute("WorkItemManager");
     if (group.isLocked()) {
      isLocked = true;
      neo.phoenix.base.WorkItem item = null;
      if(workItemManager!=null){
       item = workItemManager.findWorkItem("userGroup", group.getName()+":"+group.getOwnerPublicationId());
      }
       if (item != null) {
         editUrl = "/base/restoreWork.do?id=" + item.getId();
       } else {
         //editUrl = null;
       }
     }else if(checker.isGlobalPublicationAdmin(publication.getId())){
        if(isExternal){
          editUrl = "javascript:submitForm('external:/usergroup/edit.do?name="+group.getName()+"&pubId="+pubId+"')";
        }else{
          editUrl = "/userGroup/edit.do?name="+group.getName()+"&pubId="+pubId;
        }
        canModify = true;
      }else if(checker.isUserAdmin()){
        editUrl = "/userGroup/edit.do?name="+group.getName()+"&pubId="+pubId+"&readOnly=true&editRoles=true"; 
        canModify = true;
      }
    viewUrl = "/userGroup/edit.do?name="+group.getName()+"&readOnly=true&pubId="+pubId;
    canView = false;
    //viewUrl = null;
  
    imageSrc = "/images/users.gif";
    if(group.getOwnerPublicationId()!=publication.getId()){
      imageSrc = "/images/qw/guest_16x16.png";
    }
    if(readOnly||group.getOwnerPublicationId()<0){
      editUrl = null;
      canModify = false;
      canView = false;
      viewUrl = null;
    }
    request.setAttribute("editUrl",editUrl);
  }
%>
<%
  java.util.StringTokenizer token = new java.util.StringTokenizer(displayed,",");
  while(token.hasMoreTokens()){
    String next = token.nextToken();
    if(group==null){
      %><td>&nbsp;</td><%
      continue;
    }
    if(next.equals("name")){%>
      <td align="left">
        <% if (editUrl != null) { %>
          <html:link page='<%= editUrl  %>'>
            <%=group.getName()%>
          </html:link>
        <% } else if(isLocked){ %>
          <html:img border="0" page="/images/qw/lock_16x16.png" />
          <%=group.getName()%>
        <% }else{ %>
          <%=group.getName()%>
        <%}%>
      </td>
    <%}else if(next.equals("view")){%>
      <td>
        <% if (viewUrl != null) { %>
          <html:link page='<%= viewUrl  %>'>
            <bean:message key="l.view_usergroup"/>
          </html:link>
        <% } %>
      </td>
    <%}else if(next.equals("publication")){%>
      <td>
        <%if(group.getOwnerPublicationId()>0){%> 
          <%=neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPublication(group.getOwnerPublicationId()).getName()%>
        <%}else{%>
          &nbsp;
        <%}%>
      </td>
    <%}%>
  <%}%>
