<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ page import="org.apache.struts.action.Action"%>
<%@ page import="neo.phoenix.base.WorkItemManager"%>
<%@ page import="java.util.*"%>
<%@ page import="neo.phoenix.base.WorkItem"%>
<%@ page import="neo.phoenix.base.WorkItemForm"%>
<%@ page import="org.apache.struts.action.ActionForm"%>
<%@ page import="org.apache.struts.action.ActionMapping"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>
<bean:define name="escenic-publication" id="publication" scope="session" type="neo.xredsys.api.Publication" />
<bean:define id="checker" name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />
<bean:define id="exitMode" name="textmap-task-exit-mode" type="java.lang.String" />
<util:toggle id="toggle" name="textmap-liststyles"/>
<bean:define id="user" name="escenic-user" scope="session" type="neo.xredsys.api.User" />
<%
neo.phoenix.base.WorkItemManager manager = (neo.phoenix.base.WorkItemManager)request.getSession().getAttribute("WorkItemManager");
Object form = request.getAttribute("form");
%>  

<%
  String task = (String)request.getAttribute("task");
  String menuMain="menu-main";
  String menuSection="menu-section";
  String menuAdmin="menu-administration";


  if (task.indexOf("section")>0) {
    menuSection+=" menu-selected";
  } else if(task.indexOf("main-menu")>0) {
    menuMain+=" menu-selected";
  } else if(task.indexOf("publication")>0) {
    menuAdmin+=" menu-selected";
  } else if (task.indexOf("/userGroup/") >= 0) {
    menuAdmin+=" menu-selected";
  } else if (task.indexOf("/user/") >= 0) {
    menuAdmin+=" menu-selected";
  }

%>
<div id="header-menu">
 <div class="menu">
  <ul class="level-1">
    <li class='level-1 <%=menuMain%>'>
      <div class='level-1'>
        <ul class="level-2">
          <li class="level-2 archive">
            <div class="level-2-item">
              <h2>
                <a href='javascript:submitForm("main-menu")'>
                  <bean:message bundle="org.apache.struts.action.MESSAGE" key="m.Home"/>
                </a>
              </h2>
            </div>
          </li>
        </ul>
      </div>
    </li>
    <li class="level-1 <%=menuSection%>">
     <div class="level-1">
      <ul class="level-2">
        <li class="level-2 archive">
          <div class="level-2">
            <h2>
              <a href='javascript:submitForm("section-archive")'>
                <bean:message bundle="org.apache.struts.action.MESSAGE" key="m.Sections"/>
              </a>
            </h2>
          </div>
        </li>
        <li class="level-2 separator">
          &#187;
        </li>
      </ul>
     </div>
    </li>
  </ul>
</div>
</div>
