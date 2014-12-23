<%@ page language="java"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>

<html:errors />
<h2>Confirmation for export from publication</h2>
<%@ include file="migrate-status-content.jsp" %>
<br/>
<html:form method="post" action="/publication/export" onsubmit="showExportingMessage()">
  <table width="600px" cellspacing=0 cellpadding=0>
    <tr style="background-color:#DCDCDC;height:40px">
      <td style="font-size:13pt;">&nbsp;Do you really want to export with these settings?</td>
      <td><input type="checkbox" id="confirmed" name="confirmed" value="true" onclick="changeExportButtonStatus();">&nbsp;</td>
    </tr>
    <tr>
      <td colspan=2 align="middle">&nbsp;</td>
    </tr>
    <tr>
      <td colspan=2 align="middle"><input type="submit" id="Submit" name="Submit"
        value="Export" style="width:100px;"></td>
    </tr>
  </table>
  <div id="exporting" style="visibility: hidden">Exporting content. Please wait ...</div>
  <script>
    function showExportingMessage() {
      document.getElementById("exporting").style.visibility = "visible";
    }

    function changeExportButtonStatus() {
      document.getElementById('Submit').disabled = !document.getElementById('confirmed').checked;
    }
    changeExportButtonStatus();
</script>
</html:form>
