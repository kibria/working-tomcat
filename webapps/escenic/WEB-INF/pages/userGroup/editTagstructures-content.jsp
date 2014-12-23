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
<bean:define name="neo.phoenix.userGroup.UserGroupForm" id="form" scope="request" type="neo.phoenix.userGroup.UserGroupForm"/>
<bean:define id="checker" 
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<%@include file="../base/relatedObjects.jspf" %>
<%@include file="hiddenProps.jspf" %>
<%@include file="hiddenRelations.jspf" %>
<%@include file="hiddenMembers.jspf" %>
<%@include file="hiddenGroups.jspf" %>
<%@include file="hiddenGlobalRoles.jspf" %>
<%@include file="../person/hiddenContentTypes.jspf" %>
<html:hidden property="parentWorkItemId" />

<input type="hidden" name="validateButton" value="edit"/>
<input type="hidden" name="validateButton" value="editRoles"/>
<input type="hidden" name="validateButton" value="save"/>
<input type="hidden" name="validateInput"  value="editTagStructures"/>
<input type="hidden" name="validateField" value="none" />
<input type="hidden" name="submitButton" value="">
<script>
function markAll() {
    var elements, i;
    elements = document.getElementsByClassName('tagRole');
    for ( i = 0; i < elements.length; i++) {
      elements.item(i).checked = document.getElementById('AllTags').checked;
    }
    
}
</script>
<% boolean isReadOnly = neo.util.StringUtil.getBoolean(form.getReadOnly()) || !checker.isGlobalPublicationAdmin(form.getPubIdInt(-1)); %>
<table class="listing" cellpadding="0" cellspacing="0">
    <tr class="labels">
        <th>&nbsp;</th>
        <th><bean:message key="r.tag_admin"/> </th>
    </tr>
    <tr class="all">
      <td><strong>All</strong></td>
      <td><input type="checkbox" name="all" onclick="markAll();" id="AllTags" <%=isReadOnly ? "disabled" : ""%>></td>
    </tr>
    <logic:iterate name="form" property="tagStructures.keys" id="_sec" >
      <% String p1 = "tagStructures.item(" + _sec + ").id"; 
         String nameAttr = "tagStructures.item(" + _sec + ").attribute(name)";  
         String roleAttr = "tagStructures.item(" + _sec + ").attribute(role)";  
      %>
      <html:hidden property="<%=p1%>"/>
      <html:hidden property="<%=nameAttr%>"/>
      <tr>
          <td><bean:write name="form" property="<%=nameAttr%>"/></td>
          <td><html:checkbox property="<%=roleAttr%>" disabled="<%=isReadOnly%>" styleClass="tagRole"/></td>
          <%
              if(isReadOnly) {
                  %>
                    <html:hidden property="<%=roleAttr%>"/>
                  <%
              }
          %>
      </tr>
    </logic:iterate>
</table>
