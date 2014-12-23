<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<!-- viewArticleTypes-content.jsp -->
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>


<input type="hidden" name="submitButton" value="success">
<input type="hidden" name="validateInput" value="success">

<table border=0 cellpadding="2" cellspacing="0">
<tr><td colspan="3">&nbsp;</td></tr>
<bean:define id="publication"
             name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<%
  neo.xredsys.content.type.ArticleType[] types = neo.xredsys.content.type.TypeManager.getInstance().getArticleTypes(publication.getId());
  pageContext.setAttribute("types", types);
  String countryString= ((java.util.Locale)session.getAttribute(neo.phoenix.base.Constants.LOCALE_KEY)).getLanguage();
  
%>
<%--logic:iterate name="publication" property="articleTypes" /--%>
<logic:iterate name="types" id="type" type="neo.xredsys.content.type.ArticleType">
  <tr class="level1">
    <th align="left"><bean:message key="t.Article_type"/>: <bean:write name="type" property="name" /></th>
    <td><%=type.getLabel(countryString)%></td>
    <td><%=type.getDescription(countryString)%></td>
  </tr>
  <logic:notEqual name="type" property="smallIcon" value="">
    <tr class="level1">
      <td>&nbsp;</td>
      <td><bean:message key="t.Small_icon"/></td>
      <td><bean:write name="type" property="smallIcon"/></td>
    </tr>
  </logic:notEqual>
  <logic:notEqual name="type" property="bigIcon" value="">
    <tr class="level1">
      <td>&nbsp;</td>
      <td><bean:message key="t.Big_icon"/></td>
      <td><bean:write name="type" property="bigIcon"/></td>
    </tr>
  </logic:notEqual>
  <% if (type.getCategories() != null && type.getCategories().length > 0 ) { %>
    <tr class="level1">
      <td>&nbsp;</td>
      <td><bean:message key="t.Categories"/></td>
      <td><logic:iterate name="type" property="categories" id="category"><bean:write name="category"/>; </logic:iterate></td>
    </tr>
  <% } %>
  <logic:notEqual name="type" property="validatorClass" value="">
    <tr class="level1">
      <td>&nbsp;</td>
      <td><bean:message key="t.Validator_class"/></td>
      <td><bean:write name="type" property="validatorClass"/></td>
    </tr>
  </logic:notEqual>
  <logic:iterate name="type" property="panels" id="panel" type="neo.xredsys.content.type.Panel">
    <tr class="level2">
      <td><bean:message key="t.Panel"/>: <bean:write name="panel" property="name" /></td>
      <td><%=panel.getLabel(countryString)%></td>
      <td><%=panel.getDescription(countryString)%></td>
    </tr>
    <tr class="level2">
      <td>&nbsp;</td>
      <td><bean:message key="t.On_top"/></td>
      <td><bean:write name="panel" property="onTop" /></td>
    </tr>
    <% if (panel.getMeta() != null && panel.getMeta().length > 0 ) { %>
      <tr class="level2">
        <td>&nbsp;</td>
        <td><bean:message key="t.Meta_field"/></td>
        <td><logic:iterate name="panel" property="meta" id="meta"><bean:write name="meta" property="name" />; </logic:iterate></td>
      </tr>
    <% } %>
    <logic:notEqual name="panel" property="smallIcon" value="">
      <tr class="level2">
        <td>&nbsp;</td>
        <td><bean:message key="t.Small_icon"/></td>
        <td><bean:write name="panel" property="smallIcon"/></td>
      </tr>
    </logic:notEqual>
    <logic:notEqual name="panel" property="bigIcon" value="">
      <tr class="level2">
        <td>&nbsp;</td>
        <td><bean:message key="t.Big_icon"/></td>
        <td><bean:write name="panel" property="bigIcon"/></td>
      </tr>
    </logic:notEqual>
    <logic:notEqual name="panel" property="validatorClass" value="">
      <tr class="level2">
        <td>&nbsp;</td>
        <td><bean:message key="t.Validator_class"/></td>
        <td><bean:write name="panel" property="validatorClass"/></td>
      </tr>
    </logic:notEqual>
    <logic:iterate name="panel" property="fields" id="field" type="neo.xredsys.content.type.Field">
      <tr class="level3">
        <th align="left"><bean:write name="field" property="name" /></th>
        <td><%=field.getLabel(countryString)%></td>
        <td><%=field.getDescription(countryString)%></td>
      </tr>

      <logic:notEqual name="field" property="defaultValue" value="">
        <tr class="level3">
          <td>&nbsp;</td>
          <td><bean:message key="t.Default_value"/></td>
          <td><bean:write name="field" property="defaultValue"/></td>
        </tr>
      </logic:notEqual>

      <logic:notEqual name="field" property="format" value="">
        <tr class="level3">
          <td>&nbsp;</td>
          <td><bean:message key="t.Format"/></td>
          <td><bean:write name="field" property="format"/></td>
        </tr>
      </logic:notEqual>

      <% if (field.inherits() != null) { %>
        <tr class="level3">
          <td>&nbsp;</td>
          <td><bean:message key="t.Inherits_from"/></td>
          <td><%=field.inherits().getName()%></td>
        </tr>
      <% } %>

      <% if (field.getCols() != 0   ||   field.getRows() != 0) { %>
        <tr class="level3">
          <td>&nbsp;</td>
          <td><bean:message key="t.Dimensions"/></td>
          <td><bean:message key="t.Width"/>: <bean:write name="field" property="cols"/>; <bean:message key="t.Height"/>: <bean:write name="field" property="rows"/></td>
        </tr>
      <% } %>

      <% if (field.getMaxChar() != -1) { %>
        <tr class="level3">
          <td>&nbsp;</td>
          <td><bean:message key="t.Size"/></td>
          <td><bean:message key="t.Character_limit"/>: <%=field.getMaxChar()%></td>
        </tr>
      <% } %>

      <% if (field.getDefaultOccurence() != 1   ||   field.getMaxOccurence() != 1) { %>
        <tr class="level3">
          <td>&nbsp;</td>
          <td><bean:message key="t.Occurances"/></td>
          <td><bean:message key="t.Default"/>: <bean:write name="field" property="defaultOccurence"/>; <bean:message key="t.Maximum"/>: <bean:write name="field" property="maxOccurence"/></td>
        </tr>
      <% } %>

      <tr>
        <td>&nbsp;</td>
        <td><bean:message key="t.Options"/></td>
        <td>      
	        <% if (field.isReadOnly()) { %>
	        <bean:message key="t.Read_only"/>;
	        <% } else { %>
		     <bean:message key="t.Read_write"/>;
	        <% }%>
	        	
	        <% if (!field.allowEmpty()) { %>      
	        		<bean:message key="t.Required"/>;
	        <% }%>
	                  
	        <% if (!field.wrapLines()) { %>
	        		<bean:message key="t.Do_not_wrap_lines"/>;
	        <% }%>
        </td>
      <logic:notEqual name="field" property="index" value="">
        <tr class="level3">
          <td>&nbsp;</td>
          <td valign="top"><bean:message key="t.Index"/></td>
          <td><bean:write name="field" property="index"/></td>
        </tr>
      </logic:notEqual>

      <tr class="level3">
        <td>&nbsp;</td>
        <td valign="top">
        <bean:message key="t.Type"/>
        </td>
        <td><% switch (field.getType().getType()) {
             case neo.xredsys.content.type.Type.BASIC:
             %><bean:message key="t.Basic_text" />               
             <%  
               break;
             case neo.xredsys.content.type.Type.NUMBER:
               
             %>  
               <bean:message key="t.Numeric" />	
             <%  break;
             case neo.xredsys.content.type.Type.ENUMERATION:                            
               %>
             	<bean:message key="t.List_of_options" />	
             	
                 <table border="1" cellspacing="0" cellpadding="2">
                   <tr><th><bean:message key="t.Value" /></th><th><bean:message key="t.Label" />	</th></tr>
                   <logic:iterate name="field" property="type.options" id="option">
                     <tr>
                       <td><bean:write name="option" property="value"/></td>
                       <td><bean:write name="option" property="label"/></td>
                     </tr>
                   </logic:iterate>
                 </table>
               <%
               break;
             case neo.xredsys.content.type.Type.DATE:               
             %>
             	<bean:message key="t.Date" />	/ <bean:message key="t.Time" />
             <%
               break;
             case neo.xredsys.content.type.Type.BOOLEAN:               
             %>  
             
             <bean:message key="t.True" /> / <bean:message key="t.False" />
             <%  
               break;
             case neo.xredsys.content.type.Type.HIDDEN:               
               %>
               <bean:message key="t.Hidden" /> 
               <%
               break;
             case neo.xredsys.content.type.Type.SCHEDULE:               
               %>
               <bean:message key="t.Schedule" /> 
               <%
               break;
             default:
             %>
             	<bean:message key="t.Unknown_field_type" /> 
             <%
               break;
           } %>
        </td>
      </tr>

      <logic:notEqual name="field" property="validatorClass" value="">
        <tr class="level3">
          <td>&nbsp;</td>
          <td><bean:message key="t.Validator_class" /> </td>
          <td><bean:write name="field" property="validatorClass"/></td>
        </tr>
      </logic:notEqual>

      <tr>
        <td>&nbsp;</td>
        <td colspan="2"><hr /></td>
      </tr>

     </logic:iterate>
  </logic:iterate>
  <tr class="level1"><th align="left">Decorators</th></tr>
  <% if(type.getDecorators().size()>0) { %>
    <logic:iterate id="decorator" name="type" property="decorators" type="neo.xredsys.content.type.Decorator">
        <tr class="level3">
          <td>&nbsp;</td>
          <td>Name</td>
          <td><bean:write name="decorator" property="name"/></td>
        </tr>
        <tr class="level3">
          <td>&nbsp;</td>
          <td>Class</td>
          <td><bean:write name="decorator" property="className"/></td>
        </tr>
        <tr class="level3">
          <td>&nbsp;</td>
          <td>Parameters</td>
          <td>
            <%if(decorator.getParameterNames().size()>0) {%>
              <table border="0">
                <logic:iterate id="parameterName" name="decorator" property="parameterNames" type="java.lang.String">
                  <tr>
                    <td><bean:write name="parameterName"/></td>
                    <td><%=decorator.getParameter(parameterName)%></td>
                  </tr>
                </logic:iterate> 
              </table>
            <%}else {%>
              No parameters
            <%}%>
          </td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td colspan="2"><hr /></td>
        </tr>
    </logic:iterate>
  <%}else {%>
    <tr class="level1"><td>Type has no decorators</td></tr>
  <%}%>
  <tr class="level1"><th align="left">Modules</th></tr>
  <% if(type.hasModules()) { %>
    <logic:iterate id="module" name="type" property="modules">
        <tr class="level3">
          <td>&nbsp;</td>
          <td>ElementName</td>
          <td><bean:write name="module" property="elementName"/></td>
        </tr>
        <tr class="level3">
          <td>&nbsp;</td>
          <td>Uri</td>
          <td><bean:write name="module" property="URI"/></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td colspan="2"><hr /></td>
        </tr>
    </logic:iterate>
  <%}else {%>
    <tr class="level1"><td>Type has no modules</td></tr>
  <%}%>
  <tr><td colspan="3"><hr /></td></tr>
</logic:iterate>
</table>
<!-- end viewArticleTypes-content.jsp -->
