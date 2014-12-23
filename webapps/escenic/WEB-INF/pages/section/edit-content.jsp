<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page import="neo.xredsys.api.IOAPI"%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<div class="error"><html:errors property="global" /></div>
<bean:define id="checker" 
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<bean:define id="form" name="neo.phoenix.section.SectionForm" type="neo.phoenix.section.SectionForm"/>
<% boolean readOnly = neo.util.StringUtil.getBoolean(form.getReadOnly());%>
<% boolean isVirtualSection = neo.util.StringUtil.getBoolean(form.getIsVirtual());%>
  <html:hidden property="id" />
  <html:hidden property="parentWorkItemId" />
  <input type="hidden" name="validateButton" value="edit">
  <input type="hidden" name="validateButton" value="share">
  <input type="hidden" name="validateButton" value="save">
  <input type="hidden" name="validateButton" value="saveAndClose"/>
  <input type="hidden" name="validateInput"  value="edit">
  <input type="hidden" name="validateField" value="name" />
  <input type="hidden" name="validateField" value="directoryName" />
  <input type="hidden" name="validateField" value="agreementInfo" />
  <%if(isVirtualSection){ %>
    <input type="hidden" name="validateField" value="virtualTarget" />
  <% }%>
  <input type="hidden" name="validateField" value="uniqueName" />
  <html:hidden property="isVirtual"/>
  <html:hidden property="readOnly"/>
  <table>
  <tr><th align="left" class="edit-propertyname"><bean:message key="t.Property"/></td><th align="left" class="edit-propertyvalue"><bean:message key="t.Value"/></td><td>&nbsp;</td></tr>
  <tr><td class="view-propertyname"><bean:message key="t.id"/></td><td class="view-propertyvalue"><%=form.getId()%></td><td></td></tr>
