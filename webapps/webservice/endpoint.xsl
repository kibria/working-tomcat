<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:e="http://xmlns.escenic.com/webservice" xmlns="http://www.w3.org/1999/xhtml">

  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/e:endpoint">
    <html>
      <xsl:attribute name="xml:base">
        <xsl:value-of select="@xml:base"/>
      </xsl:attribute>
      <head>
        <title>Escenic Content Engine Web Service</title>
        <xsl:apply-templates select="e:link" mode="head"/>
      </head>
      <body>
        <h1>Escenic Content Engine Web Service</h1>
        <p>
          Welcome to the Escenic Content Engine Web Service. It is intended to be used by programmers to access the
          content repository of the Escenic Content Engine. If you are a user, you should probably download Escenic
          Content Studio.
        </p>
        <p>
          If you are a programmer, this page can be used to discover the services provided by the Content Engine.
          Services are exposed as &lt;link&gt; elements, pointing to the services. Here is a list of the links provided.
        </p>
        <ul>
          <xsl:apply-templates select="e:link"/>
        </ul>
        <p>
          Not all resources shown support GET. Indeed, some only support POST in order to create content. Most GET
          responses include an Allow header to help you find out what methods you can use with the resource.
        </p>
      </body>
    </html>
  </xsl:template>


  <xsl:template match="e:link">
    <li>
      <a href="{@href}">
        <xsl:value-of select="@rel"/>
      </a>
      <xsl:text> (</xsl:text>
      <xsl:value-of select="@type"/>
      <xsl:text>)</xsl:text>
    </li>
  </xsl:template>

  <xsl:template match="e:link[e:accept]">
    <li>
      <xsl:text>POST </xsl:text>
      <a href="{@href}">
        <xsl:value-of select="@rel"/>
      </a>
      <xsl:text> of type</xsl:text>
      <xsl:choose>
        <xsl:when test="count(e:accept) &gt; 1">
          <ul>
            <xsl:apply-templates select="e:accept" mode="li"/>
          </ul>

        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="e:accept"/>
        </xsl:otherwise>

      </xsl:choose>
    </li>
  </xsl:template>

  <xsl:template match="e:accept" mode="li">
    <li>
      <xsl:apply-templates/>
    </li>
  </xsl:template>

  <xsl:template match="e:accept">
    <xsl:text> </xsl:text>
    <xsl:apply-templates/>
    <xsl:text>;</xsl:text>
  </xsl:template>

  <xsl:template match="e:link[@type='application/opensearchdescription+xml']" mode="head">
    <link rel="search" type="{@type}" href="{@href}" title="{@rel}"/>
  </xsl:template>

  <xsl:template match="e:link" mode="head"/>

</xsl:stylesheet>