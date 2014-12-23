<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%--
  frame mapping helper page.  Allows for browsing the entire frame-mapping tree.

  Results in an XML file which looks like this (I wish, anyway!)

  <webapp>
    <areas>

      <area id="area-frame-layout">
        <name>frame-layout</name>
        <renderedin refid="/WEB-INF/pages/framework/frame.jsp"/>
        <fulfilledby refid="/WEB-INF/pages/framework/frame-layout-basketColumn.jsp" count="1"/>
        <fulfilledby refid="/WEB-INF/pages/framework/frame-layout-logon.jsp" count="3"/>
        <fulfilledby refid="/WEB-INF/pages/framework/frame-layout-popup.jsp" count="1"/>
      </area>
    </areas>

    <files>
      <file id="/WEB-INF/pages/framework/frame.jsp">
        <name>frame.jsp</name>
        <usesarea refid="area-frame-layout"/>
      </file>
    </files>

    <files>
      <file id="/WEB-INF/pages/framework/frame-layout-basketColumn.jsp">
        <name>frame-layout-baskedColumn.jsp</name>
      </file>
    </files>


--%>
<%@ page import="neo.util.*, java.util.regex.*, java.util.*, java.io.*, javax.servlet.jsp.PageContext" %>
<%@ page import="java.net.URL"%>

<%!

  void collectPaths(Set paths, PageContext pageContext) {
    collectPaths(paths, pageContext, "/WEB-INF/pages/");
  }

  void collectPaths(Set paths, PageContext pageContext, String path) {
    Set mypaths = pageContext.getServletContext().getResourcePaths(path);
    for (Iterator i = mypaths.iterator(); i.hasNext();) {
      String p = (String) i.next();
      if (p.endsWith(".jsp")) paths.add(p);
      if (p.endsWith("/")) collectPaths(paths, pageContext, p);
    }
  }


private String dtd = System.getProperty("templateRoot") + "pairmap.dtd";

private void readMapping(neo.xredsys.config.StringPairMapping mapping, org.xml.sax.InputSource source) {
  source.setSystemId(dtd);
  neo.xredsys.config.StringPairMappingXmlReader.readMapping(mapping,source);
}

%>

<%
 String escenic = request.getContextPath();
 boolean reload = neo.util.StringUtil.getBoolean(request.getParameter("reload"), false);
 Map tasksToAreas = (Map) request.getSession().getAttribute("tasksToAreas");
 Map tasksToTexts = (Map) request.getSession().getAttribute("tasksToTexts");
 Map textsToValues = (Map) request.getSession().getAttribute("textsToValues");
 Map pathsToAreas = (Map) request.getSession().getAttribute("pathsToAreas");
 Map pathsToTexts = (Map) request.getSession().getAttribute("pathsToTexts");
 Map pathsToBundles = (Map) request.getSession().getAttribute("pathsToBundles");
 Map areasToPaths = (Map) request.getSession().getAttribute("areasToPaths");
 neo.xredsys.config.StringPairMapping mapping = (neo.xredsys.config.StringPairMapping) request.getSession().getAttribute("mapping");

 List languages = new ArrayList();
 {
   Set mypaths = pageContext.getServletContext().getResourcePaths("/WEB-INF/classes/neo/phoenix/");
   for (Iterator j = mypaths.iterator(); j.hasNext(); ) {
     String result = j.next().toString().substring("/WEB-INF/classes/neo/phoenix/".length());
     if (result.startsWith("Resources_")) {
       result = result.substring("Resources_".length());
       if (! result.endsWith(".properties")) {
         continue;
       }
       result = result.substring(0, result.length() - ".properties".length());
       languages.add(result);
     }
   }
 }
