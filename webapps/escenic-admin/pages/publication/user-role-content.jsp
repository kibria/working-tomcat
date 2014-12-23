<%@ page language="java" isELIgnored="false" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic" %>
<%@ taglib prefix="bean" uri="http://struts.apache.org/tags-bean" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
  function updateReadWrite(pPrefix, pIndex, pSelect) {
    var index;
    if (!pSelect && pIndex != 'All') {
      document.getElementById(pPrefix + 'All').checked = pSelect;
    }
    if (pIndex == 'All') {
      index = 0;
      while (checkbox = document.getElementById(pPrefix + index++)) {
          checkbox.checked = pSelect;
      }
    }
  }
    
</script>
<h1>Grant a user read/write permission</h1>
<html:messages id="message">
  <div class="msg">${message}</div>
</html:messages>
<h3>Step 2 : Grant permissions for "${requestScope['userName']}"</h3>
<html:errors property="global"/>
<html:form action="/publication/user/role">
  <bean:define id="form" name="neo.phoenix.publication.UserRoleForm"/>
  <html:hidden property="userName"/>
  <html:errors property="userName"/>
  <table>
    <tbody>
    <tr>
      <th>
        All Publications
      </th>
      <th>
        <html:checkbox property="readAll"
                       styleId="readAll"
                       onchange="updateReadWrite('read', 'All', this.checked);">
          Reader
        </html:checkbox>
      </th>
      <th>
        <html:checkbox property="writeAll"
                       styleId="writeAll"
                       onchange="updateReadWrite('write', 'All', this.checked);">
          Editor
        </html:checkbox>
      </th>
    </tr>
    <logic:iterate id="publication" type="neo.xredsys.api.Publication " indexId="index" name="publications">
      <html:hidden property="publicationRoles[${index}].publicationId"/>
      <html:hidden property="publicationRoles[${index}].publicationName" value="${publication.name}"/>
      <html:hidden property="publicationRoles[${index}].ownerPublication" />
      <tr>
          <c:choose>
              <c:when test="${form.publicationRoles[index].ownerPublication == 'true'}">
                  <td style="font-weight: bold;" title="Owner publication">
              </c:when>
              <c:otherwise><td></c:otherwise>
          </c:choose>
          ${publication.name}
        </td>
        <td>
          <html:checkbox property="publicationRoles[${index}].read"
                         styleId="read${index}"
                         onchange="updateReadWrite('read', '${index}', this.checked);">
            Reader
          </html:checkbox>
        </td>
        <td>
          <html:checkbox property="publicationRoles[${index}].write"
                         styleId="write${index}"
                         onchange="updateReadWrite('write', '${index}', this.checked);">
            Editor
          </html:checkbox>
        </td>
      </tr>
    </logic:iterate>
    </tbody>
  </table>
  <html:submit>Save</html:submit>
</html:form>
