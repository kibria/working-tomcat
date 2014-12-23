<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>

<input type="hidden" name="validateInput" value="input">
<input type="hidden" name="validateField" value="country">
<input type="hidden" name="validateField" value="language">
<input type="hidden" name="validateButton" value="change">
<input type="hidden" name="submitButton" value="action:/base/changeLanguage/change.do">
<bean:define name="neo.phoenix.base.LanguageForm" type="neo.phoenix.base.LanguageForm" id="form" />

<%
  java.util.Locale currentLocale = (java.util.Locale)pageContext.findAttribute(neo.phoenix.base.Constants.LOCALE_KEY);
  if (currentLocale == null) {
    currentLocale = java.util.Locale.getDefault();
%>
    No locale was set; reverting to default locale  <%= currentLocale %>
<% } else {
     form.setLocale(currentLocale.toString());
   } %>

<bean:message key="h.Language"/>:  <html:select property="locale">
<%
  String configuredLanguages = pageContext.getServletContext().getInitParameter("languages");
  if (configuredLanguages == null) configuredLanguages="en,en_GB,de,da,no,nl";
  String[] languages = neo.util.StringUtil.split(",", configuredLanguages);
  for (int i = 0; i < languages.length; i++) {
    java.util.Locale locale = null;
    String[] codes = neo.util.StringUtil.split("_", languages[i]);
    if (codes.length == 1) {
      locale = new java.util.Locale(codes[0], "");
    } else if (codes.length == 2) {
      locale = new java.util.Locale(codes[0], codes[1]);
    } else if (codes.length == 3) {
      locale = new java.util.Locale(codes[0], codes[1], codes[2]);
    } else {
      locale = null;
    }
    if (locale != null) {
      String displayName = locale.getDisplayName(currentLocale);
      String localName = locale.getDisplayName(locale);
      if(!neo.util.StringUtil.isEmpty(displayName)){
        if (displayName.equalsIgnoreCase(localName)) {
          localName = "";
        } else {
          localName = " - " + localName;
        }
        displayName = displayName.substring(0,1).toUpperCase() + displayName.substring(1);
      }
%>


  <html:option value="<%=languages[i]%>"><%=displayName%><%=localName%></html:option>

<%
    } else {
%>
  <html:option value="<%=languages[i]%>">(unknown code <%=languages[i]%>)</html:option>
<%
    }
  }
%>
</html:select>
 <span class="error"><html:errors property="locale"/></span>

<input type="hidden" name="persistent" value="on" />
<input type="button" onClick="submitForm('action:/base/changeLanguage/change.do')" class="important-button" value="<bean:message key="t.Change"/>" />
<input type="button" class="link" onClick="javascript:submitForm('main-menu')" value='<bean:message key="b.cancel"/>' />

<br><br><br>

<div class="content-box entitydetails">
<div class="header">
<h2><%=currentLocale.getDisplayName(currentLocale)%></h2>
</div>
<div class="content">
<table>
<tbody>
<tr>
  <th><bean:message key="t.Date_format"/></th>
  <td>
    <div>
     <%= java.text.DateFormat.getDateInstance(java.text.DateFormat.LONG,currentLocale).format(new java.util.Date()) %>
    </div>
    <div>
     <%= java.text.DateFormat.getDateInstance(java.text.DateFormat.SHORT,currentLocale).format(new java.util.Date()) %>
    </div>
  </td>
</tr>
<tr>
  <th><bean:message key="t.Time_format"/></th>
  <td>
    <div>
     <%= java.text.DateFormat.getTimeInstance(java.text.DateFormat.LONG,currentLocale).format(new java.util.Date()) %>
    </div>
    <div>
     <%= java.text.DateFormat.getTimeInstance(java.text.DateFormat.SHORT,currentLocale).format(new java.util.Date()) %>
    </div>
  </td>
</tr>
</tbody>
</table>
</div>
</div>
