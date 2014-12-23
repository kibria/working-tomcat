<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<bean:define name="neo.phoenix.person.PersonSearchForm" scope="request"
              type="neo.phoenix.person.PersonSearchForm" id="form"/>
<% String actionURL = "action:/person/addPersonsToBasket.do?objectType=" + neo.xredsys.api.IOAtom.OBJECTTYPE_PERSON; %>
<%-- <table>
  <tr>
    <td>
      <a href="javascript:submitForm('<%=actionURL%>')"><html:img pageKey="b.Add_selected_items_to_my_clips.src" altKey="b.Add_person.alt"/></a>
    </td>
  </tr>
</table>      
--%>