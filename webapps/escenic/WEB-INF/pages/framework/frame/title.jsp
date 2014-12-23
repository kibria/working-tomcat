<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
Escenic Web Studio -
<logic:present name="textmap-bundle">
<bean:message name="textmap-title" bundle='<%=(String)request.getAttribute("textmap-bundle")%>'/>
</logic:present>
<logic:notPresent name="textmap-bundle">
<bean:message bundle="org.apache.struts.action.MESSAGE" name="textmap-title"/>
</logic:notPresent>

