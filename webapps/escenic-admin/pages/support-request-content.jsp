<%

 java.util.SortedMap stuff = new java.util.TreeMap();

 {
   StringBuffer buf = new StringBuffer();
   for (java.util.Iterator i = neo.nursery.GlobalBus.getGlobalBus().getComponentNames(); i.hasNext();) {
     String key = (String) i.next();
     Object object = neo.nursery.GlobalBus.lookupSafe(key);
     if (object == null) continue;
     String value = String.valueOf(object);
     // assume anything that starts with the class name, and a @ and has 8 more characters,
     //  is a default tostring implementation
     if (value.startsWith(object.getClass().getName() + "@") && value.length() <= object.getClass().getName().length() + 9) continue;
     buf.append("Nursery> ");
     buf.append(key);
     buf.append(" = ");
     buf.append(value);
     buf.append("\n");
   }
   stuff.put("1. Relevant nursery components", buf.toString());
 }

 {
   String[] strings = ((neo.nursery.Initial)neo.nursery.GlobalBus.lookup("/Initial")).getServiceNames();
   StringBuffer buf = new StringBuffer();
   for (int i = 0; i < strings.length; i++) {
     buf.append("Initial> ");
     buf.append(strings[i]);
     buf.append("\n");
   }
   stuff.put("2. List of services started by initial", buf.toString());
 }

 String[] properties = new String[] { "java.class.path", "java.library.path", "sun.boot.class.path" };

 {
   StringBuffer buf = new StringBuffer();
   for (java.util.Iterator i = new java.util.TreeSet(System.getProperties().keySet()).iterator(); i.hasNext();) {
     String key = (String) i.next();
     String value = System.getProperty(key);
     boolean found = false;
     for (int j = 0; j < properties.length; j++) {
       if (key.equals(properties[j])) found=true;
     }
     if (found) continue;
     buf.append("Property> ");
     buf.append(key);
     buf.append(" = ");
     buf.append(value);
     buf.append("\n");
   }
   stuff.put("3. System Properties", buf.toString());
 }

 for (int j = 0; j < properties.length; j++) {
   StringBuffer buf = new StringBuffer();
   String[] tokens = neo.util.StringUtil.split(System.getProperty("path.separator"), System.getProperty(properties[j]));
   for (int i = 0; i < tokens.length; i++) {
     buf.append(properties[j]);
     buf.append("> ");
     buf.append(tokens[i]);
     java.io.File f = new java.io.File(tokens[i]);
     if (!f.exists()) buf.append(" (does not exist!)");
     if (f.isDirectory()) {
       buf.append(" (directory with ");
       buf.append(f.list().length);
       buf.append(" items)");
     }
     if (f.isFile()) {
       buf.append(" (");
       buf.append(f.length());
       buf.append(" bytes, from ");
       buf.append(new java.util.Date(f.lastModified()));
       buf.append(")");
     }
     buf.append("\n");
   }
   stuff.put((4+j) + ". " + properties[j], buf.toString());
 }




 StringBuffer message = new StringBuffer();
 message.append("Enter support request here!\n\n\n\n");
 message.append("============================================================\n");
 message.append("Here is a list of useful information from the server\n\n");
 for (java.util.Iterator i = stuff.keySet().iterator(); i.hasNext();) {
   String name = (String) i.next();
   Object value = stuff.get(name);
   message.append(name);
   message.append("\n----------------------------------------------\n");
   message.append(String.valueOf(value));  // includes newline
   message.append("\n");
 }

 StringBuffer url = new StringBuffer();
 url.append("mailto:support@escenic.com?body=");
 url.append(neo.util.StringUtil.escapeHtmlLight(neo.util.StringUtil.replaceString(neo.util.StringUtil.encodeUrl(message.toString()),"\n","%0d")));


%>

<h2>Issue a support request</h2>
<p>Escenic support is available for customers at support@escenic.com.  This
page has collected a lot of useful information about the server and
its environment.  If you send us this, you will avoid a lot of tedious
e-mail back and forth, since we don't have to ask about this or that option.
</p>
<p>You may <a href="<%=url%>">send all this as an e-mail</a> or (if your
browser can't handle the link) cut and paste
the text below into your e-mail program, and send it off to support@escenic.com.
</p>
<p>Remember to include a descriptive subject header!</p>
<pre>
<%=message%>
</pre>

