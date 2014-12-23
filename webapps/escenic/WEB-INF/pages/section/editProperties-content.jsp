<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page import="neo.xredsys.api.IOAPI"%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<%--<bean:define id="form" name="neo.phoenix.section.SectionForm" type="neo.phoenix.section.SectionForm"/>--%>
<%--<% boolean readOnly = neo.util.StringUtil.getBoolean(form.getReadOnly());%>--%>

<div class="error"><html:errors property="global" /></div>
<html:textarea property="declaredProperties" rows="35" cols="70"/>
<html:hidden property="id" />
<html:hidden property="parentWorkItemId" />
<input type="hidden" name="validateButton" value="save">
<input type="hidden" name="validateInput"  value="edit">
<input type="hidden" name="validateField" value="declaredProperties" />
<input type="hidden" name="submitButton" value="">
