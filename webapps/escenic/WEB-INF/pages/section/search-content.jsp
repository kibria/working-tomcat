<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-view" prefix="view" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>

<bean:define id="checker"
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />

<bean:define id="publication"
             name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<bean:define id="user"
             name="escenic-user" scope="session" type="neo.xredsys.api.User" />
<bean:define id="selectionForm"
                 name="neo.phoenix.section.SectionSearchForm"
                 type="neo.phoenix.section.SectionSearchForm"/>
<input type="hidden" name="enterAction" value="action:/section/search/namesearch.do"/>
<div class="error"><html:errors property="global" /></div>

<util:toggle id="toggle" name="textmap-liststyles" toScope="request" />

<%
  java.util.Set displayedItems = new java.util.TreeSet();
  request.setAttribute("displayedItems", displayedItems);
%>
  <input type="hidden" name="validateInput" value="success">
  <input type="hidden" name="submitButton" value="action:/section/search/namesearch.do">
  <table>
    <tr>
      <td>
       <bean:message key="t.Look_up_section_by_name"/>:
       </td>
      <td>
        <html:text property="searchString"/>
      </td>
    </tr>
    <tr>
      <td align="right">
        <bean:message key="t.id"/>:
      </td>
      <td>
        <html:text property="sectionId"/><html:errors property="sectionId"/>
      </td>
    </tr>
    <tr>
      <td align="right">
        <bean:message key="t.Include_hidden_section"/>:
      </td>
      <td>
        <html:checkbox property="includeHiddenSection" onclick="javascript:submitForm('section-archive')"/>
        <html:errors property="includeHiddenSection"/>
      </td>
    </tr>
  </table>
  <table>
    <tr>
      <td>
        <input type="button" class="important-button" onclick="submitForm('action:/section/search/namesearch.do')" value='<bean:message key="b.search"/>'/>
      </td>
      <td>
        <input type="button" class="link" onclick="submitForm('reset')" value='<bean:message key="b.clear_search"/>'/>
      </td>
    </tr>
  </table>

  <hr>
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
  
  
  
  <logic:notPresent name="neo.phoenix.section.SearchResults">
  
  <%if(checker.hasSectionRole(publication)){%>
  <table cellpadding="2" border="0">
    <section:use section="<%=publication.getRootSection()%>">
      <jsp:include page="search-recurse.jsp" />
    </section:use>
    
  </table>  <br/>
  <%}%>
    
    <logic:iterate name="selectionForm" property="selectedNodes" id="item3" >
    
      <% if (!displayedItems.contains(item3)) { %>
        <html:hidden property="<%=\"selectedNode(\" + item3 + \")\"%>" value="on"/>
      <% } %>
    </logic:iterate>
    <%
    java.util.Collection friendly = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getFriendlyPublications(user);
    %>
     <%-- <util:toggle id="toggle" name="textmap-liststyles"/> --%>
     
  <table cellpadding="2"  border="0">
    <%
      java.util.Iterator it = friendly.iterator();
      while(it.hasNext()){
    %>
      <% neo.xredsys.api.Publication pub = (neo.xredsys.api.Publication)it.next();
        if(!checker.hasSectionRole(pub)){
          continue;
        }
      %>
    
      <tr><th align="left"><%=pub.getName()%></th></tr>
      <!--<tr  property="value" /><td> -->
      <section:use section="<%=pub.getRootSection()%>">
        <jsp:include page="search-recurse.jsp" />
      </section:use>
      <tr><td colspan="2">&nbsp;</td></tr>
      <logic:iterate name="selectionForm" property="selectedNodes" id="item3" >
        <% if (!displayedItems.contains(item3)) { %>
          <html:hidden property="<%=\"selectedNode(\" + item3 + \")\"%>" value="on"/>
        <% } %>
      </logic:iterate>
    <!--</td></tr>-->
    <%}%>
  </table>


  </logic:notPresent>

<%-- Hack to remember expanded nodes..... --%>
<%  request.getSession().setAttribute("escenic-section-expandedNodes",selectionForm.getExpandedNodes()); %>

