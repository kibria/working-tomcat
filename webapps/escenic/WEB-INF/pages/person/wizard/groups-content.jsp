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
<div class="error"><html:errors property="global" /></div>
<bean:define id="form" name="neo.phoenix.person.PersonForm" type="neo.phoenix.person.PersonForm"/>
<input type="hidden" name="validateButton" value="save"/>
<input type="hidden" name="validateInput"  value="groups"/>
<input type="hidden" name="validateField" value="none" />
<%@include file="../hiddenProperties.jspf" %>
<%@include file="../hiddenGlobalRoles.jspf" %>
<%@include file="../hiddenGroups.jspf" %>
<%@include file="../../base/relatedObjects.jspf" %>
<%@include file="../hiddenTags.jspf" %>
<%@include file="../hiddenContentTypes.jspf" %>
<bean:define id="groups" name="form" property="userGroups" type="java.util.List"/>
<% if(groups.size()>0){ %>
  <p><h3>This person is member of the following groups:</h3>
    <table>

      <logic:iterate name="form" property="userGroups" id="key" type="java.lang.String">
        <tr>
          <%  String p1 = "userGroup(" + key + ").attribute(name)";
              String p2 = "userGroup(" + key + ").type";
              String p3 = "userGroup(" + key + ").publicationId";
          %>
          <html:hidden property="<%=p1%>"/>
          <html:hidden property="<%=p2%>"/>
          <html:hidden property="<%=p3%>"/>

          <%
             neo.phoenix.base.RelatedObject relObj = form.getUserGroup(key);
             String name = relObj.getAttribute("name");
             int pubId = Integer.parseInt(relObj.getPublicationId());
             neo.xredsys.api.UserGroup item = (neo.xredsys.api.UserGroup)neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getUserGroup(name,pubId); %>
          <% String remove = "action:/person/RemovePersonFromUserGroup.do?name="+name+"&pubId="+pubId;%>

            <template:call file="../../base/presentUserGroup.jsp">
              <% String groupName = item.getName() + "";
                 String pub = item.getOwnerPublicationId() + "";
              %>
              <template:parameter key="external" value="true" />
              <template:parameter key="pubId" value="<%=pub%>" />
              <template:parameter key="groupName" value="<%=groupName%>" />
            </template:call>
          <td><a href="javascript:submitForm('<%=remove%>')">
            <html:img page="/images/qw/delete.png" />
            </a>
          </td>
        </tr>
      </logic:iterate>
    </table>
  </p>
<% }else{ %>
  <p><h3>This person is not member of any groups</h3></p>
<% } %>
<p><a href="javascript:submitForm('findGroups')">Add groups</a></p>

<br />

<table cellpadding="0" cellspacing="0" border="0">
<tr>
 <td><a href="javascript:submitForm('globalRoles')" class="global-button">Back</a></td>
 <td>&nbsp;</td>
 <td><a href="javascript:submitForm('sectionRoles')" class="global-button">Next</a></td>
 <td>&nbsp;</td>
 <td><a href="javascript:submitForm('cancel')" class="global-button">Cancel</a></td>
 <td>&nbsp;</td>
 <td><a href="javascript:submitForm('save')" class="global-button">Save</a></td>
</tr>
</table>

<input type="hidden" name="submitButton" value="">
