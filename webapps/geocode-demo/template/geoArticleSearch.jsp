<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.DateFormatSymbols" %>
<%@ page import="neo.xredsys.api.IOAPI" %>
<%@ page import="neo.xredsys.api.ObjectLoader" %>
<%@ page import="neo.xredsys.api.Publication" %>
<%@ page import="neo.xredsys.api.Section" %>
<%@ page import="neo.xredsys.content.type.ArticleType" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>

<%!
  static final int MAX_YEARS = 5;

  Map getPublicationSections(final int pPublication) {
    ObjectLoader ol = IOAPI.getAPI().getObjectLoader();
    Publication publication = ol.getPublicationById(pPublication);
    Section section = publication.getRootSection();
    Map sectionIdNameMap = new HashMap();
    sectionIdNameMap.put(new Integer(section.getId()), section.getName());
    addSubsectionsInMap(section, sectionIdNameMap);
    return sectionIdNameMap;
  }

  void addSubsectionsInMap(Section pSection, Map pMap) {
    Section[] subSections = pSection.getSubSections();
    if (subSections == null || subSections.length == 0) {
      return;
    }
    for (int i = 0; i < subSections.length; i++) {
      pMap.put(new Integer(subSections[i].getId()), subSections[i].getName());
      addSubsectionsInMap(subSections[i], pMap);
    }
  }

  List<ArticleType> getArticleTypes(int pPublicationId) {
    ObjectLoader ol = IOAPI.getAPI().getObjectLoader();
    Publication publication = ol.getPublicationById(pPublicationId);
    Iterator articleTypeIt = publication.getArticleTypes().iterator();
    int i = 0;
    List<ArticleType> articleTypes = new LinkedList<ArticleType>();
    while (articleTypeIt.hasNext()) {
      ArticleType type = (ArticleType) articleTypeIt.next();
      if (type != null) {
        articleTypes.add(type);
      }
    }
    return articleTypes;
  }
%>

<%
  String[] daysInMonth = new String[31];
  for (int i = 0; i < daysInMonth.length; i++) {
    daysInMonth[i] = "" + (i + 1);
  }

  DateFormatSymbols dateSymbols = new DateFormatSymbols();
  String [] monthLabels = dateSymbols.getShortMonths();
  String[] monthValues = new String[12];
  for (int i = 0; i < monthValues.length; i++) {
    monthValues[i] = "" + i;
  }

  int currentYear = Calendar.getInstance().get(Calendar.YEAR);
  String[] years = new String[MAX_YEARS];
  for (int i = currentYear; i > currentYear - MAX_YEARS; i--) {
    years[currentYear - i] = "" + i;
  }
%>

<bean:define id="publication" name="publication" type="neo.xredsys.api.Publication"/>

<html:form action="/geoArticleSearch">
  <input type="hidden" name="actionCommand" value="search"/>
  <html:hidden property="publicationIds" value="${publication.id}"/>

  <table border="0px" cellspacing="0px">
    <tr>
      <td class="inputError" colspan="2">
        <html:errors property="com.escenic.geocode.searchExpression.required"/>
      </td>
    </tr>
    <tr>
      <td>Search: </td>
      <td><html:text property="searchExpression"/></td>
    </tr>
    <tr>
      <td class="inputError" colspan="2">
        <html:errors property="com.escenic.geocode.from.lattitude.invalid"/>
        <html:errors property="com.escenic.geocode.from.longitude.invalid"/>
      </td>
    </tr>
    <tr>
      <td>From lattitude/longitude: </td>
      <td><html:text property="fromLattitude" size="5"/> / <html:text property="fromLongitude" size="5"/></td>
    </tr>
    <tr>
      <td class="inputError" colspan="2">
        <html:errors property="com.escenic.geocode.to.lattitude.invalid"/>
        <html:errors property="com.escenic.geocode.to.longitude.invalid"/>
      </td>
    </tr>
    <tr>
      <td>To lattitude/longitude:</td>
      <td> <html:text property="toLattitude" size="5"/> / <html:text property="toLongitude" size="5"/></td>
    </tr>
    <tr>
      <td colspan="2">
        <!--From day error code here-->
      </td>
    </tr>
    <tr>
      <td>From Date:</td>
      <td>
        <%
          request.setAttribute("monthLabels", monthLabels);
          request.setAttribute("fromDays", daysInMonth);
          request.setAttribute("fromMonths", monthValues);
          request.setAttribute("fromYears", years);
        %>
        <bean:define id="fromDays" name="fromDays"/>
        <bean:define id="fromMonths" name="fromMonths"/>
        <bean:define id="fromYears" name="fromYears"/>
        <html:select property="startDay">
          <html:options name="fromDays"/>
        </html:select>
        <html:select property="startMonth">
          <html:options name="fromMonths" labelName="monthLabels"/>
        </html:select>
        <html:select property="startYear">
          <html:options name="fromYears"/>
        </html:select>
      </td>
    </tr>
    <tr>
      <td>To Date:</td>
      <td>
        <%
          request.setAttribute("toDays", daysInMonth);
          request.setAttribute("toMonths", monthValues);
          request.setAttribute("toYears", years);
        %>
        <bean:define id="toDays" name="toDays"/>
        <bean:define id="toMonths" name="toMonths"/>
        <bean:define id="toYears" name="toYears"/>
        <html:select property="toDay">
          <html:options name="toDays"/>
        </html:select>
        <html:select property="toMonth">
          <html:options name="toMonths" labelName="monthLabels"/>
        </html:select>
        <html:select property="toYear">
          <html:options name="toYears"/>
        </html:select>
      </td>
    </tr>
    <tr>
      <td>Sections:</td>
      <td>
        <html:select property="sectionIds" multiple="true">
          <%
            Map sectionIdNameMap = getPublicationSections(publication.getId());
            request.setAttribute("sectionIds", sectionIdNameMap.keySet());
            request.setAttribute("sectionValues", sectionIdNameMap.values());
          %>
          <html:options name="sectionIds" labelName="sectionValues"/>
        </html:select>
      </td>
    </tr>
    <tr>
      <td>Include subsections:</td>
      <td>
        <html:checkbox property="searchSubSectionAllowed"/>
      </td>
    </tr>
    <tr>
      <td>ArticleTypes:</td>
      <td>
        <html:select property="articleTypes" multiple="true">
          <%
            List<ArticleType> articleTypes = getArticleTypes(publication.getId());
            request.setAttribute("articleTypes", articleTypes);
          %>
          <logic:iterate id="articleType" name="articleTypes" type="neo.xredsys.content.type.ArticleType">
              <html:option value="<%=articleType.getName()%>">${sessionScope['articleType.name']}</html:option>
          </logic:iterate>
        </html:select>
      </td>
    </tr>
    <tr>
      <td>&nbsp;</td><td align="right"><html:submit value="Search"/></td>
    </tr>
  </table>
</html:form>
