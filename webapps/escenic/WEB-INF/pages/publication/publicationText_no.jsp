<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>

<table border="0">
<tr>
  <th class="edit-propertyname" width="30%" align="left">Egenskap</th><th class="edit-propertyvalue" align="left">Verdi</th>
</tr>
<tr>
  <td class="edit-propertyname"><bean:message key="t.Name"/></td>
  <td class="edit-propertyvalue"><bean:write name="escenic-publication" property="name" /></td>
</tr>
<tr>
  <td class="edit-propertyname">Root</td>
  <td class="edit-propertyvalue"><bean:write name="escenic-publication" property="root"/></td>
</tr>
<tr>
  <td class="edit-propertyname">URL</td>
  <td class="edit-propertyvalue"><bean:write name="escenic-publication" property="url" /></td>
</tr>
<tr>
  <td class="edit-propertyname">Id</td>
  <td class="edit-propertyvalue"><bean:write name="escenic-publication" property="id"/></td>
</tr>
</table>



<p>
Publikasjonens vitale attributter, som "URL" og "Root", er beregnet ut ifra "<code>/ServerConfig</code>" 
komponentens <code>webPublicationRoot</code> og <code>filePublicationRoot</code> egenskaper.
For &aring; endre disse verdiene m&aring; du konfigurere dette i ditt lokale konfigurasjonslag (typisk 
"<code><em>$escenic.root</em>/localconfig/</code>) og restarte systemet.
Her er et eksempel p&aring; et slikt komponent, gitt publikasjonsnavnet er "xyzzy". Vi vil her sette url til &aring; v&amp;aelig;re
<code>www.xyzzy.com</code> og publiaksjonsrot ("publication root") til <code>/var/webapps/xyzzy/</code>.
</p>

<ul>
<li>Lag en fil i ditt lokale configurasjonslag og kall den "/neo/publications/Pub-xyzzy.properties"</li>
<li>Legg til f&oslash;lgende linje i filen:
  <pre>$class=neo.xredsys.config.SimplePublicationSupport</pre>
</li>
<li>For &aring; endre publikasjonsrot, legg til f&oslash;lgende linjer i filen:
<pre>
rootDirectory=/var/webapps/xyzzy/
mediaDirectory=/var/webapps/xyzzy/multimedia/
metaDirectory=/var/webapps/xyzzy/WEB-INF/
</pre>
</li>
<li>For &aring; sette ny publikasjonsurl, legg til f&oslash;lgende linjer i filen:
<pre>url=http://www.xyzzy.com/
mediaUrl=http://www.xyzzy.com/multimedia/</pre>
</li>
</ul>

<p>Merk at det er systemadministrator som m&aring; s&oslash;rge for at disse egenskapene er synkronisert med hverandre.
Ved &aring; bruke dette oppsettet, er det fullt mulig &aring; sette opp "multimedia" katalogen til &aring; v&amp;aelig;re p&aring; en annen 
(nettverks)disk, eller fra en helt forskjellig URL, etc.</p>

<p>Merk ogs&aring; at ved bare &aring; sette URLen p&aring; denne m&aring;ten ikke er nok for at publikasjonen skal fungere ordentlig 
med denne URLen. &aring; sette denne URLen p&aring;virker m&aring;ten Escenic generer sine JSP malfiler og tagger.
Du m&aring; ogs&aring; installere web-applikasjonen p&aring; en applikasjonsserver og sette opp enten applikasjonsserveren eller 
web-serveren at web-applikasjonen skal h&aring;ndere URLen. Du m&aring; ogs&aring; sette opp DNS serveren til &aring; peke p&aring; web 
eller applikasjonsserveren som skal h&aring;ndtere kallene.
</p>

<p>
For &aring; endre Escenic sin standard m&aring;te for &aring; legge publikasjonsnavnet til 
<code>filePublicationRoot</code> eller <code>webPublicationRoot</code>, s&aring; m&aring; du endre 
<code>/neo/publications/GenericPublication</code> komponenten i ditt lokale konfigurasjonslag.</p>
