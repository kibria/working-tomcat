<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" import="neo.phoenix.base.*,neo.phoenix.section.*" %>
<%@ page import="java.text.DateFormat" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-view" prefix="view" %>


<bean:define id="publication" name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<bean:define name="neo.phoenix.section.SectionForm" id="form" scope="request" type="neo.phoenix.section.SectionForm"/>

<% int sectionId = form.getIdInt();
   neo.xredsys.api.Section section = null;
   if(sectionId>0){
    section = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getSection(sectionId);
   }
   request.setAttribute("section",section);

   String lang = neo.phoenix.base.Constants.LOCALE_KEY;

   java.util.Locale loc = (java.util.Locale)session.getAttribute(lang);
%>

<div class="sectiondetails"> <!-- Use a table here to show tabular data... -->
  <table cellpadding="0" cellspacing="0" border="0">
  <%if(sectionId>0){%>
    <tr>
     <th><bean:message key="t.id"/>:</th>
     <td><bean:write name="section" property="id"/></td>
    </tr> 
    <tr>
     <th><bean:message key="t.Publishdate"/>:</th>
     <td><%=DateFormat.getDateInstance(DateFormat.SHORT).format(section.getPublishDate())%></td>
    </tr>
    <tr>
     <th><bean:message key="t.Last_Modified"/>:</th>
     <td> <%=DateFormat.getDateInstance(DateFormat.SHORT).format(section.getLastModified())%></td>
    </tr> 
    <% if(!neo.util.StringUtil.isEmpty(section.getSource())){%>
     <tr>
      <th><bean:message key="t.Source"/>:</th>
      <td> <bean:write name="section" property="source"/></td>
     </tr>
    <%}%> 
    <% if(!neo.util.StringUtil.isEmpty(section.getSourceId())){%>
     <tr>
      <th><bean:message key="t.SourceID"/>:</th>
      <td> <bean:write name="section" property="sourceId"/></td>
     </tr>
    <%}%> 
  <%} else {%>
    <tr>
     <th><bean:message key="t.id"/>:</th>
     <td>(...)</td>
    </tr> 
    <tr>
     <th><bean:message key="t.Publishdate"/>:</th>
     <td>(...)</td>
    </tr>
    <tr>
     <th><bean:message key="t.Last_Modified"/>:</th>
     <td>(...)</td>
    </tr> 
  <%}%>
  </table>
</div>
