<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page import="neo.xredsys.api.Section,
                 neo.xredsys.api.VirtualSection"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.TreeSet"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-view" prefix="view" %>
<script language="JavaScript1.2"><!--

function toggleVisibility(elementname){
  element = document.getElementById(elementname);
  if(element){
    if(element.className == ''){
      element.className = 'invisible';
    }else{
      element.className = '';
    }
  }
}
// -->
</script>

<input type="hidden" name="submitButton" value="success">

<input type="hidden" name="validateField" value="none">
<input type="hidden" name="validateButton" value="success">
<div class="error"><html:errors property="global" /></div>
<%  String sectionId = request.getParameter("id");
  if(neo.util.StringUtil.isEmpty(sectionId)){
    sectionId = (String)request.getAttribute("id");
  }
  request.setAttribute("id",sectionId);
%>
<section:use sectionId="<%=sectionId%>">
<bean:define id="section" name="section" type="neo.xredsys.api.Section" />
<bean:define id="checker" 
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<input type="hidden" name="validateInputAction" value="/section/view.do?id=<%=sectionId%>">
<% 
   boolean isLocked = false;
   String editLink = "/section/edit.do?id=" + section.getId();
   String editProperties = "/section/editProperties.do?id=" + section.getId();
   neo.phoenix.base.WorkItemManager workItemManager = (neo.phoenix.base.WorkItemManager) session.getAttribute("WorkItemManager");
   if (section.isLocked()) {
     neo.phoenix.base.WorkItem item = null;
     neo.phoenix.base.WorkItem itemProperties = null;
     if(workItemManager!=null){
      item = workItemManager.findWorkItem("section",String.valueOf(section.getId()));
      itemProperties = workItemManager.findWorkItem("sectionProperties",String.valueOf(section.getId()));
     }
     if (item != null) {
       editLink = "/base/restoreWork.do?id=" + item.getId();
     }
     if (itemProperties != null) {
       editProperties = "/base/restoreWork.do?id=" + itemProperties.getId();
     }
     if (item == null && itemProperties == null) {
      isLocked = true;
      editProperties = null;
      editLink = null;
     }
   }
%>
<%if(isLocked){%>
  <%String onclick="unlock('"+section.getId()+"','"+section.getObjectType()+"')";%>
  <html:img titleKey="t.Unlock" onclick="<%=onclick%>" border="0" src='<%= request.getContextPath()+"/images/qw/lock_16x16.png"%>' />
<%}%>
<% boolean isVirtual = section instanceof neo.xredsys.api.VirtualSection; %>
<table>
<tr><th class="view-propertyname" align="left"><bean:message key="t.Property"/></th><th class="view-propertyvalue" align="left"><bean:message key="t.Value"/></th></tr>
<%-- <tr><td class="view-propertyname"><bean:message key="t.Section_Id"/></td><td class="view-propertyvalue"><%=section.getId()%></td><td></td></tr> --%>
<%-- <tr><td class="view-propertyname"><bean:message key="t.Section_name"/></td><td class="view-propertyvalue"><section:name /></td></tr>--%>
<tr><td class="view-propertyname"><bean:message key="t.Section_unique_name"/></td><td class="view-propertyvalue"><bean:write name="section" property="uniqueName" /></td></tr>
<tr><td class="view-propertyname"><bean:message key="t.Directory_name"/></td><td class="view-propertyvalue"><bean:write name="section" property="directoryName" /></td></tr>
<tr><td class="view-propertyname"><bean:message key="t.Section_Url"/></td><td class="view-propertyvalue"><a href="<%=section.getUrl()%>" style="text-decoration:underline" target="escenicPreview"><%=section.getUrl()%></a></td></tr>
<%--<tr><td class="view-propertyname"><bean:message key="t.Section_Path"/></td><td class="view-propertyvalue"><%=section.getPath()%></td></tr>--%>
<tr><td class="view-propertyname"><bean:message key="t.Inherit_access"/></td><td class="view-propertyvalue">
<logic:equal name="section" property="inheritAccess" value="true"><bean:message key="t.Yes"/></logic:equal>
<logic:equal name="section" property="inheritAccess" value="false"><bean:message key="t.No"/></logic:equal>
<%--<bean:write name="section" property="inheritAccess" />--%></td></tr>
<tr><td class="view-propertyname"><bean:message key="t.Section_hidden"/></td><td class="view-propertyvalue">
<logic:equal name="section" property="hidden" value="true"><bean:message key="t.Yes"/></logic:equal>
<logic:equal name="section" property="hidden" value="false"><bean:message key="t.No"/></logic:equal></td></tr>
<tr><td class="view-propertyname"><bean:message key="t.State"/></td><td class="view-propertyvalue">
  <bean:message key="<%=\"s.SectionStateType.\" + neo.xredsys.api.IOAPI.getAPI().getTypeManager().getType(neo.xredsys.api.Type.SectionStateType, section.getState()).getName() %>" />
