<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<bean:define id="sectionId" name="sectionId" type="java.lang.String" />
<bean:define id="publication" 
             name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<bean:define id="checker" 
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<%@ include file="/WEB-INF/pages/base/lockUtil.jspf" %>
<%
  boolean isPopup = neo.util.StringUtil.getBoolean((String)request.getAttribute("popup"),false);
  boolean displayIcon = neo.util.StringUtil.getBoolean((String)request.getAttribute("displayIcon"),true);
  boolean displayId = neo.util.StringUtil.getBoolean((String)request.getAttribute("displayIcon"),true);
  String pubId = (String)request.getAttribute("pubId"); 
  if(pubId==null||pubId.length()==0){
    pubId = publication.getId() + "";
  }
  int index = sectionId.indexOf(":");
  if(index>0){
    pubId = sectionId.substring(index+1); 
    sectionId = sectionId.substring(0,index);
  }
  request.setAttribute("pubId",pubId);
  neo.xredsys.api.Section section = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getSection(Integer.parseInt(sectionId));
  request.setAttribute("section",section);
  
  boolean showPath = neo.util.StringUtil.getBoolean((String)request.getAttribute("showPath"));
  boolean canModify = false;
//  if (checker.isEditor(section)) {
//    canModify = "true".equals((String)request.getAttribute("editpool"));
//  }
  neo.xredsys.api.Type published = neo.xredsys.api.IOAPI.getAPI().getTypeManager().getType(neo.xredsys.api.Type.SectionStateType,"published");
  neo.xredsys.api.Pool activePool = null;
  try {
    activePool = section.getActivePool();
  } catch (neo.xredsys.api.NoSuchObjectException nsoe) {
        // Section with no pool
  }
  String imageSrc = null;
  String alt = null;
  if(section instanceof neo.xredsys.api.VirtualSection){
    if(published.getId()!=section.getState()){
      imageSrc = "/images/qw/shadowsection_16_16.png";
      alt = "unpublished shadow section"; 
    }else{
      imageSrc = "/images/qw/shadowsection_16_16.png";
      alt = "shadow section";
    }
  }else{   
    if(published.getId()!=section.getState()){
      imageSrc = "/images/qw/section_notpublished_16_16.png";
      alt = "unpublished section"; 
    }else{
      imageSrc = "/images/qw/section_16_wh.png";
      alt = "section";
    }
  }
%>

<logic:notPresent name="noTable" scope="request">
  <td>
</logic:notPresent>
<% if(displayIcon) { %>
  <html:img border="0" page="<%=imageSrc%>" alt="<%=alt%>"/>
<%}%>
<logic:notPresent name="noTable" scope="request">
  </td>

  <td>
</logic:notPresent>



  <%
    neo.xredsys.api.Section accessCheck = section;
    if(section instanceof neo.xredsys.api.VirtualSection){
      accessCheck = ((neo.xredsys.api.VirtualSection)section).getVirtualAPISource();
    }
    boolean isLocked = false;
    String editLink = "";
    if (checker.isReader(accessCheck) && activePool != null) { 
     editLink = "redirect:/pool/edit.do?id="+section.getActivePool().getId();
     if (!checker.isEditor(section)){
       editLink = editLink + "&readOnly=true";
     }
     neo.phoenix.base.WorkItemManager workItemManager = (neo.phoenix.base.WorkItemManager) session.getAttribute("WorkItemManager");
     if (section.getActivePool().isLocked()) {
       neo.phoenix.base.WorkItem item = null;
       if(workItemManager!=null){
        item = workItemManager.findWorkItem("pool",String.valueOf(section.getActivePool().getId()));
       }
       if (item != null) {
         editLink = "redirect:/base/restoreWork.do?id=" + item.getId();
         if (!checker.isEditor(accessCheck)) {
           editLink = editLink + "&readOnly=true";
         }
       } else {
        isLocked = true;
        editLink = null;
       }
     }else{
       if(section instanceof neo.xredsys.api.VirtualSection){
        editLink = editLink + "&readOnly=true";
       }
     }

     if (isPopup) {
       editLink = null;
     } else {
       editLink = "javascript:submitForm('"+editLink+"')";
     }

    %>
    <%--   (code has been moved. here for reference only --%>
    <%--
    <% if(isLocked){%>
      <%if(checker.isEditor(accessCheck)){%>
        <%String onclick="unlock('"+section.getActivePool().getId()+"','"+section.getActivePool().getObjectType()+"')";%>
        [<html:img titleKey="t.Unlock" onclick="<%=onclick%>" border="0" src='<%= request.getContextPath()+"/images/qw/lock_16x16.png"%>' />]
      <%}else{%>
        [<html:img border="0" src='<%= request.getContextPath()+"/images/qw/lock_16x16.png"%>' />]
        <%}%>
    <%}else{%>
      [ <a href="javascript:submitForm('<%=editLink%>')"><bean:message key="t.Edit"/></a> ]
    <%}%>
    --%>
  <% } editLink = null; %>  



<%
  String toRender;
  if (showPath){
    toRender = getPath(section);
  } else {
    toRender = section.getName();
  }
  if(request.getAttribute("valueToBeDisplayed") != null){
    toRender = (String)request.getAttribute("valueToBeDisplayed");
  }
  String linkClass = "";
  if(request.getAttribute("linkClass") != null) {
    linkClass = (String)request.getAttribute("linkClass");
  }
%>



<logic:equal name="isSubmittingForm" value="true">
  <logic:equal name="external" value="true">
    <% if ( (editLink!=null||canModify) && activePool != null) { %>
      <% if (isLocked && canModify) { %>
        <%=toRender%>
        <%String onclick="unlock('"+section.getActivePool().getId()+"','"+section.getActivePool().getObjectType()+"')";%>
        <html:img title="<%=getLockInfoFromObject(section.getActivePool(),pageContext)%>" onclick="<%=onclick%>" border="0" src='<%= request.getContextPath()+"/images/qw/lock_16x16.png"%>' />
      <% } else {%>
        <a href="<%=editLink%>" class="<%=linkClass%>">
          <%=toRender%>
        </a>
      <% } %>
    <% }else{ %>
        <%=toRender%>
    <% } %>
  </logic:equal>
  <logic:notEqual name="external" value="true">
    <%=toRender%>
  </logic:notEqual>
</logic:equal>
<logic:notEqual name="isSubmittingForm" value="true">
  <% if((editLink!=null||canModify) && activePool != null){ %>
    <% if (isLocked && canModify) { %>
      <%=toRender%>
      <%String onclick="unlock('"+section.getActivePool().getId()+"','"+section.getActivePool().getObjectType()+"')";%>
      <html:img title="<%=getLockInfoFromObject(section.getActivePool(),pageContext)%>" onclick="<%=onclick%>" border="0" src='<%= request.getContextPath()+"/images/qw/lock_16x16.png"%>' />
    <% } else {%>
      <a href="<%=editLink%>" class="<%=linkClass%>">
        <%=toRender%>
      </a>
    <% } %>
  <% }else{ %>
    <%=toRender%>
  <% } %>
</logic:notEqual>



<% if(displayId) { %>
(<bean:message key="t.id"/>:<bean:write name="section" property="id"/>)
<%}%>
<logic:notPresent name="noTable" scope="request">
</td>
</logic:notPresent>
<%! 
 public String getPath(neo.xredsys.api.Section sec){
  StringBuffer path = new StringBuffer(sec.getName());
  while(sec.getParent()!=null){
    sec = sec.getParent();
    path.insert(0,sec.getName()+"/");
  }
  return path.toString();
 }
%>
