<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>

<p>
  Resolve all relations will resolve all the unresolved relations in the system. Basically this will fix inconsistent relation.
</p>
<p>
  By confirming to resolve all relations, all Escenic unresolved relations will be fixed and remove the un-resolve mark.
</p>

<p>Do you really want to resolve all unresolved relations?</p>

<html:form action="/publication/resolverelation">
<html:submit property="confirm" value="Confirm" />
<html:submit property="cancel" value="Cancel" />
</html:form>

<hr />
<div><font color="red"><html:errors property="failure" /></font></div>
<div><html:messages id="success" /></div>
