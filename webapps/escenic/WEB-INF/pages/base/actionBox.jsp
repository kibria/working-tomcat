<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%--
 Common actionbox which can be used from all editors. It is possible to configure
 this box by parameters:
 readOnly - required, should it be readonly mode?
 statesLabelKey - which label to display above states
 states - which states to display in a comma separated list
 saveAction
 saveAndCloseAction
 closeAction
 previewAction
 copyAction
--%>
<%@ page import="java.util.*"%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-view" prefix="view" %>
<bean:define id="read" name="readOnly" type="java.lang.String"/>


<%
    boolean isReadOnly = neo.util.StringUtil.getBoolean(read);
    boolean isDisabled = false;


    String disable = "false";
    if (request.getAttribute("disableMenu") != null) disable = (String)request.getAttribute("disableMenu");
    pageContext.setAttribute("disable", disable);
%>

<logic:present name="disableMenu">

<%

    if (disable != null && disable.equals("true")) {
        isDisabled= neo.util.StringUtil.getBoolean(disable);
        isReadOnly = true;
    }
%>
</logic:present>


<div class="actionbox">                                       
<logic:present name="states">
  <bean:define id="allowedStates" name="states" type="java.lang.String" />
  <logic:present name="statesLabelKey">
    <h2><bean:message bundle="org.apache.struts.action.MESSAGE" key='<%=(String)request.getAttribute("statesLabelKey")%>'/></h2>
  </logic:present>
  <logic:notPresent name="statesLabelKey">
    <%--<bean:message bundle="org.apache.struts.action.MESSAGE" key=''/> --%>
    <h2>FIXME: Actions...</h2>
  </logic:notPresent>
  <div class="actionbox-content">
  <html:select name="contextForm" property="state" disabled="<%=isReadOnly%>">
  <%
    StringTokenizer token = new StringTokenizer(allowedStates ,",");
    Set displayStates = new HashSet();
    while(token.hasMoreTokens()){
      String nextToken = token.nextToken();
      displayStates.add(nextToken);
    }
    String showDraft = String.valueOf(displayStates.contains("draft"));
    request.setAttribute("showDraft",showDraft);
    String showSubmitted = String.valueOf(displayStates.contains("submitted"));
    request.setAttribute("showSubmitted",showSubmitted);
    String showApproved = String.valueOf(displayStates.contains("approved"));
    request.setAttribute("showApproved",showApproved);
    String showPublished = String.valueOf(displayStates.contains("published"));
    request.setAttribute("showPublished",showPublished);
    String showDeleted = String.valueOf(displayStates.contains("deleted"));
    request.setAttribute("showDeleted",showDeleted);
    String showUnpublished = String.valueOf(displayStates.contains("unpublished"));
    request.setAttribute("showUnpublished",showUnpublished);
    %>
    <%-- needs to check which state to display --%>
    <% if("true".equals(showDraft)) {%>
        <html:option value="draft" disabled="<%=isReadOnly%>"><bean:message bundle="org.apache.struts.action.MESSAGE" key="t.State_Draft"/></html:option>
    <%}%>
    <% if("true".equals(showSubmitted)) {%>
        <html:option value="submitted" disabled="<%=isReadOnly%>"><bean:message bundle="org.apache.struts.action.MESSAGE" key="t.State_Submitted"/></html:option>
    <%}%>
    <% if("true".equals(showApproved)) {%>
        <html:option value="approved" disabled="<%=isReadOnly%>"><bean:message bundle="org.apache.struts.action.MESSAGE" key="t.State_Approved"/></html:option>
    <%}%>
    <% if("true".equals(showPublished)) {%>
        <html:option value="published" disabled="<%=isReadOnly%>"><bean:message bundle="org.apache.struts.action.MESSAGE" key="t.State_Published"/></html:option>
    <%}%>
    <% if("true".equals(showDeleted)) {%>
        <html:option value="deleted" disabled="<%=isReadOnly%>"><bean:message bundle="org.apache.struts.action.MESSAGE" key="t.State_Deleted"/></html:option>
    <%}%>
    <% if("true".equals(showUnpublished)) {%>
        <html:option value="unpublished" disabled="<%=isReadOnly%>"><bean:message bundle="org.apache.struts.action.MESSAGE" key="t.State_Unpublished"/></html:option>
    <%}%>
     <%-- adds hidden state if object is readonly --%>
    <% if("true".equals(read)) {%>
        <html:hidden property="state"/>
    <%}%>
  </html:select>
