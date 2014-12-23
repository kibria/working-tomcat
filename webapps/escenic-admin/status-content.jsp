<%@ page buffer="none" %>
<%--









--%>
<%!
  private static final boolean OLD_JAAS = !is14();

  private static final boolean is14() {
    try {
      Class.forName("java.awt.HeadlessException"); // Any class new in 1.4 will do
      return true;
    }
    catch (ClassNotFoundException e) {
      return false;
    }
  }

  private String isJavaClassAvailable(String className, String ok, String notOk) {
    try {
      if (OLD_JAAS) {
        ClassLoader.getSystemClassLoader().loadClass(className);
      } else {
        getClass().getClassLoader().loadClass(className);
      }

      return ok;
    } catch (Throwable e) {
      return notOk;
    }
  }

  private String isNurseryComponentAvailable(String componentName, String ok, String notPresent, String notOk) {
    try {
      Object globalBus = invoke(null, "neo.nursery.GlobalBus", "getGlobalBus", null);
      Object isAvailable = invoke(globalBus, "neo.nursery.Bus", "isAvailable", new String[]{componentName});
      if (!((Boolean) isAvailable).booleanValue()) {
        error = "Component <code>" + componentName + "</code> is not initialized.";
      }
      return ((Boolean) isAvailable).booleanValue() ? ok : notPresent;
      //return notPresent;
    } catch (Throwable e) {
      handle(e);
      return notOk;
    }
  }

  private String isServerConfigSet(String getterName, String ok, String notOk) {
    try {
      Object globalBus = invoke(null, "neo.nursery.GlobalBus", "getGlobalBus", null);
      Object serverConfig = invoke(globalBus, "neo.nursery.Bus", "lookup", new String[]{"/ServerConfig"});
      if (serverConfig == null) {
        error = "Component <code>/ServerConfig</code> does not exist.";
      }
      String result = (String) invoke(serverConfig, serverConfig.getClass().getName(), getterName, null);
      if (result == null) return notOk;
      if (result.trim().length() == 0) return notOk;
      return ok;
    } catch (Throwable e) {
      handle(e);
      return notOk;
    }
  }


    private String doOpenJDKCheck(String mode, String ok, String notOk) {
        try {
            if (mode.toLowerCase().contains("openjdk".toLowerCase())) {

                return notOk;

            } else {
                return ok;
            }

        } catch (Throwable e) {
            handle(e);
            return notOk;
        }
    }

  private String doSecuritySanityCheck(String mode, String ok, String notOk) {
    try {
      if (mode.equals("loginconfig")) {
        if (javax.security.auth.login.Configuration.getConfiguration().getAppConfigurationEntry("ece-basic") == null) {
          error = javax.security.auth.login.Configuration.getConfiguration().getClass().getName() + " did not know about 'ece-basic' application.";
          return notOk;
        }
      } else if (mode.equals("sanitycheck")) {
        invoke(null, "neo.xredsys.auth.SanityCheck", "sanityCheck", null);
      }
      return ok;
    } catch (Throwable e) {
      handle(e);
      return notOk;
    }
  }

  private String doDatabaseSanityCheck(String ok, String notOk, String mode, boolean readonly) {
    try {
      Object cm = invoke(null, "neo.xredsys.content.ContentManager", "getContentManager", null);

      Object to;
      if (OLD_JAAS) {
        to = ClassLoader.getSystemClassLoader().loadClass("neo.dbaccess.SanityCheckTransactionOperation").newInstance();
      } else {
        to = getClass().getClassLoader().loadClass("neo.dbaccess.SanityCheckTransactionOperation").newInstance();
      }
      invoke(to, "neo.dbaccess.SanityCheckTransactionOperation", "setMode", new String[]{mode});
      invoke(cm, "neo.xredsys.content.ContentManager", readonly ? "doQuery" : "doTransaction", new Object[]{to});
      Object msg = invoke(to, "neo.dbaccess.SanityCheckTransactionOperation", "getMessage", null);
      if (msg != null) {
        error = (String) msg;
      }
      Boolean success = (Boolean) invoke(to, "neo.dbaccess.SanityCheckTransactionOperation", "isSuccessful", null);
      return success.booleanValue() ? ok : notOk;
    } catch (Throwable e) {
      handle(e);
      return notOk;
    }
  }


  private String doNetworkSanityCheck(String ok, String notOk, String mode) {
    try {
      if ("localhost1".equals(mode)) {
        java.net.InetAddress a = java.net.InetAddress.getLocalHost();
        java.net.InetAddress b = java.net.InetAddress.getByName("localhost");
        if (a.getHostAddress().equals(b.getHostAddress())) {
          error = a.toString() + " and " + b.toString() + " must not be equal.";
          return notOk;
        }
        return ok;
      }
      if ("localhost2".equals(mode)) {
        error = String.valueOf(java.net.InetAddress.getByName("localhost"));
        return ok;
      }
      if ("localhost3".equals(mode)) {
        error = String.valueOf(java.util.Arrays.asList(java.net.InetAddress.getAllByName("localhost")));
        return ok;
      }
      if ("localhost4".equals(mode)) {
        error = String.valueOf(java.util.Arrays.asList(java.net.InetAddress.getAllByName(java.net.InetAddress.getLocalHost().getHostName())));
        return ok;
      }
      if ("escenic".equals(mode)) {
        error = String.valueOf(java.net.InetAddress.getByName("www.escenic.com"));
        return ok;
      }
      if ("time".equals(mode)) {
        java.text.SimpleDateFormat format = new java.text.SimpleDateFormat();
        format.setTimeZone(java.util.TimeZone.getTimeZone("+00:00"));
        format.applyPattern("yyyy-MM-dd'T'HH:mm:ss");
        error = format.format(new java.util.Date()) + "+00:00";
        return ok;
      }
      error = "Unknown test: " + mode;
      return notOk;
    } catch (Throwable e) {
      handle(e);
      return notOk;
    }
  }


  private Object invoke(Object instance, String className, String methodName, Object[] parameters) throws Throwable {
    Class c;
    if (OLD_JAAS) {
      c = ClassLoader.getSystemClassLoader().loadClass(className);
    } else {
      c = getClass().getClassLoader().loadClass(className);
    }
    java.lang.reflect.Method[] methods = c.getMethods();
    java.lang.reflect.Method method = null;
    for (int i = 0; i < methods.length; i++) {
      if (methods[i].getName().equals(methodName)) {
        if (methods[i].getParameterTypes().length == (parameters == null ? 0 : parameters.length)) {
          method = methods[i];
        }
      }
    }
    if (method == null) {
      throw new Exception("No methods matched " + className + "." + methodName);
    }
    return method.invoke(instance, parameters);
  }

  public void jspInit() {


    helpTexts.put("classpath", "<p>The CLASSPATH has to contain a few things for Escenic to work properly.  Specifically it needs all of the classes of Escenic in the System CLASSPATH.</p><p>The manner in which the System CLASSPATH is set depends on your application server.  See the documentation for your application server in order to see how to set up your CLASSPATH.</p>");

    helpTexts.put("classpath-deprecated", "<p>The CLASSPATH has to contain a few things for Escenic to work properly.  Specifically it needs all of the classes in the <code>$escenic.root/lib</code> (on this machine: <code>" + System.getProperty("escenic.root") + "lib/</code>) directory to be in the System CLASSPATH.</p><p>The manner in which the System CLASSPATH is set depends on your application server.  See the documentation for your application server in order to see how to set up your CLASSPATH.</p>");

    helpTexts.put("classpath-log4j.jar", "<p>This tests whether or not the Log4Java component is in the CLASSPATH.</p><p>If it is red, it indicates that the file <code>log4j.jar</code> is not present in the CLASSPATH.  It must be in the System classpath (specified on the JVM command line) for it to work.</p><p>Normally, if this file is not in the CLASSPATH, then you can expect that no other Escenic libraries are available in the CLASSPATH; so basically this is a little sanity check to see that at least one of the files made it.  All of the Escenic JAR files must be in the system classpath.</p>");

    helpTexts.put("classpath-ece.jar", "<p>This tests whether or not the actual Escenic code is available in the CLASSPATH.  Normally, if log4j.jar is in the CLASSPATH, then the Escenic code should also be available.</p><p>Normally, if this file is not in the CLASSPATH, you can expect that no other Escenic libraries are available in the CLASSPATH either, so basically this is a little sanity check to see that at least one of the files made it.  All of the JAR files in the escenic/lib/ directory must be in the System CLASSPATH.");


    helpTexts.put("security", "<p>This test checks whether or not the necessary changes have been made to the Java environment. These settings include System properties, possibly configuring a component in your configuration layer, and setting a property in <tt>java.security</tt> in the <tt>lib/security</tt> file.</p><p>If these items have not been set up correctly, Escenic security functions will not work correctly. Typically, a user will have access to more functions than defined.</p>");

    helpTexts.put("property-security.config", "<p>Escenic needs to specify security properties, if any authorization is to be done on the server.  Typically, if the server is to be used with Studio or the web interface (which is typically always), then this property must be set to point to the <code>security/jaas.config</code> in your configuration layer folder tree. If this file does not exist, you will be unable to log in to Escenic, but Escenic will be able to serve content from publication to the Web.</p>");

    helpTexts.put("property-security.config-deprecated", "<p>Escenic needs to specify security properties, if any authorization is to be done on the server.  Typically, if the server is to be used with Studio or the web interface (which is typically always), then this property must be set to point to the <code>security/jaas.config</code> in your configuration layer folder tree. If this file does not exist, you will be unable to log in to Escenic, but Escenic will be able to serve content from publication to the Web.</p>");

    helpTexts.put("property-security.policy", "<p>Escenic assigns permissions to users that execute code when they log in; Permissions also need to be set for code that has not been authenticated. Code that is not running on behalf of a user will receive permissions that are defined in the file specified in the System Property <code>java.security.policy</code>.</p>Escenic ships with a policy file as <code>security/java.policy</code> in your configuration layer folder. If this file does not exist, a lot of the system will work, but a bug in JDK1.3 will produce sporadic StackOverflowExceptions.</p>");

    helpTexts.put("property-security.policy-deprecated", "<p>Escenic assigns permissions to users that execute code when they log in; Permissions also need to be set for code that has not been authenticated. Code that is not running on behalf of a user will receive permissions that are defined in the file specified in the System Property <code>java.security.policy</code>.</p>Escenic ships with a policy file as <code>security/java.policy</code> in the Escenic installation directory.</p> <p>For your system, this value would be <code>" + System.getProperty("escenic.root") + "security/java.policy" + "</code>. </p><p> If this file does not exist, a lot of the system will work, but a bug in JDK1.3 will produce sporadic StackOverflowExceptions.</p>");

    helpTexts.put("security-sanitycheck", "<p>If this item fails it means that the necessary changes to the Java <code>lib/security/java.policy</code> file have not been implemented. It means that if you are using JDK 1.3, you need to specify the property <code>combined.provider</code> to the <code>java.policy</code> file; while if you are using JDK1.4, you need to specify this in the component <code>/neo/auth/PolicyBootstrap</code>.</p>");

    helpTexts.put("security-sanitycheck", "<p>If this item fails it means that the necessary changes to the Java <code>lib/security/java.policy</code> file have not been implemented. It means that if you are using JDK 1.3, you need to specify the property <code>combined.provider</code> to the <code>java.policy</code> file; while if you are using JDK1.4, you need to specify this in the component <code>/neo/auth/PolicyBootstrap</code>.</p>");


    helpTexts.put("nursery", "<p>The Nursery is an Escenic component that is used to bootstrap most of the Escenic objects.  The Nursery allows each bean property of each Nursery-managed object to be specified in its own properties-file.  Normally, the default values are sufficient, except for some mandatory configuration that needs to be done. The Nursery tests show whether or not the Nursery has been set up correctly.</p><p>A valid nursery configuration is expected to be present in the location specified by the configuration layer.  When setting up Escenic for the first time, it is normal to copy the contents of the [escenic/engine/directory]/siteconfig/config-skeleton/ directory into the location spcified by the configuration layer filesystemroot directory.");

    helpTexts.put("nursery-deprecated", "<p>The Nursery is an Escenic component that is used to bootstrap most of the Escenic objects.  The Nursery allows each bean property of each Nursery-managed object to be specified in its own properties-file.  Normally, the default values are sufficient, except for some mandatory configuration that needs to be done. The Nursery tests show whether or not the Nursery has been set up correctly.</p><p>A valid nursery configuration is expected to be present in the $escenic.root/localconfig directory (on this machine: <code>" + System.getProperty("neo.nursery.GlobalBus.root", System.getProperty("escenic.root") + "localconfig") + "</code>).  When setting up Escenic for the first time, it is normal to copy the contents of the $escenic.root/siteconfig/j2ee/localconfig/ directory into the localconfig directory.</p>");

    helpTexts.put("nursery-escenic-layer", "<p>This tests if the Nursery is able to reach the <code>nursery.jar</code> that contains all of the default values for all of the Escenic components.  Failure to reach <code>nursery.jar</code>, usually has to do with <code>assembly_tool_directory/conf/layers/escenic_configuration_layer_name.properties</code> file if you are using the default setup. This properties file should use a neo.nurser.ResourceDepot with prefix=com/escenic/configuration/default/</p>");

    helpTexts.put("nursery-escenic-layer-deprecated", "<p>This tests if the Nursery is able to reach the <code>nursery.jar</code> that contains all of the default values for all of the Escenic components.  Failure to do this usually has something to do with the file <code>" + System.getProperty("escenic.root") + "localconfig/configurators/EscenicDepot.properties</code>.</p>");

    helpTexts.put("nursery-initial", "<p>This test indicates whether or not the <code>/Initial</code> component has been loaded by the Nursery.  If the <code>/Nursery</code> component loads successfully, but this component fails, it means that the primary configuration layer is unable to reach the <i>main</i> configuration layer</a></p>");

    helpTexts.put("nursery-ioapi", "<p>This test checks to see if the Nursery is able to initialize most of the Escenic objects in the system.  It does so by asking for some high-level objects, namely the IOAPI object.  If it is unavailable, the reason should be found in another test.</p>");


    helpTexts.put("database", "<p>Escenic stores most of its content in a database.  The tests that follow indicate whether or not the database is configured correctly, and whether or not it is possible to connect to the database. <p>The Database component is used to configure the database when using the Escenic connection pool. If you are using a different connection pool than the one that ships with Escenic, this section can be ignored, as the connection parameters are typically defined in your Application Server.</p>");

    helpTexts.put("database-deprecated", "<p>Escenic stores most of its content in a database.  The tests that follow indicate whether or not the database is configured correctly, and whether or not it is possible to connect to the database given the information in the <code>/Database</code> component.</p><p>For information on how to configure the <code>/Database</code> component, see the file <code>$escenic.root/Database.properties</code> (on this machine: <code>" + System.getProperty("escenic.root") + "/localconfig/Database.properties</code>)</p>");

    helpTexts.put("database-connect-read", "<p>This test checks to see if Escenic can connect to the read data source that it has received.  If this fails, it indicates that the data source or connection pool in use is failing, or misconfigured.</p><p>  By default, Escenic uses its own connection pool that retrieves its configuration from the <code>/Database</code> component.</p><p>If you get a NoSuitableDriver exception here, it can mean one of the following:<ul><li>Your CLASSPATH does not contain your database driver</li><li>The class name of your database driver is spelled incorrectly in <code>Database.properties</code></li><li>Your <code>JDBC URL</code> contains a spelling mistake, so that the <code>JDBC</code> driver fails to recognise the URL.</li><li>Your connection pool does not work or cannot be found.</li></ul></p>");

    helpTexts.put("database-connect-update", "<p>This test checks to see if Escenic can connect to the update data source which it has received.  If this fails, it indicates that the data source or connection pool in use is failing, or misconfigured.</p><p>  By default, Escenic uses its own connection pool, which retrieves its configuration from the <code>/Database</code> component.</p><p>If you get a NoSuitableDriver exception here, it can mean one of the following:<ul><li>Your CLASSPATH does not contain your database driver</li><li>The class name of your database driver is spelled incorrectly in <code>Database.properties</code></li><li>Your <code>JDBC URL</code> contains a spelling mistake, so that the <code>JDBC</code> driver fails to recognise the URL.</li><li>Your connection pool does not work or cannot be found.</li></ul></p>");

    helpTexts.put("database-tables", "<p>This second test checks to see if the database script has been run, and the tables exist.  If this portion fails it means that you need to run the database scripts in the  <code> EscenicEngine/database</code> directory.</p>");

    helpTexts.put("database-symbols", "<p>This second test checks to see if the database is populated with some constant values that Escenic needs in order to work.  If this test fails, it means that the database scripts have not completed.</p>");

    helpTexts.put("database-publications", "<p>This test simply checks to see if there are any publications defined in the database.  This typically fails if you have just installed the database and have not yet created any publications.</p>");


    helpTexts.put("property", "<p>Some features in Escenic are controlled by a few important System Properties.  These properties must be set correctly in order for the rest of Escenic to function correctly.  Some are mandatory, while some are optional.  A yellow result indicates an optional property that has not been set.  A red result indicates a mandatory property that has not been set or has an improper value.</p><p>System properties are set in different ways depending on your application server.  Some application servers allow you to pass parameters to the java executable that runs the application server.  In this case use the -D parameter to pass System Properties on the command line.  For example; to set the System property <code>property</code> to the value <code>value</code>, you should  add <code>-Dproperty=value</code>.</p>");

    helpTexts.put("property-com.escenic.config", "<p><code>com.escenic.config</code> is deprecated because it is not needed anymore. <p>Instead you need to set a configuration layer in <code>assembly_tool_directory/conf/layers/escenic_configuration_layer_name.properties</p>");

    helpTexts.put("property-escenic.root", "<p>The <code>escenic.root</code> is deprecated because it is not needed anymore. <p>You might set <code>com.escenic.config</code> to the location where the Escenic configuration files are placed if required. It tells the boot-strapping Escenic code where to find the configuration of Escenic.</p><p>The system property <code>com.escenic.config</code> must have the following URI syntax:</p><ul><li><code>file:/some/absolute/directory/path</code></li><li><code>classpath:/some/classpath/prefix</code></li></ul><p>The <code>com.escenic.config</code> system property will default to <code>classpath:/com/escenic/config</code> if it is not set.</p>");

    helpTexts.put("property-escenic.server", "<p>This is a mandatory property that is used to indicate the name of the instance of the engine within a cluster of Escenic Content Engine servers.  If you have more than one server, they must all have unique names that identify them. </p><p> The Nursery looks in the <code>servers</code> directory in the configuration layer directory for a directory specified by configuration layer <code>filesystemRoot</code>. </p><p>This default behaviour is defined by the <code>/Nursery</code> component in a default installation.</p>");

    helpTexts.put("property-java.vm.name", "<p>This indicates the Java virtual machine name that is running in the server.<code>Oracle Java</code> is recommended.</p><p> <code>OpenJDK</code> is not supported.</p>");

    helpTexts.put("property-escenic.server-deprecated", "<p>This is a mandatory property that is used to indicate the name of the instance of the engine within a cluster of Escenic Content Engine servers.  If you have more than one server, they must all have unique names that identify them. </p><p><code>escenic.root</code> also usually points the server to use a specific, dominant configuration layer in the Nursery.</p><p>By default, the Nursery looks in the <code>servers</code> directory in the <code>escenic.root</code> directory for a directory specified by <code>escenic.server</code>.  If that directory contains a <code>localconfig</code> directory, this is added as a dominant configuration layer.</p><p>This default behaviour is defined by the <code>/Nursery</code> component in a default installation.</p>");

    helpTexts.put("property-nursery.root", "<p><code>neo.nursery.GlobalBus.root</code> is deprecated. We recommend removing the <code>neo.nursery.GlobalBus.root</code> system property from the classpath.</p><p>The Nursery will by default be initialized from <code>com.escenic.config/Nursery.properties</code>.</p>");

    helpTexts.put("network", "<p>Network parameters can be problematic if they are set up wrong.  This page is meant as a sanity check to verify that important networking parameters are set correctly.</p>");

    helpTexts.put("network-localhost1", "<p>This test checks to see whether the server can figure out its own host name.  This might seem unimportant, but if a server can not resolve itself then RMI and other networking services might not work.</p>");

    helpTexts.put("network-localhost2", "<p>This test looks up the name <b>localhost</b>.</p>");
    helpTexts.put("network-localhost3", "<p>This test looks up all the <b>localhost</b> interfaces, if there are more than one.</p>");
    helpTexts.put("network-localhost4", "<p>This test looks up all the host names of the local host name, if there are more than one.</p>");
    helpTexts.put("network-escenic", "<p>This test checks the availability of a functioning DNS server.  Normally, the host name of <b>www.escenic.com</b> is not in the <tt>hosts</tt> file.  This test simply looks up that address. If there is no connection to a DNS server, then the server could experience long timeouts when attempting to resolve host names.</p>");

    helpTexts.put("network-time", "<p>This displays the server&apos;s time, alongside the correct time.  You should check the time manually and see that the discrepancy is small.  If it is too big, then this could be irritating with in terms of activation and deactivation.  Another thing to consider when clustering, is that each server should be kept in sync with the other servers, so that they don&apos;t display different content.</p>");

    /* These properties define what the "all tests" button shows, and the "next" / "previous" buttons. */
    allTests.add("properties");
    allTests.add("security");
    allTests.add("classpath");
    allTests.add("nursery");
    allTests.add("database");
    allTests.add("network");

    descriptions.put("properties", "System Properties");
    descriptions.put("security", "Security settings");
    descriptions.put("classpath", "Classpath");
    descriptions.put("nursery", "Configuration Layers");
    descriptions.put("database", "Database");
    descriptions.put("network", "Network Parameters");
  }

  final java.util.List allTests = new java.util.ArrayList();
  final java.util.Map descriptions = new java.util.HashMap();

