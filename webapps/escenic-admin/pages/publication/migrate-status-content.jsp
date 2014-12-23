<%@ page language="java"%>

<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>

<table width="600px" style="background-color: #DCDCDC; border-width: 1px;">
  <colgroup>
    <col width="280px"></col>
  </colgroup>
  <tr>
    <td nowrap>Publication ID</td>
    <td>:&nbsp;<bean:write name="neo.phoenix.publication.ExportForm" property="publicationId" /></td>
  </tr>

  <logic:notEmpty name="neo.phoenix.publication.ExportForm" property="sectionIds">
    <tr>
      <td nowrap>Section IDs</td>
      <td>:&nbsp;<bean:write name="neo.phoenix.publication.ExportForm" property="sectionIds" />
        <logic:equal name="neo.phoenix.publication.ExportForm" property="includeChilds" value="true">
          &nbsp;and subsection(s)
        </logic:equal>      
      </td>
    </tr>
  </logic:notEmpty>


  <tr>
    <td nowrap>Folder name</td>
    <td>:&nbsp;<bean:write name="neo.phoenix.publication.ExportForm" property="directoryName" /></td>
  </tr>

  <logic:equal name="neo.phoenix.publication.ExportForm" property="groupBy" value="true">
    <tr>
      <td nowrap>Group files by object type</td>
      <td>:&nbsp;<img src="/escenic-admin/images/green.gif" height="14px" width="14px"></td>
    </tr>
  </logic:equal>

  <logic:greaterThan name="neo.phoenix.publication.ExportForm" property="maxNumberOfObjects" value="0">
    <tr>
      <td nowrap>Number of items in each file</td>
      <td>:&nbsp;<bean:write name="neo.phoenix.publication.ExportForm" property="maxNumberOfObjects" /></td>
    </tr>
  </logic:greaterThan>

  <logic:equal name="neo.phoenix.publication.ExportForm" property="sections" value="true">
    <tr>
      <td nowrap>Export sections</td>
      <td>:&nbsp;<img src="/escenic-admin/images/green.gif" height="14px" width="14px"></td>
    </tr>
  </logic:equal>

  <logic:equal name="neo.phoenix.publication.ExportForm" property="articles" value="true">
    <tr>
      <td nowrap>Export Content items</td>
      <td>:&nbsp;<img src="/escenic-admin/images/green.gif" height="14px" width="14px">&nbsp;
        <bean:write name="neo.phoenix.publication.ExportForm" property="contentTypes" />
        <logic:equal name="neo.phoenix.publication.ExportForm" property="includeStagedContent" value="true">
          &nbsp;(the exported content items will include staged content)
        </logic:equal>      
      </td>
    </tr>
  </logic:equal>

  <logic:equal name="neo.phoenix.publication.ExportForm" property="pools" value="true">
    <tr>
      <td nowrap>Export Section pages, Inboxes, Lists</td>
      <td>:&nbsp;<img src="/escenic-admin/images/green.gif" height="14px" width="14px"></td>
    </tr>
  </logic:equal>

  <logic:notEmpty name="neo.phoenix.publication.ExportForm" property="fromDate">
    <tr>
      <td nowrap>Export form time</td>
      <td>:&nbsp;
        <bean:write name="neo.phoenix.publication.ExportForm" property="fromDate" />&nbsp;
        <bean:write name="neo.phoenix.publication.ExportForm" property="fromTime" />
      </td>
    </tr>
  </logic:notEmpty>

  <logic:notEmpty name="neo.phoenix.publication.ExportForm" property="toDate">
    <tr>
      <td nowrap>Export to time</td>
      <td>:&nbsp;
        <bean:write name="neo.phoenix.publication.ExportForm" property="toDate" />&nbsp;
        <bean:write name="neo.phoenix.publication.ExportForm" property="toTime" />
      </td>
    </tr>
  </logic:notEmpty>
</table>