if (mapping == null || reload) {
  mapping = new neo.xredsys.config.StringPairMapping();
  System.out.println("               Initializing the mapping.  *****************************");
  String resource = "/WEB-INF/frame-mapping.xml";
  java.io.InputStream stream = getServletConfig().getServletContext().getResourceAsStream(resource);
  org.xml.sax.InputSource source = new org.xml.sax.InputSource(stream);
  readMapping(mapping, source);
  
  Enumeration resources = getClass().getClassLoader().getResources("com/escenic/plugin/frame-mapping.xml");
  if (resources.hasMoreElements()) {
    while (resources.hasMoreElements()) {
      URL u = (URL) resources.nextElement();
      source = new org.xml.sax.InputSource(u.openStream());
      readMapping(mapping, source);
    }
  }
  request.getSession().setAttribute("mapping", mapping);
}



  String path = request.getPathInfo();
  String area = null;
  String file = null;
  String task = null;
  if (path == null) path = "";
  if (path == "" && ! request.getRequestURI().endsWith("/")) {
    response.sendRedirect(request.getRequestURI() + "/");
    return;
  }

  if (path.startsWith("/area/")) {
    area = path.substring(6);
  }
  if (path.startsWith("/file/")) {
    file = path.substring(6);
  }
  if (path.startsWith("/task/")) {
    task = path.substring(6);
  }

  Pattern areamapPattern = Pattern.compile(".*areamap-([a-z][a-z]*[-]*[a-z]*[-]*[a-z]*[-]*[a-z]*[-]*[a-z]*[-]*[a-z]*).*");
  Pattern textmapPattern = Pattern.compile(".*textmap-([a-z][a-z]*[-]*[a-z]*[-]*[a-z]*[-]*[a-z]*[-]*[a-z]*[-]*[a-z]*).*");
  Pattern bundlePattern = Pattern.compile(".*[Bb][Ee][Aa][Nn]:message.*key=\"([^<][^\"]*)\".*");

  if (tasksToAreas == null || reload) {
    System.out.println("               Initializing the tasks.  *****************************");
    tasksToAreas = new TreeMap();
    tasksToTexts = new TreeMap();
    textsToValues = new TreeMap();
    areasToPaths = new TreeMap();
    request.getSession().setAttribute("tasksToAreas", tasksToAreas);
    request.getSession().setAttribute("tasksToTexts", tasksToTexts);
    request.getSession().setAttribute("textsToValues", textsToValues);
    request.getSession().setAttribute("areasToPaths", areasToPaths);
    Set areas = new TreeSet();

    for (Iterator i = mapping.getPrimaryKeyIterator(); i.hasNext(); ) {
      String _task = (String) i.next();
      java.util.Iterator keys;
      Map areamap = new TreeMap();
      Map textmap = new TreeMap();
      for (keys = mapping.getSecondaryKeyIterator(_task); keys.hasNext(); ) {
        String key = (String)keys.next();
        String value = mapping.getValue(_task,key);
        if (value.startsWith("//") && value.endsWith(".jsp")) {
          value = value.substring(1);
        }
        if (value.startsWith("/") && value.endsWith(".jsp")) {
          areamap.put(key, value);
          List areaToPath;
          if (areasToPaths.containsKey(key)) { 
            areaToPath = (List) areasToPaths.get(key);
          } else {
            areaToPath = new ArrayList();
            areasToPaths.put(key, areaToPath);
          }
          String p = value.substring(1);
          if (p.startsWith("/")) p = p.substring(1);
          if (! areaToPath.contains(p)) {
            areaToPath.add(p);
          }
        }else {
          textmap.put(key, value);
        }
      }
      tasksToAreas.put(_task.substring(1),areamap);
      tasksToTexts.put(_task.substring(1),textmap);
    }
  }

  if (pathsToAreas == null || reload) {
    System.out.println("               Initializing the paths.  *****************************");
    pathsToAreas = new TreeMap();  // map from "framework/frame.jsp" -> List of String
    pathsToTexts = new TreeMap();  // map from "framework/frame.jsp" -> List of String
    pathsToBundles = new TreeMap();
    request.getSession().setAttribute("pathsToAreas", pathsToAreas);
    request.getSession().setAttribute("pathsToTexts", pathsToTexts);
    request.getSession().setAttribute("pathsToBundles", pathsToBundles);
    Set paths = new TreeSet();
    collectPaths(paths, pageContext);
    for (Iterator i = paths.iterator(); i.hasNext();) {
      String p = (String) i.next();
      InputStream stream = pageContext.getServletContext().getResourceAsStream(p);
      if (stream == null) continue;
      BufferedReader br = new BufferedReader(new InputStreamReader(stream));
      List areaList = new ArrayList();
      List textList = new ArrayList();
      List bundleList = new ArrayList();
      while (true) {
        String line = br.readLine();
        if (line == null) {
          break;
        }
        Matcher matcher = areamapPattern.matcher(line); // get a matcher object
        if (matcher.matches()) {
          String newline = matcher.group(1);
          if (! areaList.contains(newline)) {
            areaList.add(newline);
          }
        }
        matcher = textmapPattern.matcher(line); // get a matcher object
        if (matcher.matches()) {
          String newline = matcher.group(1);
          if (! textList.contains(newline)) {
            textList.add(newline);
          }
        }
        matcher = bundlePattern.matcher(line); // get a matcher object
        if (matcher.matches()) {
          String newline = matcher.group(1);
          if (! bundleList.contains(newline)) {
            bundleList.add(newline);
          }
        }
      }
      pathsToAreas.put(p.substring("/WEB-INF/pages/".length()), areaList);
      pathsToTexts.put(p.substring("/WEB-INF/pages/".length()), textList);
      pathsToBundles.put(p.substring("/WEB-INF/pages/".length()), bundleList);
    }
  }

  // Go through all the JSP files in '/WEB-INF/pages/' and look for areas, using regexp
  // Create a map of <jsp-file> to list of <area> names
  //   (areas that end with '-' indicate wildcard completion)
  //   Remove 'frame-mapping.jsp' and look for other exceptions, such as 'elements/context-content-top.jsp'...

  // Go through the frame-mapping file and look for areas (i.e. they point to JSP files)
  // Create a map of <area> to list of possible JSP files

  // go through any plug-in files as well!


