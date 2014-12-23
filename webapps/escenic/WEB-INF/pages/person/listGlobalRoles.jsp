<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>

  <table class="listing" cellpadding="0" cellspacing="0">
    <tr class="labels">
      <th>
        <bean:message key="t.Global_roles"/>
      </th>
      <th>&nbsp;</th>
    </tr>
    <%
      java.util.Map roleMap = neo.phoenix.base.RoleUtil.getInstance().getAllRoles();
      java.util.ArrayList roles = new java.util.ArrayList();
      request.setAttribute("roles",roles);
      boolean readOnly = neo.util.StringUtil.getBoolean(request.getParameter("readOnly"));
    %>
      <tr> 
        <% String key = "globalRole(publicationadmin)"; %>
        <td><bean:message key="r.publication_admin"/>:</td>
        <td><html:checkbox property="<%=key%>" disabled="<%=readOnly%>"/><html:errors property="<%=key%>" /></td>
      </tr>
      <%if(readOnly){%>
        <html:hidden property="<%=key%>"/>
      <%}%>
      <tr> 
        <% key = "globalRole(administrator)"; %>
        <td><bean:message key="r.section_admin"/>:</td>
        <td><html:checkbox property="<%=key%>" disabled="<%=readOnly%>"/><html:errors property="<%=key%>" /></td>
      </tr>
      <%if(readOnly){%>
        <html:hidden property="<%=key%>"/>
      <%}%>
      <tr> 
        <% key = "globalRole(useradmin)"; %>
        <td><bean:message key="r.user_admin"/>:</td>
        <td><html:checkbox property="<%=key%>" disabled="<%=readOnly%>"/><html:errors property="<%=key%>" /></td>
      </tr>
      <%if(readOnly){%>
        <html:hidden property="<%=key%>"/>
      <%}%>
      <tr> 
        <% key = "globalRole(editor)"; %>
        <td><bean:message key="r.section_editor"/>:</td>
        <td><html:checkbox property="<%=key%>" disabled="<%=readOnly%>"/><html:errors property="<%=key%>" /></td>
      </tr>
      <%if(readOnly){%>
        <html:hidden property="<%=key%>"/>
      <%}%>
      <tr> 
        <% key = "globalRole(journalist)"; %>
        <td><bean:message key="r.journalist"/>:</td>
        <td><html:checkbox property="<%=key%>" disabled="<%=readOnly%>"/><html:errors property="<%=key%>" /></td>
      </tr>
      <%if(readOnly){%>
        <html:hidden property="<%=key%>"/>
      <%}%>
      <tr> 
        <% key = "globalRole(reader)"; %>
        <td><bean:message key="r.reader"/>:</td>
        <td><html:checkbox property="<%=key%>" disabled="<%=readOnly%>"/><html:errors property="<%=key%>" /></td>
      </tr>
      <%if(readOnly){%>
        <html:hidden property="<%=key%>"/>
      <%}%>
      <tr>
        <% key = "globalRole(articleWithContentTypeReader)"; %>
        <td>Read all content types:</td>
        <td><html:checkbox property="<%=key%>" disabled="<%=readOnly%>"/><html:errors property="<%=key%>" /></td>
      </tr>
      <%if(readOnly){%>
        <html:hidden property="<%=key%>"/>
      <%}%>
      <tr>
        <% key = "globalRole(articleWithContentTypeWriter)"; %>
        <td>Write all content types:</td>
        <td><html:checkbox property="<%=key%>" disabled="<%=readOnly%>"/><html:errors property="<%=key%>" /></td>
      </tr>
      <%if(readOnly){%>
        <html:hidden property="<%=key%>"/>
      <%}%>
    <%-- VF-431 : kept these hidden fields for backward compatibility --%>
    <% key = "topicRole(editor)"; %>
    <html:hidden property="<%=key%>"/>
    <% key = "topicRole(journalist)"; %>
    <html:hidden property="<%=key%>"/>
    <%if(readOnly){%>
      <html:hidden property="<%=key%>"/>
    <%}%>
    <%
    //Check for dashboard plug-in
    neo.xredsys.plugin.PluginManager pm = neo.xredsys.plugin.PluginManager.getPluginManager();
    if (pm.getPluginNames().contains("dashboard") || pm.getPluginNames().contains("Dashboard")) {
      %>
    <tr> 
      <% key = "globalRole(dashboard-administrator)"; %>
      <td><bean:message key="r.dashboard-administrator"/>:</td>
      <td><html:checkbox property="<%=key%>" disabled="<%=readOnly%>"/><html:errors property="<%=key%>" /></td>
    </tr>
    <%if(readOnly){%>
      <html:hidden property="<%=key%>"/>
    <%}%>
    <tr> 
      <% key = "globalRole(content-moderator)"; %>
      <td><bean:message key="r.content-moderator"/>:</td>
      <td><html:checkbox property="<%=key%>" disabled="<%=readOnly%>"/><html:errors property="<%=key%>" /></td>
    </tr>
    <%if(readOnly){%>
      <html:hidden property="<%=key%>"/>
    <%}%>
  <%}%>
  </table>
