<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>

<% 
 String formDef = (String)request.getAttribute("formName");
 String searchRes = (String)request.getAttribute("searchResult");
 String previousUrl = (String)request.getAttribute("previous");
 String nextUrl = (String)request.getAttribute("next");
 String pagerUrl = (String)request.getAttribute("pager");
 String scope = (String)request.getAttribute("scope");
  
 if(scope==null) { 
   scope = "session";
 }
%>
<%
  neo.phoenix.base.PagedForm form = (neo.phoenix.base.PagedForm)request.getAttribute(formDef);
  java.util.Collection result = (java.util.Collection) (scope.equals("session") ? request.getSession().getAttribute(searchRes) : request.getAttribute(searchRes));
  int currentPage = 1;
  int totSize = result.size();
  int pgLength = Integer.parseInt(form.getPageLength());
  int pgStart = Integer.parseInt(form.getPageStart());
  int totPages = totSize / pgLength + 1;
  if(totSize>0){
    currentPage = pgStart % totSize / pgLength + 1;
  } 
  if(totSize%pgLength==0){
    totPages--;
  }
  int MAX=10;
  int start = currentPage - MAX / 2;
  if(currentPage%MAX==0){
    start = currentPage-MAX / 2;
  }
  if(start<=0){
    start = 1;
  }
  if(currentPage>MAX/2){
    MAX++;
  }
  if(pagerUrl.indexOf("?")>0){
    pagerUrl = pagerUrl+"&";
  }else{
    pagerUrl = pagerUrl+"?";
  }
  
%>
<% if(totPages>1){%>
  <div class="pager">
      <%if(currentPage>1){
        String url = pagerUrl+"page="+1+"')";
        %><span><a href="<%=url%>"><%="<<"%></a></span><%
      }%>
      <% if(currentPage > 1){%>
        <span>
          <a href="<%=previousUrl%>"><%="<"%></a>
        </span>
      <%}%>
      <% for (int i = start; i < start + MAX && i <= totPages; i++) {
        %><span><%  
        if(i!=currentPage){
          String url = pagerUrl+"page="+i+"')";
          %><a href="<%=url%>"><%=i%></a><%
        }else{
          out.print("<b>"+i+"</b>");
        }
        %></span><%
      }%>
      <%if(currentPage < totPages){%>
        <span>                
          <a href="<%=nextUrl%>"><%=">"%></a>
        </span>
      <%}%>
      <% if(currentPage!=totPages){%>
        <%String url = pagerUrl+"page="+totPages+"')";
        %><span><a href="<%=url%>"><%=">>"%></a></span><%
      }%>
  </div>
<%}%>

  