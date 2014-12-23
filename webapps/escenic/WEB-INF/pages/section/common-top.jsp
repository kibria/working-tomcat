<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" import="neo.phoenix.base.*,neo.phoenix.section.*" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<logic:notPresent parameter="id">
<logic:present name="neo.phoenix.section.SectionForm">
  <bean:define id="form" name="neo.phoenix.section.SectionForm" type="neo.phoenix.section.SectionForm"/>
  <%  
    String secId = form.getId();
    request.setAttribute("sectionId",secId);
  %>
</logic:present>
<logic:present name="neo.phoenix.section.SectionMembersForm">
  <bean:define id="membersForm" name="neo.phoenix.section.SectionMembersForm" type="neo.phoenix.section.SectionMembersForm"/>
  <%  
    String secId = membersForm.getId();
    request.setAttribute("sectionId",secId);
  %>
</logic:present>
<logic:present name="neo.phoenix.section.PropertiesForm">
  <bean:define id="propertiesForm" name="neo.phoenix.section.PropertiesForm" type="neo.phoenix.section.PropertiesForm"/>
  <%
    String secId = propertiesForm.getId();
    request.setAttribute("sectionId",secId);
  %>
</logic:present>
</logic:notPresent>
<%
  String secId = request.getParameter("id");
  if (neo.util.StringUtil.isEmpty(secId)) {
    secId = (String) request.getAttribute("sectionId");
    if (neo.util.StringUtil.isEmpty(secId)) {
      secId = (String) request.getAttribute("id");
    }
  } 

  neo.xredsys.api.Section section = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getSection(Integer.parseInt(secId));
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