<%--  <% if(isVirtualSection){ %>
    <tr><td class="edit-propertyname"><bean:message key="t.Section_name"/></td><td class="view-propertyvalue"><%=form.getName()%></td><td><html:errors property="name" /></td></tr>
    <html:hidden property="name"/>
  <%}else{%> --%>
    <tr><td class="edit-propertyname"><bean:message key="t.Section_name"/></td><td class="edit-propertyvalue"><html:text property="name" disabled="<%=readOnly%>"/></td><td><html:errors property="name" /></td></tr>
    <%if(readOnly){%>
      <html:hidden property="name"/>
    <%}%>
  <%--<%}%> --%>
    <%--hides edit uniquename for system-sections --%>
    <% 
      neo.xredsys.api.Section tmpSec = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getSection(form.getIdInt());
      boolean readOnlyUnique = readOnly;
      boolean isRoot = false;
      boolean hiddenInheritBox = readOnly;
      if(tmpSec.getParent()==null||tmpSec.getType().getName().equals("hidden")||
         tmpSec.getType().getName().equals("forum") || tmpSec.getType().getName().equals("all") ||
              !checker.isGlobalPublicationAdmin(tmpSec.getOwnerPublicationId())){
        readOnlyUnique = true;
        hiddenInheritBox = true;
      }
      if("frontpage".equals(tmpSec.getType().getName())) {
        isRoot = true;
      }
    %>
    <tr>
      <td class="edit-propertyname"><bean:message key="t.Section_unique_name"/></td>
      <td class="edit-propertyvalue">
        <%if(readOnlyUnique){%>
          <%=form.getUniqueName()%>
        <%}else{%>
          <html:text property="uniqueName" disabled="<%=readOnly%>"/>
        <%}%>
        </td>
        <td><html:errors property="uniqueName" /></td>
      </tr>
        
    <%if(readOnlyUnique){%>
      <html:hidden property="uniqueName"/>
    <%}%>
    <tr><td class="edit-propertyname"><bean:message key="t.Directory_name"/></td><td class="edit-propertyvalue"><html:text property="directoryName" disabled="<%=readOnly%>"/></td><td><html:errors property="directoryName" /></td></tr>
    <%if(readOnly){%>
      <html:hidden property="directoryName"/>
    <%}%>

    <tr><td class="edit-propertyname"><bean:message key="t.Section_Url"/></td><td class="edit-propertyvalue"><html:text property="url" disabled="<%=readOnly%>"/></td><td>(<bean:message key="t.Optional"/>) <html:errors property="url" /></td></tr>
    <%if(readOnly){%>
      <html:hidden property="url"/>
    <%}%>
  <%if(!readOnly){%>

  <tr><td class="edit-propertyname"> <bean:message key="t.Move_section"/> </td>
      <td class="edit-propertyvalue"><html:hidden property="parentId"/>
      <% if (!neo.util.StringUtil.isEmpty(form.getParentId())) { %>
      <section:use sectionId="<%=form.getParentId()%>"><bean:write name="section" property="name"/> </section:use>
      <% } %>
      <a class="global-button" href="javascript:submitForm('external:/section/choose.do?multipleSelection=false&hideFromId=<%=form.getId()%>&hiddenNodes=<bean:write name="neo.phoenix.section.SectionForm" property="id" />&singleSelectedNode=<bean:write name="publication" property="rootSection.id"/>')"><bean:message key="b.choose"/></a></td><td>(<bean:message key="t.Optional"/>) <html:errors property="parentId" /></td></tr>
    <%}%>

    <tr><td class="edit-propertyname"><bean:message key="t.Default_section_template"/></td>
    <%
      neo.xredsys.api.Publication pub = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPublication(tmpSec.getOwnerPublicationId());
      request.setAttribute("sectionLayouts",pub.getSectionLayouts());
      request.setAttribute("articleLayouts",pub.getArticleLayouts());
    %>
    <td class="edit-propertyvalue">
      <html:select property="sectionLayout" disabled="<%=readOnly%>">
        <logic:iterate name="sectionLayouts" scope="request" id="slayout" type="neo.xredsys.api.Layout" >
          <html:option value="<%=slayout.getName()%>"> <%=slayout.getName()%></html:option>
        </logic:iterate>
      </html:select>
      <%if(readOnly){%>
        <html:hidden property="sectionLayout"/>
      <%}%>
    </td></tr>
    <tr><td class="edit-propertyname"><bean:message key="t.Default_article_template"/></td>
    <td class="edit-propertyvalue">
      <html:select property="articleLayout" disabled="<%=readOnly%>">
        <logic:iterate name="articleLayouts" scope="request" id="alayout" type="neo.xredsys.api.Layout" >
          <html:option value="<%=alayout.getName()%>" ><%=alayout.getName()%></html:option>
        </logic:iterate>
      </html:select>
      <%if(readOnly){%>
        <html:hidden property="articleLayout"/>
      <%}%>
    </td></tr>
    <%if(!isRoot) {%>
  <tr><td class="edit-propertyname"><bean:message key="t.Hide_section"/></td><td class="edit-propertyvalue"><html:checkbox property="hideSection" disabled="<%=readOnly%>"/></td><td class="edit-propertydescription"><span class="error"><html:errors property="hideSection" /></span></td></tr>
  <%}%>
  <tr><td class="edit-propertyname"><bean:message key="t.Inherit_access"/></td><td class="edit-propertyvalue"><html:checkbox property="inheritAccess" disabled="<%=readOnly || hiddenInheritBox%>"/></td><td class="edit-propertydescription"><span class="error"><html:errors property="inheritAccess" /></span></td></tr>
    <%if(readOnly || hiddenInheritBox){%>
      <html:hidden property="inheritAccess"/>
    <%}%>

  <tr><td class="edit-propertyname"><bean:message key="t.Priority"/></td><td class="edit-propertyvalue"><html:text property="priority" disabled="<%=readOnly%>"/></td><td class="edit-propertydescription"><span class="error"><html:errors property="priority" /></span></td></tr>
    <%if(readOnly){%>
      <html:hidden property="priority"/>
    <%}%>
  
  <%if(true || !isVirtualSection){%>
    <tr><td class="edit-propertyname"><bean:message key="t.State"/></td>
        <td class="edit-propertyvalue"><html:select property="state" disabled="<%=readOnly%>">
    <% neo.xredsys.api.Type[] states = neo.xredsys.api.IOAPI.getAPI().getTypeManager().getTypes(neo.xredsys.api.Type.SectionStateType);
       pageContext.setAttribute("states", states); %>
           <logic:iterate name="states" id="state" type="neo.xredsys.api.Type">
             <html:option value="<%=\"\" + state.getId()%>"><bean:message key="<%=\"s.SectionStateType.\" + state.getName()%>"/></html:option>
           </logic:iterate>
           </html:select>   <html:errors property="state" /><td></tr>
    <%if(readOnly){%>
      <html:hidden property="state"/>
    <%}%>
  <%}else{%>
    <tr><td class="edit-propertyname"><bean:message key="t.State"/></td>
    <% 
      neo.xredsys.api.Type publishedType =  neo.xredsys.api.IOAPI.getAPI().getTypeManager().getType(neo.xredsys.api.Type.SectionStateType,"published");
      neo.xredsys.api.Section parentSec = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getSection(Integer.parseInt(form.getVirtualTarget()));
      if(parentSec.getState()==publishedType.getId()){       
    %>
        <td class="edit-propertyvalue"><html:select property="state">
            
        <% 
        
        neo.xredsys.api.Type[] states = neo.xredsys.api.IOAPI.getAPI().getTypeManager().getTypes(neo.xredsys.api.Type.SectionStateType);
           pageContext.setAttribute("states", states); %>
               <logic:iterate name="states" id="state" type="neo.xredsys.api.Type">
                 <html:option disabled="<%=readOnly%>" value="<%=\"\" + state.getId()%>"><bean:message key="<%=\"s.SectionStateType.\" + state.getName()%>"/></html:option>
               </logic:iterate>
               </html:select>   <html:errors property="state" /><td></tr>
        
    <%if(readOnly){%>
      <html:hidden property="state"/>
    <%}%>
    <%}else{%>
      <td>
        Not possible to change state of section because the target section is not published.
      </td> 
    <%}%>
  <%}%>
  <html:hidden property="virtualTarget"/>
  <tr><td class="edit-propertyname"><bean:message key="t.Is_agreement_required"/> </td><td class="edit-propertyvalue"><html:checkbox property="isAgreementRequired" disabled="<%=readOnly%>"/></td><td class="edit-propertydescription"><span class="error"><html:errors property="isAgreementRequired" /></span></td></tr>
  
  <tr><tr><td class="edit-propertyname"><bean:message key="t.AgreementInfo"/> </td><td class="edit-propertyvalue"><html:text property="agreementInfo" disabled="<%=readOnly%>"/></td><td class="edit-propertydescription"><span class="error"><html:errors property="agreementInfo" /></span></td></tr>
    <%if(readOnly){%>
      <html:hidden property="agreementInfo"/>
    <%}%>
  <tr><td class="edit-propertyname"><bean:message key="t.AgreementType"/></td>
      <td class="edit-propertyvalue"><html:select disabled="<%=readOnly%>" property="agreementType">
<%--        <% neo.xredsys.api.Type[] agreementTypes = neo.xredsys.api.IOAPI.getAPI().getTypeManager().getTypes(neo.xredsys.api.Type.AgreementType);
           pageContext.setAttribute("agreementTypes", agreementTypes); %> --%>
           <html:option value="1">ShowFrontpage</html:option>
           <html:option value="2">HideFrontpage</html:option>
      </html:select>
    <%if(readOnly){%>
      <html:hidden property="agreementType"/>
    <%}%>
      </td><td class="edit-propertydescription"><span class="error"><html:errors property="agreementType" /></span></td></tr>
</table>

<util:pluginResources type="internal-page" target="escenic" task="/section-edit" area="edit-content" id="resources" />
<logic:iterate name="resources" id="resource" type="neo.xredsys.plugin.Resource" >
  <% String uri = resource.getUri(); %>
  <template:call file="<%=uri%>"/>
</logic:iterate>

<input type="hidden" name="submitButton" value="">

