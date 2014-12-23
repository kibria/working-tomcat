<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<bean:define id="publication"
             name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
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
    if(!subs[i].getType().getName().equals("hidden") &&
            checker.isVisible(subs[i])){
      displayedSubCount++;
    }
  }
  String listClass = "collapsed";
  String listImg = "/images/plus.gif";
  if (displayedSubCount == 0) {
    // Not expandable section links
    listClass = "";
  } else if (section == publication.getRootSection()) {
    listClass = "expanded";
    listImg = "/images/minus.gif";
  }
  request.setAttribute("listClass", listClass);
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

  boolean showCheckBox = false;
  if(accessLevel.equalsIgnoreCase("journalist")){
    showCheckBox = checker.isJournalist(section);
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
  <% if (!selectionForm.isHidden("" + section.getId())
    && (!section.isHidden()
            || neo.util.StringUtil.getBoolean(selectionForm.getIncludeHiddenSection()))) { %>
  <%= (section.isHidden())? "<div class='section-hidden'>":""%>
  <div class="<%=listClass%>" style="margin-left: 3mm; border-left: 1pt;">
    <logic:notEmpty name="listClass">
      <a href="javascript:void(0);" onclick="javascript:toggleListStyle(this.parentNode,'expanded','collapsed','<%= request.getContextPath() + "/images/minus.gif" %>', '<%= request.getContextPath() + "/images/plus.gif" %>')">
        <img src="<%= request.getContextPath() + listImg %>" border="0"/>
      </a>
   </logic:notEmpty>
    <logic:empty name="listClass">
      <img src="<%= request.getContextPath() + "/images/none.gif" %>" border="0"/>
   </logic:empty>
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
            neo.util.StringUtil.getBoolean(selectionForm.getHideVirtualSections()))){ %>
      <html:radio property="singleSelectedNode" value="<%= \"\" + section.getId() %>" />
      <%}%>
      <%}%>
  <% } %>
  <% displayedItems.add("" + section.getId()); %>
    <template:call file="../base/presentSection.jsp">
      <template:parameter key="noTable" value="true"/>
      <template:parameter key="sectionId" value="<%=String.valueOf(section.getId())%>" />
      <template:parameter key="pubId" value="<%=String.valueOf(section.getOwnerPublicationId())%>" />
      <template:parameter key="popup" value="true"/>      
    </template:call>
    <div class="subSection">
    <logic:iterate name="section" property="subSections" id="s" type="neo.xredsys.api.Section">
      <section:use section="<%=s%>">
        <% if(!s.getType().getName().equals("hidden") &&
            checker.isVisible(s)){%>
            <jsp:include page="choose-popup-recurse.jsp" />
        <%}%>
      </section:use>
    </logic:iterate>
    </div>
  </div>
  <%= (section.isHidden())? "</div>":""%>
  <% } %> <%-- isHidden --%>
<%}%>
