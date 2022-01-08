<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  xmlns:opentopic="http://www.idiominc.com/opentopic" 
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:local="urn:local-functions" 
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  xmlns:sps="urn:ns:dita-community:split-page-sequences"
  xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  exclude-result-prefixes="xs xd opentopic local dita-ot sps map"
  version="3.0">
  <!-- ==============================================================
       org.dita-community.split-page-sequences
    
       Overrides of topic-level templates to handle @outputclass
       with page-sequence* entries.
       ============================================================== -->
  

  <!-- Override of general topic handling to handle generation of page sequence markers
    -->
  <xsl:template match="*[contains(@class, ' topic/topic ')]">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
    
    <xsl:variable name="doDebug" as="xs:boolean" select="$doDebug"/>
    
    <xsl:variable name="page-sequence-data" as="map(*)?"
         select="sps:getPageSequenceData(.)"
    />
    
    <xsl:if test="$doDebug">
      <xsl:message expand-text="yes">+ [DEBUG] SPS: topic/topic override: page-sequence-data: <xsl:sequence select="$page-sequence-data"/></xsl:message>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="exists($page-sequence-data)">
        <xsl:if test="$page-sequence-data('start')">
          <sps:page-sequence-start page-sequence-master="{$page-sequence-data('layout')}"/>
        </xsl:if>        
        <xsl:next-match/>
        <xsl:if test="$page-sequence-data('end')">
          <sps:page-sequence-end page-sequence-master="{$page-sequence-data('layout')}"/>
        </xsl:if>        
      </xsl:when>
      <xsl:otherwise>
        <xsl:next-match/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>