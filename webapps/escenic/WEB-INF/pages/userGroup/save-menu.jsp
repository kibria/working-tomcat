<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page import="neo.xredsys.api.UserGroup,
                 neo.xredsys.api.IOAPI"%>
<%@ page language="java" %>

<%@ 
taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %><%@
taglib uri="http://struts.apache.org/tags-html" prefix="html" %><%@
taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %><%@
taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %><%@
taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>

<bean:define 
id="publication" name="escenic-publication" scope="session" type="neo.xredsys.api.Publication"/>
<bean:define id="form" name="neo.phoenix.userGroup.UserGroupForm" type="neo.phoenix.userGroup.UserGroupForm"/>

<bean:define id="checker"
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<%  boolean readOnly = neo.util.StringUtil.getBoolean(form.getReadOnly()); %>

<!-- <b><bean:message key="action.article.saveAsLabel"/></b><br> -->


<table cellpadding="0" cellspacing="0" border="0">
   <% if(!readOnly){%>
   
     <tr>
      <td><input type="button" class="important-button" onClick="javascript:submitForm('save')" value="<bean:message key="b.save"/>" /></td>
     </tr>
     <tr>
      <td>&nbsp;</td>
     </tr>
   <% }else{
      String edit = null; 
      UserGroup g = IOAPI.getAPI().getObjectLoader().getUserGroup(form.getName(),form.getPubIdInt(publication.getId()));
      if(!g.isLocked()&&checker.isEditable(g)){
        edit = "/userGroup/edit.do?name="+form.getName()+"&pubId="+form.getPubIdInt(publication.getId());
      }
      if(edit!=null){%>
       <tr>
          <td><input type="button" onClick="javascript:submitForm('external:<%=edit%>')" class="important-button" value="<bean:message key="b.Edit"/>" /></td>
       </tr>
      <%}%>    
   <%}%>
   <tr>
    <td><input type="button" class="link" onClick="javascript:submitForm('close')" value="<bean:message key="b.close"/>" /></td>
   </tr>
   <tr>
</table>   
<script>
  function previewWindowOnLoadHook() {
<% if (request.getAttribute("previewUrl") != null) { %>
    window.open('<%=request.getAttribute("previewUrl")%>', 'escenicPreview');
<% } %>
    return true;
  }
  registerHook('onLoad',previewWindowOnLoadHook);
</script>
