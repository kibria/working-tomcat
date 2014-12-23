<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>

<% 
  final neo.xredsys.plugin.PluginManager pluginManager = (neo.xredsys.plugin.PluginManager) neo.nursery.GlobalBus.lookupSafe("/neo/io/managers/PluginManager");

  java.util.TreeSet pluginNames = new java.util.TreeSet();
  pluginNames.addAll(pluginManager.getPluginNames());
  pageContext.setAttribute("pluginNames", pluginNames);

  pageContext.setAttribute("pluginManager", pluginManager);
%>
<table class="plugin">

<logic:iterate name="pluginManager" property="invalidPlugins" id="invalidPlugin" type="neo.xredsys.plugin.Plugin">
<tr class="plugin">
  <td class="pluginName" valign="top" rowspan="2" ><%=invalidPlugin.getName()%></td>
  <td class="icon" valign="top" rowspan="2"><html:img page="/images/red.gif"/></td>
  <td colspan="3">Error messages:</td>
</tr>
<tr>
  <td>&nbsp;</td><td colspan="3">
  <ol>
  <logic:iterate name="invalidPlugin" property="errors" id="errorMessage" type="java.lang.String">
  <li><bean:write name="errorMessage"/></li>
  </logic:iterate>
  </ol>
</td>
</tr>
<tr>
  <td class="separator" colspan="5"><html:img page="/images/nothing.gif" width="1" height="1"/></td>
</tr>
</logic:iterate>

<logic:iterate name="pluginNames" id="pluginName" type="java.lang.String">
<tr class="plugin">
  <td class="pluginName" valign="top"><%=pluginName%></td>
  <td class="icon" valign="top" rowspan="2"><html:img page="/images/green.gif"/></td>
  <% neo.xredsys.plugin.Plugin plugin = pluginManager.getPlugin(pluginName); %>
  <td class="version"><%=plugin.getVersion()==null?"&nbsp;":plugin.getVersion()%></td>
  <td class="label"><%=plugin.getLabel()==null?"&nbsp;":plugin.getLabel()%></td>
  <td class="description"><%=plugin.getDescription()%></td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td colspan="3">
    <% java.util.Collection resources = plugin.getResourcesLike(new neo.xredsys.plugin.Resource()); %>
    <% if (resources.size() > 0) { %>
    <table class="plugin-description">
      <tr>
         <th>Type</th>
         <th>Target</th>
         <th>Task</th>
         <th>Area</th>
         <th>Roles</th>
         <th>Label</th>
         <th>LabelKey</th>
         <th>Uri</th>
      </tr>
    <logic:iterate collection="<%=resources%>" id="resource" type="neo.xredsys.plugin.Resource">
      <tr>
      <td><%= resource.getType() %></td>
      <td><%= resource.getTarget() %></td>
      <td><%= resource.getTask() %></td>
      <td><%= resource.getArea() %></td>
      <td>[...]</td>
      <td><%= resource.getLabel() %></td>
      <td><%= resource.getLabelKey() %></td>
      <td><%= resource.getUri() %></td>
      </tr>
    </logic:iterate>
    </table>
    <% } %>
  </td>
</tr>
<tr>
  <td class="separator" colspan="5"><html:img page="/images/nothing.gif" width="1" height="1"/></td>
</tr>
</logic:iterate>
<tr>
  <td colspan="5">
    <p>Plug-ins are installed to the application class path, and typically bundled in the Enterprise Archive, using the Assembly Tool.</p>
  </td>
</tr>
</table>