%>


<html>
<head>
  <title>
    Frame Mapping &gt; <%=StringUtil.escapeHtmlLight(path)%>
 </title>
</head>
<body>
  <h1>
    Frame Mapping &gt; <%=StringUtil.escapeHtmlLight(path)%>
  </h1>
  <% if (path.equals("/")) { %>
    <ul>
      <li><!--<a href="action/"-->30 Struts Actions</a></li>
      <li><a href="task/"><%=tasksToAreas.size()%> Tasks</a></li>
      <li><a href="area/"><%=areasToPaths.size()%> Areas</a></li>
      <li><a href="file/"><%=pathsToAreas.size()%> JSP files</a></li>
      <li><!--a href="i18n/"-->892 i18n resources</a></li>
      <li><!--a href="text/"-->8 resources</a></li>
    </ul>
  <% } %>
  <% if (area != null) { %>
    <% if (area.equals("")) { %>
    <h2>List of areas</h2>
    <ul>
      <% for (Iterator i = areasToPaths.keySet().iterator(); i.hasNext();) { %>
        <% String a = (String)i.next(); %>
      <li><a href="<%=a.substring(0)%>"><%=a%></a></li>
      <% } %>
    </ul>
    <% } else if (areasToPaths.get(area) == null) { %>
    <h2>Unknown area</h2>
    <p>The area '<%=area%>' is not known.</p>
    <% } else { %>
    <h2>Area <%=area%></h2>
    <p>The <%=area%> area can be mapped to the following JSP files:</p>
    <dl>
      <% for (Iterator i = ((List)areasToPaths.get(area)).iterator(); i.hasNext();) { %>
        <% String a = (String)i.next(); %>
        <dt><a href="<%=escenic%>/frame-mapping/file/<%=a.substring(0,a.length()-4)%>"><%=a%></a></dt>

        <% if (pathsToAreas.get(a) != null) { %>
          <% for (Iterator i2 = ((List)pathsToAreas.get(a)).iterator(); i2.hasNext();) { %>
            <% String b = (String)i2.next(); %>
            <dd><a href="<%=escenic%>/frame-mapping/area/<%=b%>"><%=b%></a></dd>
          <% } %>
        <% } %>
      <% } %>
    </dl>
    <% } %>
  <% } %>
  <% if (file != null) { %>
    <% if (file.equals("")) { %>
    <h2>List of files ...</h2>
    <ul>
      <% for (Iterator i = pathsToAreas.keySet().iterator(); i.hasNext();) { %>
        <% String a = (String)i.next(); %>
      <li><a href="<%=a.substring(0,a.length()-4)%>"><%=a%></a></li>
      <% } %>
    </ul>
    <% } else if (pathsToAreas.get(file + ".jsp") == null) { %>
    <h2>Unknown file</h2>
    <p>The file '<%=file%>.jsp' is not known.</p>
    <% } else { %>
    <h2>File <%=file%>.jsp</h2>
    <p>The file <%=file%>.jsp defines the following areas:
    <dl>
      <% for (Iterator i = ((List)pathsToAreas.get(file + ".jsp")).iterator(); i.hasNext();) { %>
        <% String a = (String)i.next(); %>
        <dt><a href="<%=escenic%>/frame-mapping/area/<%=a%>"><%=a%></a></dt>

        <% if (areasToPaths.get(a) != null) { %>
          <% for (Iterator i2 = ((List)areasToPaths.get(a)).iterator(); i2.hasNext();) { %>
            <% String b = (String)i2.next(); %>
            <dd><a href="<%=escenic%>/frame-mapping/file/<%=b.substring(0,b.length()-4)%>"><%=b%></a></dd>
          <% } %>
        <% } %>
      <% } %>
    </dl>
    <% if (pathsToTexts.get(file + ".jsp") != null) { %>
      <p>The file <%=file%>.jsp uses the following texts:
      <dl>
        <% for (Iterator i = ((List)pathsToTexts.get(file + ".jsp")).iterator(); i.hasNext();) { %>
          <% String a = (String)i.next(); %>
          <dt><a href="<%=escenic%>/frame-mapping/text/<%=a%>"><%=a%></a></dt>

          <% if (textsToValues.get(a) != null) { %>
            <% for (Iterator i2 = ((List)textsToValues.get(a)).iterator(); i2.hasNext();) { %>
              <% String b = (String)i2.next(); %>
              <dd><%=b%></dd>
            <% } %>
          <% } %>
        <% } %>
      </dl>
    <% } else { %>
      <p>The file <%=file%>.jsp does not use any texts.</p>
    <% } %>

    <% if (pathsToBundles.get(file + ".jsp") != null) { %>
      <p>The file <%=file%>.jsp uses the following text resources:
      <dl>
        <% for (Iterator i = ((List)pathsToBundles.get(file + ".jsp")).iterator(); i.hasNext();) { %>
          <% String a = (String)i.next(); %>
          <dt><a href="<%=escenic%>/frame-mapping/bundle/<%=a%>"><%=a%></a>
          <dl>
            <dt>
             default
            </dt>
            <dd>
             value=<bean:message key="<%=a%>" locale="" />
            </dd>
          <%--doesn't work for some reason :-( for (Iterator j = languages.iterator(); j.hasNext(); ) {  String lang = (String)j.next(); %>
            <dt>
             <%=lang%>
            </dt>
            <dd>
             value=<bean:message key="<%=a%>" locale="<%=lang%>" />
            </dd>
          <% } --%>
          </dl>
          </dt>
          

          <%-- if (textsToValues.get(a) != null) { %>
            <% for (Iterator i2 = ((List)textsToValues.get(a)).iterator(); i2.hasNext();) { %>
              <% String b = (String)i2.next(); %>
              <dd><%=b%></dd>
            <% } %>
          <% } --%>
        <% } %>
      </dl>
    <% } else { %>
      <p>The file <%=file%>.jsp does not use any texts.</p>
    <% } %>

    <% } %>
  <% } %>
  <% if (task != null) { %>
    <% if (task.equals("")) { %>
    <h2>List of tasks</h2>
    <ul>
      <% for (Iterator i = tasksToAreas.keySet().iterator(); i.hasNext();) { %>
        <% String a = (String)i.next(); %>
      <li><a href="<%=a%>"><%=a%></a></li>
      <% } %>
    </ul>
    <% } else if (tasksToAreas.get(task) == null) { %>
    <h2>Unknown task</h2>
    <p>The task '<%=task%>' is not known.</p>
    <% } else { %>
    <h2>Task <%=task%>.jsp</h2>
    <p>The file <%=task%>.jsp defines the following tasks:
    <dl>
      <% for (Iterator i = ((Map)tasksToAreas.get(task)).keySet().iterator(); i.hasNext();) { %>
        <% String a = (String)i.next(); %>
        <% String b = (String)((Map)tasksToAreas.get(task)).get(a); %>
        <dt><a href="<%=escenic%>/frame-mapping/area/<%=a%>"><%=a%></a></dt>
        <dd><a href="<%=escenic%>/frame-mapping/file<%=b.substring(0,b.length()-4)%>"><%=b%></a></dd>
      <% } %>
    </dl>

    <% } %>
  <% } %>

<hr />
<form>
  <input type=hidden name=reload value=1>
  <input type=submit name=submit value=reload>
</form>
</body>
</html>