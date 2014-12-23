<%@ page import="neo.xredsys.api.IOAPI" %>
<%@ page import="neo.xredsys.api.Section" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-view" prefix="view" %>

<bean:define id="publication"
             name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<bean:define id="user"
             name="escenic-user" scope="session" type="neo.xredsys.api.User" />
<bean:define id="selectionForm"
                 name="neo.phoenix.section.SectionSearchForm"
                 type="neo.phoenix.section.SectionSearchForm"/>
<bean:define id="checker"
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<div class="error"><html:errors property="global" /></div>

<%
  java.util.Set displayedItems = new java.util.TreeSet();
  request.setAttribute("displayedItems", displayedItems);
%>
  <input type="hidden" name="validateInput" value="success">
  <input type="hidden" name="submitButton" value="success">
  <html:hidden property="multipleSelection"/>
  <html:hidden property="onlyVirtualTarget"/>
  <html:hidden property="hideVirtualSections"/>
  <html:hidden property="nonSelectable"/>
  <html:hidden property="hideFromId"/>
  <%
    boolean checkArticleType = false;
    int homePub = -1;
    String type = null;
    String accessLevel = "administrator";
    if(!neo.util.StringUtil.isEmpty(selectionForm.getParentWorkItemId())){
      neo.phoenix.base.WorkItemManager workItemManager = (neo.phoenix.base.WorkItemManager) session.getAttribute("WorkItemManager");
      neo.phoenix.base.WorkItem item = workItemManager.getWorkItem(selectionForm.getParentWorkItemId());
      if(item.getForm() instanceof neo.phoenix.section.SectionForm){
        neo.phoenix.section.SectionForm form = (neo.phoenix.section.SectionForm)item.getForm();
        if(form.getIdInt()<0){
          accessLevel = "reader";
        }
      }else if(item.getForm() instanceof neo.phoenix.base.MultiSearchForm){
        accessLevel = "editor";
      }
    }
    request.setAttribute("accessLevel",accessLevel);

  %>
  <% if ("/homepage/section/choose".equals(request.getAttribute("task"))) { %>
  <br />
  <div class="explanatory-text">
    <bean:message key="t.Explanation_for_section_chooser_on_home_page"/>
  </div>
  <% } %>
  <br />

  <table cellspacing="0" cellpadding="0" border="0">
  <tr>
   <td><bean:message key="t.Look_up_section_by_name"/>:&nbsp;</td>
   <td><html:text property="searchString"/></td>
   <td>&nbsp;</td>
   <td><a class="global-button" href="javascript:submitForm('action:/section/search/namesearch.do')"><bean:message key="b.find"/></a></td>
  </tr>
  </table>
  <html:hidden property="parentWorkItemId" />
  <html:hidden property="shadowParentId" />
  <%
    if (!neo.util.StringUtil.isEmpty((String)request.getAttribute("shadowParentId"))) {
      selectionForm.setShadowParentId((String)request.getAttribute("shadowParentId"));
    }
    java.util.HashMap parentSections = new java.util.HashMap();
    if (!StringUtils.isBlank(selectionForm.getShadowParentId())) {
      String shadowParentId = selectionForm.getShadowParentId();
      Section shadowSection = IOAPI.getAPI().getObjectLoader().getSection(Integer.parseInt(shadowParentId));
      parentSections.put(shadowSection.getHashKey(), null);
      Section parentSection = shadowSection.getParent();
      while (parentSection != null && parentSection.getId() != -1) {
        parentSections.put(parentSection.getHashKey(), null);
        parentSection = parentSection.getParent();
      }
    }
    request.setAttribute("parentSections", parentSections);
  %>

  <logic:present name="selectionForm" property="expandedNodes">
  <logic:iterate name="selectionForm" property="expandedNodes" id="item" >
    <% if (item != null) { %>
      <input type="hidden" name="expandedNodes" value="<%=item%>">
    <% } %>
  </logic:iterate>
  </logic:present>

  <logic:present name="selectionForm" property="hiddenNodes">
  <logic:iterate name="selectionForm" property="hiddenNodes" id="item2" >
    <% if (item2 != null) { %>
      <input type="hidden" name="hiddenNodes" value="<%=item2%>">
    <% } %>
  </logic:iterate>
  </logic:present>


