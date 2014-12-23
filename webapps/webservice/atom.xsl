<?xml version="1.0"?>

<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:a="http://www.w3.org/2005/Atom"
  xmlns:app="http://www.w3.org/2007/app"
  xmlns:fh="http://xmlns.vizrt.com/2011/feed-help"
  xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:vdf="http://www.vizrt.com/types"
  xmlns:metadata="http://xmlns.escenic.com/2010/atom-metadata"
  xmlns:dcterms="http://purl.org/dc/terms/"
  xmlns="http://www.w3.org/1999/xhtml"
  version="1.0"
>

  <xsl:output method="html"
              version="1.0"
              indent="yes" />

  <xsl:template match ="/">
    <xsl:apply-templates select="/*" mode="root"/>
  </xsl:template>

  <xsl:template match ="/a:feed|/a:entry|/vdf:model" mode="root">
    <html>
      <head>
        <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"/>

        <title><xsl:value-of select="a:title[1]"/></title>
        <style type="text/css">
body {
  font-family: Arial, Helvetica, sans-serif;
  font-size: 1em;
  margin: 30px 30px 0px 30px;
}


article {
  margin-top: 2em;
}

article, div {
  margin-left: 1em;
}

h1, h2, h3 {
  color: #ff752d;
}

h1 {
  font-size: 1.5em;
}

h2 {
  font-size: 1.2em;
  margin-top: 3em;
  margin-bottom: 0em;
}

h3,h4,h5,h6 {
  font-weight: bold;
  margin-top: 2em;
  margin-bottom: 0.2em;
}

h3,h4,h5 {
  font-size: 1em;
}

a {
  font-weight: bold;
  text-decoration: none;
}

a:hover {
  text-decoration: underline;
}


a.plain {
  font-weight: inherit;
}

p {
  margin-top: 0em;
  margin-bottom: 0.6em;
  padding-right: 4cm;
}

div.element-atom-link {
  margin-top: 1em;
}
div.element-atom-link+div.element-atom-link {
  margin-top: 0;
  margin-bottom: 0;
}

div.element-atom-content>div.element-vdf-payload {
  border: 2px solid green;
  margin-top: 0.5em;
  margin-bottom: 0.5em;
  padding: 0.5em;
  background-color: #f9f9f9;
}

div.element-vdf-field {
  margin-bottom: 1em;
}

/* Standard dcterms, atom and app namespaced elements are green */
.ns-dcterms>tt .element-name,
.ns-app>tt .element-name,
.ns-atom>tt .element-name {
  color: green;
}

.atom, .vizrt-rel, .std-rel, .draft-rel {
  outline: 1px solid #ccc;
  cursor: help;
}

.atom:hover, .vizrt-rel:hover, .std-rel:hover, .draft-rel:hover {
  outline: 1px solid black;
}

.attribute:nth-child(even) {
  display: block;
  padding-left: 3.5em;
}

.attribute:nth-child(n+2) {
  display: block;
  padding-left: 3.5em;
}

