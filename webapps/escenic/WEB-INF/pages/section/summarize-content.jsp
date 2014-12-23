<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<bean:define id="publication" name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<input type="hidden" name="validateButton" value="store">
<input type="hidden" name="validateInput"  value="view">
<input type="hidden" name="validateField" value="none" />

<%
  /* Setting the order of the fields in the section list */
  java.util.ArrayList fields = new java.util.ArrayList();

  fields.add("Name");
  fields.add("State");
  fields.add("SectionTemplate");
  fields.add("ArticleTemplate");
  request.setAttribute("fields",fields);


  java.util.ArrayList subFields = new java.util.ArrayList();

  subFields.add("Id");
  subFields.add("Uniquename");
  subFields.add("isVirtual");
  subFields.add("virtualSource");
  subFields.add("AgreementType");
  request.setAttribute("subFields",subFields);
%>
  <br />
  <table border="0" cellspacing="0" cellpadding="0" width="100%" class="section-summarizeTable">
    <tr>
      <%
        java.util.Iterator it = fields.iterator();
        while(it.hasNext()){
          String name = it.next().toString();
          %>
           <td align="left" class="section-summarizeTableHeading">
          <%
            if(name.equalsIgnoreCase("name"))out.print("Name");
            else if(name.equalsIgnoreCase("Uniquename"))out.print("Uniquename");
            else if(name.equalsIgnoreCase("State"))out.print("State");
            else if(name.equalsIgnoreCase("Id"))out.print("Id");
            else if(name.equalsIgnoreCase("AgreementType"))out.print("AgType");
            else if(name.equalsIgnoreCase("SectionTemplate"))out.print("SecTempl");
            else if(name.equalsIgnoreCase("ArticleTemplate"))out.print("ArtTempl");
            else if(name.equalsIgnoreCase("isVirtual"))out.print("Is Virt");
            else if(name.equalsIgnoreCase("virtualSource"))out.print("Source");
          %>
           </td>
          <%
        }
      %>
    </tr>

    <%
      String indent = "";
      request.setAttribute("indent",indent);
    %>
    <bean:define name="publication" property="rootSection" id="rootSection" />
    rootSection=<%=rootSection%>
    <template:call file="summarize-recurse.jsp">
      <template:parameter key="section" name="rootSection"/>
    </template:call>

    <tr>
      <%
        it = fields.iterator();
        while(it.hasNext()){
          String name = it.next().toString();
          %>
           <td align="left">
          <%
            if(name.equalsIgnoreCase("State")){%>

              <html:select property="state">
                <%
                  neo.xredsys.api.Type[] states = neo.xredsys.api.IOAPI.getAPI().getTypeManager().getTypes(neo.xredsys.api.Type.SectionStateType);
                  pageContext.setAttribute("states", states);
                %>
                 <html:option value="-1">&nbsp;</html:option>
                 <logic:iterate name="states" id="state" type="neo.xredsys.api.Type">
                   <html:option value="<%=\"\" + state.getId()%>"><bean:message key="<%=\"s.SectionStateType.\" + state.getName()%>"/></html:option>
                 </logic:iterate>
              </html:select>
              <html:errors property="state" />

            <%}else if(name.equalsIgnoreCase("SectionTemplate")){%>
              <html:select property="sectionLayout">
                <html:option value="">&nbsp;</html:option>
                <logic:iterate name="escenic-publication" property="sectionLayouts" scope="session" id="slayout" type="neo.xredsys.api.Layout" >
                  <html:option value="<%=slayout.getName()%>"><%=slayout.getName()%></html:option>
                </logic:iterate>
              </html:select>

            <%}else if(name.equalsIgnoreCase("ArticleTemplate")){%>
              <html:select property="articleLayout">
                <html:option value="">&nbsp;</html:option>
                <logic:iterate name="escenic-publication" property="articleLayouts" scope="session" id="alayout" type="neo.xredsys.api.Layout" >
                  <html:option value="<%=alayout.getName()%>"><%=alayout.getName()%></html:option>
                </logic:iterate>
              </html:select>

            <%}else{
              out.print("&nbsp;");
            }
          %>
           </td>
          <%
        }
      %>
    </tr>
  </table>
  <table>
  <tr>
   <td><a class="global-button" href="javascript:submitForm('store')">Save</a></td>
  </tr>
  </table>
<hr>
<table>
  <tr>
    <td>Id:</td>
    <td>The sectionid</td>
  </tr>
  <tr>
    <td>Name:</td>
    <td>The name of the section</td>
  </tr>
  <tr>
    <td>Uniquename:</td>
    <td>The uniquename of the section</td>
  </tr>
  <tr>
    <td>State:</td>
    <td>The state of the section</td>
  </tr>
  <tr>
    <td>AgType:</td>
    <td>The agreementtype of the section. If empty, no agreementtype is specified</td>
  </tr>
  <tr>
    <td>SecTempl:</td>
    <td>The section template of the section</td>
  </tr>
  <tr>
    <td>ArtTempl:</td>
    <td>The default article template of the section</td>
  </tr>
  <tr>
    <td>Is Virt:</td>
    <td>Is the section a virtual section?</td>
  </tr>
  <tr>
    <td>Source:</td>
    <td>If the section is virtual, this is the target section</td>
  </tr>
</table>
<input type="hidden" name="submitButton" value="">
