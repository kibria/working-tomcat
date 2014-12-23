<%@page import="java.sql.Driver"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Properties"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.TreeSet"%>
<%@page import="java.util.Collections"%>
<%@page import="java.net.URI"%>
<%@ page import="neo.nursery.*" %>
<%!
  private static final String NURSERY_PATH = "/Nursery";

  private neo.nursery.Configurator config = null;
  private PropertyValueParser mParser = null;

  private String getJdbcDriverInfo() {
    String driverClassname = getValueOf("/Database", "driver");
    String url = getValueOf("/Database", "url");
    String userid = getValueOf("/Database", "userid");
    String password = getValueOf("/Database", "password");
    String driverInfo = "";
    Connection conn = null;

    if (driverClassname != null) {
      try {
        Driver jdbcDriver = (Driver) Class.forName(driverClassname).newInstance();

        driverInfo = "Maj.: " + jdbcDriver.getMajorVersion() + ", min.: " + jdbcDriver.getMinorVersion();

        if (url != null && userid != null && password != null) {
          conn = DriverManager.getConnection(url, userid, password);
          driverInfo += " [" + conn.getMetaData().getDriverName()
                  + "], driver version: [" + conn.getMetaData().getDriverVersion() + "]";
        }
      }
      catch (Exception e) { /* Intentionally left blank*/}
      finally {
        if (conn != null) {
          try {
            conn.close();
          }
          catch (Exception e) { /* Intentionally left blank*/ }
        }
      }
    }
    return driverInfo;
  }

  private void initializeConfigurator() {
    try {
      mParser = new PropertyValueParserFactoryImpl().getPropertyValueParser();
      config = getConfigurator();
    } catch (Exception e) {
      // store this for later....
      e.printStackTrace();
    }
  }

  private Configurator getConfigurator() throws BusException {
    Properties bootstrapper;
    
    try {
      config = new PropertyFileConfigurator(new ResourceDepot("/com/escenic/configuration/bootstrap"));
      bootstrapper = config.getPropertiesFor(NURSERY_PATH);
    }
    catch (Exception ex) {
      throw new BusException("Unable to retrieve bootstrap config. It should be available under the classpath.", ex);
    }

    MultipleConfigurator configurator = new MultipleConfigurator();
    
    // First we find the layers and sort them 
    Set<String> layerNames = new TreeSet<String>();
    for (Object key : bootstrapper.keySet()) {
      if (key.toString().startsWith("layer.")) {
        layerNames.add(key.toString());
      }
    }

    for (String layer : layerNames) {
      try {
        Configurator layerConfig = getLayerConfiguration(config, getValueOf(NURSERY_PATH, layer));
        if (config != null) {
          configurator.addDominantConfigurator(layerConfig);
        }
      }
      catch (Exception ex) {
        new BusException ("Unable to add layer '" + layer + "' wtih path " + bootstrapper.getProperty(layer), ex).printStackTrace(); 
      }
    }

    return configurator;
  }
   
  private Configurator getLayerConfiguration(final Configurator pConfig, final String pLayer) throws Exception {
    URI layerURI = new URI(NURSERY_PATH).resolve(pLayer);

    String depotFilePath = layerURI.resolve(getValueOf(layerURI.toString(), "depot")).toString();

    String className = getValueOf(depotFilePath, "$class");
    if ("neo.nursery.ResourceDepot".equals(className)) {
      return new PropertyFileConfigurator(new ResourceDepot(getValueOf(depotFilePath, "prefix")));
    }
    else if ("neo.nursery.FileSystemDepot".equals(className)) {
      String fsRoot = getValueOf(depotFilePath, "fileSystemRoot");
      return new PropertyFileConfigurator(new FileSystemDepot(fsRoot));
    }
    else if ("neo.nursery.JarFileDepot".equals(className)) {
      return new PropertyFileConfigurator(new JarFileDepot(getValueOf(depotFilePath, "jarFile")));
    }

    return null;
  }
  
  private Properties getPropertiesFor(String name) {
    try {
      return config.getPropertiesFor(name);
    } catch (Exception e) {
      return new java.util.Properties();
    }
  }

  private String isConfigured(String name, String property, String ok, String notOk) {
    java.util.Properties props = getPropertiesFor(name);
    if (props.containsKey(property)) return ok;
    error = "Component " + name + " did not contain property " + property;
    return notOk;
  }

  private String isConfiguredWithValue(String name, String property, String[] validValues, String ok, String notOk) {
//    final String FAKE_COMPONENT = "/my/fake/Component";
//    Configurator myConfigurator = new Configurator() {
//
//      public Properties getPropertiesFor(String pName) throws BusException {
//        if(FAKE_COMPONENT.equals(pName)) {
//          Properties props = new Properties();
//          props.put("$class", "java.util.Properties");
//          props.put("property." + property, "${/" + name+ "." + property +"}");
//          System.out.println("props:" + props);
//          return props;
//        }
//        return new Properties();
//      }
//
//    };
//    Bus result = neo.nursery.BusFactory.createBus(myConfigurator, GlobalBus.getGlobalBus(), this.getClass().getClassLoader());
//    Object fake = result.lookupSafe(FAKE_COMPONENT);

    String res = isConfigured(name, property, ok, notOk);
    if (res == ok) {
      String item = getValueOf(name, property);
      boolean hit = false;
      for (int i = 0; i < validValues.length; i++) {
        if (item.equals(validValues[i])) {
          hit = true;
        }
      }
      if (!hit) {
        res = notOk;
        error = "Configured value did not match one of the valid values: ";
        for (int i = 0; i < validValues.length; i++) {
          error = error + "'" + validValues[i] + "' ";
        }
      }
    }
    return res;
  }

  private String getValueOf(String name, String property) {
    java.util.Properties props = getPropertiesFor(name);
    if (props.containsKey(property)) return expandPropertyValue(props.getProperty(property), name);
    return "(not specified)";
  }

  private String expandPropertyValue(String pValue, String pComponentName) { 
    try {
      PropertyValue propertyValue = mParser.parse(pComponentName, pValue, config);
      if (propertyValue == null)
        return "";
      else
        return propertyValue.getExpandedValue();
    } catch(BusException be) {
      return "";
    }
  }

  public void jspInit() {

    initializeConfigurator();

    helpTexts.put("/ServerConfig", "<p>The ServerConfig has two very important properties that must be configured.  These are shown below.</p>");

    helpTexts.put("/ServerConfig.databaseProductName", "<p>The name of your database product vendor must appear here, in order for the system to tailor its SQL commands to your specific database.</p>");

    helpTexts.put("/ServerConfig.filePublicationRoot", "<p>The directory in which new publications will be created.</p>");

    helpTexts.put("/Database", "<p>The Database component is used to configure the database when using the Escenic connection pool.  If you are using a different connection pool than the one that ships with Escenic, this section can be ignored, as the connection parameters are typically defined in your Application Server.</p>");

    helpTexts.put("/Database.url", "<p>The url property must be set to the complete JDBC URL that should be used when connecting to your database. See your database vendor documentation for information on how to set this property.</p>");

    helpTexts.put("/Database.driver", "<p><code>driver</code> must be set to the full class name of your JDBC driver. </p>");

    helpTexts.put("/Database.userid", "<p><code>userid</code> must be set to the user ID that will access the database for all operations.</p>");

    helpTexts.put("/Database.password", "<p><code>password</code> must be set to the password of the user that accesses the database.</p>");
  }

