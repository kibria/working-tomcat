<%@ page import="com.escenic.auth.jaas.oauth2.OAuth2ProviderConfiguration" %>
<%@ page import="neo.nursery.GlobalBus" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Escenic Content Studio Webstart!</title>
    <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="images/favicon.png" sizes="32x32">
    <script>
      function alt() {
        var options = document.getElementById('options');
        var element = document.getElementById('alt');
        element.parentNode.removeChild(element);
        options.className = "open";
      }
    	function sync(lang) {
        var langItem = document.getElementById('lang');
        langItem.value = lang;
		  }
    </script>
    <style>
      body {margin: 0; padding: 0; font-family: "lucida grande",arial,sans-serif; font-size: 12px; color: #666666;}
      .header {text-align: center; background-color: #444444; margin: 100px 0 20px 0;}
      .buttons {width: 300px; margin: 0 auto;}
      .buttons .head {text-align: center; font-size: 22px; color: #444444; margin: 30px 0;}

      #options {max-height: 0; overflow: hidden; -webkit-transition: max-height 0.8s; -moz-transition: max-height 0.8s; transition: max-height 0.8s;}
      #options.open {max-height: 1000px;}
      

      #alt {text-align: right;}
      #alt a {color: #888888;}

      ul {margin: 0; padding: 10px 0;}
      li { list-style: none; margin: 0 0 0.5em 1em;}
      input[type='submit']{
        width: 100%;
        border: 0;
        color: #444444;
        background-color: #dedede;
        text-transform: capitalize;
        font-size: 3em;
        line-height: 2em;
        cursor: pointer;
        border-bottom: 1px solid rgba(0,0,0,0.1);
        vertical-align: bottom;
        text-rendering: optimizeLegibility;
        -webkit-user-select: none;
        -khtml-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
        -webkit-border-radius: 3px;
        -moz-border-radius: 3px;
        border-radius: 3px;
        -webkit-transition: all .1s ease;
        -moz-transition: all .1s ease;
        -ms-transition: all .1s ease;
        -o-transition: all .1s ease;
        transition: all .1s ease;
      }
      input[type='submit']:hover {
        color: #FFFFFF;
        background-color: #ff752d;
      }
      input[type='submit']:active {
        color: #FFFFFF;
        background-color: #fcb088;
      }
    </style>
  </head>
  
  <body>
    <div class="header">
      <img src="images/escenic_ws_logo.png" alt="Escenic Content Studio" />
    </div>
    <div class="buttons">
      <div class="head">Launch Content Studio</div>

      <form id="frm" action="Studio.jnlp" method="get">
        <div id="options">
          Language:
          <ul>
            <li><input type="radio" name="user.country" value="" onclick="sync()" checked/> Detect Language</li>
            <li><input type="radio" name="user.country" value="US" onclick="sync('en')" /> English (American dates)</li>
            <li><input type="radio" name="user.country" value="GB" onclick="sync('en')" /> English (British dates)</li>
            <li><input type="radio" name="user.country" value="DE" onclick="sync('de')" /> German</li>
            <li><input type="radio" name="user.country" value="NL" onclick="sync('nl')" /> Dutch</li>
            <li><input type="radio" name="user.country" value="SE" onclick="sync('sv')" /> Swedish</li>
            <li><input type="radio" name="user.country" value="NO" onclick="sync('nb')" /> Norwegian</li>
          </ul>
          <input type="hidden" id="lang" name="user.language" value=""/>
          Login type:
          <ul>
          <%
            OAuth2ProviderConfiguration configuration = (OAuth2ProviderConfiguration) GlobalBus.lookupSafe("/com/escenic/auth/oauth2/OAuth2Configuration");
            if (configuration != null && configuration.getClientIdAndSecretFor("application") != null) {
          %>
            <li><input type="radio" name="com.escenic.sso.enabled" value="true" checked/> <%=configuration.getName()%></li>
            <li><input type="radio" name="com.escenic.sso.enabled" value="false" /> Username & Password</li>
            <%} else { %>
            <li><input type="radio" name="com.escenic.sso.enabled" value="false" checked/> Username & Password</li>
            <%} %>
          </ul>
          <input type="hidden" name="com.escenic.sso.provider" value="Google" id="provider"/>
        </div>
        <input type="submit" value="Start"/>
      </form>
      <div id="alt"><a href="javascript: alt();">Alternative login</a></div>
    </div>
  </body>
</html>
