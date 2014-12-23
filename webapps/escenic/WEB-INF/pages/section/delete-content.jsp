<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page import="neo.util.StringUtil"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-view" prefix="view" %>

<html:hidden property="id"/>
<html:hidden property="name"/>
<html:hidden property="uniqueName"/>
<html:hidden property="url"/>
<input type="hidden" name="validateButton" value="delete">
<input type="hidden" name="validateInput"  value="confirm">
<input type="hidden" name="validateField"  value="none">
<input type="hidden" name="submitButton" value="">
<bean:define id="form" name="neo.phoenix.section.SectionForm" type="neo.phoenix.section.SectionForm" />
<%  neo.xredsys.api.Section section = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getSection(form.getIdInt()); %>

<table>
<tr><th align="right"><bean:message key="t.id"/>:</th><td><%=form.getId()%></td></tr>
<tr><th align="right"><bean:message key="t.Section_name"/></th><td><%=form.getName()%></td></tr>
<tr><th align="right"><bean:message key="t.Section_unique_name"/></th><td><%=form.getUniqueName()%></td></tr>
<tr><th align="right"><bean:message key="t.Section_Url"/></th><td><%=section.getUrl()%></td></tr>
</table>
<%!
 public int getArticleCount(neo.xredsys.api.Section sec, int startCount){
   int count = 0;
   if(!(sec instanceof neo.xredsys.api.VirtualSection)){
     count = sec.getHomeArticleIds().length;
   }
   neo.xredsys.api.Section[] subs = sec.getSubSections();
   for (int i = 0; i < subs.length; i++) {
     count += getArticleCount(subs[i],startCount);
   }
   startCount += count;
   return startCount;
 }
%>
<% 
  int count = getArticleCount(section,0);
  boolean needConfirm = !StringUtil.getBoolean(request.getParameter("confirm"));
  %>
 <div class="error"><html:errors property="global" /></div>
 <p>
  <bean:message key="t.you_are_about_to_delete_a_section"/>
 </p>
 <%if(needConfirm){%>
  <%if(count>0) {%>
   <p>
    <bean:message key="t.you_are_about_to_delete_a_section_with_x_articles" arg0="<%=String.valueOf(count)%>"/>  
   </p>
  <%}%>
 <p>
  <% 
    String moveUrl = "javascript:submitForm('move')"; 
    String confirmUrl = "javascript:submitForm('confirm')";
  %>
  <%if(count>0){%>
    <table>
      <tr>
        <td>
          <a href="<%=moveUrl%>" class="global-button"><bean:message key="b.move"/></a>
        <td>
        <td>
          <bean:message key="t.articles"/>
        </td>
      </tr>
    </table>
  <%}%>
  <table>
    <tr>
      <td>
        <a href="<%=confirmUrl%>" class="global-button"><bean:message key="b.delete"/></a></td><td>
      <td>
      <td>
        <%=section.getName()%>
      </td>
    </tr>
  </table>
 </p>
 <%}else{
  neo.xredsys.api.Section[] secs = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getVirtualSections(section.getId());
  if(secs!=null&&secs.length>0){ %>
      <p><%=secs.length%> <bean:message key="t.Shadow_sections_uses_this_section_as"/>:
         <%
          out.print("<ul>");
          for (int i = 0; i < secs.length; i++) {
            out.print("<li>"+secs[i].getName()+"(id="+secs[i].getId()+")");
          }
          out.print("</ul"); 
         %>
      </p>
  <%}%>  
  <p>
    <div class="warning">
      <bean:message key="t.delete_section_time_warning"/>
    </div>
  </p>
  <% String url = "javascript:submitForm('delete')"; %>
  <table>
    <tr>
      <td>
        <a href="<%=url%>" class="global-button">
          <bean:message key="b.Confirm_deletion"/>
        </a>  
      </td>
      <td> 
        <bean:message key="t.of_this_section"/>.
      </td>
    </tr>
  </table>
 <%}%>
<hr/>
<table>
  <tr>
    <td>
      <html:link page="<%= \"/section/view.do?id=\" + section.getId() %>" styleClass="global-button"><bean:message key="b.cancel"/></html:link>
    <td>
  </tr>
</table>
<%-- <p>--%>
<%-- You are about to delete a section. By doing this you are also removing all sections beneath this section, and all the sections beneath those.  Are you sure you want to do this?--%>
<%-- --%>
<%-- This section contains <%=count %> articles. Deleting this section will also delete all <%=count%> articles. --%>
<%-- <bean:message key="t.you_cannot_delete_this_section" arg0="<%=new Integer(count).toString()%>"/>--%>
<%--</p>--%>
<%--  <% String moveUrl = "javascript:submitForm('move')"; %>--%>
<%--  <table><tr><td>--%>
<%--    <a href="<%=moveUrl%>" class="global-button"><bean:message key="b.move"/></a></td><td><bean:message key="t.articles"/>.--%>
<%--  </td></tr></table>--%>
<%--  <table><tr><td>--%>
<%--    <% String url = "javascript:submitForm('confirm')";%> --%>
<%--   	<a href="<%=url%>" class="global-button"><bean:message key="b.delete"/></a> </td><td><bean:message key="t.all"/>.</td></tr></table>--%>
<%--  <table><tr><td>--%>
<%--  <hr>--%>
<%--  <html:link page="<%= \"/section/view.do?id=\" + section.getId() %>" styleClass="global-button"><bean:message key="b.cancel"/></html:link></td></tr></table>--%>
<%----%>
<%--<h1><bean:message key="t.warning"/></h1>--%>
<%--<p><bean:message key="t.you_are_about_to_delete_a_section"/></p>--%>
<%----%>
<%--  <% String url = "javascript:submitForm('delete')"; %>--%>
<%--  <% --%>
<%--  neo.xredsys.api.Section[] secs = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getVirtualSections(section.getId());--%>
<%--  if(secs!=null&&secs.length>0){ %>--%>
<%--      --%>
<%--      <p><%=secs.length%> <bean:message key="t.Shadow_sections_uses_this_section_as"/>:--%>
<%----%>
<%--         <%--%>
<%--          out.print("<ul>");--%>
<%--          for (int i = 0; i < secs.length; i++) {--%>
<%--            out.print("<li>"+secs[i].getName()+"(id="+secs[i].getId()+")");--%>
<%--          }--%>
<%--          out.print("</ul"); --%>
<%--         %>--%>
<%--      </p>--%>
<%--  <%}%>  --%>
<%--<p>--%>
<%--<ul>--%>
<%--  <table><tr><td>--%>
<%--  <a href="<%=url%>" class="global-button"><bean:message key="b.Confirm_deletion"/></a></td><td> <bean:message key="t.of_this_section"/>.</td></tr></table>--%>
<%-- <table><tr><td>--%>
<%-- 	  <html:link page="<%= \"/section/view.do?id=\" + section.getId() %>" styleClass="global-button"><bean:message key="b.cancel"/></html:link></td></tr></table>--%>
<%--</ul>--%>
<%--</p>--%>