.attribute:only-child, .attribute:last-child {
  display: inline !important;
}
/*
pre.programlisting {
  margin-top: 0em;
  background-color: #ffddaa;
  padding-top: 0.5em;
  padding-bottom: 0.5em;
  padding-left: 0.5em;
  padding-right: 0.5em;
}

div.note {
  background-color: #ffddaa;
  padding-top: 0.5em;
  padding-bottom: 0.5em;
  padding-left: 0.5em;
  padding-right: 0.5em;
}

th {
  background-color: #ff752d;
  color: #ffffff;
  padding-top: 0.5em;
  padding-bottom: 0.5em;
  padding-left: 0.5em;
  padding-right: 0.5em;
}
*/

        </style>
        <script>
  /* Auto-annotate the following link relations */
  linkrels =
          { 'http://www.vizrt.com/types/relation/changelog' :
            { title : 'An Atom Collection where all content items from this section are available ' +
                      '(possibly along with items from other sections), ordered by last modified date.'
            , href : 'http://documentation.vizrt.com/ece-integration-guide/5.3/changelog.html'
            , class : 'vizrt-rel'
            }

          , 'http://www.vizrt.com/types/relation/content-items' :
            { title : 'An Atom Collection where you can POST to create new articles in this section, ' +
                      'and perform searches for content in this section.'
            , href : 'http://documentation.vizrt.com/ece-integration-guide/5.3/content_items.html'
            , class : 'vizrt-rel'
            }

          , 'http://www.vizrt.com/types/relation/home-section' :
            { title : '(Escenic specific) Identifies the home section of a content item.'
            , href : 'http://documentation.vizrt.com/ece-integration-guide/5.3/home_section.html'
            , class : 'vizrt-rel'
            }

          , 'http://www.vizrt.com/types/relation/inboxes' :
            { title : 'A list of Inboxes available at this node'
            , href : 'http://documentation.vizrt.com/ece-integration-guide/5.3/inboxes.html'
            , class : 'vizrt-rel'
            }

          , 'http://www.vizrt.com/types/relation/lists' :
            { title : 'A list of Lists available at this node'
            , href : 'http://documentation.vizrt.com/ece-integration-guide/5.3/http_____related.html'
            , class : 'vizrt-rel'
            }

          , 'http://www.vizrt.com/types/relation/list-pool' :
            { title : 'The actual contents of a list, namely the content items in the list themselves'
            , href : 'http://documentation.vizrt.com/ece-integration-guide/5.3/http_____list_pool.html'
            , class : 'vizrt-rel'
            }

          , 'http://www.vizrt.com/types/relation/protection-domains' :
            { title : 'A list of "changelogs" available'
            , href : 'http://documentation.vizrt.com/'
            , class : 'vizrt-rel'
            }

          , 'http://www.vizrt.com/types/relation/pages' :
            { title : 'A list of Section Pages available at this node'
            , href : 'http://documentation.vizrt.com/ece-integration-guide/5.3/pages.html'
            , class : 'vizrt-rel'
            }

          /*************** Standard link relations ********/
          , 'alternate' :
            { title : 'An alternative representation, typically a publicly available web page'
            , href : 'http://tools.ietf.org/html/rfc4287#section-4.2.7.2'
            , class : 'std-rel'
            }

          , 'edit' :
            { title : 'This is a resource that should be an Atom Entry which supports GET and PUT '+
                      'operations to modify it.'
            , href : 'http://tools.ietf.org/html/rfc5023#section-11.1'
            , class : 'std-rel'
            }

          , 'edit-media' :
            { title : 'This is a resource that typically is NOT an Atom Entry, but supports GET and ' +
                      'PUT operations to modify it.'
            , href : 'http://tools.ietf.org/html/rfc5023#section-11.2'
            , class : 'std-rel'
            }

          , 'down' :
            { title : 'A feed which describes child nodes in a hierarchy'
            , href : 'http://tools.ietf.org/html/draft-divilly-atom-hierarchy'
            , class : 'draft-rel'
            }

          , 'first' :
            { title : 'The first page in this series of documents'
            , href : 'http://tools.ietf.org/html/rfc5005#section-3'
            , class : 'std-rel'
            }

          , 'last' :
            { title : 'The last page in this series of documents'
            , href : 'http://tools.ietf.org/html/rfc5005#section-3'
            , class : 'std-rel'
            }

          , 'next' :
            { title : 'The next page in this series of documents'
            , href : 'http://tools.ietf.org/html/rfc5005#section-3'
            , class : 'std-rel'
            }

          , 'previous' :
            { title : 'The previous page in this series of documents'
            , href : 'http://tools.ietf.org/html/rfc5005#section-3'
            , class : 'std-rel'
            }

          , 'related' :
            { title : 'A related resource'
            , href : 'http://tools.ietf.org/html/rfc4287#section-4.2.7.2'
            , class : 'std-rel'
            }

          , 'search' :
            { title : 'A resource describing how to search in this collection (typically an OpenSearch ' +
                      'description document)'
            , href : 'http://www.opensearch.org/Specifications/OpenSearch/1.1#Autodiscovery_in_RSS.2FAtom'
            , class : 'std-rel'
            }

          , 'self' :
            { title : 'The canonical location of where to access the parent element'
            , href : 'http://tools.ietf.org/html/rfc4287#section-7.1'
            , class : 'std-rel'
            }

          }


  linktypes =
          { 'application/atom+xml;type=feed' :
            { title : 'An Atom Feed or Collection'
            , class : 'atom'
            , href: 'http://tools.ietf.org/html/rfc4287'
            }

          , 'application/atom+xml;type=entry' :
            { title : 'An Atom Entry'
            , class : 'atom'
            , href: 'http://tools.ietf.org/html/rfc5023#section-12'
            }

          , 'application/atom+xml' :
            { title : 'An Atom document (Feed or Entry)'
            , href: 'http://tools.ietf.org/html/rfc4287'
            , class : 'atom'
            }

          , 'application/opensearchdescription+xml' :
            { title : 'An OpenSearch Description Document, which tells you how to search for items in this ' +
                      'collection'
            , href: 'http://www.opensearch.org/Specifications/OpenSearch/1.1#OpenSearch_description_document'
            , class : 'atom'
            }

          , 'application/vnd.vizrt.payload+xml' :
            { title : 'A Vizrt Payload.  A payload is a self describing set of key-value data elements' +
                      'which can be parsed and manipulated as needed by user agents.'
            , href: 'http://documentation.vizrt.com/?payloads-somewhere:-)'
            , class : 'proprietary'
            }

          , 'application/vnd.escenic.content+xml' :
            { title : 'A proprietary XML. Undocumented, and it will change.'
            , class : 'proprietary'
            }
          }

  var vdfelements =
          { payload : 
             { title : 'A map of editable key-values'
             , href : 'http://documentation.vizrt.com/?some-payload-uri-goes-here'
             }

          , field : 
             { title : 'A single field within a payload or field'
             , href : 'http://documentation.vizrt.com/?some-payload-uri-goes-here'
             }

          , value : 
             { title : 'The value of the enclosing field.'
             , href : 'http://documentation.vizrt.com/?some-payload-uri-goes-here'
             }

          , list : 
             { title : 'A list of values.'
             , href : 'http://documentation.vizrt.com/?some-payload-uri-goes-here'
             }

          }

  var appelements =
          { edited : 
             { title : 'The date of the last update (system generated)'
             , href : 'http://tools.ietf.org/html/rfc5023#section-10.2'
             }

          , control : 
             { title : 'Controls visibility of articles. app:draft YES means it\'s not published.'
             , href : 'http://tools.ietf.org/html/rfc5023#section-13.1'
             }

          , draft : 
             { title : 'If present inside app:control, this means that the item should not be public.'
             , href : 'http://tools.ietf.org/html/rfc5023#section-13.1.1'
             }

          }

  var atomelements =
          { updated : 
             { title : 'The date of the last significant update (editable by users)'
             , href : 'http://tools.ietf.org/html/rfc4287#section-4.2.15'
             }

          , published : 
             { title : 'The initial publishing date (editable by users)'
             , href : 'http://tools.ietf.org/html/rfc4287#section-4.2.9'
             }

          , content : 
             { title : 'The actual content of the entry, i.e. the important stuff'
             , href : 'http://tools.ietf.org/html/rfc4287#section-4.1.3'
             }

          }

  $(document).ready(function() {
    annotate('div.element-atom-link>tt span.type-attr, div.element-atom-content>tt span.type-attr', linktypes);
    annotate('div.element-atom-link>tt span.rel-attr', linkrels);
    linkify('div.element-vdf-payload>tt span.attribute-model span.attribute-value');
    linkify('div.element-metadata-publication>tt span.attribute-href span.attribute-value');
    documentElements('vdf', vdfelements);
    documentElements('atom', atomelements);
    documentElements('app', appelements);
  });

  function documentElements(ns, values) {
    for (e in values) {
      var item = values[e];
      $('div.element-' + ns + '-' + e + '>tt span.element-name').each(function(index, element) {
        if (item.title) {
          $(this).attr('title', item.title);
        }
        if (item.class) {
          $(this).addClass(item.class);
        }
        if (item.parentClass) {
          $(this).parent().addClass(item.parentClass);
        }
        if (item.href) {
          $(this).wrap('<a class="plain" href="' + item.href + '"/>');
        }
      });
    }
  }

  function linkify(what) {
    console.log(what);
    $(what).each(function (index, element) {
      console.log(element);
      $(element).wrap('<a href="' + $(element).text() + '"/>');
    });
  }

  /**
   * the values map maps the text content of the matched element,
   * as a prefix-substring in the map. The longest match will be used
   * the values in the resulting object can have the following keys:
   * * title --- annotate with a title attribute
   * * href --- wrap in a href
   * * class --- add css class to element
   * * parentclass --- add css class to parent element
   * @param type a jquery selector
   * @param values a map containing keys to objects
   */
  function annotate(type, values) {
    $(type).each(function (index, element) {
      var match;
      /* Use the longest matching string */
      var length = 0;
      var name = $(this).text().replace(/\s/,'');
      for (t in values) {
        if (t.length &lt; length) continue;
        if (name.substring(0,t.length) == t) {
          length = t.length;
          match = t;
        }
      }
      if (! match) return;

      var item = values[match];
      if (item.title) {
        $(this).attr('title', item.title);
      }
      if (item.class) {
        $(this).addClass(item.class);
      }
      if (item.parentClass) {
        $(this).parent().addClass(item.parentClass);
      }
      if (item.href) {
        $(this).wrap('<a class="plain" href="' + item.href + '"/>');
      }
    });
  }        
        </script>
      </head>
      <body>
        <!-- escenic logo -->
