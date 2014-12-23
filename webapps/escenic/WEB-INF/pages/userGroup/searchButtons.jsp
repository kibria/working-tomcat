<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<bean:define name="neo.phoenix.userGroup.UserGroupSearchForm" scope="request"
              type="neo.phoenix.userGroup.UserGroupSearchForm" id="form"/>
<% String actionURL = "action:/userGroup/addUserGroupsToBasket.do?objectType=" + neo.xredsys.api.IOAtom.OBJECTTYPE_USERGROUP; %>
<table>
  <tr>
<%--    <td>
        <a class="global-button" href="javascript:submitForm('<%=actionURL%>')">Add selected to clips</a>      
    </td>--%>
    <td>
      <% if(form.getParentWorkItemId()!=null&&form.getParentWorkItemId().length()>0){ %>
        <a class="global-button" href="javascript:submitForm('finished')">Finished</a>
      <% } %>
    </td>
  </tr>
</table>      
