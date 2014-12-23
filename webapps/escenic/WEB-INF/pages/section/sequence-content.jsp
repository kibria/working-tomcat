<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<bean:define id="form" name="neo.phoenix.section.SequenceForm" type="neo.phoenix.section.SequenceForm"/>
<html:hidden property="id" />
<input type="hidden" name="validateButton" value="edit">
<input type="hidden" name="validateButton" value="save">
<input type="hidden" name="validateInput"  value="edit">
<input type="hidden" name="validateField"  value="none">
<section:use sectionId="<%=form.getId()%>">
  <bean:define id="parentSection" name="section" type="neo.xredsys.api.Section"/>
  <% 
    neo.xredsys.api.Section parent = parentSection.getParent();
    String tmp = parentSection.getName();
    while(parent!=null){
      tmp = parent.getName() + "\\" + tmp;
      parent = parent.getParent();
    }
  %>
  <h3><bean:message key="t.Change_subsection_sequence"/> <%=tmp%></h3>
</section:use>
<div class="error"><html:errors property="global" /></div>
<input type="hidden" name="submitButton" value="">
<table>
  <logic:iterate name="form" property="relatedObjects" id="_item" >
    <% String p1 = "relatedObject(" + _item + ").id"; 
       String p2 = "relatedObject(" + _item + ").attribute(priority)";  
    %>
    <html:hidden property="<%=p1%>"/>
    <%-- <html:hidden property="<%=p2%>"/> --%>
    <% 
      neo.phoenix.base.RelatedObject obj = form.getRelatedObject(_item.toString());
    %>
    <section:use sectionId="<%=obj.getId()%>">
      <tr>
        <td>
          <bean:write name="section" property="name"/>
        </td>
        <td>
          <html:text property="<%=p2%>" size="3"/> 
          <%--<%=obj.getAttribute("priority")%>--%>
        </td>
      </tr>
    </section:use>
  </logic:iterate>
</table>
<table>
  <tr>
    <td>
      <a class="global-button" href="javascript:submitForm('save')"><bean:message key="b.save"/></a>
    </td>
  </tr>
</table>
