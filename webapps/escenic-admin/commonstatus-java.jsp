<%!


  private String directoryExists(String name, boolean trailingSlash, String ok, String isNull, String notOk) {
    String ret = fileExists(name,ok,isNull,notOk);
    if (ret == isNull) return ret;
    if (ret == ok) {
      java.io.File f = new java.io.File (name);
      if (!f.isDirectory()) {
        error = "File <code>" + name + "</code> is not a directory, but a regular file.";
        return notOk;
      }
      return ok;
    }
    if (ret == ok && trailingSlash) {
      ret = notOk;
      if ((!name.endsWith(java.io.File.separator)) && (!name.endsWith("/"))) {
        ret = notOk;
        error="The specified value does <em>not</em> end with the mandatory trailing slash.";
      }
    }
    return ret;
  }

  private String fileExists(String name, String ok, String isNull, String notOk) {
    if (name == null) {
      error = "(not specified)";
      return isNull;
    }
    java.io.File f = new java.io.File (name);
    if (!f.exists()) {
      error = "File <code>" + name + "</code> does not exist. If you are having all configuration files in the classpath" +
          "and all other configuretion status is fine then you can ignore this message";
      return notOk;
    }
    return ok;
  }

  private String lastError() {
    try {
      return error==null?"&nbsp;":error;
    } finally {
      error = null;
    }
  }

  private String help(String key) {
    String text = (String)helpTexts.get(key);
    if (text != null) {
      return "<a href='javascript:helpText(\""+text+"\")'>Help</a>";
    } 
    return "";
  }

  private String inlineHelp(String key) {
    String text = (String)helpTexts.get(key);
    if (text != null) {
      return text;
    } 
    return "";
  }

  private void handle(Throwable t) {
    if (t instanceof java.lang.reflect.InvocationTargetException) {
      t = ((java.lang.reflect.InvocationTargetException)t).getTargetException();
    }
    error = t.toString();
    t.printStackTrace();
  }
 
  private final String Space = "&nbsp;";
  private String error = null;

  private final java.util.Map helpTexts = new java.util.HashMap();

%>
