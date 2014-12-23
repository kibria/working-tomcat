<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<div class="error"><html:errors property="global" /></div>

<bean:define name="neo.phoenix.section.SectionForm" id="form" scope="request" type="neo.phoenix.section.SectionForm"/>
<input type="hidden" name="validateButton" value="save"/>
<input type="hidden" name="validateInput"  value="edit"/>
<input type="hidden" name="validateField" value="name" />
<input type="hidden" name="validateField" value="agreementInfo" />

<%if(neo.util.StringUtil.getBoolean(form.getIsVirtual())){ %>
  <input type="hidden" name="validateField" value="virtualTarget" />
<% }else{ %>
    <input type="hidden" name="validateField" value="directoryName" />
<%}%>
<input type="hidden" name="validateField" value="uniqueName" />
<input type="hidden" name="validateField" value="url" />

<html:hidden property="parentId" />
<html:hidden property="isVirtual" />
<%
  neo.xredsys.api.Section parent = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getSection(Integer.parseInt(form.getParentId()));
  String path = parent.getName();
  while(parent.getParent()!=null){
    parent = parent.getParent();
    path = parent.getName()+"/"+path;
  }
  neo.xredsys.api.Section target = null;
  if(!neo.util.StringUtil.isEmpty(form.getVirtualTarget())){
    target = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getSection(Integer.parseInt(form.getVirtualTarget()));
  }      
%>
<h4>Create a subsection of:<%=path%></h4>
<table>
<tr><th class="edit-propertyname" align="left"><bean:message key="t.Property"/></th><th class="edit-propertyvalue" align="left"><bean:message key="t.Value"/></th><td>&nbsp;</td></tr>
<%-- <%if(neo.util.StringUtil.getBoolean(form.getIsVirtual())){ %>
  <tr><td class="view-propertyname"><bean:message key="t.Section_name"/></td><td class="view-propertyvalue"><% if(target!=null)out.print(target.getName());%></td><td><html:errors property="name" /></td></tr>
<%}else{%> --%>
  <tr><td class="edit-propertyname"><bean:message key="t.Section_name"/></td><td class="edit-propertyvalue"><html:text property="name" /></td><td><html:errors property="name" /></td></tr>
<%--<%}%> --%>
<tr><td class="edit-propertyname"><bean:message key="t.Section_unique_name"/></td><td class="edit-propertyvalue"><html:text property="uniqueName" /></td><td><html:errors property="uniqueName" /></td></tr>
<tr><td class="edit-propertyname"><bean:message key="t.Directory_name"/></td><td class="edit-propertyvalue"><html:text property="directoryName" /></td><td><html:errors property="directoryName" /></td></tr>
<%if(!neo.util.StringUtil.getBoolean(form.getIsVirtual())){ %>
  <tr><td class="edit-propertyname"><bean:message key="t.Section_Url"/></td><td class="edit-propertyvalue"><html:text property="url" /></td><td>(<bean:message key="t.Optional"/>) <html:errors property="url" /></td></tr>
  <tr><td class="edit-propertyname"><bean:message key="t.State"/></td>
      <td class="edit-propertyvalue"><html:select property="state">
  <% neo.xredsys.api.Type[] states = neo.xredsys.api.IOAPI.getAPI().getTypeManager().getTypes(neo.xredsys.api.Type.SectionStateType);
     pageContext.setAttribute("states", states); %>
         <logic:iterate name="states" id="state" type="neo.xredsys.api.Type">
           <html:option value="<%=\"\" + state.getId()%>"><bean:message key="<%=\"s.SectionStateType.\" + state.getName()%>"/></html:option>
         </logic:iterate>
         </html:select>   <html:errors property="state" /><td></tr>
<% } %>
<tr><td class="edit-propertyname"><bean:message key="t.Priority"/></td><td class="edit-propertyvalue"><html:text property="priority" /></td><td class="edit-propertydescription"><span class="error"><html:errors property="priority" /></span></td></tr>
<%if(!neo.util.StringUtil.getBoolean(form.getIsVirtual())){ %>
  <%
    neo.xredsys.api.Publication pub = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPublication(parent.getOwnerPublicationId());
    request.setAttribute("sectionLayouts",pub.getSectionLayouts());
    request.setAttribute("articleLayouts",pub.getArticleLayouts());
  %>
  <tr><td class="edit-propertyname"><bean:message key="t.Default_section_template"/></td>
  <td class="edit-propertyvalue">
    <html:select property="sectionLayout">
      <logic:iterate name="sectionLayouts" scope="request" id="slayout" type="neo.xredsys.api.Layout" >
        <html:option value="<%=slayout.getName()%>"><%=slayout.getName()%></html:option>
      </logic:iterate>
    </html:select>
  </td></tr>
  <tr><td class="edit-propertyname"><bean:message key="t.Default_article_template"/></td>
  <td class="edit-propertyvalue">
    <html:select property="articleLayout">
      <logic:iterate name="articleLayouts" scope="request" id="alayout" type="neo.xredsys.api.Layout" >
        <html:option value="<%=alayout.getName()%>"><%=alayout.getName()%></html:option>
      </logic:iterate>
    </html:select>
  </td></tr>
<% } %>