<logic:present name="neo.phoenix.section.SearchResults">
  
  <% if(((java.util.Collection)request.getSession().getAttribute("neo.phoenix.section.SearchResults")).size()==0){%>
    <bean:message key="t.No_sections_found"/>
  <%}else{%>
    
    <strong><bean:message key="t.Search_Result"/></strong>:<br>
    
    <table cellpadding="2" cellspacing="0">
		<!-- <th width="60%" align="left">Sekjsonnavn:</td><th align="right">Handling</th> -->
    <logic:iterate name="neo.phoenix.section.SearchResults" id="section" type="neo.xredsys.api.Section">

      <section:use section="<%=section%>">
        <% displayedItems.add("" + section.getId()); %>

          <% try{%>
           <util:toggleNext name="toggle" scope="request"/>
    <tr class='<bean:write name="toggle" property="value" />'>
        <td >
  <template:call file="../base/presentSection.jsp">
    <template:parameter key="editpool" value="true"/>
    <template:parameter key="noTable" value="true"/>
    <template:parameter key="sectionId" value="<%=String.valueOf(section.getId())%>" />
    <template:parameter key="pubId" value="<%=String.valueOf(section.getOwnerPublicationId())%>" />
  </template:call>

<%--
            <%
            neo.xredsys.api.Section parent = section.getParent();
            String tmp = section.getName();
            while(parent!=null){
              tmp = parent.getName() + "\\" + tmp;
              parent = parent.getParent();
            }
          %>
          <%=tmp%> (<%=section.getId()%>)
        </td>
        <td align="right">
            <% int poolId = section.getActivePool().getId();%>


            <% if (checker.isAdministrator(section)) {%>
            [ <a  href="javascript:submitForm('redirect:/section/view.do?id=<%=section.getId()%>')"><bean:message key="t.Administrate"/></a> ]&nbsp;<% } %>
			<% if (checker.isEditor(section)) {%>
         	[ <a href="javascript:submitForm('redirect:/pool/edit.do?id=<%=poolId%>')"><bean:message key="t.Edit"/></a> ]
  <%-            could happen of section is deleted..-%>
          <% } else if (checker.isReader(section)) {%> 
          	[ <a href="javascript:submitForm('redirect:/pool/edit.do?id=<%=poolId%>&readOnly=true')"><bean:message key="t.Edit"/></a> ]
  <%-            could happen of section is deleted..-%>
          <% }%> 
--%>
        </td>
        <td align="right"> 

          <%-- Start Admin and Section links --%>
        <% if (checker.isAdministrator(section) || checker.isUserAdmin(section)) {%>
	      [ <a href="javascript:submitForm('redirect:/section/view.do?id=<%=section.getId()%>')"><bean:message key="t.Administrate"/></a> ]
        <% } %>
          <%-- End Admin and Section links --%>

        </td>  
        </tr>
     

          <%}catch(Exception e){}%>
      </section:use>
    </logic:iterate>
    </table>
  <%}%>
   <br /><br />
   <table cellpadding="0" cellspacing="0" border="0">
   <tr>
    <td>
        <a href="javascript:submitForm('action:/base/clearSessionAttribute.do?attribute=neo.phoenix.section.SearchResults')" class="global-button"><bean:message key="b.view_tree"/></a>
    </td>
   </tr>
   </table>
</logic:present>

<%if(checker.isEditor()||checker.isSectionAdministrator()){%>
<br>
<table cellpadding="0" cellspacing="0" border="0">
<tr>
 <td><html:link page="/section/summarize.do" styleClass="global-button"><bean:message key="b.summary"/>..</html:link></td>
</tr>
</table>
<%}%>
<%--
<!--
<h3>// try to view the tree</h3>
Possible solution with a maximum hard-coded depth.  Recursive in that it repeats the recursed code in-line....
<pre>
// go to the root node.
// if the root is expanded (typically)
//   show its contents.
// if any of the items contained are expanded, show them
</pre>
<h3>Another solution</h3>
Any number of levels---
<pre>
// go to the root node
// call recurse.jsp using the root section
//   recurse.jsp prints out the node, and
//   if it is expanded, it also
//     recurses for all children.
</pre>

-->
--%>
