<%@ page language="java"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ page import="java.util.ArrayList" %>

<h2>Successful</h2>
<%@ include file="migrate-status-content.jsp" %>
<br/>

All requested data from the publication has now been exported.
<br>

<i>The result has been written to the directory <bean:write name="neo.phoenix.publication.ExportForm" property="directoryName" /></i>. 

<logic:present name="exportedFileNames">  
  <bean:size id="size" name="exportedFileNames"/>
  <bean:define id="limit" value="30"/>

  <logic:lessEqual name="size" value="${limit}">
    <bean:define id="limit" value="${size}"/>
  </logic:lessEqual>

  Following file(s) are created during export process.
  <div style='background-color: #DCDCDC;width:600px'>
    <ol>
      <logic:iterate id="fileName" name="exportedFileNames" length="${limit}">
        <li><bean:write name="fileName"/></li>
      </logic:iterate>
    </ol>
    <logic:greaterThan name="size" value="${limit}">
      <bean:define id="diff" value="${size - limit}"/>
      ... and <bean:write name="diff"/> more file(s).
    </logic:greaterThan>
  </div>
</logic:present>


<br>
<!--  When the result is stored, -->Now some manual steps needs to be done:
<ol>
  <li>Create the new publication</li>
  <li>Copy all the templates from the old publication to the new
  publication</li>
  <li>Copy all configuration files such as
  content-type, layout-group, image-version etc. to the new publication</li>
  <li>Import templates</li>
  <li>Deploy all taglibs</li>
  <li>Import the all the exported XML files and binary files in the new publication.</li>
</ol>
<h2>Important</h2>
<ul>
<li>If some content items contain entities, these entities must be defined in a
dtd before importing the data
</li>
<li>If content items are related to other content items ,&nbsp;
the xml file might need to be imported twice. If not, some relations may
be lost.
</li>
<li>The application server might need to be restarted before data are
imported</li>

</ul>
