<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page import="neo.xredsys.api.Section,
                 neo.xredsys.api.VirtualSection"%>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<bean:define id="section"
                 name="section"
                 type="neo.xredsys.api.Section"/>
<bean:define id="selectionForm"
                 name="neo.phoenix.section.SectionSearchForm"
                 type="neo.phoenix.section.SectionSearchForm"/>
<bean:define id="displayedItems"
                 name="displayedItems"
                 type="java.util.Set"/>
<bean:define id="checker"
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />

  <util:toggleNext name="toggle" scope="request"/>
 <% if (!selectionForm.isHidden("" + section.getId())
       && (!section.isHidden()
            || neo.util.StringUtil.getBoolean(selectionForm.getIncludeHiddenSection()))) { %>
 <tr class='<bean:write name="toggle" property="value" /><%= (section.isHidden())? " section-hidden":""%>'>
 <td width="60%">
   <div style="margin-left: <%=request.getAttribute("level")%>mm; border-left: 1pt;">
 <%
 if (request.getAttribute("level") == null) {
 	request.setAttribute("level", "3");
} else {
	int level = Integer.parseInt((String)request.getAttribute("level"));
	level += 3;
	request.setAttribute("level", new Integer(level).toString());
}
 	
 
 %>

<%
  int displayedSubCount = 0;
  neo.xredsys.api.Section[] subs = section.getSubSections();
  for (int i = 0; i < subs.length; i++) {
    if(checker.isVisible(subs[i])){
      displayedSubCount++;
    }
  }
%>

<% if (selectionForm.isExpanded("" + section.getId()) && displayedSubCount>0) {
  request.setAttribute("expanded", "true");
} else {
  request.setAttribute("expanded", "false");
}
  %>

<% if (request.getAttribute("expanded").equals("true")) {%>

  <a href="javascript:submitForm('action:/section/search/contract.do?_treeNode=<%=section.getId()%>')"><html:img src="<%= request.getContextPath() + \"/images/minus.gif\" %>" border="0" /></a>
  <template:call file="../base/presentSection.jsp">
    <template:parameter key="editpool" value="true"/>
    <template:parameter key="noTable" value="true"/>
    <template:parameter key="sectionId" value="<%=String.valueOf(section.getId())%>" />
    <template:parameter key="pubId" value="<%=String.valueOf(section.getOwnerPublicationId())%>" />
   
  </template:call>
  </div>
   
</td>
<td align="right"> 

  <%-- Start Admin and Sectino links --%>
  <% if (checker.isAdministrator(section) || checker.isUserAdmin(section)) {%>
	[ <a href="javascript:submitForm('redirect:/section/view.do?id=<%=section.getId()%>')"><bean:message key="t.Administrate"/></a> ]
  <% } %>
  <%-- End Admin and Sectino links --%>


  </td>
  </tr>
  <logic:iterate name="section" property="subSections" id="s" type="neo.xredsys.api.Section">
    <section:use section="<%=s%>">
      <% if(!s.getType().getName().equals("hidden") &&
             checker.isVisible(s)){%>
        <% request.setAttribute("level", request.getAttribute("level")); %>     
        <jsp:include page="search-recurse.jsp" />
      <%}%>
    </section:use>
       
  </logic:iterate>
   
<%}else {%>

  <% if (displayedSubCount > 0) { %>
    <a href="javascript:submitForm('action:/section/search/expand.do?_treeNode=<%=section.getId()%>')"><html:img src="<%= request.getContextPath() + \"/images/plus.gif\" %>" border="0" /></a>
  <% } else { %>
    <html:img src="<%= request.getContextPath() + \"/images/none.gif\" %>" border="0" />
  <% } %>
  <template:call file="../base/presentSection.jsp">
    <template:parameter key="editpool" value="true"/>
    <template:parameter key="noTable" value="true"/>
    <template:parameter key="sectionId" value="<%=String.valueOf(section.getId())%>" />
    <template:parameter key="pubId" value="<%=String.valueOf(section.getOwnerPublicationId())%>" />
  </template:call>
  </div>
</td>
<td align="right"> 
	<%-- Start Admin and Sectino links --%>
  <% if (checker.isAdministrator(section) || checker.isUserAdmin(section)) {%>
	[ <a href="javascript:submitForm('redirect:/section/view.do?id=<%=section.getId()%>')"><bean:message key="t.Administrate"/></a> ]
  <% } else {%>
    &nbsp;
  <% } %>
  <%-- End Admin and Sectino links --%>
 </td>
 </tr>
<%}%>









 <%
 if (request.getAttribute("level") == null) {
 	request.setAttribute("level", "3");
} else {
	int level = Integer.parseInt((String)request.getAttribute("level"));
	level -= 3;
	request.setAttribute("level", new Integer(level).toString());
}
     } 	
 
 %>