%>

<%@include file="commonstatus-java.jsp"%>
<%-- <%@include file="commonstatus-style.jsp"%> --%>
<%@include file="commonstatus-script.jsp"%>

<%
  java.util.List tests = new java.util.ArrayList();
  String testParameter = request.getParameter("tests");
  if (testParameter == null) testParameter = "properties";
  if (testParameter.equals("all")) {
    tests = allTests;
  } else {
    java.util.StringTokenizer tokens = new java.util.StringTokenizer(testParameter,",");
    while (tokens.hasMoreTokens()) {
      tests.add(tokens.nextToken());
    }
  }
%>

<table class="status-buttons"><tr>
<% for (int i = 0; i < allTests.size(); i++) { /* > */ %>
  <th style=" width: <%=100 / (allTests.size() + 1)%>%; "
      class='<%=tests.size() == 1 ?  ( tests.get(0).equals(allTests.get(i)) ?  "disabledbutton" : "none" ) :"none"%>'>
    <a  href="<%=request.getRequestURI()%>?tests=<%=allTests.get(i)%>"><%=descriptions.get(allTests.get(i))%></a>
  </th>
<% } %>
  <th style=" width: <%=100 / (allTests.size() + 1)%>%; "
      class='<%=tests.equals(allTests) ? "disabledbutton" : "button" %>'>
    <a  href="<%=request.getRequestURI()%>?tests=all">All tests</a>
  </th>
