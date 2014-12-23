<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<bean:define id="title" value="h.Edit_usergroup" toScope="request"/>
<jsp:include page="../base/header.jsp"/>
<bean:define id="includeWorkItems"         value="true" toScope="request" />
<bean:define id="includeMenu"              value="true" toScope="request" />
<bean:define id="includeLogoffButton"      value="true" toScope="request" />
<bean:define id="includeBasket"            value="true" toScope="request" />
<jsp:include page="../base/body-begin.jsp" />
<jsp:include page="../base/banner.jsp" />
<tr>
  <td valign="top" class="menu">
    <jsp:include page="../base/menu.jsp" />
  </td>
  <td>&nbsp;</td>
  <td valign="top" class="main">

    <div class="error"><html:errors property="global" /></div>
    <html:form action="/person/search">
      <table>
        <tr>
          <td>Searchword</td>
          <td><html:text property="searchWord"/></td>
          <td><span class="error"><html:errors property="searchWord"/></span></td>
        </tr>
        <tr><td></td><!-- Align with input fields -->
        <td colspan="2"><a class="global-button"  href="javascript:submitForm('submit')">Search</a></td>
        <input type="hidden" name="submitButton" value="">
        </tr>
       </table>
    </html:form>
    <logic:present name="neo.phoenix.person.SearchResult" scope="session">
      <p>
      <div class="title"><bean:message key="h.Search_Result"/></div>
        <% String actionURL = "/person/addPersonsToBasket?objectType=" + neo.xredsys.api.IOAtom.OBJECTTYPE_PERSON; %>      
        <html:form action="<%=actionURL%>">
          <bean:define id="persons" name="neo.phoenix.person.SearchResult" scope="session"/>
            <logic:iterate name="persons" id="item" type="neo.xredsys.api.Person">
              <br>
              <% String id = "selected(" + item.getId() + ")"; 
                String delete = "/person/delete.do?id=" + item.getId() + "&objectType=" + neo.xredsys.api.IOAtom.OBJECTTYPE_PERSON;
              %>
              <html:checkbox property="<%=id%>"></html:checkbox>      
              <html:img page="/images/qw/person_16_wh.png" />          
              <html:link page="<%=delete%>">
                <html:img page="/images/qw/delete.png"/>
              </html:link>
              <% String url = "/person/edit.do?id=" + item.getId(); %>
              <html:link page="<%=url%>">
                 <logic:present name="item" property="surName"><%=item.getSurName()%>, </logic:present>
                 <logic:present name="item" property="firstName"><%=item.getFirstName()%></logic:present>
              </html:link>  
            </logic:iterate>
            <br>
            <html:submit>Add selected items to basket</html:submit>
          </html:form>
      </p>
    </logic:present>
  </td>
</tr>
<jsp:include page="../base/body-end.jsp" />
