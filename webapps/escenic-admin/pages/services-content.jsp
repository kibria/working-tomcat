<%@ page import="java.util.Map" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
  function help(text) {
    var win = window.open("","help","directories=no,location=no,menubar=no,status=yes,toolbar=no,width=350,height=400,scrollbars=yes,resizable=yes");
    win.focus();
    win.document.open("text/html","replace");
    win.document.write("<html><head><title>Help</title></head>");
    win.document.write("<body><html>");
    win.document.write(text);
    win.document.write("</html></body>");
    win.document.close();
  }
 
  function handleFilterChanged() {
      showAll();
      var inputs = document.getElementsByTagName("input");
      for (var i = 0; i < inputs.length; i++) {
          if (inputs[i].type == "checkbox") {
            if (!inputs[i].checked) {
                hideComponentsWithClass(inputs[i].value);
            }
          }
      }
  }

  function showAll() {
      var elements = document.getElementsByTagName("tr"); 
      for (var i = 0; i < elements.length; i++) {
          elements[i].style.display="table-row";
      }
  }
  function hideComponentsWithClass(pClazz) {
      var elements = document.getElementsByTagName("tr"); 
      for (var i = 0; i < elements.length; i++) {

         var classname = elements[i].className;
         var classes = classname.split(' ');
         var display;
         for (var j = 0; j < classes.length; j++) {
            if (classes[j] == pClazz) {
                elements[i].style.display="none";
            }
         }  
      }

  }
    
  </script>

<h3>Services</h3>
<table>
    <tr>
        <td valign="top">
            <table width="600px;">
                <tr>
                    <th align="left" title="The scope where the service is initialized">Scope</th>
                    <th align="left" title="The name of the service">Name</th>
                    <th align="left" title="The current state of the service" colspan="2" >State</th>
                    <%--<th align="left" title="Some services are designed to only run on one server at a time. This column gives you the name of the server where this service is currently running">Where</th>--%>
                    <th align="left" >&nbsp;</th>
                    
                </tr>
                <c:forEach items="${scopes}" var="scope">
                    <tr class="${scope.identifier}">
                        <td colspan="5"><a href="<%=request.getContextPath()%>/browser/${scope.name}/">${scope.name}</a></td>
                    </tr>
                    <c:forEach items="${scope.services}" var="service">
                        <tr class="${scope.identifier} ${service.interfaces} ${service.state}">
                            <td>&nbsp;</td>
                            <td valign="top"><a href="<%=request.getContextPath()%>/browser/${scope.name}${service.nurseryPath}" title="${service.description}">${service.name}</a></td>
                            <td valign="top"><img width="22" height="22" src="<%=request.getContextPath()%>/images/services/${service.icon}" alt="" title="${service.help}"/></td>
                            <td width="400px">${service.message}</td>
                            <%--<td>${service.where}</td>--%>
                              <c:choose>
                                <c:when test="${not empty service.description}">
                                  <td valign="top" >
                                  <a href="javascript:help('${service.description}');" title="service.description">info</a>
                                </c:when>
                                <c:otherwise><td valign="top">&nbsp;</td></c:otherwise>
                              </c:choose>
                        </tr>
                    </c:forEach>
                    <tr class="${scope.identifier}">
                        <td colspan="5"><hr/></td>
                    </tr>
                </c:forEach>
             </table>
        </td>
        <td valign="top">
            <div style="border: dotted 1px black; margin-left: 10px; padding-left: 10px; padding-right: 10px;">
                <b>Scopes</b>
                <ul>
                    <c:forEach items="${scopes}" var="scope">
                        <li><input type="checkbox" checked="true" value="${scope.identifier}" onchange="handleFilterChanged();"/>${scope.name}</li>
                    </c:forEach>
                </ul>
                <b>Services</b>
                <ul>
                    <li><input type="checkbox" checked="true" value="neo.xredsys.api.IOEventListener" onchange="handleFilterChanged();"/>EventListener</li>
                    <li><input type="checkbox" checked="true" value="neo.services.schedule.AlarmListener" onchange="handleFilterChanged();"/>AlarmListener</li>
                    <li><input type="checkbox" checked="true" value="neo.xredsys.dao.AbstractDao" onchange="handleFilterChanged();"/>Dao</li>
                    <li><input type="checkbox" checked="true" value="neo.xredsys.api.services.FilterService" onchange="handleFilterChanged();"/>FilterService</li>
                    <li><input type="checkbox" checked="true" value="neo.util.cache.Cache" onchange="handleFilterChanged();"/>Cache</li>
                    <li><input type="checkbox" checked="true" value="other" onchange="handleFilterChanged();"/>Other</li>
                </ul>
                <b>States</b>
                <table border="0" cellspacing="3">
                    <tr>
                        <td><input type="checkbox" checked="true" value="constructed" onchange="handleFilterChanged();"/></td>
                        <td valign="top"><img width="22" height="22" src="<%=request.getContextPath()%>/images/services/constructed.png" alt=""/></td>
                        <td>The service has been constructed by Nursery, but not started. This is normally due to <i>serviceEnabled=false</i></td>
                    </tr>                    
                    <tr>
                        <td><input type="checkbox" checked="true" value="starting" onchange="handleFilterChanged();"/></td>
                        <td valign="top"><img width="22" height="22" src="<%=request.getContextPath()%>/images/services/starting.png" alt=""/></td>
                        <td>The service is in the process of being started.</td>
                    </tr>                    
                    <tr>
                        <td><input type="checkbox" checked="true" value="failed-starting" onchange="handleFilterChanged();"/></td>
                        <td valign="top"><img width="22" height="22" src="<%=request.getContextPath()%>/images/services/failed-starting.png" alt=""/></td>
                        <td>Starting the service failed. This normally requires a system administrator to investigate the reason behind the failure.</td>
                    </tr>                    
                    <tr>
                        <td><input type="checkbox" checked="true" value="idle" onchange="handleFilterChanged();"/></td>
                        <td valign="top"><img width="22" height="22" src="<%=request.getContextPath()%>/images/services/idle.png" alt=""/></td>
                        <td>The service is idling. This might occur if the service has tried to start, but cannot be started right now. The service can be started later.</td>
                    </tr>                    
                    <tr>
                        <td><input type="checkbox" checked="true" value="running" onchange="handleFilterChanged();"/></td>
                        <td valign="top"><img width="22" height="22" src="<%=request.getContextPath()%>/images/services/running.png" alt=""/></td>
                        <td>The service is running normally</td>
                    </tr>                    
                    <tr>
                        <td><input type="checkbox" checked="true" value="stopping" onchange="handleFilterChanged();"/></td>
                        <td valign="top"><img width="22" height="22" src="<%=request.getContextPath()%>/images/services/stopping.png" alt=""/></td>
                        <td>The service is in the process of being stopped</td>
                    </tr>                    
                    <tr>
                        <td><input type="checkbox" checked="true" value="failed-stopping" onchange="handleFilterChanged();"/></td>
                        <td valign="top"><img width="22" height="22" src="<%=request.getContextPath()%>/images/services/failed-stopping.png" alt=""/></td>
                        <td>Stopping the service failed. This normally requires a system administrator to investigate the reason behind the failure.</td>
                    </tr>                    
                    <tr>
                        <td><input type="checkbox" checked="true" value="stopped" onchange="handleFilterChanged();"/></td>
                        <td valign="top"><img width="22" height="22" src="<%=request.getContextPath()%>/images/services/stopped.png" alt=""/></td>
                        <td>The service has been stopped</td>
                    </tr>                    
                </table>
            </div>                
        </td>
    </tr>
</table>
