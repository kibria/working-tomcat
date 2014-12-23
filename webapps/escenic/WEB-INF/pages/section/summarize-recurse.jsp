<%-- INCLUDE COMMON JSP HEADER --%>
<%@ include file="/WEB-INF/pages/base/common-jsp-header.jspf" %>
<%-- END STANDARD HEADER --%>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-section" prefix="section" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-template" prefix="template" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<bean:define id="section" name="section" type="neo.xredsys.api.Section" />
<bean:define id="checker" name="escenic-access" scope="session" type="neo.phoenix.access.AccessChecker" />

<tr>
  <%
    boolean canEdit = checker.isAdministrator(section);
    boolean isEditor = checker.isEditor(section);
    boolean isVirtual = false;
    boolean canBePublished = true;
    if(section instanceof neo.xredsys.api.VirtualSection){
      isVirtual = true;
      neo.xredsys.api.VirtualSection virt = (neo.xredsys.api.VirtualSection)section;
      neo.xredsys.api.Type publishedType =  neo.xredsys.api.IOAPI.getAPI().getTypeManager().getType(neo.xredsys.api.Type.SectionStateType,"published");
      neo.xredsys.api.Section parentSec = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getSection(virt.getVirtualSource());
      if(parentSec.getState()!=publishedType.getId()){
        canBePublished = false;
      }
    }

  %>
    <%
      String myIndent = (String)request.getAttribute("indent");
      String childIndent = myIndent+"&nbsp;&nbsp;";
      request.setAttribute("indent",childIndent);

      java.util.ArrayList fields = (java.util.ArrayList)request.getAttribute("fields");
      java.util.Iterator it = fields.iterator();

      while(it.hasNext()){
        String name = it.next().toString();
          if(name.equalsIgnoreCase("name")){
            String editUrl = "javascript:submitForm(\'external:/section/edit.do?id="+section.getId()+"\')";
             neo.phoenix.base.WorkItemManager workItemManager = (neo.phoenix.base.WorkItemManager) session.getAttribute("WorkItemManager");
             boolean isLocked = section.isLocked();
             if (isLocked) {
               neo.phoenix.base.WorkItem item = null;
               if(workItemManager!=null){
                item = workItemManager.findWorkItem("section",String.valueOf(section.getId()));
               }
               if (item != null) {
                 editUrl = "/base/restoreWork.do?id=" + item.getId();
               } else {
                canEdit = false;
                editUrl = null;
               }
             }

            %>
             <td align="left" class="section-summarizeTableNormalCell">
            <%
            if(canEdit){%>
              <a href="<%=editUrl%>"><%
                out.print(myIndent+section.getName());
              %></a>
            <%}else{
              if(isLocked){%>
                <html:img page="/images/qw/lock_16x16.png" border="0" alt="" />
              <%}
              out.print(myIndent+section.getName());
            }

          }else{
            %>
             <td align="left" class="section-summarizeTableNormalCell">
            <%

            /* Printing Section Uniquename */
            if(name.equalsIgnoreCase("Uniquename")){
              if(section.getUniqueName()!=null){
                out.print(section.getUniqueName());
              }else{
                out.print("&nbsp;");
              }

            /* Printing State */
            }else if(name.equalsIgnoreCase("State")){
              int state = section.getState();
              neo.xredsys.api.Type type = neo.xredsys.api.IOAPI.getAPI().getTypeManager().getType(neo.xredsys.api.Type.SectionStateType,state);
              if(canEdit&&canBePublished){
                String p5 = "relatedObject(" + section.getId() + ").attribute(state)";
                %><html:checkbox property="<%=p5%>" /><%
              }
              out.print(type.getName());

            /* Printing Agreement Type */
            }else if(name.equalsIgnoreCase("AgreementType")){
              int agId  = section.getAgreementId();
              if(agId>0){
                neo.xredsys.api.AgreementInfo info = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getAgreementInfo(agId);
                neo.xredsys.api.Type type = neo.xredsys.api.IOAPI.getAPI().getTypeManager().getType(neo.xredsys.api.Type.AgreementType,info.getAgreementType());
                if(type.getId()==1){
                  out.print("ShowFrontpage");
                }else{
                  out.print("HideFrontpage");
                }
              }else{
                out.print("&nbsp;");
              }

            /* Printing Section Template */
            }else if(name.equalsIgnoreCase("SectionTemplate")){
              if(canEdit){
                String p5 = "relatedObject(" + section.getId() + ").attribute(sectionTemplate)";
                %><html:checkbox property="<%=p5%>" /><%
              }
              out.print(neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getLayout(section.getLayoutId()).getName());

            /* Printing Article Template */
            }else if(name.equalsIgnoreCase("ArticleTemplate")){
              if(canEdit){
                String p5 = "relatedObject(" + section.getId() + ").attribute(articleTemplate)";
                %><html:checkbox property="<%=p5%>" /><%
              }
              out.print(neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getLayout(section.getArticleLayoutId()).getName());

            /* Printing Section ID */
            }else if(name.equalsIgnoreCase("id")){
              out.print(section.getId());

            /* Printing Is Virtual */
            }else if(name.equalsIgnoreCase("isVirtual")){
              if(section instanceof neo.xredsys.api.VirtualSection){
                out.print("true");
              }else{
                out.print("false");
              }

            /* Printing Source */
            }else if(name.equalsIgnoreCase("virtualSource")){
              if(section instanceof neo.xredsys.api.VirtualSection){
                neo.xredsys.api.VirtualSection sec = (neo.xredsys.api.VirtualSection)section;
                neo.xredsys.api.Section target = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getSection(sec.getVirtualSource());
                if(target!=null){
                  out.print(target.getId()+" " + target.getName());
                }else{
                  out.print("&nbsp;");
                }
              }else{
                out.print("&nbsp;");
              }

            }
          }
        %>
         </td>
        <%
      }
      %>
