<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>
<%@ taglib prefix="logic" uri="http://jakarta.apache.org/struts/tags-logic" %>
<%@ taglib prefix="bean" uri="http://jakarta.apache.org/struts/tags-bean" %>

<div>
  <h3>Import tags</h3>
  <c:choose>
    <c:when test="${importedTagsCount eq null}">
      <span>Below is an example XML that can be imported</span>
<c:set var="exampleXML"><?xml version="1.0"?>
<tags xmlns="http://xmlns.escenic.com/2011/classification-tags">
  <tag term="tag1">
    <label>Tag 1</label>
    <description>
      Tag 1 is the root of all tags whose label starts with "Tag 1".
    </description>
  </tag>

  <tag term="tag2" parent-term="tag1">
    <label>Tag 2</label>
    <description>
      The first child of Tag 1.
    </description>
  </tag>
</tags></c:set>

      <p><pre><c:out value="${exampleXML}" escapeXml="true"/></pre></p>
      <p>Please see the <strong>Server Administration Guide</strong> for complete reference.</p>
      <html:form action="/classification/import" method="post" enctype="multipart/form-data">
        <html:errors header="e.import.header" footer="e.import.footer" />
        <html:hidden property="identifier" />
        <html:hidden property="import" value="true" />
        <html:file property="file" />
        <html:submit value="Import" /><html:cancel value="Cancel"/>
      </html:form>
    </c:when>
    <c:otherwise>
      <p>Imported <strong>${importedTagsCount}</strong> tags into <em>${structure.name} (${structure.scheme})</em></p>
      <a href='<c:url value="/do/classification/display"/>'>Back</a>
    </c:otherwise>
  </c:choose>
</div>
