<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<bean:define name="neo.phoenix.person.PersonForm" id="form" scope="request" type="neo.phoenix.person.PersonForm"/>
<bean:define id="publication" name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<div class="icon">
      <%
        String imageSrc = "/images/qw/person_32_wh.png";
        if(!form.getPubId().equals(String.valueOf(publication.getId()))){
          imageSrc = "/images/qw/guest_16x16.png";
        }
      %>
      <html:img border="0" page="<%=imageSrc%>" align="center"/>
</div>
<div class="intro">
      <table>
        <tr>
      <% String titleClass="subHeading";
         if(form.getLockedBy() != null && "true".equals(form.getReadOnly())) titleClass="locked-icon subHeading";
      %>
          <td class="<%= titleClass %>">
            <bean:write name="form" property="surName"/>, 
            <bean:write name="form" property="firstName"/>
          </td>
        </tr>
        
      </table>

</div>

  <% if("true".equals(form.getReadOnly())) { 
       String readOnly = org.apache.struts.util.RequestUtils.message(pageContext, null, null, "t.Read_only", null);
  %>
<p>
  <span class="highlight-warning">
    <%=readOnly%><%
       if(!neo.util.StringUtil.isEmpty(form.getLockedBy())) { %>:
    <bean:message key="t.Used_by"/> <%= form.getLockedBy() %>
  <%      } %>
  </span>
</p>
  <% } %>
<html:hidden property="lockedBy"/>
