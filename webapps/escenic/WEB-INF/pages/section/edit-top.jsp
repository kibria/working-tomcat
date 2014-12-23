<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" import="neo.phoenix.base.*,neo.phoenix.section.*" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>

<%
 SectionForm sectionForm = null;
 if (request.getAttribute("form") instanceof SectionForm) {
   sectionForm = (SectionForm)request.getAttribute("form");
 } else  if (request.getAttribute("parentForm") instanceof SectionForm) {
   sectionForm = (SectionForm)request.getAttribute("parentForm");
 }
 if (sectionForm != null) {
   pageContext.setAttribute("sectionForm", sectionForm);
 }
%>

<logic:present name="sectionForm" scope="page">

<bean:define id="publication" name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<%if(!neo.util.StringUtil.isEmpty(sectionForm.getId())){%>
  <%
    neo.xredsys.api.Section section = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getSection(Integer.parseInt(sectionForm.getId()));
  %>
  <table>
    <tr>
    <%
      neo.xredsys.api.Type published = neo.xredsys.api.IOAPI.getAPI().getTypeManager().getType(neo.xredsys.api.Type.SectionStateType,"published");
      String img = null;
      if(section instanceof neo.xredsys.api.VirtualSection){
        if(published.getId()!=section.getState()){
          img = "/images/qw/shadowsection_32_32.png"; 
        }else{
          img = "/images/qw/shadowsection_32_32.png";
        }
      }else{   
        if(published.getId()!=section.getState()){
          img = "/images/qw/section_notpublished_32_32.png"; 
        }else{
          img = "/images/qw/section_32_wh.png";
        }
      }
    %>
      <td><html:img page="<%=img%>"/></td>
      <td valign="top" ><b><%=section.getName()+"("+section.getId()+")"%></b></td>
    <% if(!neo.util.StringUtil.isEmpty(section.getSource())){%>
        <td valign="top" class="subHeading">Source:</td>
        <td valign="top"><%=section.getSource()%></td>
    <%}%> 
    <% if(!neo.util.StringUtil.isEmpty(section.getSourceId())){%>
        <td valign="top" class="subHeading">SourceId:</td>
        <td valign="top"><%=section.getSourceId()%></td>
    <%}%> 
    
    </tr>
  </table>
<%}%>
</logic:present>

