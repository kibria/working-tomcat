<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>

<%
  java.util.List reasons = new java.util.ArrayList();
  java.util.Map articletypes = (java.util.Map) request.getSession().getAttribute("uploaded-publication-resource:/escenic/article-type");
  java.util.Map contenttypes = (java.util.Map) request.getSession().getAttribute("uploaded-publication-resource:/escenic/content-type");
  java.util.Map layouts = (java.util.Map) request.getSession().getAttribute("uploaded-publication-resource:/escenic/layout");
  java.util.Map layoutsGroups = (java.util.Map) request.getSession().getAttribute("uploaded-publication-resource:/escenic/layout-group");
  // TODO: not used by Escenic 5.0..
  // java.util.Map teaserTypes = (java.util.Map) request.getSession().getAttribute("uploaded-publication-resource:/escenic/teaser-type");
  java.util.Map imageversions = (java.util.Map) request.getSession().getAttribute("uploaded-publication-resource:/escenic/image-version");
  if ( (articletypes == null || ! Boolean.TRUE.equals(articletypes.get("valid"))) && 
      (contenttypes == null || ! Boolean.TRUE.equals(contenttypes.get("valid"))) ) {
    reasons.add("Content Type Definition");
  }
  if (layouts == null || ! Boolean.TRUE.equals(layouts.get("valid"))) {
    reasons.add("Layout Definition");
  }

  /*if (teaserTypes == null || ! Boolean.TRUE.equals(teaserTypes.get("valid"))) {
    reasons.add("Teaser-type Definition");
  }*/

  if (reasons.size() != 0) {
    request.setAttribute("context","create-publication");
    pageContext.include("upload-resources-content.jsp");
    return;
  }

  java.util.Vector publishers = neo.xredsys.content.PublicationManager.getPublicationManager().getPublishers();
  java.util.Map archives = new java.util.HashMap();
  java.io.File f = new java.io.File(System.getProperty("templateRoot") + "pars");
  java.io.File[] parFiles = f.listFiles();
  if(parFiles!=null){
    for (int i = 0; i < parFiles.length; i++) {
      if (parFiles[i].getName().endsWith(".par")) {
        archives.put(neo.util.FileUtil.basename(parFiles[i].getName(), ".par"), parFiles[i].getName());
      }
    }
  }
%>
<script>

  function enableOrDisablePasswordFields() {
    if (document.getElementById("allowEmptyPassword").checked) {
      document.getElementById("password").disabled=true;
      document.getElementById("confirmPassword").disabled=true;
    } else {
      document.getElementById("password").disabled=false;
      document.getElementById("confirmPassword").disabled=false;
    }
  }
</script>

<table><tr><td valign="top">
<div><font color="red"><html:errors property="global" /></font></div>
<html:form action="/publication/insert" >
  The publication will be created based on the publication definition files you have uploaded.  If you want to use different files, you can <html:link page="/pages/publication/upload-resources.jsp">upload different files</html:link>.
  <table><tr><td><nobr>Publication Name:</nobr></td><td><html:text property="name" /></td>
  <td><span class="error"><html:errors property="name" /></span></td></tr>
  <tr><td>&nbsp;</td><td colspan="2"><div style="font-size: x-small">Note: The name must be a symbolic name, with no spaces or punctuation.  The publication name is simply an administrative name for the site.  For an intranet/internet server good examples include "intranet" or "internet"; while for a hosting site, consider using a symbolic customer name, e.g. "somecompany" or "johndoe"</div></td></tr>
  <html:hidden property="publisherName" value="<%=((neo.xredsys.Publisher)publishers.elementAt(0)).getName()%>"/>

  <tr>
    <td>Create publication without password</td>
    <td><html:checkbox property="allowEmptyPassword" styleId="allowEmptyPassword" value="true" onchange="enableOrDisablePasswordFields()"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td colspan="2">
      <div style="font-size: x-small">
        If this checkbox is enabled, the publication administrator will be created without a password. Users without
        passwords will not be able to log into Content Studio or Web Studio.
      </div>
      <div style="font-size: x-small">
        This option should only be enabled if users are authenticated using for instance Active Directory.
      </div>
    </td>
  </tr>

  <tr><td>Administrator password:</td><td>
  <html:password property="adminPassword" styleId="password"/>
  </td><td><span class="error"><html:errors property="adminPassword" /></span></td>
  </tr>
  <tr><td><bean:message key="t.Verify_password"/>:</td><td>
  <html:password property="adminPasswordConfirm" styleId="confirmPassword" />
  </td><td><span class="error"><html:errors property="adminPasswordConfirm" /></span></td>
  </tr>
  <tr><td>&nbsp;</td><td colspan="2"><div style="font-size: x-small">To access your publication after it has been created, an administrator user is created.  To protect access to the publication, you can specify the administrator's password.  Note: Take care of the administrator password.</div></td></tr>

</table>
  <html:submit />
</html:form>
</td>

<td valign="top">
<template:call file="/pages/base/box.jsp">
  <template:parameter key="title" value="Creating a new publication" />
  <template:parameter key="content" value="<B>A Publication</B> is the Escenic representation of one complete web-site.  Many installations only have one publication, while other installations have several publications.  To decide wether or not your installation requires several publications, an easy rule of thumb is <b>one publication per web site</b>.  Say Escenic is being used to power a company internet; you might only need one publication.  If Escenic is used to power several company internets, it is logical to create a Publication for each such web site.  The same rule could apply to an installation with a Company Intranet and Extranet; where the two sites would primarily contain different data." />
</template:call>
</td></tr></table>

