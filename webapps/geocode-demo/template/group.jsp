<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- Start: group.jsp --%>

<div id="group-default">
  <c:forEach items="${pool.rootElement.areas.default.items}" var="item">
    <c:set var="element" value="${item}" scope="request"/>
    <jsp:include page="fp_default.jsp"/>
    <c:remove var="element" scope="request"/>
  </c:forEach>
</div>

<%-- End: group.jsp --%>