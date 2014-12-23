<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-view" prefix="view" %>
<div class="error"><html:errors property="global" /></div>
<bean:define id="form" name="neo.phoenix.section.MoveArticlesForm" type="neo.phoenix.section.MoveArticlesForm"/>
<input type="hidden" name="validateButton" value="move"/>
<input type="hidden" name="validateInput"  value="edit"/>
<input type="hidden" name="validateField" value="none" />
<input type="hidden" name="submitButton" value="">
<html:hidden property="parentWorkItemId"/>
<% if(neo.util.StringUtil.isEmpty(form.getFromId())){
  neo.phoenix.base.WorkItemManager manager = (neo.phoenix.base.WorkItemManager)request.getSession().getAttribute("WorkItemManager");
  neo.phoenix.base.WorkItemForm wForm = (neo.phoenix.base.WorkItemForm)manager.getWorkItem(form.getParentWorkItemId()).getForm();
  form.setFromId(((neo.phoenix.base.ObjectForm)wForm).getId());    
}
%> 
<html:hidden property="fromId" />
<section:use sectionId="<%=form.getFromId()%>">
  <bean:define id="fromSection" name="section" type="neo.xredsys.api.Section" />
  <table>
    <tr><th class="view-propertyname" align="left"><bean:message key="t.Property"/></th><th class="view-propertyvalue" align="left"><bean:message key="t.Value"/></th></tr>
    <tr><td class="view-propertyname"><bean:message key="t.Name"/>:</td><td class="view-propertyvalue"><%=fromSection.getName()%></td></tr>
    
    <tr><td class="edit-propertyname"><bean:message key="t.Move_shortcuts"/></td><td class="edit-propertyvalue"><html:radio property="moveShortCuts" value="move"/></td></tr>
    <tr><td class="edit-propertyname"><bean:message key="t.Delete_shortcuts"/></td><td class="edit-propertyvalue"><html:radio property="moveShortCuts" value="delete"/></td></tr>
    <tr>
      <td class="edit-propertyname"><bean:message key="t.Recursive"/></td>
      <td class="edit-propertyvalue"><html:checkbox property="recursive"/>
    </tr>
    <tr><td class="edit-propertyname"><bean:message key="t.Move_content_to"/></td>
      <td class="edit-propertyvalue"><html:hidden property="toId"/>
        <% if (!neo.util.StringUtil.isEmpty(form.getToId())) { %>
          <section:use sectionId="<%=form.getToId()%>">
            <bean:define id="movesection" name="section" type="neo.xredsys.api.Section" />
            <%=movesection.getName()%>
          </section:use>
        <% } %>
      <a href="javascript:submitForm('external:/section/choose.do?multipleSelection=false&nonSelectable=<%=form.getFromId()%>')" class="global-button"><bean:message key="b.choose"/></a></td>
    </tr>
  </table>
  <p>
    <% if(form.getToIdInt()>0){ %>
        <h3><bean:message key="t.warning"/></h3>
        
        <bean:message key="t.this_will_remove_all_articles" arg0="<%=fromSection.getName()%>"/>
        
        <table><tr><td>
        <% if(neo.util.StringUtil.isEmpty(form.getParentWorkItemId())){ %>
          <input type="submit" onclick="javascript:submitForm('move')" value="<bean:message key="b.move"/>"/>
        <%}else {%>
          <a href="javascript:submitForm('moveAsChild')"  class="global-button"><bean:message key="b.move"/></a>
        <%}%>  
      </td></tr></table>
    <% }else{ %>
    
    	<bean:message key="t.you_have_not_selected_section"/>
    
    <% } %>
  </p>
  
  
    <% String url2 = "/section/view.do?id=" + fromSection.getId(); %>
    <table><tr><td>
    <html:link styleClass="global-button" page="<%=url2%>"><bean:message key="b.cancel"/></html:link> 
    </td>
   </tr>
</table>
  
</section:use>