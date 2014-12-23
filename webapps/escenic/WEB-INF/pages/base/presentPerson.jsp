<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%@ include file="/WEB-INF/pages/base/trim.jspf" %> 
<%-- END STANDARD HEADER --%>
<%@ page import="neo.xredsys.api.User,
                 neo.xredsys.api.IOAPI,
                 neo.xredsys.api.Type"%>
<%@ page import="neo.util.StringUtil" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%@ include file="/WEB-INF/pages/base/lockUtil.jspf" %>
<bean:define id="personId" name="personId" type="java.lang.String" />
<bean:define id="publication" 
             name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<bean:define id="checker" 
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<%
  boolean isPopup = neo.util.StringUtil.getBoolean((String)request.getAttribute("popup"),false);
  String displayed = (String)request.getAttribute("displayedAttributes");
  if(displayed==null){
    displayed="id,name,lastModified,publication,view";
  }
  boolean trimName = StringUtil.getBoolean((String) request.getAttribute("trimName"), false);

  String titleattributes = (String)request.getAttribute("titleAttributes");
  if(titleattributes==null){
    titleattributes="name,publication";
  }
  
  String tag = (String)request.getAttribute("tag");
  if (neo.util.StringUtil.isEmpty(tag)) {
    tag = "<td>";
  }
  final String endtag = tag.substring(0,1) + "/" + tag.substring(1);
  final String begintagstart = tag.substring(0,tag.lastIndexOf(">"));
  final String begintagend = ">";
  

  String tmp = (String)request.getAttribute("showAttributes");
  boolean showAttribs = false;
  if(tmp!=null){
    showAttribs = neo.util.StringUtil.getBoolean(tmp);
  }
  boolean hideEditLink = true;
  tmp = (String)request.getAttribute("hideEditLink");
  if(tmp!=null){
    hideEditLink = neo.util.StringUtil.getBoolean(tmp);
  }
  String pubId = (String)request.getAttribute("pubId"); 
  if(pubId==null||pubId.length()==0){
    pubId = publication.getId() + "";
  }
  int index = personId.indexOf(":");
  if(index>0){
    pubId = personId.substring(index+1); 
    personId = personId.substring(0,index);
  }
  request.setAttribute("pubId",pubId);
  neo.xredsys.api.Person person = null;
  try{
    person = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPerson(Integer.parseInt(personId),Integer.parseInt(pubId));
    request.setAttribute("person",person);
  }catch(neo.xredsys.api.NoSuchObjectException nsoe){
  }
  String external = (String)request.getAttribute("external");
  String editUrl = null;
  boolean isExternal = false;
  boolean isLocked = false;
  boolean isLockedByMe = false;
  String viewUrl = null;
  if(external!=null&&external.equalsIgnoreCase("true")){
    isExternal = true;
  }
  boolean canModify = false;
  User user = null;
  if(person!=null && person.getId()>0){
    
    if(checker.isEditable(person)){
      editUrl = "/person/edit.do?id="+person.getId()+"&pubId="+pubId;
      canModify = true;
    }else if(checker.isUserAdmin()&&person.isUser()){
      editUrl = "/person/edit.do?id="+person.getId()+"&pubId="+pubId+"&readOnly=true&editRoles=true"; 
      canModify = true;
    }
     neo.phoenix.base.WorkItemManager workItemManager = (neo.phoenix.base.WorkItemManager) session.getAttribute("WorkItemManager");
     if (person.isLocked()) {
      isLocked = true;
      neo.phoenix.base.WorkItem item = null;
      if(workItemManager!=null){
       item = workItemManager.findWorkItem("person", String.valueOf(person.getId()));
      }
       if (item != null) {
         editUrl = "/base/restoreWork.do?id=" + item.getId();
         isLockedByMe = true;
       } else {
         editUrl = null;
       }
     }
      viewUrl = "/person/edit.do?id="+person.getId()+"&pubId="+pubId+"&readOnly=true";
      if(editUrl == null){
        editUrl = viewUrl;
      }
      if(hideEditLink){
        editUrl=null;
        viewUrl=null;
      }
      if(editUrl!=null&&isPopup){
        editUrl="javascript:submitParentWindow('external:"+editUrl+"')";
        viewUrl="javascript:submitParentWindow('external:"+viewUrl+"')";
      }
      if(person.isExternal()&&!neo.util.StringUtil.getBoolean(publication.getFeature(neo.xredsys.api.FieldConstants.EDITEXTERNALPERSON))){
        editUrl=null;
        viewUrl=null;
      }
      String imageSrc = "/images/qw/person_16_wh.png";
      if(person.getOwnerPublicationId()!=publication.getId()){
        imageSrc = "/images/qw/guest_16x16.png";
      }
      if(!person.isUser()){
        imageSrc = "/images/qw/person_16_wh.png";
      }
      if(person.isUser()&&neo.util.StringUtil.getBoolean((String)request.getAttribute("loadUser"),false)){
        user = IOAPI.getAPI().getObjectLoader().getUser(person,-1);  
      }
  }
