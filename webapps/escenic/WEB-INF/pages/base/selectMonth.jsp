<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%--
  Note: This file is used from several places, and it takes the single parameter selectMonth.property which
  is expected to be a property in the form, containing a number (0-11) corresponding to
  java.util.Calendar.JANUARY .. DECEMBER
  This file will render a <select ...> <option .../> ...  </select> with one option for each month in the year,
  using the user's preferred locale.

  The selection will be disabled if the property selectMonth.disabled is set to true.

  Example of usage:

        <template:call file="/WEB-INF/pages/base/selectMonth.jsp">
          <template:parameter key="selectMonth.property" value="monthFromDate" />
          <template:parameter key="selectMonth.disabled" value='<%="" + readOnly%>' />
          <template:parameter key="selectMonth.format" value="short" />
          <template:parameter key="selectMonth.includeBlank" value="true" />
        </template:call>

  property -- the name of the property to query the form -- passed on to <html:select property= />
  disabled -- passed on to <html:select disabled= />
  format -- short will give "jan feb mar...", but the default is "january february march..."
  includeBlank -- true or false, default false, wether or not to include an empty (blank) entry
               the blank entry will be the first item in the list


  Example 2:

        <template:call file="/WEB-INF/pages/base/selectMonth.jsp">
          <template:parameter key="selectMonth.property" value="someDateProperty" />
        </template:call>

  simply display an option list for the someDateProperty
   * long format
   * no blank entry
   * enabled

--%>
<%
  String lang = neo.phoenix.base.Constants.LOCALE_KEY;
  
  java.util.Locale locale = (java.util.Locale)session.getAttribute(lang);
if (locale == null) locale = java.util.Locale.getDefault();
java.text.DateFormatSymbols symbols = new java.text.DateFormatSymbols(locale);
String[] months;
if (!"short".equals(pageContext.findAttribute("selectMonth.format"))) {
  months = symbols.getMonths();
} else {
  months = symbols.getShortMonths();
}
String[] indexes = new String[] {"0","1","2","3","4","5","6","7","8","9","10","11"};
pageContext.setAttribute("months", months);
pageContext.setAttribute("indexes", indexes);
String property = (String)pageContext.findAttribute("selectMonth.property");
String onchange = (String)pageContext.findAttribute("selectMonth.onchange");
String styleClass = (String)pageContext.findAttribute("selectMonth.class");
boolean disabled = neo.util.StringUtil.getBoolean((String)pageContext.findAttribute("selectMonth.disabled"));
boolean includeBlank = neo.util.StringUtil.getBoolean((String)pageContext.findAttribute("selectMonth.includeBlank"));
if (false) System.out.println("locale=" + locale + " disabled=" + disabled + " prop=" + property);
%> 
<html:select styleId="<%=property%>" styleClass="<%=styleClass%>" onchange="<%=onchange%>" property='<%=property%>' disabled="<%=disabled%>">
  <% if (includeBlank) { %>
    <html:option value="">&nbsp;</html:option>
  <% } %>
  <html:options labelName="months" name="indexes"/>
</html:select>