</tr>
<tr>
 <td>&nbsp;</td>
 <td colspan="5" class="section-summarizeTableSpannedCell">
<%

      java.util.ArrayList subFields = (java.util.ArrayList)request.getAttribute("subFields");
      java.util.Iterator itSub = subFields.iterator();

      while(itSub.hasNext()){
        String name = itSub.next().toString();
          if(name.equalsIgnoreCase("name")){
            String editUrl = "javascript:submitForm(\'external:/section/edit.do?id="+section.getId()+"\')";
             neo.phoenix.base.WorkItemManager workItemManager = (neo.phoenix.base.WorkItemManager) session.getAttribute("WorkItemManager");
             boolean isLocked = section.isLocked();
             if (isLocked) {
               neo.phoenix.base.WorkItem item = null;
               if(workItemManager!=null){
                item = workItemManager.findWorkItem("section",String.valueOf(section.getId()));
               }
               if (item != null) {
                 editUrl = "/base/restoreWork.do?id=" + item.getId();
               } else {
                canEdit = false;
                editUrl = null;
               }
             }

            %><!-- <td align="left"> --><%
            if(canEdit){%>
              <a href="<%=editUrl%>"><%
                out.print(myIndent+section.getName());
              %></a>
            <%}else{
              if(isLocked){%>
                <html:img page="/images/qw/lock_16x16.png" border="0" alt="" />
              <%}
              out.print(myIndent+section.getName());
            }

          }else{

            /* Printing Section Uniquename */
            if(name.equalsIgnoreCase("Uniquename")){
              out.print("Section Uniquename: ");
              if(section.getUniqueName()!=null){
                out.print(section.getUniqueName());
              }else{
                out.print("n/a");
              }

            /* Printing State */
            }else if(name.equalsIgnoreCase("State")){
              int state = section.getState();
              neo.xredsys.api.Type type = neo.xredsys.api.IOAPI.getAPI().getTypeManager().getType(neo.xredsys.api.Type.SectionStateType,state);
              out.print(type.getName());
              out.print("State: ");
              if(canEdit&&canBePublished){
                String p5 = "relatedObject(" + section.getId() + ").attribute(state)";
                %><html:checkbox property="<%=p5%>" /><%
              }

            /* Printing Agreement Type */
            }else if(name.equalsIgnoreCase("AgreementType")){
              int agId  = section.getAgreementId();
              out.print("Agreement Type: ");
              if(agId>0){
                neo.xredsys.api.AgreementInfo info = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getAgreementInfo(agId);
                neo.xredsys.api.Type type = neo.xredsys.api.IOAPI.getAPI().getTypeManager().getType(neo.xredsys.api.Type.AgreementType,info.getAgreementType());
                if(type.getId()==1){
                  out.print("ShowFrontpage");
                }else{
                  out.print("HideFrontpage");
                }
              }else{
                out.print("n/a");
              }

            /* Printing Section Template */
            }else if(name.equalsIgnoreCase("SectionTemplate")){
              out.print("Section Template: ");
              out.print(neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getLayout(section.getLayoutId()).getName());
              if(canEdit&&!isVirtual){
                String p5 = "relatedObject(" + section.getId() + ").attribute(sectionTemplate)";
                %><html:checkbox property="<%=p5%>" /><%
              }

            /* Printing Article Template */
            }else if(name.equalsIgnoreCase("ArticleTemplate")){
              out.print("Article Template: ");
              out.print(neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getLayout(section.getArticleLayoutId()).getName());
              if(canEdit&&!isVirtual){
                String p5 = "relatedObject(" + section.getId() + ").attribute(articleTemplate)";
                %><html:checkbox property="<%=p5%>" /><%
              }

            /* Printing Section ID */
            }else if(name.equalsIgnoreCase("id")){
              out.print("Section ID: ");
              out.print(section.getId());

            /* Printing Is Virtual */
            }else if(name.equalsIgnoreCase("isVirtual")){
              out.print("Is Virtual: ");
              if(section instanceof neo.xredsys.api.VirtualSection){
                out.print("true");
              }else{
                out.print("false");
              }

            /* Printing Source */
            }else if(name.equalsIgnoreCase("virtualSource")){
              out.print("Source: ");
              if(section instanceof neo.xredsys.api.VirtualSection){
                neo.xredsys.api.VirtualSection sec = (neo.xredsys.api.VirtualSection)section;
                neo.xredsys.api.Section target = neo.xredsys.api.IOAPI.getAPI().getObjectLoader().getSection(sec.getVirtualSource());
                if(target!=null){
                  out.print(target.getId()+" " + target.getName());
                }else{
                  out.print("n/a");
                }
              }else{
                out.print("n/a");
              }

            }
          }
        %>
         -
        <%
      }
      %>

 </td>
</tr>

<logic:iterate name="section" property="subSections" id="s" type="neo.xredsys.api.Section">
  <% if (! s.getType().getName().equals("hidden")) { %>
  <tr>
    <template:call file="summarize-recurse.jsp">
      <template:parameter key="section" name="s"/>
    </template:call>
  </tr>
  <% } %>
</logic:iterate>
<% request.setAttribute("indent",myIndent);%>