</td></tr>
<tr><td class="view-propertyname"><bean:message key="t.Priority"/></td><td class="view-propertyvalue"><bean:write name="section" property="priority" /></td></tr>
<tr><td class="view-propertyname"><bean:message key="t.Is_agreement_required"/></td>
<td class="view-propertyvalue">
<%-- <logic:equal name="section" property="isAgreementRequired" value="true">YO!<bean:message key="t.Yes"/></logic:equal> --%>
<% if (section.isAgreementRequired()) { %>
       <bean:message key="t.Yes" />
<% } else { %>
       <bean:message key="t.No" />
<% } %></td></tr>
<% if(section.isAgreementRequired()){ %>
  <tr><td class="view-propertyname"><bean:message key="t.AgreementInfo"/></td><td class="view-propertyvalue"><% if(section.getAgreementInfo()!= null) out.print(section.getAgreementInfo().getAgreementInfo());%></td></tr>
<% } %>
<% if(!(section instanceof neo.xredsys.api.VirtualSection)){ %>
  <tr><td class="view-propertyname"><bean:message key="t.Shared"/></td><td class="view-propertyvalue">
    <logic:equal name="section" property="isVirtualSource" value="true">
       <bean:message key="t.Yes" />
    </logic:equal>
    <logic:equal name="section" property="isVirtualSource" value="false"> 
       <bean:message key="t.No" />
    </logic:equal>
</td></tr>
<% }else{
    neo.xredsys.api.VirtualSection virtual = (neo.xredsys.api.VirtualSection)section;%>
    <tr><td class="edit-propertyname"><bean:message key="t.Shadow_source"/></td>
      <section:use sectionId="<%=String.valueOf(virtual.getVirtualSource())%>">
        <td class="view-propertyvalue" title="<%=section.getUrl()%>">
          <%=section.getName()%>&nbsp;(<%=virtual.getVirtualSource()%>)
        </td>
      </section:use>
    </tr>
    
<% } %>
  <%
    TreeSet declaredProperties = new TreeSet(section.getDeclaredParameterNameSet());
    TreeSet inheritedProperties = new TreeSet(section.getParameterNameSet());
    inheritedProperties.removeAll(declaredProperties);
    
    if(declaredProperties.size()>0){
  %>
    <tr>
      <td class="view-propertyname">
        <a href="javascript:void(0);" onclick="javascript:toggleVisibility('declaredProperties'); return false;">
          <bean:message key="t.view_declared_properties"/>
        </a>
      </td>
      <td>
        <div id="declaredProperties" class="invisible">
          <table>
            <%
              Iterator declared = declaredProperties.iterator();
              while(declared.hasNext()){
                String key = (String)declared.next();
                %>
                <tr>
                  <td class="view-propertyname"><%=key%></td>
                  <td class="view-propertyvalue"><%=section.getDeclaredParameter(key)%></td>
                </tr>
              <%}%>
          </table>
        </div>
      </td>
    </tr>
  <%}%>
  <%if(inheritedProperties.size()>0){%>
<tr>
  <td class="view-propertyname">
    <a href="javascript:void(0);" onclick="javascript:toggleVisibility('inheritedProperties'); return false;">
      <bean:message key="t.view_inherited_properties"/>
    </a>
  </td>
  <td>
    <div id="inheritedProperties" class="invisible">
      <table>
            <%
          Iterator inherited = inheritedProperties.iterator();
          while(inherited.hasNext()){
            String key = (String)inherited.next();
                %>
            <tr>
              <td class="view-propertyname"><%=key%></td>
              <td class="view-propertyvalue"><%=section.getParameter(key)%></td>
            </tr>
              <%}%>
      </table>
    </div>
  </td>
</tr>
  <%}%>
</table>

