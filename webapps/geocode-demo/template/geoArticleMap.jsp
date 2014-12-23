<%@ page import="com.escenic.geocode.presentation.PresentationConstants" %>
<%@ page import="java.util.Collection" %>
<%@ page import="com.escenic.geocode.api.GeoField" %>
<%@ page import="java.util.List" %>
<%@ page import="com.escenic.geocode.utils.KMLUtils" %>
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

<div id="resultGoogleMap" style="width:500px;height:300px"></div>

<logic:present name="<%=PresentationConstants.RQ_ATTR_GEO_ARTICLE_SEARCH_RESULT%>">
  <bean:define id="searchResult" name="<%=PresentationConstants.RQ_ATTR_GEO_ARTICLE_SEARCH_RESULT%>"
                                 type="neo.xredsys.content.search.SearchResult"/>
  <%
    Collection searchHits = searchResult.getSearchHits();
    pageContext.setAttribute("searchHits", searchHits);
  %>
  <script type="text/javascript">
    getMarkerArray().length = 0;
  </script>
    <logic:iterate id="searchHit" name="searchHits"
                                  type="neo.xredsys.content.search.SearchHit">
      <bean:define id="articleIdStr" type="java.lang.String"><%=searchHit.getField("objectid")%></bean:define>
      <article:use articleId="<%=Integer.parseInt(articleIdStr)%>">
        <c:set var="geocodeFieldName" value="<%=GeocodePluginConstants.GEOCODE_FIELD%>"></c:set>
        <bean:define id="geocodeFields" value="${article.fields[geocodeFieldName].value}" type="java.lang.String"/>
        <%
          List<GeoField> geoFields = KMLUtils.getGeoFields(geocodeFields);
          request.setAttribute("geoFields", geoFields);
        %>
        <template:call file="./geoFieldsOnMap.jsp">
          <template:parameter key="geoFields" name="geoFields"/>
        </template:call>
      </article:use>
    </logic:iterate>
</logic:present>
