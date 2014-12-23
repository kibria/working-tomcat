<%@ page import="java.net.URI" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
  <head><title>Escenic Indexer application web interface</title></head>
  <body>
  <p>Welcome to the indexer application. It takes documents from Escenic Content Engine <em>indexer webservice</em> and
    feeds them to a SOLR instance.  The indexer application usually runs together with the solr instance.</p>
  <h2>Configuration:</h2>
  <dl>
    <dt>Documents are read from the following URI Base Query URI</dt>
    <dd>${config.baseQueryURI}</dd>
    <dt>Documents are sent to SOLR using the following update URI</dt>
    <dd>${config.indexURI}</dd>
    <dt>Head/tail storage path</dt>
    <dd>${storagePath}</dd>
  </dl>
  <h2>Current state:</h2>
  <p>The indexer application is ${status}</p>
  <dl>
    <dt>Current head</dt>
    <dd>${head}</dd>
    <dt>Current tail</dt>
    <dd>${tail}</dd>
    <c:if test="${fn:length(reindex) gt 0}">
      <dt>Currently reindexing</dt>
      <c:forEach var="reindexUri" items="${reindex}">
        <dd>${reindexUri}</dd>
      </c:forEach>
    </c:if>
    <c:if test="${fn:length(reindex) eq 0}">
      <dt>No active reindex tasks</dt>
      <dd>&nbsp;</dd>
    </c:if>
    <dt>Number of documents read but not yet processed</dt>
    <dd>${queueSize}</dd>
  </dl>

  <h2>Current statistics:</h2>
  <%-- The following foreach is Formatted like this for the <pre> to format correctly. --%>
  <pre>
  <c:forEach items="${collectors}" var="coll"><c:out value="${coll.report}"/>
  </c:forEach>
  </pre>
  <div id="indexer actions">
    <h2>Indexer actions:</h2>
    <form action="<%=request.getContextPath()%>/admin/" method="POST">
      <input type="hidden" name="reindex" value="true"/>
      <input type="submit" value="Reindex..."/>
    </form>
    <form action="<%=request.getContextPath()%>/admin/" method="POST">
      <input type="hidden" name="pause" value="true"/>
      <input type="submit" value="Pause indexer"/>
    </form>
    <form action="<%=request.getContextPath()%>/admin/" method="POST">
      <input type="hidden" name="pause" value="false"/>
      <input type="submit" value="Resume Indexer"/>
    </form>
    <form action="<%=request.getContextPath()%>/admin/" method="POST">
      <input type="hidden" name="optimize" value="true"/>
      <input type="submit" value="Optimize Solr Index"/>
    </form>
  </div>

  <ul>
    <c:forEach items="${errors}" var="error">
      <li>
        <b>
            <fmt:formatDate type="both" value="${error.date}" /> <c:out value="${error.status.code}"/>&nbsp;${error.status.text}
        </b>
        <a href="<c:out value="${error.URI}"/>"><c:out value="${error.URI}"/></a>
        <br/>
        ${error.status.errorText}
      </li>
    </c:forEach>
  </ul>
  </body>
</html>
