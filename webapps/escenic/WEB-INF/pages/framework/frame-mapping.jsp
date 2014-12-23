<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page language="java" import="java.util.*" %>
<%@ page import="java.net.URL"%>
<%--
  frame-mapping.jsp
  =================

The purpose of this file is to map from the "task" request
scoped attribute to a set of attributes

In the future, this will be a call to a TAG, which is initialized
from an XML file or something nice...

  "task"             +  "area"          =  implementation
  /article/generic   +  frame-left        =  "/framework/frame-left.jsp"

  /article/edit inherits /article/generic
  /article/edit      +  main-content      =  "/article/editFields-content.jsp"

  /article/show      +  frame-left        =  "/framework/frame-left.jsp"
  /article/show      +  main-content      =  "/article/show-content.jsp"


  Each task will typically specify the same set of areas, with different implementations.

  It would be nice if we could have some sort of inheritance mechanism as well...

  This file implements the strategy above using a double hash map:
  
  Hashmap:
  "/article/generic" -> hashmap:
                        "frame-left"   =  "/framework/frame-left.jsp"
  
  "/article/edit" -> hashmap:
                        "frame-left"   =  "/framework/frame-left.jsp"
                        "main-content" =  "/article/editFields-content.jsp"


--%>

<%!
neo.xredsys.config.StringPairMapping mapping = new neo.xredsys.config.StringPairMapping();



public void jspInit() {
  org.apache.log4j.Logger LOGGER = org.apache.log4j.Logger.getLogger("neo.phoenix.framework.FrameMapping");
  String resource = "/WEB-INF/frame-mapping.xml";
  java.io.InputStream stream = getServletConfig().getServletContext().getResourceAsStream(resource);
  org.xml.sax.InputSource source = new org.xml.sax.InputSource(stream);
  readMapping(source);

  try{
    Enumeration resources = getClass().getClassLoader().getResources("com/escenic/plugin/frame-mapping.xml");
    if (resources.hasMoreElements()) {
      while (resources.hasMoreElements()) {
        URL u = (URL) resources.nextElement();
        LOGGER.info("Loading additional mappings from url " + u);
        try{
          source = new org.xml.sax.InputSource(u.openStream());
          readMapping(source);
        } catch (java.io.IOException e) {
          LOGGER.warn("Loading additional mappings from url " + u + " failed: " + e);
          LOGGER.debug("Exception details: ", e);
        }
      }
    }
  }catch(Exception e){
    LOGGER.error("Could not read any resources at all");
  }
}
private String dtd = System.getProperty("templateRoot") + "pairmap.dtd";

private void readMapping(org.xml.sax.InputSource source) {
  source.setSystemId(dtd);
  neo.xredsys.config.StringPairMappingXmlReader.readMapping(mapping,source);
}


 %>


<%

String task = (String)request.getAttribute("task");

java.util.Iterator keys = mapping.getSecondaryKeyIterator(task);
if (!keys.hasNext()) {
  org.apache.log4j.Category.getInstance("neo.phoenix.framework").error("Invalid task specified '" + task + "': Reverting to '/generic' mapping.");
  task = "/generic";
}

for (keys = mapping.getSecondaryKeyIterator(task); keys.hasNext(); ) {
  String key = (String)keys.next();
  String value = mapping.getValue(task,key);
  if (value.startsWith("//") && value.endsWith(".jsp")) {
    value = value.substring(1);
    request.setAttribute("areamap-" + key, value);
  }else if (value.startsWith("/") && value.endsWith(".jsp")) {
    value = "/WEB-INF/pages" + value;
    request.setAttribute("areamap-" + key, value);
  }else if(key.equals("enctype")){
    request.setAttribute(key,value);
  }else {
    request.setAttribute("textmap-" + key, value);
  }
}

%>
