  <h1>System Properties</h1>

    <table><tr><th>Name</th><th>Value</th></tr>
<%!

public String printProperty(String prop) {
  if (prop == null) return "<em>null</em>";
  if (prop == "") return "<em>empty string</em>";
  if (prop.length() == 1) return "<em>0x" + Integer.toHexString(prop.charAt(0)) + " (" +prop.charAt(0)+ ")</em>";
  return prop;
}
%>

<%

 java.util.Properties properties = System.getProperties();
 java.util.Set set = new java.util.TreeSet(properties.keySet());
 java.util.Iterator i = set.iterator();
 while (i.hasNext()) {
   String property = (String)i.next();
%>
<tr><td><%=property%></td><td><%=printProperty(properties.getProperty(property))%></td></tr>
<%
 }
%>
    </table>
