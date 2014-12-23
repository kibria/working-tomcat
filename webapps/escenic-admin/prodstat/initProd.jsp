<%@ page import="java.util.*,
                 java.io.IOException,
                 neo.xredsys.content.type.ArticleType,
                 java.io.FileInputStream" %>
<%@page import="java.sql.*" %>
<%@page import="neo.xredsys.content.*" %>
<%@page import="neo.dbaccess.*" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>

<%-- include properties --%>
<%@include file="properties.jsp" %>
<%
  final Object att = session.getAttribute("publicationMap");
  final HttpSession sess = session;
  ContentManager.getContentManager().doTransaction( new TransactionOperation() {
    public void execute(Transaction t) throws SQLException {
      //if the publication-map is on the session we simply return.
      if (att!= null){
        return;
      }
      PreparedStatement stmt = null;
      String sql = "select referenceID,publicationName from publication order by publicationName";
      try {
        stmt = t.getConnection().prepareStatement(sql);
        ResultSet rs=stmt.executeQuery();
        Map pubs = new HashMap();
        Collection pubColl = new ArrayList();
        Map aTypeMap = new HashMap();
        while(rs.next()) {
          int pubId = rs.getInt(1);
          ArticleType[] types =  neo.xredsys.content.type.TypeManager.getInstance().getArticleTypes(pubId);
          for (int i = 0; i < types.length; i++) {
            aTypeMap.put(String.valueOf(types[i].getId()),types[i]);
          }
          pubColl.add(String.valueOf(pubId));
          pubs.put(String.valueOf(pubId),rs.getString(2));
        }
        //sets the publication-map and the articleTypeMap on the session.
        sess.setAttribute("publicationMap",pubs);
        sess.setAttribute("publicationCollection",pubColl);
        sess.setAttribute("articleTypeMap",aTypeMap);
      } catch(Exception e) {
        e.printStackTrace();
      } finally {
        if(stmt!=null) stmt.close();
      }
    }
  });
%>		