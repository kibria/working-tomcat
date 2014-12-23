<%@ page language="java" isELIgnored="false" %>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>
<h2>Successfully assigned roles to user "${requestScope['userName']}"</h2>
<table>
  <tbody>
  <tr>
    <th>Publication</th>
    <th>Role</th>
  </tr>
  <logic:iterate id="role" type="neo.phoenix.publication.UserRoleForm.PublicationRole" name="roles">
    <tr>
      <td>${role.publicationName}</td>
      <td>
        <c:choose>
            <c:when test="${role.write == 'true' && role.read == 'true'}">
                Reader/Editor
            </c:when>
            <c:when test="${role.write == 'true'}">
                Editor
            </c:when>
            <c:when test="${role.read== 'true'}">
                Reader
            </c:when>
            <c:otherwise>
                None
            </c:otherwise>
        </c:choose>
      </td>
    </tr>
  </logic:iterate>
  </tbody>
</table>
<br/>

<div>
  <a href='<html:rewrite page="/pages/publication/user.jsp"/>'>Start over</a>
</div>
