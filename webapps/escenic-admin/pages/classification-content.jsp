<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>
<%@ taglib prefix="logic" uri="http://jakarta.apache.org/struts/tags-logic" %>
<%@ taglib prefix="bean" uri="http://jakarta.apache.org/struts/tags-bean" %>

<div>
  <html:form action="/classification/tag-structure/new">
  <h3>Create new Tag Structure</h3>
  <html:errors property="e.tag-structure.creation.failed"/><br/>
    <table>
      <tr>
        <td>Scheme:</td>
        <td>
          <tt>tag:</tt><html:text property="identifier"/>
          <html:errors property="e.invalid_tag_identifier"/>
        </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td style="font-size: x-small; padding-bottom: 1em;">
          The machine readable scheme assigned to this tag structure. Must conform to the <em>entity</em>
          portion of RFC 4151. <br/>
          APIs and web services will use this to identify the tag-structure as well as tags created under it.<br/>
          example: <em>places@example.org,2011</em>. This would result in tags like: <em>places@example.org,2011:Oslo</em>
        </td>
      </tr>
      <tr>
        <td>
          Name:</td><td><html:text property="name"/>
        <html:errors property="errors.required"/><br/>          
        </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td style="font-size: x-small; padding-bottom: 1em;">
          The human readable name for the tag structure.  Users will see this when they tag content using this tag structure.  Example: <em>Places</em>. This field is required.
        </td>
      </tr>
      <tr>
        <td>Description:</td><td><html:text property="description"/></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td style="font-size: x-small; padding-bottom: 1em;">
          A description of the tag structure and its purpose.  
        </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td><html:submit value="Create"/></td>
      </tr>
    </table>
  </html:form>
</div>
<div class="structures">
  <h3>Tagging structures</h3>
  <ul>
    <c:forEach items="${structures}" var="structure">
      <li>
        <h3>${structure.name}</h3>
        <p>${structure.description} (<tt>${structure.scheme}</tt>)</p>
        <ul class="buttons">
          <li>
            <html:form action="/classification/import" method="get">
              <html:hidden property="identifier" value="${structure.scheme}" />
              <html:submit value="Import"/>
            </html:form>
          </li>
          <li>
            <html:form action="/classification/delete" method="post">
              <html:hidden property="identifier" value="${structure.scheme}" />
              <html:submit value="Delete"/>
            </html:form>
          </li>
        </ul>
      </li>
    </c:forEach>
  </ul>
</div>
