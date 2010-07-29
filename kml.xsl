<!-- 

source:
http://www.ldodds.com/blog/2006/05/generating-google-earth-overlays-with-sparql-and-xslt/

-->

<xsl:stylesheet
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:dawg="http://www.w3.org/2005/sparql-results#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:kml="http://earth.google.com/kml/2.0"
   xmlns="http://earth.google.com/kml/2.0"
   version="1.0"
   exclude-result-prefixes="dawg rdf kml">

<xsl:output
   indent="yes"
   method="xml"
   omit-xml-declaration="yes" 
   media-type="application/vnd.google-earth.kml+xml"
      />

<xsl:param name="folder-name"/>
<xsl:param name="folder-desc"/>
   
<!-- Create document from SPARQL Query Results XML Format -->
<xsl:template match="/">
   <kml>   	
     <Folder>
	   <name>
	    <xsl:choose>
        	<xsl:when test="$folder-name"><xsl:value-of select="$folder-name"/></xsl:when>
        	<xsl:otherwise><xsl:text>SPARQL Query Results</xsl:text></xsl:otherwise>
      	</xsl:choose>
       </name>
	   <description>
	    <xsl:choose>
        	<xsl:when test="$folder-desc"><xsl:value-of select="$folder-desc"/></xsl:when>
        	<xsl:otherwise><xsl:text>SPARQL Query Results</xsl:text></xsl:otherwise>
      	</xsl:choose>
	   </description>
      <xsl:apply-templates select="//dawg:result"/>
     </Folder>
   </kml>
</xsl:template>

<!-- Ignore head element -->
<xsl:template match="dawg:head"/>

<xsl:template match="dawg:results">
      <xsl:apply-templates select="dawg:result"/>
</xsl:template>

<!-- Process results element -->
<xsl:template match="dawg:result">
  <Placemark>
    <description><xsl:value-of select="dawg:binding[@name='description']/dawg:literal"/></description>
    <name><xsl:value-of select="dawg:binding[@name='title']/dawg:literal"/></name>
    <Point>
    	<coordinates>
    	<xsl:value-of select="dawg:binding[@name='coordinates']/dawg:literal"/>
    	</coordinates>
    </Point>
  </Placemark>
</xsl:template>
   
</xsl:stylesheet>
