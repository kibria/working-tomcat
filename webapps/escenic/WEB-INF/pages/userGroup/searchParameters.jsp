<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<div id="userGroup-archive" class="archive"> 
<bean:define id="form" name="neo.phoenix.userGroup.UserGroupSearchForm"/>
    <bean:define id="publication"
             name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<bean:define id="checker"
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<%--<bean:define id="hidePubs" name="hidePubs" type="java.lang.String"/> --%>
<%-- <% if(checker.isUserAdmin(publication)&&!neo.util.StringUtil.getBoolean(hidePubs)){ %> --%>
<% if(checker.isUserAdmin(publication)){ %>
    <fieldset class="unstyled publication">
      <label>
        <span><bean:message key="l.Publication" bundle="org.apache.struts.action.MESSAGE"/>:</span>
        <%
          java.util.Collection friendly = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getFriendlyIds(publication.getId());
          java.util.Iterator it = friendly.iterator();
          neo.xredsys.api.Publication[] pubs = new neo.xredsys.api.Publication[friendly.size()+1];
          for (int i = 0; it.hasNext(); i++) {
            pubs[i] = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPublication(((Integer)it.next()).intValue());
          }
          pubs[pubs.length-1]=publication;
          request.setAttribute("pubs",pubs);
        %>
        <html:select multiple="true" property="publications" styleClass="selectPublication">
          <logic:iterate id="item" name="pubs" type="neo.xredsys.api.Publication">
              <html:option value="<%=new Integer(item.getId()).toString()%>">
                <%=item.getName()%>
              </html:option>
          </logic:iterate>
        </html:select>
      </label>
    </fieldset>
  <% } %>
    <fieldset class="unstyled searchword">
      <label><span><bean:message key="t.Searchword" bundle="org.apache.struts.action.MESSAGE"/>:</span>
      <html:text property="searchWord"/></label>
      <span class="error"><html:errors property="searchWord"/></span>
    </fieldset>
    <% String searchUrl=(String)request.getAttribute("searchUrl");
    	if (searchUrl==null) searchUrl="/userGroup/search/perform";
    	searchUrl="javascript:submitForm('action:" + searchUrl + ".do')";
     %>
     <fieldset class="unstyled buttons">
       <input type="button" class="important-button"  onClick="<%=searchUrl%>" value='<bean:message key="b.search"/>' />
       <input type="button" class="link" onClick="javascript:submitForm('reset')" value='<bean:message key="b.clear_search"/>' />
         <% if(checker.isGlobalPublicationAdmin(publication.getId())){ %> 
          <input type="button"  class="link" onClick="submitForm('external:/userGroup/new.do')"
            value="<bean:message bundle="org.apache.struts.action.MESSAGE" key="b.createNewUsergroup"/>" />
         <%}%>
     </fieldset>
</div>

