<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page import="neo.xredsys.api.IOAPI,
                 neo.xredsys.api.Section"%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<script language="JavaScript1.2"><!-- 
  var warningDisplayed = false;
  function verifyUnshare() {
    if(!document.forms[0]['SHARED'].checked&&!warningDisplayed){
      if(!confirm("<bean:message key='t.Unshare_section_confirm'/>")){
        document.forms[0]['SHARED'].checked=true;
      }else{
        warningDisplayed= true;
      }
    }
  }
// -->
</script>

<div class="error"><html:errors property="global" /></div>
<bean:define id="checker" 
             name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<bean:define id="form" name="neo.phoenix.section.SectionForm" type="neo.phoenix.section.SectionForm"/>
<% boolean readOnly = neo.util.StringUtil.getBoolean(form.getReadOnly());%>
<% boolean isVirtualSection = neo.util.StringUtil.getBoolean(form.getIsVirtual());%>
<html:hidden property="id" />
<html:hidden property="parentWorkItemId" />
<input type="hidden" name="validateButton" value="edit">
<input type="hidden" name="validateButton" value="share">
<input type="hidden" name="validateButton" value="save">
<input type="hidden" name="validateInput"  value="share">
<input type="hidden" name="validateField"  value="none">
<html:hidden property="isVirtual"/>
<html:hidden property="readOnly"/>
<html:hidden property="name"/>
<html:hidden property="directoryName"/>
<html:hidden property="uniqueName"/>
<html:hidden property="url"/>
<html:hidden property="parentId"/>
<html:hidden property="sectionLayout"/>
<html:hidden property="articleLayout"/>
<html:hidden property="inheritAccess"/>
<html:hidden property="priority"/>
<html:hidden property="state"/>
<html:hidden property="state"/>
<html:hidden property="isAgreementRequired" />
<html:hidden property="agreementInfo"/>
<html:hidden property="agreementType"/>
<input type="hidden" name="submitButton" value="">

<%
  neo.xredsys.api.Section tmpSec = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getSection(form.getIdInt());
  Section[] virtualSections = IOAPI.getAPI().getObjectLoader().getVirtualSections(tmpSec.getId()); 
  int virtualSectionCount=virtualSections.length;
  request.setAttribute("virtualSections",virtualSections);
%>
<table>
<%if(checker.isGlobalPublicationAdmin(tmpSec.getOwnerPublicationId())||virtualSectionCount==0){%>
  <%if(neo.util.StringUtil.getBoolean(form.getVirtualTarget())&&virtualSectionCount>0){%>
    <tr>
      <td colspan="2">
        <div class="textWarning">
          <bean:message key='t.Unshare_section_warning'/>
        </div>
      </td>
    </tr>
    <tr>
      <td>
        <table>
          <tr>
            <td class="edit-propertyname"> 
              <bean:message key="t.Shared"/>
            </td>
            <td class="edit-propertyvalue">
              <html:checkbox styleId="SHARED" property="virtualTarget" onchange="verifyUnshare();" disabled="<%=readOnly%>"/>
            </td>
            <td class="edit-propertydescription"><span class="error"><html:errors property="virtualTarget" /></span></td>
          </tr>
        </table>
      </td>
    </tr>
  <%}else{%>
    <tr><td class="edit-propertyname"> <bean:message key="t.Shared"/></td><td class="edit-propertyvalue"><html:checkbox styleId="SHARED" property="virtualTarget" disabled="<%=readOnly%>"/></td><td class="edit-propertydescription"><span class="error"><html:errors property="virtualTarget" /></span></td></tr>
  <%}%>
<%}else{%>
  <tr><td class="edit-propertyname"> <bean:message key="t.Shared"/></td><td class="edit-propertyvalue"><html:checkbox property="virtualTarget" disabled="<%=true%>"/></td><td class="edit-propertydescription"><span class="error"><html:errors property="virtualTarget" /></span></td></tr>
<%}%>
</table>
<hr/>
<%if(virtualSectionCount>0){%>
  <bean:message key="t.Section_shared_to" arg0="<%=tmpSec.getName()%>"/>
  <table>
    <logic:iterate id="virtualSection" name="virtualSections" type="neo.xredsys.api.Section">
      <template:call file="../base/presentSection.jsp">
        <template:parameter key="publicationId" value="<%=String.valueOf(virtualSection.getOwnerPublicationId())%>"/>
        <template:parameter key="sectionId" value="<%=String.valueOf(virtualSection.getId())%>"/>
      </template:call>
    </logic:iterate>
  </table>
<%}else{%>
  <bean:message key="t.Section__not_shared_to" arg0="<%=tmpSec.getName()%>"/>
<%}%>