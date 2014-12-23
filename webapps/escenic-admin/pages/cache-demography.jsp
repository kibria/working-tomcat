<%--
  ******************************************************************************
  * Copyright (C) 2004 Escenic AS.
  * All Rights Reserved.  No use, copying or distribution of this
  * work may be made except in accordance with a valid license
  * agreement from Escenic AS.  This notice must be included on
  * all copies, modifications and derivatives of this work.
  ******************************************************************************
  *           File: $Header: //depot/escenic/engine/branches/5.7/phoenix/phoenix-admin/src/main/webapp/pages/cache-demography.jsp#1 $
  * Last edited by: $Author: sai $ $Date: 2013/12/04 $
  *   Version     : $Revision: #1 $
  ******************************************************************************
  * This is a prototype for the cache demography
  ******************************************************************************
 --%>

<%@ page language="java" %>
<%@ page import="java.util.*,
                 neo.xredsys.presentation.*,
                 neo.util.StringUtil,
                 neo.nursery.*,
                 neo.util.cache.*,
                 gnu.trove.*,
                 neo.xredsys.api.Section" %>
<%

  class SectionDemography{
    private Section section;
    private int size = 0;
    private long lastAccess = 0;
    private long lastUpdate = 0;
    public void setSection(Section pSection){
      section = pSection;
    }
    public Section getSection(){
      return section;
    }
    public void setSize(int pSize){
      size = pSize;
    }
    public int getSize(){
      return size;
    }
    public void incSize(){
      size++;
    }
    public void setLastAccess(long pLastAccess){
      lastAccess += pLastAccess;
    }
    public long getLastAccess(){
      if(size==0){
        return 0;
      }
      return lastAccess/size;
    }
    public void setLastUpdate(long pLastUpdate){
      lastUpdate += pLastUpdate;
    }
    public long getLastUpdate(){
      if(size==0){
        return 0;
      }
      return lastUpdate/size;
    }
  }

  class SectionComparator implements Comparator{
    public int compare(Object o1, Object o2) {
      SectionDemography sd1 = (SectionDemography)o1;
      SectionDemography sd2 = (SectionDemography)o2;

      if(sd1.getSection().getOwnerPublicationId() > sd2.getSection().getOwnerPublicationId()) {
        return -1;
      } else if(sd1.getSection().getOwnerPublicationId() < sd2.getSection().getOwnerPublicationId())  {
        return 1;
      }
      return sd2.getSize() - sd1.getSize();
    }
  }

  class SizeComparator implements Comparator{
    public int compare(Object o1, Object o2) {
      return ((SectionDemography)o2).getSize() - ((SectionDemography)o1).getSize();
    }
  }

  class LastAccessComparator implements Comparator{
    public int compare(Object o1, Object o2) {
      return (int)(((SectionDemography)o2).getLastAccess() - ((SectionDemography)o1).getLastAccess());
    }
  }

  class TimeInCacheComparator implements Comparator{
    public int compare(Object o1, Object o2) {
      return (int)(((SectionDemography)o2).getLastUpdate() - ((SectionDemography)o1).getLastUpdate());
    }
  }

  class ArticleTypeDemography {
    private String articleType;
    private int size = 0;
    private long lastAccess = 0;
    private long lastUpdate = 0;
    public void setArticleType(String pArticleType) {
      articleType = pArticleType;
    }
    public String getArticleType() {
      return articleType;
    }
    public void setSize(int pSize){
      size = pSize;
    }
    public int getSize(){
      return size;
    }
    public void incSize(){
      size++;
    }
    public void setLastAccess(long pLastAccess){
      lastAccess += pLastAccess;
    }
    public long getLastAccess(){
      if(size==0){
        return 0;
      }
      return lastAccess/size;
    }
    public void setLastUpdate(long pLastUpdate){
      lastUpdate += pLastUpdate;
    }
    public long getLastUpdate(){
      if(size==0){
        return 0;
      }
      return lastUpdate/size;
    }
  }

  class ArticleTypeComparator implements Comparator{
    public int compare(Object o1, Object o2) {
      ArticleTypeDemography sd1 = (ArticleTypeDemography)o1;
      ArticleTypeDemography sd2 = (ArticleTypeDemography)o2;

      return sd2.getSize() - sd1.getSize();
    }
  }

  final String PAC_D = "presentationArticleCache_demography";
  final String PH = "publication_histgram";
  final String ATH = "articleType_histgram";
  final String SH = "section_histgram";

  Hashtable cachedItems = (Hashtable)pageContext.getAttribute(PAC_D, PageContext.SESSION_SCOPE);
  if(cachedItems == null || StringUtil.getBoolean(request.getParameter("reload"))) {
    cachedItems = (Hashtable)ArticlePresentationManager.getInstance().getCache().getCacheItems().clone();
    pageContext.setAttribute(PAC_D, cachedItems, PageContext.SESSION_SCOPE);
    pageContext.setAttribute(PH, null, PageContext.SESSION_SCOPE);
    pageContext.setAttribute(ATH, null, PageContext.SESSION_SCOPE);
    pageContext.setAttribute(SH, null, PageContext.SESSION_SCOPE);
  }
  Enumeration enumeration = cachedItems.keys();
  HashMap sectionMap = new HashMap();
  HashMap articleTypeMap = new HashMap();
  while(enumeration.hasMoreElements()) {
    CacheItem ci =  (CacheItem)cachedItems.get(enumeration.nextElement());
    PresentationArticle pa = (PresentationArticle)ci.getObject();

    ArticleTypeDemography artValues = (ArticleTypeDemography)articleTypeMap.get(pa.getArticleTypeName());
    if(artValues==null) {
      artValues = new ArticleTypeDemography();
      artValues.setArticleType(pa.getArticleTypeName());
      articleTypeMap.put(pa.getArticleTypeName(), artValues);
    }
    artValues.incSize();
    artValues.setLastAccess(ci.getLastAccess());
    artValues.setLastUpdate(ci.getLastUpdate());


    Iterator sectionIterator = pa.getSectionsList().iterator();
    while(sectionIterator.hasNext()) {
      Section sec = (Section)sectionIterator.next();
      SectionDemography secValues = (SectionDemography)sectionMap.get(sec);
      if(secValues==null) {
        secValues = new SectionDemography();
        secValues.setSection(sec);
        sectionMap.put(sec, secValues);
      }
      secValues.incSize();
      secValues.setLastAccess(ci.getLastAccess());
      secValues.setLastUpdate(ci.getLastUpdate());
    }
  }