</tr></table>

    <table class="status" border="0" cellpadding="0" cellspacing="0">
      <tr height="0">
        <td class="width: 20%;" width='20%'>&nbsp;</td>
        <td class="width: 40;" width='40'><img src="images/nothing.gif" width="40" height="1"></td>
        <td class="width: 60%;" width='60%'>&nbsp;</td>
        <td class="width: 40;" width='40'>&nbsp;</td>
      </tr>
<% if (tests.contains("properties")) { %>
      <tr>
        <th colspan=4><%=descriptions.get("properties")%></th>
      </tr>
      <tr>
        <td colspan="4" class="intro"><%=inlineHelp("property")%></td>
      </tr>
      <tr>
        <td>com.escenic.config</td>
        <td><img src="images/<%=System.getProperty("com.escenic.config") != null?"yellow":"green" %>.gif"><%=Space%></td>
        <td><%=System.getProperty("com.escenic.config") != null?"com.escenic.config is deprecated.":""%></td>
        <td><%=help("property-com.escenic.config")%></td>
      </tr>
      <tr>
        <td>escenic.server</td>
        <td><img src="images/<%= (System.getProperty("escenic.server") == null ? "red" : "green")%>.gif"><%=Space%></td>
        <td><code><%=System.getProperty("escenic.server")%></code>
            <%=lastError()%></td>
        <td >
          <%=help("property-escenic.server")%>
        </td>
      </tr>
      <tr>
          <td>Java VM Specification</td>
          <td><img src="images/<%=doOpenJDKCheck(System.getProperty("java.vm.name"), "green","red")%>.gif"><%=Space%></td>
          <td><code><%=System.getProperty("java.vm.name")%></code>
              <%=lastError()%></td>
          <td >
              <%=help("property-java.vm.name")%>
          </td>
      </tr>
      <% if(System.getProperty("neo.nursery.GlobalBus.root")!=null) { %>
      <tr>
        <td>neo.nursery.GlobalBus.root</td>
        <td><img src="images/<%=directoryExists(System.getProperty("neo.nursery.GlobalBus.root"),true,"yellow","yellow","red")%>.gif"><%=Space%></td>
        <td><code><%=System.getProperty("neo.nursery.GlobalBus.root")%></code> <br> <b>neo.nursery.GlobalBus.root</b> is deprecated. Use <b>com.escenic.config</b> instead.
            <%=lastError()%></td>
        <td><%=help("property-nursery.root")%></td>
      </tr>
      <% } %>
      <% out.flush();%>
<% } %>
<% if (tests.contains("security")) { %>
      <tr>
        <th colspan=4><%=descriptions.get("security")%></th>
      </tr>
      <tr>
        <td colspan=4 class="intro"><%=inlineHelp("security")%></td>
      </tr>
      <tr>
        <td>java.security.auth.login.config</td>
        <td><img src="images/<%=fileExists(System.getProperty("java.security.auth.login.config"),"green","red","red")%>.gif"><%=Space%></td>
        <td  ><code><%=System.getProperty("java.security.auth.login.config")%></code>
            <%=lastError()%></td>
        <td >
          <%=help("property-security.config")%>
       </td>
      </tr>
      <tr>
        <td>java.security.policy</td>
        <td><img src="images/<%=fileExists(System.getProperty("java.security.policy"),"green","red","red")%>.gif"><%=Space%></td>
        <td  ><code><%=System.getProperty("java.security.policy")%></code>
            <%=lastError()%></td>
        <td >
          <%=help("property-security.policy")%>
        </td>
      </tr>
      <tr>
        <td>JNDI Login Module</td>
        <td><img src="images/<%=doSecuritySanityCheck("sanitycheck", "green","red")%>.gif"><%=Space%></td>
        <td  >
            <%=lastError()%></td>
        <td ><%=help("security-sanitycheck")%></td>
      </tr>
        <% out.flush();%>
      <tr>
        <td>Login Configuration</td>
        <td><img src="images/<%=doSecuritySanityCheck("loginconfig", "green","red")%>.gif"><%=Space%></td>
        <td  >
            <%=lastError()%></td>
        <td ><%=help("security-loginconfig")%></td>
      </tr>
        <% out.flush();%>
      <tr>
        <td colspan=4>&nbsp;</td>
      </tr>
<% } %>
<% if (tests.contains("classpath")) { %>
      <tr>
        <th colspan=4><%=descriptions.get("classpath")%></th>
      </tr>
      <tr>
        <td colspan=4 class="intro">
          <%=inlineHelp("classpath")%>
        </td>
      </tr>
      <tr>
	<td >Is the Log4Java code available?</td>
	<td><img src="images/<%=isJavaClassAvailable("org.apache.log4j.Category","green","red")%>.gif"><%=Space%></td>
        <td  ><%=lastError()%></td>
        <td ><%=help("classpath-log4j.jar")%></td>
      </tr>
      <% out.flush();%>
      <tr>
	<td >Is the Escenic code available?</td>
	<td><img src="images/<%=isJavaClassAvailable("neo.xredsys.api.IOAPI","green","red")%>.gif"><%=Space%></td>
	<td  ><%=lastError()%></td>
        <td ><%=help("classpath-ece.jar")%></td>
      </tr>
      <% out.flush();%>
      <tr>
        <td colspan=4>&nbsp;</td>
      </tr>
<% } %>
<% if (tests.contains("nursery")) { %>
      <tr>
        <th colspan=4><%=descriptions.get("nursery")%></th>
      </tr>
      <tr>
        <td colspan=4 class="intro">
          <%=inlineHelp("nursery")%>
        </td>
      </tr>
      <tr>
	<td >Are the configuration layers initialized</td>
	<td><img src="images/<%=isNurseryComponentAvailable("/Nursery","green","yellow","red")%>.gif"><%=Space%></td>
	<td  ><%=lastError()%></td>
        <td ><%=help("nursery-init")%></td>
      </tr>
      <tr>
	<td >Is the /Initial component initialized</td>
	<td><img src="images/<%=isNurseryComponentAvailable("/Initial","green","yellow","red")%>.gif"><%=Space%></td>
	<td  ><%=lastError()%></td>
        <td ><%=help("nursery-initial")%></td>
      </tr>
      <tr>
	<td >Is the Escenic API initialized</td>
	<td><img src="images/<%=isNurseryComponentAvailable("/io/api/API","green","yellow","red")%>.gif"><%=Space%></td>
	<td  ><%=lastError()%></td>
        <td ><%=help("nursery-ioapi")%></td>
      </tr>
      <tr>
	<td >Can Escenic reach its default configuration layer</td>
	<td><img src="images/<%=isNurseryComponentAvailable("/SanityCheck","green","red","red")%>.gif"><%=Space%></td>
	<td  ><%=lastError()%></td>
        <td >
          <%=help("nursery-escenic-layer")%>
        </td>
      </tr>
      <tr>
        <td >ServerConfig configured</td>
        <td><img src="images/<%=isServerConfigSet("getFilePublicationRoot","green","red")%>.gif"><%=Space%></td>
        <td  ><%=lastError()%></td>
        <td ><%=help("nursery-serverconfig-filePublicationRoot")%></td>
      </tr>
        <% out.flush();%>
      <tr>
        <td colspan=4>&nbsp;</td>
      </tr>
<% } %>
<% if (tests.contains("database")) { %>
      <tr>
        <th colspan=4>Database</th>
      </tr>
      <tr>
        <td colspan=4 class="intro">
          <%=inlineHelp("database")%>
        </td>
      </tr>
      <tr>
        <td >ServerConfig configured</td>
        <td><img src="images/<%=isServerConfigSet("getDatabaseProductName","green","red")%>.gif"><%=Space%></td>
        <td  ><%=lastError()%></td>
        <td ><%=help("database-product-name")%></td>
      </tr>
      <% out.flush();%>
      <tr>
	<td >Database Connection</td>
	<td><img src="images/<%=doDatabaseSanityCheck("green","red", "connection", true)%>.gif"><%=Space%></td>
	<td  ><%=lastError()%></td>
        <td ><%=help("database-connect")%></td>
      </tr>
      <% out.flush();%>
	<td >Tables</td>
	<td><img src="images/<%=doDatabaseSanityCheck("green","red", "tables", true)%>.gif"><%=Space%></td>
	<td  ><%=lastError()%></td>
        <td ><%=help("database-tables")%></td>
      </tr>
      <% out.flush();%>
      </tr>
	<td >Escenic's constants</td>
	<td><img src="images/<%=doDatabaseSanityCheck("green","red", "symbols", true)%>.gif"><%=Space%></td>
	<td  ><%=lastError()%></td>
        <td ><%=help("database-symbols")%></td>
      </tr>
      <% out.flush();%>
      <tr>
	<td >Any publications defined?</td>
	<td><img src="images/<%=doDatabaseSanityCheck("green","yellow", "publications", true)%>.gif"><%=Space%></td>
	<td  ><%=lastError()%></td>
        <td ><%=help("database-publications")%></td>
      </tr>
      <% out.flush();%>
<% } %>
<% if (tests.contains("network")) { %>
      <tr>
        <th colspan=4>Network Parameters</th>
      </tr>
      <tr>
        <td colspan=4 class="intro"><%=inlineHelp("network")%></td>
      </tr>
      <% out.flush();%>
      <tr>
	<td >My own host name</td>
	<td><img src="images/<%=doNetworkSanityCheck("green","red", "localhost1")%>.gif"><%=Space%></td>
	<td  ><%=lastError()%></td>
        <td ><%=help("network-localhost1")%></td>
      </tr>
      <% out.flush();%>
      <tr>
	<td >Look up all addresses for my host name</td>
	<td><img src="images/<%=doNetworkSanityCheck("green","red", "localhost4")%>.gif"><%=Space%></td>
	<td  ><%=lastError()%></td>
        <td ><%=help("network-localhost4")%></td>
      </tr>
      <% out.flush();%>
      <tr>
	<td >Look up 'localhost'</td>
	<td><img src="images/<%=doNetworkSanityCheck("green","red", "localhost2")%>.gif"><%=Space%></td>
	<td  ><%=lastError()%></td>
        <td ><%=help("network-localhost2")%></td>
      </tr>
      <% out.flush();%>
      <tr>
	<td >Look up all localhosts</td>
	<td><img src="images/<%=doNetworkSanityCheck("green","red", "localhost3")%>.gif"><%=Space%></td>
	<td  ><%=lastError()%></td>
        <td ><%=help("network-localhost3")%></td>
      </tr>
      <% out.flush();%>
      <tr>
	<td >DNS</td>
	<td><img src="images/<%=doNetworkSanityCheck("green","red", "escenic")%>.gif"><%=Space%></td>
	<td  ><%=lastError()%></td>
        <td ><%=help("network-escenic")%></td>
      </tr>
      <% out.flush();%>
      <%--
      <tr>
	<td >Time</td>
	<td><img src="images/<%=doNetworkSanityCheck("yellow","red", "time")%>.gif"><%=Space%></td>
	<td  >Server time (UTC): <%=lastError()%><br>Correct time (UTC): <iframe style="vertical-align: middle; width: 30em; height: 4em; border: 0; padding: 0; margin: 0;" src="http://www.escenic.com/time/"></iframe><br>
              You should check that the time is relatively in sync
        </td>
        <td ><%=help("network-time")%></td>
      </tr>
      <% out.flush();%>
    --%>

<% } %>
    </table>