</logic:present>
<logic:notPresent name="states">
  <div class="actionbox-content">
</logic:notPresent>

<logic:equal name="disable" value="false">       
  <ul class="actionbox-actions">
  <logic:present name="saveAction">
    <bean:define id="sAction" name="saveAction"/>
    <li class="actionbox-action-save">
           <input <%= isReadOnly?"disabled=\""+isReadOnly+"\"":""%> type="button" onClick="<%=sAction%>" class="important-button" value="<bean:message bundle="org.apache.struts.action.MESSAGE" key="b.save"/>"/>
    </li>
  </logic:present>
  <logic:present name="saveAndCloseAction">
    <bean:define id="scAction" name="saveAndCloseAction"/>
    <li class="actionbox-action-saveandclose">
      <% if (!isReadOnly) { %>
        <input type="button" onClick="<%=scAction%>" class="link" value="<bean:message bundle="org.apache.struts.action.MESSAGE" key="b.save_and_close"/>" />
      <% } else { %>
        <span class="global-button"><bean:message bundle="org.apache.struts.action.MESSAGE" key="b.save_and_close"/></span>
      <%}%>
    </li>
  </logic:present>
  <logic:present name="previewAction">
    <bean:define id="pAction" name="previewAction"/>
    <li class="actionbox-action-preview">
     <input type="button" onClick="<%=pAction%>" class="link" value="<bean:message bundle="org.apache.struts.action.MESSAGE" key="b.preview"/>" />
    </li>
  </logic:present>
  <logic:present name="copyAction">
    <bean:define id="cpAction" name="copyAction"/>
    <li class="actionbox-action-copy">
     <input type="button" onClick="<%=cpAction%>" class="link" value="<bean:message bundle="org.apache.struts.action.MESSAGE" key="b.copy"/>" />
    </li>
  </logic:present>
  <logic:present name="closeAction">
    <bean:define id="cAction" name="closeAction"/>
    <li class="actionbox-action-close">
     <input type="button" onClick="<%=cAction%>" class="link" value="<bean:message bundle="org.apache.struts.action.MESSAGE" key="b.close"/>" />
    </li>
  </logic:present>
  <logic:present name="infoUrl">
     <bean:define id="infUrl" name="infoUrl"/>
     <bean:define id="infoTxt" name="infoText"/>
    <li class="actionbox-action-info">
      <input type="button" onClick="<%=infUrl%>" target="_new" class="link" value="<%=infoTxt%>" />
     </li>
  </logic:present>
 </ul>
 </logic:equal>

 <logic:equal name="disable" value="true">
 <ul class="disabled">
  <logic:present name="saveAction">
   <li class="actionbox-action-save">
    <span class="global-button"><bean:message bundle="org.apache.struts.action.MESSAGE" key="b.save"/></span>
   </li>
  </logic:present>
  <logic:present name="saveAndCloseAction">
    <li class="actionbox-action-saveandclose">
      <span class="global-button"><bean:message bundle="org.apache.struts.action.MESSAGE" key="b.save_and_close"/></span>
    </li>
  </logic:present>
  <logic:present name="closeAction">
    <li class="actionbox-action-close">
     <span class="global-button"><bean:message bundle="org.apache.struts.action.MESSAGE" key="b.close"/></span>
    </li>
  </logic:present>
  <logic:present name="previewAction">
    <li class="actionbox-action-preview">
     <span class="global-button"><bean:message bundle="org.apache.struts.action.MESSAGE" key="b.preview"/></span>
    </li>
  </logic:present>
  <logic:present name="infoUrl">
     <bean:define id="infoTxt2" name="infoText"/>
     <li class="actionbox-action-info">
      <span class="global-button"><%=infoTxt2%></span>
     </li>
  </logic:present>
  <logic:present name="copyAction">
    <li class="actionbox-action-copy">
     <span class="global-button"><bean:message bundle="org.apache.struts.action.MESSAGE" key="b.copy"/></span>
    </li>
  </logic:present>
 </ul>
 </logic:equal>
 </div>
</div>