%>

<HTML>
  <HEAD>
    <TITLE>
      Escenic Cache Demography
    </TITLE>
    <LINK REL="stylesheet" HREF="<%=request.getContextPath()%>/images/basic.css" TYPE="text/css">
  </HEAD>
  <BODY>
    <A href="?reload=true">Refresh cache</A>
    <table>
      <tr>
        <th><A href="?sort=default">Publication</A></th>
        <th>Section</th>
        <th><A href="?sort=Size">Size</A></th>
        <th><A href="?sort=Access">Last access</A></th>
        <th><A href="?sort=Cache">Time in cache</A></th>
      </tr>
<%
  List objects = new ArrayList(sectionMap.values());
  Comparator comp = new SectionComparator();
  if(!StringUtil.isEmpty(request.getParameter("sort"))) {
    if(request.getParameter("sort").equalsIgnoreCase("Size")) {
      comp = new SizeComparator();
    } else if(request.getParameter("sort").equalsIgnoreCase("Access")) {
      comp = new LastAccessComparator();
    } else if(request.getParameter("sort").equalsIgnoreCase("Cache")) {
      comp = new TimeInCacheComparator();
    }
  }
  Collections.sort(objects, comp);
  Iterator it = objects.iterator();
  while(it.hasNext()) {
    SectionDemography values = (SectionDemography)it.next();
%>
      <tr>
        <td><A href="?pub=<%=values.getSection().getOwnerPublicationId()%>"><%=values.getSection().getOwnerPublicationId()%></A></td>
        <td><A href="?section=<%=values.getSection().getId()%>"><%=values.getSection().getName() + "(" + values.getSection().getId() + ")"%></A></td>
        <td><%=values.getSize()%></td>
        <td><%=StringUtil.formatDuration(System.currentTimeMillis() - values.getLastAccess())%></td>
        <td><%=StringUtil.formatDuration(System.currentTimeMillis() - values.getLastUpdate())%></td>
      </tr>
<%
}
%>
    </table>

    <table>
      <tr>
        <th><A href="?sort=default">ArticleType</th>
        <th><A href="?sort=Size">Size</A></th>
        <th>Last access</th>
        <th>Time in cache</th>
      </tr>
