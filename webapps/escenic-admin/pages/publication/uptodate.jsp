<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<bean:define id="p" name="p" type="neo.xredsys.api.Publication" />
<bean:define id="source" name="source" type="java.lang.String" />
<bean:define id="filter" name="filter" type="java.lang.String" />
<%java.text.DateFormat format = new java.text.SimpleDateFormat("yyyy/MM/dd HH.mm.ss");%>
<% java.io.File libDir = new java.io.File(p.getRoot() + source);
   java.io.File globalLibDir = new java.io.File(System.getProperty("templateRoot") + source);
   java.io.File[] globalLibFiles;
   if (neo.util.StringUtil.isEmpty(filter)) {
     globalLibFiles = globalLibDir.listFiles();
   } else {
     final String finalfilter = filter;
     globalLibFiles = globalLibDir.listFiles(new java.io.FileFilter() {
       public boolean accept(java.io.File f) {
         return (f.getName().endsWith(finalfilter));
       }
     });
   }
   %>
   <logic:iterate collection="<%=globalLibFiles%>" id="file" type="java.io.File">
     <%
     if (!file.isDirectory()) {
       java.io.File pubFile = new java.io.File(libDir,file.getName());
       if (!pubFile.exists()) {
       %>
       <tr>
         <td>&nbsp;</td>
         <td><input type="checkbox" name="file" value="<%=source%><%= file.getName() %>" checked> Copy</td>
         <td><bean:write name="file" property="name"/></td>
         <td>This file is missing from the publication</td>
       </tr>
       <% } else {
            String fileCRC = neo.util.FileUtil.getChecksumString(file);
            String pubFileCRC = neo.util.FileUtil.getChecksumString(pubFile);
            if (!fileCRC.equals(pubFileCRC)) { %>
       <tr>
         <td>&nbsp;</td>
         <td><input type="checkbox" name="file" value="<%=source%><%= file.getName() %>" checked> Update</td>
         <td><bean:write name="file" property="name"/></td>
         <td>These files differ in content: <br>Escenic file checksum 0x<%=fileCRC%>, <%=file.length()%> bytes. <br>Publication file 0x<%=pubFileCRC%>, <%=pubFile.length()%> bytes</td>
       </tr>
         <% }
          }
        }
       %>
     </logic:iterate>
   <%
%>
