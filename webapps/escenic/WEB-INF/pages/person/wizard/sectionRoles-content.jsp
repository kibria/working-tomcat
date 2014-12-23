<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template"
%><bean:define id="publication"
             name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<bean:define id="checker"
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<bean:define id="form" name="neo.phoenix.person.PersonForm" type="neo.phoenix.person.PersonForm"/>
<div class="error"><html:errors property="global" /></div>
<input type="hidden" name="validateButton" value="save"/>
<input type="hidden" name="validateInput"  value="sectionRoles"/>
<input type="hidden" name="validateField" value="none" />
<%@include file="../hiddenProperties.jspf" %>
<%@include file="../hiddenGlobalRoles.jspf" %>
<%@include file="../hiddenGroups.jspf" %>
<%@include file="../hiddenTags.jspf" %>
<%@include file="../hiddenContentTypes.jspf" %>
<%
  java.util.Collection roles = neo.phoenix.base.RoleUtil.getInstance().getSectionRoles();
   request.setAttribute("types",roles);
%>
<bean:define name="types" id="types" />
<table  class="listing" cellpadding="0" cellspacing="0">
  <tr class="labels">
    <th>
      Roles:
    </th>
    <logic:iterate id="role" type="java.lang.String" name="types">
      <th>
        <%=role%>
      </th>
    </logic:iterate>
  </tr>
  <%
    java.util.List rel = form.getRelatedObjects();

    if(rel==null||rel.size()==0){
      java.util.Collection sections = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getNonInheritSections(publication.getId());
      java.util.Iterator i = sections.iterator();
      while(i.hasNext()){
        neo.xredsys.api.Section section = (neo.xredsys.api.Section)i.next();
        neo.xredsys.api.IOHashKey secKey = section.getHashKey();
        neo.phoenix.base.RelatedObject current = null;
        if(!form.containsRelatedObject(secKey)){
          current = form.addRelatedObject(secKey);
        }else{
          current = form.getRelatedObject(secKey);
        }
      }
    }
  %>
  <logic:iterate name="neo.phoenix.person.PersonForm" property="relatedObjects" id="item" >
    <% String p1 = "relatedObject(" + item + ").id";
    String p2 = "relatedObject(" + item + ").type";
    String p3 = "relatedObject(" + item + ").publicationId";
    String p4 = "relatedObject(" + item + ").attributeNames";
    %>
    <html:hidden property="<%=p1%>"/>
    <html:hidden property="<%=p2%>"/>
    <html:hidden property="<%=p3%>"/>
    <bean:define id="sectionId" name="form" property="<%=p1%>" type="java.lang.String"/>
    <tr>
      <td>
      <% neo.xredsys.api.Section section = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getSection(Integer.parseInt(sectionId));
      %>
      <template:call file="../../base/presentSection.jsp">
        <%
           String pubId = section.getOwnerPublicationId() + "";
        %>
        <template:parameter key="sectionId" value="<%=sectionId%>" />
        <template:parameter key="noTable" value="true" />
        <template:parameter key="external" value="true" />
        <template:parameter key="pubId" value="<%=pubId%>" />
      </template:call>
      </td>
      <logic:iterate id="role" name="types" type="java.lang.String" >
      <td>
        <% String key = "relatedObject(" + item + ").attribute("+ role + ")"; %>
        <html:checkbox property="<%=key%>" />
      </td>
      </logic:iterate>
    </tr>
  </logic:iterate>
</table>

<br />

<table cellpadding="0" cellspacing="0" border="0">
<tr>
 <td><a href="javascript:submitForm('groups')" class="global-button">Back</a></td>
 <td>&nbsp;</td>
 <td><a href="javascript:submitForm('tagStructures')" class="global-button">Next</a></td>
 <td>&nbsp;</td>
 <td><a href="javascript:submitForm('cancel')" class="global-button">Cancel</a></td>
 <td>&nbsp;</td>
 <td><a href="javascript:submitForm('save')" class="global-button">Save</a></td>
</tr>
</table>

<input type="hidden" name="submitButton" value="">