<%
  objects = new ArrayList(articleTypeMap.values());
  comp = new ArticleTypeComparator();
  if(!StringUtil.isEmpty(request.getParameter("sort"))) {
    if(request.getParameter("sort").equalsIgnoreCase("Size")) {
      comp = new SizeComparator();
    }
  }
  Collections.sort(objects, new ArticleTypeComparator());
  it = objects.iterator();
  while(it.hasNext()) {
    ArticleTypeDemography articleTypeDemography = (ArticleTypeDemography)it.next();
%>
      <tr>
        <td><A href="?type=<%=articleTypeDemography.getArticleType()%>"><%=articleTypeDemography.getArticleType()%></A></td>
        <td><%=articleTypeDemography.getSize()%></td>
        <td><%=StringUtil.formatDuration(System.currentTimeMillis() - articleTypeDemography.getLastAccess())%></td>
        <td><%=StringUtil.formatDuration(System.currentTimeMillis() - articleTypeDemography.getLastUpdate())%></td>
      </tr>
<%
}
%>
    </table>

<%
  if(!StringUtil.isEmpty(request.getParameter("pub"))){
%> 
    
<%
  Map publicationHistogramMap = (Map)pageContext.getAttribute(PH, PageContext.SESSION_SCOPE);
  if(publicationHistogramMap == null) {
    publicationHistogramMap = new HashMap();
    pageContext.setAttribute(PH, publicationHistogramMap, PageContext.SESSION_SCOPE);
  }
  String pub = request.getParameter("pub");
  TIntIntHashMap phAccess = (TIntIntHashMap)publicationHistogramMap.get(pub+"_access");
  if(phAccess == null) {
    phAccess = new TIntIntHashMap();
    publicationHistogramMap.put(pub+"_access", phAccess);
    Enumeration e = cachedItems.keys();
    int timeslot = 1000 * 60 * 15;
    int maxIndex = 0;
    int maxValue = 0;
    while(e.hasMoreElements()) {
      CacheItem ci =  (CacheItem)cachedItems.get(e.nextElement());
      PresentationArticle pa = (PresentationArticle)ci.getObject();
      if(pa.getPublicationId() == StringUtil.parseInt(pub)) {
        int tmpIndex = (int)(System.currentTimeMillis() - ci.getLastAccess())/timeslot;
        int tmpValue = phAccess.get(tmpIndex) + 1;
        phAccess.put(tmpIndex, tmpValue);
        if(tmpIndex > maxIndex){
          maxIndex = tmpIndex;
        }
        if(tmpValue > maxValue) {
          maxValue = tmpValue;
        }
        break;
      }
    }
    phAccess.put(-100, maxValue);
    phAccess.put(-99, maxIndex);
  }

  TIntIntHashMap phCache = (TIntIntHashMap)publicationHistogramMap.get(pub+"_cache");
  if(phCache == null) {
    phCache = new TIntIntHashMap();
    publicationHistogramMap.put(pub+"_cache", phCache);
    Enumeration e = cachedItems.keys();
    int timeslot = 1000 * 60 * 15;
    int maxIndex = 0;
    int maxValue = 0;
    while(e.hasMoreElements()) {
      CacheItem ci =  (CacheItem)cachedItems.get(e.nextElement());
      PresentationArticle pa = (PresentationArticle)ci.getObject();
      if(pa.getPublicationId() == StringUtil.parseInt(pub)) {
        int tmpIndex = (int)(System.currentTimeMillis() - ci.getLastUpdate())/timeslot;
        int tmpValue = phCache.get(tmpIndex) + 1;
        phCache.put(tmpIndex, tmpValue);
        if(tmpIndex > maxIndex){
          maxIndex = tmpIndex;
        }
        if(tmpValue > maxValue) {
          maxValue = tmpValue;
        }
        break;
      }
    }
    phCache.put(-100, maxValue);
    phCache.put(-99, maxIndex);
  }
%>
  Last access:<br>
  <table>
      <tr>
        <th>Time</th>
        <th>Size</th>
      </tr>
<%
  for(int i = 0; i <= phAccess.get(-99); i++) {
%>
      <tr>
        <td><%=i*15%></td>
        <td><%=phAccess.get(i)%></td>
      </tr>
<%
}
%>

    </table>
    Time in cache:<br>
    <table>
      <tr>
        <th>Time</th>
        <th>Size</th>
      </tr>
<%
  for(int i = 0; i <= phCache.get(-99); i++) {
%>
      <tr>
        <td><%=i*15%></td>
        <td><%=phCache.get(i)%></td>
      </tr>
<%
}
%>

    </table>

<%
}
if(!StringUtil.isEmpty(request.getParameter("type"))){
  Map articleTypeHistogramMap = (Map)pageContext.getAttribute(ATH, PageContext.SESSION_SCOPE);
  if(articleTypeHistogramMap == null) {
    articleTypeHistogramMap = new HashMap();
    pageContext.setAttribute(ATH, articleTypeHistogramMap, PageContext.SESSION_SCOPE);
  }
  String articleType = request.getParameter("type");
  TIntIntHashMap athAccess = (TIntIntHashMap)articleTypeHistogramMap.get(articleType+"_access");
  if(athAccess == null) {
    athAccess = new TIntIntHashMap();
    articleTypeHistogramMap.put(articleType+"_access", athAccess);
    Enumeration e = cachedItems.keys();
    int timeslot = 1000 * 60 * 15;
    int maxIndex = 0;
    int maxValue = 0;
    while(e.hasMoreElements()) {
      CacheItem ci =  (CacheItem)cachedItems.get(e.nextElement());
      PresentationArticle pa = (PresentationArticle)ci.getObject();
      if(pa.getArticleTypeName().equalsIgnoreCase(articleType)) {
        int tmpIndex = (int)(System.currentTimeMillis() - ci.getLastAccess())/timeslot;
        int tmpValue = athAccess.get(tmpIndex) + 1;
        athAccess.put(tmpIndex, tmpValue);
        if(tmpIndex > maxIndex){
          maxIndex = tmpIndex;
        }
        if(tmpValue > maxValue) {
          maxValue = tmpValue;
        }
      }
    }
    athAccess.put(-100, maxValue);
    athAccess.put(-99, maxIndex);
  }

  TIntIntHashMap athCache = (TIntIntHashMap)articleTypeHistogramMap.get(articleType+"_cache");
  if(athCache == null) {
    athCache = new TIntIntHashMap();
    articleTypeHistogramMap.put(articleType+"_cache", athCache);
    Enumeration e = cachedItems.keys();
    int timeslot = 1000 * 60 * 15;
    int maxIndex = 0;
    int maxValue = 0;
    while(e.hasMoreElements()) {
      CacheItem ci =  (CacheItem)cachedItems.get(e.nextElement());
      PresentationArticle pa = (PresentationArticle)ci.getObject();
      if(pa.getArticleTypeName().equals(articleType)) {
        int tmpIndex = (int)(System.currentTimeMillis() - ci.getLastUpdate())/timeslot;
        int tmpValue = athCache.get(tmpIndex) + 1;
        athCache.put(tmpIndex, tmpValue);
        if(tmpIndex > maxIndex){
          maxIndex = tmpIndex;
        }
        if(tmpValue > maxValue) {
          maxValue = tmpValue;
        }
      }
    }
    athCache.put(-100, maxValue);
    athCache.put(-99, maxIndex);
  }
%>
  Last access:<br>
  <table>
      <tr>
        <th>Time</th>
        <th>Size</th>
      </tr>
<%
  for(int i = 0; i <= athAccess.get(-99); i++) {
%>
      <tr>
        <td><%=i*15%></td>
        <td><%=athAccess.get(i)%></td>
      </tr>
<%
}
%>

    </table>
    Time in cache:<br>
    <table>
      <tr>
        <th>Time</th>
        <th>Size</th>
      </tr>
<%
  for(int i = 0; i <= athCache.get(-99); i++) {
%>
      <tr>
        <td><%=i*15%></td>
        <td><%=athCache.get(i)%></td>
      </tr>
<%
}
%>

    </table>

<%
}
if(!StringUtil.isEmpty(request.getParameter("section"))){
  Map sectionHistogramMap = (Map)pageContext.getAttribute(SH, PageContext.SESSION_SCOPE);
  if(sectionHistogramMap == null) {
    sectionHistogramMap = new HashMap();
    pageContext.setAttribute(SH, sectionHistogramMap, PageContext.SESSION_SCOPE);
  }
  String section = request.getParameter("section");
  TIntIntHashMap shAccess = (TIntIntHashMap)sectionHistogramMap.get(section+"_access");
  if(shAccess == null) {
    shAccess = new TIntIntHashMap();
    sectionHistogramMap.put(section+"_access", shAccess);
    Enumeration e = cachedItems.keys();
    int timeslot = 1000 * 60 * 15;
    int maxIndex = 0;
    int maxValue = 0;
    while(e.hasMoreElements()) {
      CacheItem ci =  (CacheItem)cachedItems.get(e.nextElement());
      PresentationArticle pa = (PresentationArticle)ci.getObject();
      Iterator sections = pa.getSectionsList().iterator();
      while(sections.hasNext()) {
        Section sec = (Section)sections.next();
        if(sec.getId() == StringUtil.parseInt(section)) {
          int tmpIndex = (int)(System.currentTimeMillis() - ci.getLastAccess())/timeslot;
          int tmpValue = shAccess.get(tmpIndex) + 1;
          shAccess.put(tmpIndex, tmpValue);
          if(tmpIndex > maxIndex){
            maxIndex = tmpIndex;
          }
          if(tmpValue > maxValue) {
            maxValue = tmpValue;
          }
        }
      }
    }
    shAccess.put(-100, maxValue);
    shAccess.put(-99, maxIndex);
  }

  TIntIntHashMap shCache = (TIntIntHashMap)sectionHistogramMap.get(section+"_cache");
  if(shCache == null) {
    shCache = new TIntIntHashMap();
    sectionHistogramMap.put(section+"_cache", shCache);
    Enumeration e = cachedItems.keys();
    int timeslot = 1000 * 60 * 15;
    int maxIndex = 0;
    int maxValue = 0;
    while(e.hasMoreElements()) {
      CacheItem ci =  (CacheItem)cachedItems.get(e.nextElement());
      PresentationArticle pa = (PresentationArticle)ci.getObject();
      Iterator sections = pa.getSectionsList().iterator();
      while(sections.hasNext()) {
        Section sec = (Section)sections.next();
        if(sec.getId() == StringUtil.parseInt(section)) {
          int tmpIndex = (int)(System.currentTimeMillis() - ci.getLastUpdate())/timeslot;
          int tmpValue = shCache.get(tmpIndex) + 1;
          shCache.put(tmpIndex, tmpValue);
          if(tmpIndex > maxIndex){
            maxIndex = tmpIndex;
          }
          if(tmpValue > maxValue) {
            maxValue = tmpValue;
          }
        }
      }
    }
    shCache.put(-100, maxValue);
    shCache.put(-99, maxIndex);
  }
%>
  Last access:<br>
  <table>
      <tr>
        <th>Time</th>
        <th>Size</th>
      </tr>
<%
  for(int i = 0; i <= shAccess.get(-99); i++) {
%>
      <tr>
        <td><%=i*15%></td>
        <td><%=shAccess.get(i)%></td>
      </tr>
<%
}
%>

    </table>
    Time in cache:<br>
    <table>
      <tr>
        <th>Time</th>
        <th>Size</th>
      </tr>
<%
  for(int i = 0; i <= shCache.get(-99); i++) {
%>
      <tr>
        <td><%=i*15%></td>
        <td><%=shCache.get(i)%></td>
      </tr>
<%
  }
%>

    </table>
<%
}
%>

  </BODY>
</HTML>