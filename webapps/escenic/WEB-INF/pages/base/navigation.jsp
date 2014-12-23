<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>

<table>
  <tr>
    <td><a href="javascript:submitForm('hot')"><html:img page="/images/studio/XL_globe.gif" border="0" /></a></td>
  </tr>
  <tr>
    <td><a href="javascript:submitForm('article-archive')"><html:img page="/images/studio/XL_article.gif" border="0" /></a></td>
  </tr>
  <tr>
    <td><a href="javascript:submitForm('image-archive')"><html:img page="/images/studio/XL_picture.gif" border="0" /></a></td>
  </tr>
  <tr>
    <td><a href="javascript:submitForm('person-archive')"><html:img page="/images/studio/XL_person.gif" border="0" /></a></td>
  </tr>
  <tr>
    <td><a href="javascript:submitForm('media-archive')"><html:img page="/images/studio/XL_multimedia.gif" border="0" /></a></td>
  </tr>
  <tr>
    <td><a href="javascript:submitForm('link-archive')"><html:img page="/images/studio/XL_link.gif" border="0" /></a></td>
  </tr>
  <tr>
    <td><a href="javascript:submitForm('userGroup-archive')">user<br>groups</a></td>
  </tr>
  <tr>
    <td><a href="javascript:submitForm('section-archive')"><html:img page="/images/studio/XL_section.gif" border="0" /></a></td>
  </tr>
</table>
