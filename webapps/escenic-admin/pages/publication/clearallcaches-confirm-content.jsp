<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>


<ol>
 <html:messages id="err" property="failure">
  <li><font color="red"><bean:write name="err"/></font></li>
 </html:messages>
</ol>

<ol>
 <html:messages id="warn" property="warning">
  <li><font color="red"><bean:write name="warn"/></font></li>
 </html:messages>
</ol>

<ol>
 <html:messages id="msg" property="success" message="true">
  <li><bean:write name="msg"/></li>
 </html:messages>
</ol>

