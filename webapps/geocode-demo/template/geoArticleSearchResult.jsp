<%@ page import="com.escenic.geocode.presentation.PresentationConstants" %>
<%@ page import="com.escenic.geocode.index.GeocodeIndexConstants" %>
<%@ page import="java.util.Collection" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.escenic.geocode.utils.KMLUtils" %>
<%@ page import="com.escenic.geocode.api.GeoField" %>
<%@ page import="java.util.List" %>
<%@ page import="com.escenic.geocode.plugin.GeocodePluginConstants" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-article" prefix="article" %>

<%!
  final String imageURL = "http://labs.google.com/ridefinder/images/mm_20_green.png";
%>
<logic:present name="<%=PresentationConstants.RQ_ATTR_GEO_ARTICLE_SEARCH_RESULT%>">
  <bean:define id="searchResult" name="<%=PresentationConstants.RQ_ATTR_GEO_ARTICLE_SEARCH_RESULT%>"
                                 type="neo.xredsys.content.search.SearchResult"/>
  <%
    Collection searchHits = searchResult.getSearchHits();
    pageContext.setAttribute("searchHits", searchHits);
  %>
  <logic:notEmpty name="searchHits">
  <h3>Number of search results: <%=searchHits.size()%></h3>
  <table>
    <tr>
      <th>Article ID</th>
      <th>Title</th>
      <th>Coordinates</th>
      <th>Article Type</th>
    </tr>
    <logic:iterate id="searchHit" name="searchHits"
                                  type="neo.xredsys.content.search.SearchHit">
      <bean:define id="articleIdStr" type="java.lang.String"><%=searchHit.getField("objectid")%></bean:define>
      <article:use articleId="<%=Integer.parseInt(articleIdStr)%>">
      <tr>
        <td><%=articleIdStr%></td>
        <td>
          <html:link href="${article.url}">${article.fields.title.value}</html:link>
        </td>
        <td>
          <table>
            <tr>
              <c:set var="geocodeFieldName" value="<%=GeocodePluginConstants.GEOCODE_FIELD%>"></c:set>
              <bean:define id="geocodeFields" value="${article.fields[geocodeFieldName].value}" type="java.lang.String"/>
              <%
                List<GeoField> geoFields = KMLUtils.getGeoFields(geocodeFields);
                request.setAttribute("geoFields", geoFields);
              %>
              <logic:iterate id="geoField" name="geoFields" type="com.escenic.geocode.api.GeoField">
                <td>(Lat : <%=geoField.getLocation().getLatitude()%>,
                    Lon : <%=geoField.getLocation().getLongitude()%>)</td>
              </logic:iterate>
            </tr>
          </table>
        </td>
        <td>
          <%=searchHit.getField("type")%>
        </td>
      </tr>
      </article:use>
    </logic:iterate>
  </table>
  </logic:notEmpty>
</logic:present>