%>
<%
  StringBuffer tmpTitle = new StringBuffer();
  java.util.StringTokenizer titleTokens = new java.util.StringTokenizer(titleattributes,",");
  while (titleTokens.hasMoreTokens()) {
    String next = titleTokens.nextToken();
    if (next.equals("id")) {
      tmpTitle.append(org.apache.struts.util.RequestUtils.message(pageContext, null, null, "t.id", null));
      tmpTitle.append(": ");
      tmpTitle.append(person.getId());
    } else if (next.equals("name")) {
      tmpTitle.append(person.getName());
    } else if (next.equals("lastModified")) {
      tmpTitle.append(DateFormat.getDateInstance(DateFormat.SHORT).format(person.getLastModified()));
    } else if (next.equals("publication")) {
      if (person.getOwnerPublicationId() > 0) {
        tmpTitle.append(neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPublication(person.getOwnerPublicationId()).getName());
      }
    } else if (next.equals("failedLoginDate")) {
      if (person.isUser()) {
        tmpTitle.append(DateFormat.getDateInstance(DateFormat.SHORT).format(user.getLastFailedLoginAttempt()));
      }
    } else if (next.equals("loginDate")) {
      if(person.isUser()){
        tmpTitle.append(DateFormat.getDateInstance(DateFormat.SHORT).format(user.getLastLogin()));
      }
    } else if (next.equals("status")) {
      if(person.isUser()) {
        String key = null;
        Type state = user.getStatus();
        if(state.getName().equals("enabled")){
          key="t.User_status_enabled";
        }else if(state.getName().equals("disabled")){
          key="t.User_status_disabled";
        }else if(state.getName().equals("suspended")){
          key="t.User_status_suspended";
        }else if(state.getName().equals("banned")){
          key="t.User_status_banned";
        }
        tmpTitle.append(org.apache.struts.util.RequestUtils.message(pageContext, null, null, key, null));
      }
    }
    if (titleTokens.hasMoreTokens()) {
      tmpTitle.append(", ");
    }
  }

  String title = tmpTitle.toString();

  java.util.StringTokenizer token = new java.util.StringTokenizer(displayed,",");
  while(token.hasMoreTokens()){
    String next = token.nextToken();
    if(person==null||person.getId()<0){
    %><%=begintagstart%> class='nonexistent' <%=begintagend%>&nbsp;<%=endtag%><%
    continue;
  }

    if(next.equals("name")){%>
      <% String personName = trimName ? trim(person.getName(), 30) : person.getName(); %>
      <%=begintagstart%> title="<%=title%>" class='name' <%=begintagend%>
      <% if(isLocked && !isLockedByMe) {%>
            <%if(canModify){%>
              <%String onclick="unlock('"+person.getId()+"','"+person.getObjectType()+"')";%>
              <html:img title="<%=getLockInfoFromObject(person,pageContext)%>" onclick="<%=onclick%>" border="0" src='<%= request.getContextPath()+"/images/qw/lock_16x16.png"%>' />
            <%}else{%>
              <html:img border="0" src='<%= request.getContextPath()+"/images/qw/lock_16x16.png"%>' />
            <%}%>
       <%}%>
       <% if(editUrl!=null) { %>
            <%if(isPopup){%>
              <html:link href='<%= editUrl  %>'>
                <%=personName%>
              </html:link>
            <%}else{%>
              <%if(isExternal) {%>
                <a href="javascript:submitForm('external:<%=editUrl%>')">
                  <%=personName%>
                </a>
              <%} else {%>
                <html:link page='<%= editUrl  %>'>
                  <%=personName%>
                </html:link>
              <%}%>
            <%}%>
        <%}else { %>
            <%=personName%>
        <%}%>
      <%=endtag%>
    <%}else if(next.equals("id")){%>
      <%=begintagstart%> title="<%=title%>" class='id' <%=begintagend%><%=person.getId()%><%=endtag%>
    <%}else if(next.equals("view")){%>
      <%=begintagstart%> title="<%=title%>" class='name' <%=begintagend%>
        <% if (viewUrl != null) { %>
            <%if(isPopup){%>
              <html:link href='<%= viewUrl  %>'>
                <bean:message key="l.view_person"/>
              </html:link>
            <%}else{%>
              <html:link page='<%= viewUrl  %>'>
                <bean:message key="l.view_person"/>
              </html:link>
            <%}%>
        <% }%>
      <%=endtag%>
    <%}else if(next.equals("lastModified")){%>
      <%=begintagstart%> title="<%=title%>" class='lastmodified' <%=begintagend%>
      <%=DateFormat.getDateInstance(DateFormat.SHORT).format(person.getLastModified())%>
      <%=endtag%>
    <%}else if(next.equals("publication")){%>
      <%=begintagstart%> title="<%=title%>" class='publication' <%=begintagend%>
        <%if(person.getOwnerPublicationId()>0){%>
          <%=neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPublication(person.getOwnerPublicationId()).getName()%>
        <%}else{%>
          &nbsp;
        <%}%>
      <%=endtag%>
    <%}else if(next.equals("failedLoginDate")){%>
      <%=begintagstart%> title="<%=title%>" class='failedlogindate' <%=begintagend%>
        <% if(person.isUser()){
        %>
        <%=DateFormat.getDateInstance(DateFormat.SHORT).format(user.getLastFailedLoginAttempt())%>
        <%}else{%>
          &nbsp;
        <%}%>
      <%=endtag%>
    <%}else if(next.equals("loginDate")){%>
      <%=begintagstart%> title="<%=title%>" class='logindate' <%=begintagend%>
        <% if(person.isUser()){
        %>
        <%=DateFormat.getDateInstance(DateFormat.SHORT).format(user.getLastLogin())%>
        <%}else{%>
          &nbsp;
        <%}%>
      <%=endtag%>
    <%}else if(next.equals("status")){%>
      <%=begintagstart%> title="<%=title%>" class='status' <%=begintagend%>
        <% if(person.isUser()){
          String key = null;
          Type state = user.getStatus();
          if(state.getName().equals("enabled")){
            key="t.User_status_enabled";
          }else if(state.getName().equals("disabled")){
            key="t.User_status_disabled";
          }else if(state.getName().equals("suspended")){
            key="t.User_status_suspended";
          }else if(state.getName().equals("banned")){
            key="t.User_status_banned";
          }
        %>
        <bean:message key="<%=key%>"/>
        <%}else{%>
          &nbsp;
        <%}%>
      <%=endtag%>
    <%}
  }
%>