<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   version="1.1"
   id="Layer_1"
   x="0px"
   y="0px"
   width="315.34943"
   height="67.178162"
   viewBox="0 0 315.34943 67.178162"
   enable-background="new 0 0 790.909 251.948"
   xml:space="preserve"
   inkscape:version="0.48.4 r9939"
   sodipodi:docname="escenic-logo.svg"><metadata
     id="metadata47"><rdf:RDF><cc:Work
         rdf:about=""><dc:format>image/svg+xml</dc:format><dc:type
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" /></cc:Work></rdf:RDF></metadata><defs
     id="defs45" /><sodipodi:namedview
     pagecolor="#ffffff"
     bordercolor="#666666"
     borderopacity="1"
     objecttolerance="10"
     gridtolerance="10"
     guidetolerance="10"
     inkscape:pageopacity="0"
     inkscape:pageshadow="2"
     inkscape:window-width="1855"
     inkscape:window-height="1056"
     id="namedview43"
     showgrid="false"
     fit-margin-top="0"
     fit-margin-left="0"
     fit-margin-right="0"
     fit-margin-bottom="0"
     inkscape:zoom="1.4767818"
     inkscape:cx="38.851635"
     inkscape:cy="65.272747"
     inkscape:window-x="65"
     inkscape:window-y="24"
     inkscape:window-maximized="1"
     inkscape:current-layer="Layer_1" /><g
     id="g3001"
     transform="matrix(0.48,0,0,0.48,-6.8190146e-7,0)"><path
       style="fill:#231f20"
       inkscape:connector-curvature="0"
       id="path3"
       d="m 195.065,70.1325 c 1.121,8.553 8.553,14.721 20.608,14.721 6.309,0 14.58,-2.384 18.506,-6.449 l 10.935,10.795 c -7.29,7.57 -19.205,11.215 -29.721,11.215 -23.833,0 -37.992,-14.721 -37.992,-36.871 0,-21.029 14.299,-36.169 36.73,-36.169 23.132,0 37.572,14.299 34.909,42.759 h -53.975 z m 37.573,-14.16 c -1.122,-8.972 -8.131,-13.459 -17.945,-13.459 -9.253,0 -16.822,4.487 -19.347,13.459 h 37.292 z" /><path
       style="fill:#231f20"
       inkscape:connector-curvature="0"
       id="path5"
       d="m 307.355,47.8415 c -4.907,-4.626 -10.514,-6.168 -17.103,-6.168 -8.131,0 -12.618,2.524 -12.618,6.869 0,4.486 4.066,7.01 12.897,7.571 13.039,0.841 29.582,3.785 29.582,22.15 0,12.197 -9.954,22.711 -29.722,22.711 -10.935,0 -21.87,-1.821 -31.964,-12.336 l 8.411,-12.197 c 4.907,5.468 16.123,9.533 23.834,9.673 6.448,0.14 12.476,-3.224 12.476,-8.271 0,-4.768 -3.924,-6.729 -13.738,-7.291 -13.037,-0.98 -28.6,-5.748 -28.6,-21.449 0,-15.982 16.543,-21.59 29.16,-21.59 10.795,0 18.927,2.104 26.918,9.113 l -9.533,11.215 z" /><path
       style="fill:#231f20"
       inkscape:connector-curvature="0"
       id="path7"
       d="m 390.347,89.7595 c -7.99,7.852 -16.402,10.936 -26.637,10.936 -20.048,0 -36.73,-12.057 -36.73,-36.591 0,-24.534 16.683,-36.59 36.73,-36.59 9.814,0 17.385,2.804 24.955,10.233 l -10.795,11.357 c -4.066,-3.646 -9.112,-5.468 -13.879,-5.468 -11.496,0 -19.907,8.412 -19.907,20.468 0,13.177 8.972,20.188 19.626,20.188 5.468,0 10.936,-1.542 15.142,-5.747 l 11.495,11.214 z" /><path
       style="fill:#231f20"
       inkscape:connector-curvature="0"
       id="path9"
       d="m 415.296,70.1325 c 1.121,8.553 8.551,14.721 20.608,14.721 6.309,0 14.58,-2.384 18.506,-6.449 l 10.935,10.795 c -7.291,7.57 -19.207,11.215 -29.722,11.215 -23.832,0 -37.992,-14.721 -37.992,-36.871 0,-21.029 14.3,-36.169 36.731,-36.169 23.132,0 37.572,14.299 34.908,42.759 h -53.974 z m 37.571,-14.16 c -1.121,-8.972 -8.131,-13.459 -17.945,-13.459 -9.252,0 -16.821,4.487 -19.346,13.459 h 37.291 z" /><path
       style="fill:#231f20"
       inkscape:connector-curvature="0"
       id="path11"
       d="m 533.334,98.5915 v -36.17 c 0,-10.515 -5.748,-18.505 -16.684,-18.505 -10.515,0 -17.665,8.832 -17.665,19.347 v 35.328 h -16.963 v -69.255 h 15.281 l 1.122,9.392 c 7.009,-6.869 14.019,-10.374 22.711,-10.374 16.263,0 29.301,12.197 29.301,33.927 v 36.31 h -17.103 z" /><path
       style="fill:#231f20"
       inkscape:connector-curvature="0"
       id="path13"
       d="m 583.8,9.9885 c 0,13.319 -20.188,13.319 -20.188,0 0,-13.318 20.188,-13.318 20.188,0 m -18.647,88.603 h 17.104 v -69.395 h -17.104 v 69.395 z" /><path
       style="fill:#231f20"
       inkscape:connector-curvature="0"
       id="path15"
       d="m 656.978,89.7595 c -7.992,7.852 -16.403,10.936 -26.637,10.936 -20.048,0 -36.731,-12.057 -36.731,-36.591 0,-24.534 16.684,-36.59 36.731,-36.59 9.813,0 17.384,2.804 24.954,10.233 L 644.5,49.1045 c -4.065,-3.646 -9.112,-5.468 -13.879,-5.468 -11.496,0 -19.907,8.412 -19.907,20.468 0,13.177 8.972,20.188 19.627,20.188 5.467,0 10.935,-1.542 15.141,-5.747 l 11.496,11.214 z" /><path
       style="fill:#231f20"
       inkscape:connector-curvature="0"
       id="path17"
       d="m 190.617,139.6675 -1.582,-3.935 h -8.468 l -1.583,3.935 h -1.583 l 6.549,-16 h 1.702 l 6.548,16 h -1.583 z m -5.804,-14.537 -3.79,9.355 h 7.555 l -3.765,-9.355 z" /><path
       style="fill:#231f20"
       inkscape:connector-curvature="0"
       id="path19"
       d="m 201.312,131.6795 c 0,-4.917 3.574,-8.275 8.106,-8.275 2.543,0 4.487,1.127 5.83,2.83 l -1.151,0.744 c -1.007,-1.393 -2.759,-2.326 -4.679,-2.326 -3.74,0 -6.668,2.854 -6.668,7.027 0,4.126 2.928,7.027 6.668,7.027 1.92,0 3.672,-0.935 4.679,-2.325 l 1.176,0.719 c -1.439,1.751 -3.312,2.854 -5.854,2.854 -4.532,0 -8.107,-3.358 -8.107,-8.275" /><path
       style="fill:#231f20"
       inkscape:connector-curvature="0"
       id="path21"
       d="m 217.981,131.6795 c 0,-4.917 3.574,-8.275 8.106,-8.275 2.543,0 4.487,1.127 5.83,2.83 l -1.151,0.744 c -1.008,-1.393 -2.759,-2.326 -4.679,-2.326 -3.741,0 -6.668,2.854 -6.668,7.027 0,4.126 2.927,7.027 6.668,7.027 1.92,0 3.671,-0.935 4.679,-2.325 l 1.176,0.719 c -1.44,1.751 -3.312,2.854 -5.854,2.854 -4.532,0 -8.107,-3.358 -8.107,-8.275" /><rect
       style="fill:#231f20"
       id="rect23"
       height="15.999"
       width="1.367"
       y="123.6675"
       x="235.24901" /><path
       style="fill:#231f20"
       inkscape:connector-curvature="0"
       id="path25"
       d="m 247.36,131.6795 c 0,-4.917 3.574,-8.275 8.106,-8.275 2.543,0 4.487,1.127 5.83,2.83 l -1.151,0.744 c -1.008,-1.393 -2.758,-2.326 -4.679,-2.326 -3.74,0 -6.668,2.854 -6.668,7.027 0,4.126 2.928,7.027 6.668,7.027 1.921,0 3.671,-0.935 4.679,-2.325 l 1.176,0.719 c -1.439,1.751 -3.312,2.854 -5.854,2.854 -4.533,0 -8.107,-3.358 -8.107,-8.275" /><path
       style="fill:#231f20"
       inkscape:connector-curvature="0"
       id="path27"
       d="m 264.028,131.6795 c 0,-4.678 3.07,-8.275 7.771,-8.275 4.678,0 7.772,3.598 7.772,8.275 0,4.677 -3.095,8.275 -7.772,8.275 -4.701,0 -7.771,-3.597 -7.771,-8.275 m 14.105,0 c 0,-4.055 -2.495,-7.027 -6.333,-7.027 -3.861,0 -6.333,2.973 -6.333,7.027 0,4.029 2.472,7.027 6.333,7.027 3.838,0 6.333,-2.998 6.333,-7.027" /><polygon
       transform="translate(-73.382001,-60.5945)"
       style="fill:#231f20"
       id="polygon29"
       points="371.877,184.262 371.877,200.262 370.486,200.262 370.486,185.99 364.656,200.262 364.129,200.262 358.275,185.99 358.275,200.262 356.909,200.262 356.909,184.262 358.947,184.262 364.393,197.575 369.813,184.262 " /><path
       style="fill:#231f20"
       inkscape:connector-curvature="0"
       id="path31"
       d="m 303.05,139.6675 v -16 h 5.996 c 3.071,0 4.822,2.158 4.822,4.678 0,2.519 -1.775,4.678 -4.822,4.678 h -4.629 v 6.645 h -1.367 z m 9.379,-11.322 c 0,-2.016 -1.391,-3.43 -3.525,-3.43 h -4.486 v 6.859 h 4.486 c 2.134,0.001 3.525,-1.439 3.525,-3.429" /><path
       style="fill:#231f20"
       inkscape:connector-curvature="0"
       id="path33"
       d="m 327.011,139.6675 -1.582,-3.935 h -8.469 l -1.582,3.935 h -1.584 l 6.55,-16 h 1.702 l 6.549,16 h -1.584 z m -5.805,-14.537 -3.789,9.355 h 7.556 l -3.767,-9.355 z" /><polygon
       transform="translate(-73.382001,-60.5945)"
       style="fill:#231f20"
       id="polygon35"
       points="406.268,186.518 406.268,200.262 404.9,200.262 404.9,184.262 406.291,184.262 416.318,197.815 416.318,184.262 417.686,184.262 417.686,200.262 416.343,200.262 " /><polygon
       transform="translate(-73.382001,-60.5945)"
       style="fill:#231f20"
       id="polygon37"
       points="420.608,184.262 422.264,184.262 427.662,192.13 433.059,184.262 434.714,184.262 428.356,193.426 428.356,200.262 426.966,200.262 426.966,193.426 " /><path
       style="fill:#ff752d"
       inkscape:connector-curvature="0"
       id="path39"
       d="m 61.922999,52.4305 c -2.278,0.944 -4.347,2.335 -6.146,4.133 -1.798,1.799 -3.189,3.867 -4.133,6.146 -0.944,2.279 -1.423,4.725 -1.423,7.268 0,2.544 0.479,4.989 1.423,7.269 0.943,2.279 2.335,4.348 4.133,6.146 1.799,1.798 3.867,3.189 6.146,4.133 2.279,0.943 4.726,1.424 7.269,1.424 H 109.948 l 17.776,-37.942 H 69.191999 c -2.544,0 -4.99,0.479 -7.269,1.423" /><path
       style="fill:#ff752d"
       inkscape:connector-curvature="0"
       id="path41"
       d="m 5.4439986,96.9145 c 3.486,8.241 8.4730004,15.64 14.8220004,21.988 6.349,6.35 13.747,11.337 21.987,14.821 8.541,3.613 17.604,5.444 26.938,5.444 h 17.228 L 101.087,107.8575 H 69.190999 c -10.118,0 -19.631,-3.94 -26.786,-11.096 -7.155,-7.154 -11.095,-16.666 -11.095,-26.785 0,-10.12 3.939,-19.632 11.095,-26.787 7.155,-7.155 16.668,-11.096 26.786,-11.096 H 136.582 L 151.251,0.7845 H 69.190999 c -9.333,0 -18.396,1.832 -26.938,5.444 -8.24,3.485 -15.639,8.472 -21.987,14.822 -6.35,6.349 -11.3360004,13.747 -14.8220004,21.988 -3.612,8.54 -5.4439999566168,17.603 -5.4439999566168,26.938 0,9.336 1.8319999566168,18.398 5.4439999566168,26.938" /></g></svg>
               <h1>HTML Documentation</h1>
        <p>
          This is a developer friendly rendering of what you get if you access this resource
          using HTTP.  The page below is annotated to help you as a developer navigate through
          your own web services.  All related resources are linked (in bold), and many elements
          and attributes are annotated with tooltips and links directly to their definition in
          various standards and our own documentation.
        </p>
        <p>Have fun!</p>
        <h2>Annotated XML Source</h2>
        <xsl:apply-templates select="." mode="adornments"/>
      </body>
    </html>
  </xsl:template>


  <xsl:template match ="a:subtitle[@type='xhtml']">
    <xsl:copy-of select="."/>
  </xsl:template>

  <xsl:template match ="a:subtitle[@type='text']">
    <p><xsl:value-of select="."/></p>
  </xsl:template>

  <xsl:template match ="a:entry" mode="adornments">
    <article>
      <xsl:apply-templates select="."/>
    </article>
  </xsl:template>

  <xsl:template match ="*" mode="adornments">
    <xsl:apply-templates select="."/>
  </xsl:template>

  <xsl:template match="text()">
    <xsl:value-of select="."/>
  </xsl:template>
  
  <xsl:template match ="a:link/@rel" mode="value">
    <span class="rel-attr">
      <xsl:value-of select="."/>
    </span>
  </xsl:template>

  <xsl:template match ="a:link/@type|a:content/@type" mode="value">
    <span class="type-attr">
      <xsl:value-of select="."/>
    </span>
  </xsl:template>

  <xsl:template match ="a:link/@href" mode="value">
    <a href="{.}">
      <xsl:value-of select="."/>
    </a>
  </xsl:template>

  <xsl:template match ="@*" mode="value">
    <span class="attribute-value unknown-attribute-value">
      <xsl:value-of select="."/>
    </span>
  </xsl:template>

  <xsl:template match ="*">
    <xsl:variable name="ns">
      <xsl:apply-templates select="." mode="namespace-prefix"/>
    </xsl:variable>
    <div class="element-{$ns}-{local-name()} ns-{$ns}">
      <tt>
        <xsl:text>&lt;</xsl:text>
        <span class="element-name">
          <xsl:value-of select="name()"/>
        </span>
        <span class="attribute-container">
          <xsl:for-each select="@*" >
            <span class="attribute attribute-{name()}">
              <xsl:text> </xsl:text>
              <span class="attribute-name">
                <xsl:value-of select="name()"/>
              </span>
              <xsl:text>="</xsl:text>
              <xsl:apply-templates select="." mode="value"/>
              <xsl:text>"</xsl:text>
            </span>
          </xsl:for-each>
        </span>
        <xsl:if test="count(*|text()) = 0">
          <xsl:text>/</xsl:text>
        </xsl:if>
        <xsl:text>&gt;</xsl:text>
      </tt>
      <xsl:apply-templates select="*|text()" mode="adornments" />
      <xsl:if test="count(*|text()) > 0">
        <tt>
          <xsl:text>&lt;/</xsl:text>
          <span class="element-name">
            <xsl:value-of select="name()"/>
          </span>
          <xsl:text>&gt;</xsl:text>
        </tt>
      </xsl:if>
    </div>
  </xsl:template>


  <xsl:template match="a:*" mode="namespace-prefix">
    <xsl:text>atom</xsl:text>
  </xsl:template>

  <xsl:template match="app:*" mode="namespace-prefix">
    <xsl:text>app</xsl:text>
  </xsl:template>

  <xsl:template match="vdf:*" mode="namespace-prefix">
    <xsl:text>vdf</xsl:text>
  </xsl:template>

  <xsl:template match="dcterms:*" mode="namespace-prefix">
    <xsl:text>dcterms</xsl:text>
  </xsl:template>

  <xsl:template match="metadata:*" mode="namespace-prefix">
    <xsl:text>metadata</xsl:text>
  </xsl:template>

  <xsl:template match="html:*" mode="namespace-prefix">
    <xsl:text>html</xsl:text>
  </xsl:template>

  <xsl:template match="*" mode="namespace-prefix">
    <xsl:text>unknown</xsl:text>
  </xsl:template>

</xsl:stylesheet>
