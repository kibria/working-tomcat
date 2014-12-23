<%@ taglib prefix="bean" uri="http://struts.apache.org/tags-bean" %>
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic" %>

<%!
  final String imageURL = "http://labs.google.com/ridefinder/images/mm_20_green.png";
%>

<bean:define id="geoFields" name="geoFields"/>

<logic:iterate id="geoField"
               indexId="geoFieldIndex"
               name="geoFields"
               type="com.escenic.geocode.api.GeoField">
  <%
      StringBuffer titleBuffer = new StringBuffer();
      titleBuffer.append("<html><body><h3>")
                 .append(geoField.getAddress().getAddress())
                 .append("</h3>")
                 .append("</body></html>");
  %>
  <script type="text/javascript">
    addMarker(<%=geoField.getLocation().getLatitude()%>,<%=geoField.getLocation().getLongitude()%>,'<%=imageURL%>', "<%=titleBuffer.toString()%>");
  </script>
</logic:iterate>
