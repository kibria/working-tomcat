<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>

<% 
 String formDef = (String)request.getAttribute("formName");
 String searchRes = (String)request.getAttribute("searchResult");
 String renderMode = (String)request.getAttribute("renderMode");
%>
<%
  neo.phoenix.base.AbstractSearchForm form = (neo.phoenix.base.AbstractSearchForm)request.getAttribute(formDef);
  java.util.Collection result = (java.util.Collection)request.getSession().getAttribute(searchRes);
  int currentPage = 1;
  int totSize = result.size();
  int pgLength = Integer.parseInt(form.getPageLength());
  int pgStart = Integer.parseInt(form.getPageStart());
  int totPages = totSize / pgLength + 1;
  if(totSize>0){
    currentPage = pgStart % totSize / pgLength+1;
  } 
  if(totSize%pgLength==0){
    totPages--;
  }
  
%>
<%if ("css".equals(renderMode)) { %>
  <span class="operation">
     <bean:message bundle="org.apache.struts.action.MESSAGE" key="t.hits" arg0="<%=String.valueOf(totSize)%>" />
  </span>
    <%if(totPages>0){%>
  <span class="operation">
    <bean:message bundle="org.apache.struts.action.MESSAGE" key="t.Page"/>:<%=currentPage%> / <%=totPages%>
  </span>
  <span class="operation">
   <a href="javascript:void(0);"
        onclick="toggleclass(document.getElementById('searchresults-collapsible-list'),
        'collapsed-list','expanded-list')"><bean:message key="l.show_details"/></a>
  </span>
    <%}%>
  <h2><bean:message bundle="org.apache.struts.action.MESSAGE" key="h.Search_Result"/></h2>
<% } else { %>
<table>
  <tr>
    <td colspan="2">
      <div class="title"><bean:message bundle="org.apache.struts.action.MESSAGE" key="h.Search_Result"/></div>
    </td>
  </tr>
  <tr>
    <td>
      <bean:message bundle="org.apache.struts.action.MESSAGE" key="t.hits" arg0="<%=String.valueOf(totSize)%>" />
    </td>
    <%if(totPages>0){%>
      <td>
        <bean:message bundle="org.apache.struts.action.MESSAGE" key="t.Page"/>:<%=currentPage%> / <%=totPages%>
      </td>
    <%}%>
  </tr>
</table>
<% } %>