%>

<%@include file="commonstatus-java.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Escenic Configuration Report</title>
    <!-- Last modified: $Date: 2013/12/04 $ -->
  </head>

<%@include file="commonstatus-style.jsp"%>
<%@include file="commonstatus-script.jsp"%>

  <body>
    <%
      String path= request.getContextPath();
    %>
    <a href="<%=path%>/">Home</a>
    <h3>Escenic Configuration Report</h3>

    <p>The purpose of this page is to aid field personnel and system administrators in diagnosing connection problems when installing Escenic Content Engine.</p>

    <p>You are viewing this page probably to check your configuration for syntactical errors.  This page will show you the configured values of an Escenic Content Engine configuration.  What this page does is to use the same set of configuration layers as Escenic, but instead of instantiating any components, it shows the configured values.  Note that keyword expansion is not done, so any $ {/ComponentName.propertyValue} keywords are left alone.</p>

    <p>This report only shows the values that are critical that the system works, and that are mandatory configuration values when configuring Escenic Content Engine for the first time.</p>

    <h3>Configuration report</h3>
    <table class="status" width="100%">
      <tr height="0">
        <td width="30%">&nbsp;</td>
        <td width="10">&nbsp;</td>
        <td width="*">&nbsp;</td>
        <td width="10">&nbsp;</td>
      </tr>
      <tr>
        <th colspan=4>/ServerConfig component</th>
      </tr>
      <tr>
        <td colspan="4" class="intro"><%=inlineHelp("/ServerConfig")%></td>
      </tr>
      <tr>
        <td>/ServerConfig.databaseProductName</td>
        <td><img src="images/<%=isConfiguredWithValue("/ServerConfig","databaseProductName",new String[] {"Oracle","Sybase","MsSQL","MsSql","Postgres","DB2","MySQL","Cache"},"green","red")%>.gif"><%=Space%></td>
        <td>(<%=getValueOf("/ServerConfig","databaseProductName")%>) <%=lastError()%></td>
        <td><%=help("/ServerConfig.databaseProductName")%></td>
      </tr>
      <tr>
        <td>/ServerConfig.filePublicationRoot</td>
        <td><img src="images/<%=isConfigured("/ServerConfig","filePublicationRoot","green","red")%>.gif"><%=Space%></td>
        <td>(<%=getValueOf("/ServerConfig","filePublicationRoot")%>) <%=lastError()%></td>
        <td><%=help("/ServerConfig.filePublicationRoot")%></td>
      </tr>
      <tr>
        <th colspan=4>/Database component</th>
      </tr>
      <tr>
        <td colspan="4" class="intro"><%=inlineHelp("/Database")%></td>
      </tr>
      <tr>
        <td>/Database.url</td>
        <td><img src="images/<%=isConfigured("/Database","url","green","red")%>.gif"><%=Space%></td>
        <td>(<%=getValueOf("/Database","url")%>) <%=lastError()%></td>
        <td><%=help("/Database.url")%></td>
      </tr>
      <tr>
        <td>/Database.driver</td>
        <td><img src="images/<%=isConfigured("/Database","driver","green","red")%>.gif"><%=Space%></td>
        <td>(<%=getValueOf("/Database","driver")%>) <%= getJdbcDriverInfo() %> <%=lastError()%></td>
        <td><%=help("/Database.driver")%></td>
      </tr>
      <tr>
        <td>/Database.userid</td>
        <td><img src="images/<%=isConfigured("/Database","userid","green","red")%>.gif"><%=Space%></td>
        <td>(<%=getValueOf("/Database","userid")%>) <%=lastError()%></td>
        <td><%=help("/Database.userid")%></td>
      </tr>
      <tr>
        <td>/Database.password</td>
        <td><img src="images/<%=isConfigured("/Database","password","green","red")%>.gif"><%=Space%></td>
        <td>(password not displayed) <%=lastError()%></td>
        <td><%=help("/Database.password")%></td>
      </tr>
    </table>

    <hr>
  </body>
</html>



