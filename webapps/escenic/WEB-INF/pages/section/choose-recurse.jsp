<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<bean:define id="section"
                 name="section"
                 type="neo.xredsys.api.Section"/>
<bean:define id="accessLevel"
                 name="accessLevel"
                 type="java.lang.String"/>
<bean:define id="selectionForm" 
                 name="neo.phoenix.section.SectionSearchForm"
                 type="neo.phoenix.section.SectionSearchForm"/>
<bean:define id="displayedItems" 
                 name="displayedItems"
                 type="java.util.Set"/>
<bean:define id="checker" 
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />                 
<% 
  int displayedSubCount = 0; 
  neo.xredsys.api.Section[] subs = section.getSubSections();
  for (int i = 0; i < subs.length; i++) {
    if(checker.isVisible(subs[i])){
      displayedSubCount++;
    }
  }
  int hideFromId = -1;
  try{
    hideFromId = Integer.parseInt(selectionForm.getHideFromId());
  }catch(Exception e){
  }
  int nonSelectable = -1;
  try{
    nonSelectable = Integer.parseInt(selectionForm.getNonSelectable());
  }catch(Exception e){
  }

  java.util.HashMap parentSections = (java.util.HashMap) request.getAttribute("parentSections");
  if (parentSections == null) {
    parentSections = new java.util.HashMap();
  }

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
  if(nonSelectable==section.getId()){
    showCheckBox=false;
  }
%>
<% if(hideFromId!=section.getId()){%>
  <% if (!selectionForm.isHidden("" + section.getId())) { %>
  <% if (selectionForm.isMultipleSelectionBoolean() && 
      ((!selectionForm.showOnlyVirtualTargets())||
         (selectionForm.showOnlyVirtualTargets()&&section.isVirtualSource()))
        ){
  %>
    <%if(showCheckBox){%>
      <%if(!(section instanceof neo.xredsys.api.VirtualSection &&  
            neo.util.StringUtil.getBoolean(selectionForm.getHideVirtualSections()))){%>
        <html:checkbox property="<%=\"selectedNode(\" + section.getId() + \")\" %>" />
      <%}%>
    <%}%>
  <% } else if((!selectionForm.showOnlyVirtualTargets())||
         (selectionForm.showOnlyVirtualTargets()&&section.isVirtualSource())){ %>
    <%if(showCheckBox){%>
      <%if(!(section instanceof neo.xredsys.api.VirtualSection &&  
            neo.util.StringUtil.getBoolean(selectionForm.getHideVirtualSections())) &&
          !parentSections.containsKey(section.getHashKey())){ %>
      <html:radio property="singleSelectedNode" value="<%= \"\" + section.getId() %>" />
      <%}%>
      <%}%>
  <% } %>
  <% displayedItems.add("" + section.getId()); %>
  <% if(selectionForm.isExpanded("" + section.getId())) {%>
    <a href="javascript:submitForm('action:/section/search/contract.do?_treeNode=<%=section.getId()%>')"><html:img src="<%= request.getContextPath() + \"/images/minus.gif\" %>" border="0" /></a>
    <template:call file="../base/presentSection.jsp">
      <template:parameter key="noTable" value="true"/>
      <template:parameter key="sectionId" value="<%=String.valueOf(section.getId())%>" />
      <template:parameter key="pubId" value="<%=String.valueOf(section.getOwnerPublicationId())%>" />
    </template:call><br />
    <div style="margin-left: 3mm; border-left: 1pt;">
    <logic:iterate name="section" property="subSections" id="s" type="neo.xredsys.api.Section">
      <section:use section="<%=s%>">
        <% if(!s.getType().getName().equals("hidden") &&
            checker.isVisible(s)){%>
          <jsp:include page="choose-recurse.jsp" />
        <%}%>
      </section:use>
    </logic:iterate>
    </div>
  <%}else {%>
    <% if (section.getSubSections().length > 0) { %>
      <a href="javascript:submitForm('action:/section/search/expand.do?_treeNode=<%=section.getId()%>')">
<html:img src="<%= request.getContextPath() + \"/images/plus.gif\" %>" border="0" /></a>
    <% } else { %>
      <html:img src="<%= request.getContextPath() + \"/images/none.gif\" %>" border="0" />
    <% } %>
    <template:call file="../base/presentSection.jsp">
      <template:parameter key="noTable" value="true"/>
      <template:parameter key="sectionId" value="<%=String.valueOf(section.getId())%>" />
      <template:parameter key="pubId" value="<%=String.valueOf(section.getOwnerPublicationId())%>" />
    </template:call><br />
  <%}%>
  <% } %> <%-- isHidden --%>
<%}%>