<% if(neo.util.StringUtil.getBoolean(form.getIsVirtual())){ %>
  <tr><td class="edit-propertyname"><bean:message key="t.Choose_shadow_source"/></td>
    <td class="edit-propertyvalue">
      <html:hidden property="virtualTarget"/>
    <% if (!neo.util.StringUtil.isEmpty(form.getVirtualTarget())) { %>
    <section:use sectionId="<%=form.getVirtualTarget()%>">
      <bean:write name="section" property="name"/>
    </section:use>
    <% } %>
    <a class="global-button" href="javascript:submitForm('external:/section/choose.do?multipleSelection=false&onlyVirtualTarget=true&hideVirtualSections=true&shadowParentId=<%=form.getParentId()%>')"><bean:message key="b.choose"/></a>
    </td><td> <html:errors property="virtualTarget" /></td>
  </tr>
  <tr><td class="edit-propertyname"><bean:message key="t.Create_recursive"/></td><td class="edit-propertyvalue"><html:checkbox property="recursive"/></td><td><span class="error"><html:errors property="recursive" /></span></td></tr>
<% }else{ %>
  <tr><tr><td class="edit-propertyname"><bean:message key="t.Shared"/></td><td class="edit-propertyvalue"><html:checkbox property="virtualTarget" /></td><td class="edit-propertydescription"><span class="error"><html:errors property="virtualTarget" /></span></td></tr>
<% } %>
  <tr><td class="edit-propertyname"><bean:message key="t.Is_agreement_required"/></td><td class="edit-propertyvalue"><html:checkbox property="isAgreementRequired"/></td><td class="edit-propertydescription"><span class="error"><html:errors property="isAgreementRequired" /></span></td></tr>
  
  <tr><tr><td class="edit-propertyname"><bean:message key="t.AgreementInfo"/></td><td class="edit-propertyvalue"><html:text property="agreementInfo" /></td><td class="edit-propertydescription"><span class="error"><html:errors property="agreementInfo" /></span></td></tr>
  <tr><td class="edit-propertyname"><bean:message key="t.AgreementType"/></td>
      <td class="edit-propertyvalue"><html:select property="agreementType">
<%--        <% neo.xredsys.api.Type[] agreementTypes = neo.xredsys.api.IOAPI.getAPI().getTypeManager().getTypes(neo.xredsys.api.Type.AgreementType);
           pageContext.setAttribute("agreementTypes", agreementTypes); %> --%>
           <html:option value="1">ShowFrontpage</html:option>
           <html:option value="2">HideFrontpage</html:option>
      </html:select>
      </td><td class="edit-propertydescription"><span class="error"><html:errors property="agreementType" /></span></td></tr>
</table>
<table><tr>
  <td><input type="button" class="important-button" onClick="submitForm('save')" value="<bean:message key="b.save"/>" /></td>
  <td><html:link  styleClass="global-button" page="<%= \"/section/view.do?id=\" + form.getParentId() %>"><bean:message key="b.cancel"/></html:link></td>
  </tr>
</table>
<input type="hidden" name="submitButton" value="">
