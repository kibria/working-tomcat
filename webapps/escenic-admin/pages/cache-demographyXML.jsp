<%@ page language="java" contentType="text/xml"%><%@
    page import="neo.util.cache.CacheItem,
              neo.xredsys.presentation.PresentationArticle,
              neo.xredsys.api.Section,
              java.util.Hashtable,
              java.util.Enumeration,
              java.util.Iterator"
%><?xml version="1.0" encoding="ISO-8859-1" ?>
<%
  long currentTime = System.currentTimeMillis();
  Hashtable cachedItems = (Hashtable)neo.xredsys.presentation.ArticlePresentationManager.getInstance().getCache().getCacheItems().clone();
  out.print("<cache name=\"articlePresentationCache\" timestamp=\"" + currentTime + "\">");
  Enumeration enumeration = cachedItems.keys();
  StringBuffer sb = new StringBuffer(1024);
  while(enumeration.hasMoreElements()) {
    CacheItem ci =  (CacheItem)cachedItems.get(enumeration.nextElement());
    sb.setLength(0);
    out.print(generateXMLNode(sb, ci, currentTime).toString());
  }
  out.println ("</cache>");
%><%!

  public StringBuffer generateXMLNode(StringBuffer sb, CacheItem ci, long currentTime) {
    PresentationArticle pa = (PresentationArticle)ci.getObject();
    Iterator sections = pa.getSectionsList().iterator();
    sb.append("<cacheItem lastAccess=\"");
    sb.append((currentTime - ci.getLastAccess()) / 1000);
    sb.append("\" lastUpdated=\"");
    sb.append((currentTime - ci.getLastUpdate()) / 1000);
    sb.append("\">");

    sb.append("<art type=\"");
    sb.append(pa.getArticleTypeName());
    sb.append("\" id=\"");
    sb.append(pa.getId());
    sb.append("\" homesec=\"");
    sb.append(pa.getHomeSection().getId());
    sb.append("\">");

    sb.append("<pub id=\"");
    sb.append(pa.getPublicationId());
    sb.append("\" name=\"");
    sb.append(pa.getPublication().getName());
    sb.append("\"/>");

    while(sections.hasNext()) {
      Section sec = (Section)sections.next();
      sb.append("<sec id=\"");
      sb.append(sec.getId());
      sb.append("\" name=\"");
      sb.append(sec.getName());
      sb.append("\"/>");
    }
    sb.append("</art>");
    sb.append("</cacheItem>");
    return sb;
  }
%>