<br>
<% if(checker.isAdministrator(section)&&!isLocked){ %>
  
  <table><tr><td>
  <html:link styleClass="global-button" page="<%=editLink%>"><bean:message key="b.Edit"/></html:link></td><td> <bean:message key="t.this_section"/>.</td></tr></table>
<% } %>
<% if(checker.isAdministrator(section)&&editProperties!=null){ %>
  
  <table><tr><td>
  <html:link styleClass="global-button" page="<%=editProperties%>"><bean:message key="b.Edit_section_properties"/></html:link></td><td> <bean:message key="t.this_section"/>.
  </td></tr></table>
<% } %>

<% String url = null;%>
<hr width="95%" align="left">

<% if(checker.isAdministrator(section)){ %>
  <table><tr><td>
  <% url = "/section/new.do?id=" + section.getId(); %>
  <html:link styleClass="global-button" page="<%=url%>"><bean:message key="b.create"/></html:link></td><td><bean:message key="t.a_sub_section"/>. </td></tr></table>
  <% url = "/section/new.do?id=" + section.getId()+"&isVirtual=true"; %>
      <table><tr><td>
      <html:link styleClass="global-button" page="<%=url%>"><bean:message key="b.create"/></html:link></td><td><bean:message key="t.a_shadow_sub_section"/>. </td></tr></table>
  <% if(section instanceof neo.xredsys.api.VirtualSection){ %>
    <% url = "/section/updateVirtualSectionTree.do?id=" + section.getId(); %>
    <table><tr><td>
      <html:link styleClass="global-button" page="<%=url%>"><bean:message key="b.update"/></html:link></td><td> <bean:message key="t.the_shadow_section_tree"/>.</td></tr></table> 
  <% } %>
<% } %>

<% if(checker.isUserAdmin(section)&&!section.getInheritAccess()){ %>
  
  <table><tr><td>
  <% url = "/section/editMembers.do?id=" + section.getId(); %>
  <html:link styleClass="global-button" page="<%=url%>"><bean:message key="b.access_control"/></html:link></td><td><bean:message key="t.edits_the_access_to_this_section"/>.  </td></tr></table>
<% } %>

<hr width="95%" align="left">



<% if(checker.isAdministrator(section)&&!isLocked&&section.getParent()!=null&&!"default".equalsIgnoreCase(section.getType().getName())){ %>
  
  <% url = "/section/delete.do?id=" + section.getId()+"&noLock=true"; %>
  <table><tr><td><html:link styleClass="global-button" page="<%=url%>"><bean:message key="b.delete"/></html:link></td><td> <bean:message key="t.this_section_and_all_subsections"/>.</td></tr></table>
<% } %>

<% if(checker.isAdministrator(section)){ %>
  <%if(!isVirtual){%>
    <table><tr><td>
    <% url = "/section/moveArticles.do?fromId=" + section.getId(); %>
      <html:link styleClass="global-button" page="<%=url%>"><bean:message key="b.move_articles"/></html:link></td><td> <bean:message key="t.in_this_section"/></td></tr></table>
    <table><tr><td>
    <% url = "/section/deleteArticles.do?id=" + section.getId(); %>
      <html:link styleClass="global-button" page="<%=url%>"><bean:message key="b.delete_articles"/></html:link></td><td> <bean:message key="t.in_this_section"/></td></tr></table>
  <%}%>
  <hr width="95%" align="left">
  <% if(section.getSubSections().length>1){%>
    <table><tr><td>
    <% url = "/section/changeSubSectionSequence.do?id=" + section.getId(); %>
      <html:link styleClass="global-button" page="<%=url%>"><bean:message key="b.change_sequence"/></html:link></td><td> <bean:message key="t.of_subsections"/>. </td></tr></table>
      <hr width="95%" align="left">
  <%}%>  
<%}%>


<hr width="95%" align="left">

<table><tr><td class="global-button"><a href="javaScript:submitForm('section-archive')" class="global-button"><bean:message key="b.back"/></a></td></tr></table>

<hr width="95%" align="left">
 <table>
  <tr><th align="left"><bean:message key="h.Subsections"/>:</th></tr>
  <bean:define id="subs" name="section" property="subSections"/>
  <logic:iterate id="currentSubSec" name="subs" type="neo.xredsys.api.Section">
    <tr>
      <td>
        <table>
          <tr>
            <template:call file="../base/presentSection.jsp">
              <template:parameter key="sectionId" value="<%=String.valueOf(currentSubSec.getId())%>" />
              <template:parameter key="pubId" value="<%=String.valueOf(currentSubSec.getOwnerPublicationId())%>" />
            </template:call>
          </tr>
        </table>
      </td>
    </tr>
  </logic:iterate>
 </table>
</section:use>
