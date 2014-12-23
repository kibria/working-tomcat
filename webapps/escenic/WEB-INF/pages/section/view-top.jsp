<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" import="neo.phoenix.base.*,neo.phoenix.section.*" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<%  String secId = request.getParameter("id");
  if(neo.util.StringUtil.isEmpty(secId)){
    secId = (String)request.getAttribute("id");
  }
  request.setAttribute("id",secId);
%>
<section:use sectionId="<%=secId%>">
  <bean:define id="section" name="section" type="neo.xredsys.api.Section"/>
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
      <td valign="top" ><b><bean:write name="section" property="name"/></b></td>
      <% if(!neo.util.StringUtil.isEmpty(section.getSource())){%>
        <td class="subHeading">Source:</td>
        <td> <bean:write name="section" property="source"/></td>
      <%}%> 
      <% if(!neo.util.StringUtil.isEmpty(section.getSourceId())){%>
        <td class="subHeading">SourceId:</td>
        <td> <bean:write name="section" property="sourceId"/></td>
    <%}%> 
    </tr>
  </table>
</section:use>