<logic:present name="neo.phoenix.section.SearchResults">
  <section:view id="view" section="<%=publication.getRootSection()%>" />
  Search results:
  <logic:iterate name="neo.phoenix.section.SearchResults" id="section" type="neo.xredsys.api.Section">
    <%-- If the node is a "hidden" node -- simply ignore it. --%>
    <% boolean _hidden = false; %>
    <logic:present name="selectionForm" property="hiddenNodes">
      <logic:iterate name="selectionForm" property="hiddenNodes" id="hiddenSectionId" type="java.lang.String">
        <% neo.xredsys.api.Section hiddenSection = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getSection(Integer.parseInt(hiddenSectionId));
           com.escenic.common.util.tree.Relationships rel = view.relationships(section, hiddenSection);
           if (rel.isAncestor() || rel.isBase()) _hidden = true;
         %>
      </logic:iterate>
    </logic:present>

   <% if (!_hidden) { %>
    <br />
    <%
      boolean showCheckBox = false;
      if(accessLevel.equalsIgnoreCase("journalist")){
        showCheckBox = checker.isJournalist(section);
      }else if(accessLevel.equalsIgnoreCase("editor")){
        showCheckBox = checker.isEditor(section);
      }else if(accessLevel.equalsIgnoreCase("administrator")){
        showCheckBox = checker.isAdministrator(section);
      }else if(accessLevel.equalsIgnoreCase("reader")){
        showCheckBox = checker.isReader(section);
      }
      boolean multiple = neo.util.StringUtil.getBoolean(selectionForm.getMultipleSelection());
      if(showCheckBox){
        boolean onlyVirtual = neo.util.StringUtil.getBoolean(selectionForm.getOnlyVirtualTarget());
        boolean hideVirtual = neo.util.StringUtil.getBoolean(selectionForm.getHideVirtualSections());
        boolean isVirtual = false;
        boolean isVirtualTarget = false;
        if(section instanceof neo.xredsys.api.VirtualSection){
          isVirtual = true;
        }else{
          isVirtualTarget = section.isVirtualSource();
        }
        if(onlyVirtual&&!isVirtualTarget){
          showCheckBox = false;
        }else if(hideVirtual&&isVirtual){
          showCheckBox = false;
        }
      }
    %>
    <section:use section="<%=section%>">
      <%if(!multiple&&showCheckBox){%>
        <% if (!parentSections.containsKey(section.getHashKey())) { %>
          <html:checkbox property="<%=\"selectedNode(\" + section.getId() + \")\" %>" />
        <% } %>
        <% displayedItems.add("" + section.getId()); %>
      <%}else if(multiple && showCheckBox){%>
        <% if (!parentSections.containsKey(section.getHashKey())) { %>
          <html:radio property="<%=\"selectedNode(\" + section.getId() + \")\" %>" value="<%= \"\" + section.getId() %>" />
        <% } %>
        <% displayedItems.add("" + section.getId()); %>
      <%}%>
      <bean:write name="section" property="name"/>
    </section:use>
   <% } %>
  </logic:iterate>
  <hr>
  <a href="javascript:submitForm('action:/base/clearSessionAttribute.do?attribute=neo.phoenix.section.SearchResults')">View Tree</a>
</logic:present>

<logic:notPresent name="neo.phoenix.section.SearchResults">
  <%
    java.util.Collection friendly = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getFriendlyPublications(user);
    boolean showHomePub = true;
    if(checkArticleType){
      if(publication.getId()!=homePub){
        showHomePub = neo.xredsys.content.type.TypeManager.getInstance().isTypeDefined(type,publication.getId());
      }
    }
  %>
  <table>
    <%if(friendly.size()>0&&showHomePub){ %>
      <tr><th align="left"><%=publication.getName()%></th></tr>
    <%}%>
    <%if(showHomePub){%>
      <tr><td>
        <section:use section="<%=publication.getRootSection()%>">
          <jsp:include page="choose-recurse.jsp" />
        </section:use><br>
      </td></tr>
    <%}%>
    <%
      java.util.Iterator it = friendly.iterator();
      while(it.hasNext()){
    %>
      <% neo.xredsys.api.Publication pub = (neo.xredsys.api.Publication)it.next(); %>
      <% if(!checkArticleType || neo.xredsys.content.type.TypeManager.getInstance().isTypeDefined(type,pub.getId())){%>
        <tr><th align="left"><%=pub.getName()%></th></tr>
        <tr><td>
          <section:use section="<%=pub.getRootSection()%>">
            <jsp:include page="choose-recurse.jsp" />
          </section:use><br>
        </td></tr>
      <%}%>
    <%}%>
  </table>
</logic:notPresent>

<logic:iterate name="selectionForm" property="selectedNodes" id="item" >
  <% if (!displayedItems.contains(item)) { %>
    <html:hidden property="<%=\"selectedNode(\" + item + \")\"%>" value="on"/>
  <% } %>
</logic:iterate>

<fieldset class="unstyled buttons">
<input type="button" class="important-button" onClick="submitForm('finished')" value="<bean:message key="b.finished"/>"/>
<input type="button" class="link" onClick="submitForm('cancel')" value="<bean:message key="b.cancel"/>"/>
</fieldset>
