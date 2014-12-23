<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<!-- view-content.jsp -->
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>

<script language="JavaScript1.2"><!--

  function select(value){
    for (var i=0; i < document.forms[0].elements.length; i++) {
        if (document.forms[0].elements[i].type == 'checkbox'){
           document.forms[0].elements[i].checked = value;
        }
    }
  }
  // -->
</script>

<bean:define id="publication" name="escenic-publication" scope="session" type="neo.xredsys.api.Publication" />
<input type="hidden" name="validateButton" value="succes"/>
<input type="hidden" name="validateField" value="none" />
<input type="hidden" name="submitButton" value="">
<input type="hidden" name="validateInput" value="edit">
<table border=0>
  <tr>
    <th align="left"><bean:message key="t.Users_are_currently_imported_from_these_pubs"/>:</th>
  </tr>
  <tr>
    <td>
      <ul>
      <%
        java.util.Collection friendly = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getFriendlyIds(publication.getId());
        java.util.Iterator fIt = friendly.iterator();
        while(fIt.hasNext()){
          Integer next = (Integer)fIt.next();
          neo.xredsys.api.Publication pub = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPublication(next.intValue());
          %>
          <li><%=pub.getName()+"(id="+pub.getId()+")"%>
          <%
        }
      %>
     </ul>
    </td>
  </tr>
  <tr>
    <th align="left"><bean:message key="t.Users_are_currently_exported_to_these_pubs"/>:</th>
  </tr>
  <tr>
    <td>
      <ul>
      <%
        java.util.Collection exported = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getExportedIds(publication.getId());
        fIt = exported.iterator();
        java.util.HashSet exportedPubs = new java.util.HashSet();
        while(fIt.hasNext()){
          Integer next = (Integer)fIt.next();
          neo.xredsys.api.Publication pub = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPublication(next.intValue());
          %>
          <li><%=pub.getName()+"(id="+pub.getId()+")"%><a href="javascript:submitForm('action:/publication/deleteFriendlyPub.do?pubId=<%=publication.getId()%>&friendlyId=<%=pub.getId()%>')"><html:img src="/escenic/images/qw/delete.png" border="0"/></a>
          <%
          exportedPubs.add(next);
        }
      %>
     </ul>
    </td>

  </tr>
  <tr>
    <td><h4><bean:message key="t.Export_users_to_pubs"/>:</h4></td>
  </tr>
      <%
        exportedPubs.add(new Integer(publication.getId()));
       neo.xredsys.api.Publication[] pubs = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getPublications();
       if(pubs.length>0){%>
        <tr>
          <td>
            <table>
            <tr><td>
            <a class="global-button" href="javascript: select(true)">
            <bean:message key="b.select_all"/></a></td>
            <td> <a class="global-button" href="javascript: select(false)"><bean:message key="b.unselect_all"/></a></td>
            </tr></table>
          </td>
        </tr>
       <%}
       for (int i = 0; i < pubs.length; i++) {
         neo.xredsys.api.Publication pub = pubs[i];
         if(!exportedPubs.contains(new Integer(pub.getId()))){
          String id = "selected(" + pub.getId() +")";
          %>
  <tr>
    <td>
          <html:checkbox property="<%=id%>"></html:checkbox><%=pub.getName()+"(id="+pub.getId()+")"%><br>
    </td>
  </tr>
  <tr>
  </tr>
          <%
         }
       }

       if(pubs.length>0){%>
        <tr>
          <td>
            <table>
            <tr><td>
            <a class="global-button" href="javascript: select(true)">
            <bean:message key="b.select_all"/></a></td>
            <td> <a class="global-button" href="javascript: select(false)"><bean:message key="b.unselect_all"/></a></td>
            </tr></table>
          </td>
        </tr>
       <%}%>

</table>

<table cellpadding="0" cellspacing="0" border="0" >
<tr>
 <td>
  <a href="javascript:submitForm('cancel')" class="global-button"><bean:message key="b.cancel"/></a>
 </td>
 <td>&nbsp;</td>
 <td>
  <a href="javascript:submitForm('success')" class="global-button"><bean:message key="b.export"/></a>
 </td>
</tr>
</table>
