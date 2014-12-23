<%@ page language="java" %>

<%--
 * Copyright (C) 2001 Escenic AS.
 * All Rights Reserved.  No use, copying or distribution of this
 * work may be made except in accordance with a valid license
 * agreement from Escenic AS.  This notice must be included on
 * all copies, modifications and derivatives of this work.

 * The reason for the strange formatting, is that in  this way,
 * this file does not include any extra garbage whitespace, that could
 * hurt the resulting page.
 --%>

<%@ taglib uri="http://www.escenic.com/taglib/escenic-article" prefix="article" %>
<%@ taglib uri="http://www.escenic.com/taglib/escenic-util" prefix="util" %>

<!-- Start: fp_default.jsp -->
<h1>${element.fields.title.value}</h1>
${element.fields.body.value}
<p>
 <a href="${element.content.url}" />Read article</a>
</p>
<!-- End: fp_default.jsp -->