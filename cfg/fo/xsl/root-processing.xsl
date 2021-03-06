<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  xmlns:opentopic="http://www.idiominc.com/opentopic" 
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:local="urn:local-functions" 
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  xmlns:sps="urn:ns:dita-community:split-page-sequences"
  exclude-result-prefixes="xs xd opentopic local dita-ot" 
  version="3.0">
  <!-- ==============================================================
       org.dita-community.split-page-sequences
    
       Override of base root template processing to do post-processing
       of the initial FO to split the page sequences.
       ============================================================== -->
  
  <xsl:import href="split-page-sequences.xsl"/>
  <xsl:import href="topic.xsl"/>
  
  <xsl:template match="/" name="rootTemplate">
    
    <xsl:variable name="doDebug" as="xs:boolean" select="false()"/>
    
    <xsl:variable name="base-fo" as="node()*">
      <xsl:next-match/>
    </xsl:variable>
    <xsl:if test="$doDebug">
      <xsl:message>+ [DEBUG] SPS: Applying templates to base FO in mode sps:split-page-sequences...</xsl:message>
    </xsl:if>
<!--  Uncomment this if you need to inspect the initial state of the FO.
      
      NOTE: This result-document instruction will fail is some other extension to the PDF2 transform puts
            the result of the "/" template into a variable.
      
      <xsl:result-document href="base-fo.fo">
        <xsl:sequence select="$base-fo"/>
      </xsl:result-document>
--> 
    <xsl:apply-templates select="$base-fo" mode="sps:split-page-sequences">
      <xsl:with-param name="doDebug" as="xs:boolean" tunnel="yes" select="$doDebug"/>
    </xsl:apply-templates>
    <xsl:if test="$doDebug">
      <xsl:message>+ [DEBUG] SPS: Done applying templates to base FO in mode sps:split-page-sequences.</xsl:message>
    </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>