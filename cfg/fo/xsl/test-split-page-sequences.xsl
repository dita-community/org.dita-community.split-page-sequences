<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  xmlns:opentopic="http://www.idiominc.com/opentopic" 
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:local="urn:local-functions" 
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  exclude-result-prefixes="xs xd opentopic local dita-ot" 
  version="2.0">
  
  <xsl:import href="commons.xsl"/>
  <xsl:import href="construct-page-sequences.xsl"/>
  <xsl:import href="split-spans.xsl"/>
  <xsl:import href="split-page-sequences.xsl"/>
  
  <xsl:key name="topic-id" match="*[contains(@class, ' topic/topic ')][@id]" use="@id"/>
  <xsl:output
    indent="yes"
  />
  
  <xsl:key name="id" match="*[@id]" use="@id"/>
  
  <xsl:template match="/">
    <xsl:message>+ [DEBUG] test-split-page-sequences: Starting...</xsl:message>
    <root>      
      <xsl:apply-templates select="/*/fo:page-sequence">
        <xsl:with-param name="doDebug" as="xs:boolean" tunnel="yes" select="true()"/>
      </xsl:apply-templates>
    </root>
    <xsl:message>+ [DEBUG] test-split-sequences: Done.</xsl:message>
  </xsl:template>
  
  <xsl:template match="fo:page-sequence">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
    
    <xsl:variable name="base-page-sequence" as="element(fo:page-sequence)" select="."/>
    <xsl:choose>
      <xsl:when test="exists($base-page-sequence//dita-ot:page-sequence-start)">
        <!-- Split page sequences -->
        <xsl:message>+ [DEBUG] test-split-page-sequences: Splitting page sequences. </xsl:message>
        <xsl:apply-templates select="$base-page-sequence" mode="split-page-sequences">
          <xsl:with-param name="doDebug" as="xs:boolean" tunnel="yes" select="$doDebug"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <no-page-sequence-split/>
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:template>
  
  <xsl:template name="commonattributes">
    <!-- Stub -->
  </xsl:template>
</xsl:stylesheet>