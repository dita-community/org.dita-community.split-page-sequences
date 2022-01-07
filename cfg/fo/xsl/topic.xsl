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
    
    <xsl:variable name="doDebug" as="xs:boolean" select="$doDebug or true()"/>
    
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
  

  <xsl:function name="sps:getPageSequenceData" as="map(*)?">
    <xsl:param name="context" as="element()"/>
    
    <xsl:variable name="outputclassValue" as="xs:string?"
      select="
      if (exists($context/@outputclass))
      then string($context/@outputclass)
      else key('map-id', $context/@id, root($context))[1]/@outputclass
      "
    />
    
    <xsl:variable name="page-sequence-token" as="xs:string?"
      select="tokenize($outputclassValue, ' ')[matches(., '^page-sequence(-|_)')][1]"
    />
    <!-- Token is one of:
         
         page-sequence_{layoutname}
         page-sequence-start_{layoutname}
         page-sequence-end_{layoutname}
      -->
    <xsl:variable name="result" as="map(*)?">
      <xsl:if test="exists($page-sequence-token)">
        <xsl:variable name="page-sequence-control-token" as="xs:string"
          select="tokenize($page-sequence-token, '_')[1]"
        />        
        <xsl:variable name="layoutName" as="xs:string?" select="tokenize($page-sequence-token, '_')[2]"/>
        <xsl:variable name="startEnd" as="xs:string?" select="tokenize($page-sequence-control-token, '-')[3]"/>
        <xsl:choose>
          <xsl:when test="empty($layoutName)">
          <xsl:message expand-text="yes">- [WARN] split page sequences: @outputclass token "{$page-sequence-token}" on element {name($context)} does not specify a page layout name. Should be "{$page-sequence-token}_layoutname" </xsl:message>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="exists($startEnd) and not($startEnd = ('start', 'end'))">
                <xsl:message expand-text="yes">- [WARN] split page sequences: @outputclass token "{$page-sequence-token}" on element {name($context)} is not a recognized page-sequence control value.
      Expected "-start" or "-end", found "-{$startEnd}".            
                </xsl:message>
              </xsl:when>
              <xsl:otherwise>
                <xsl:map>
                  <xsl:map-entry key="'start'" select="$startEnd eq 'start' or empty($startEnd)"/>
                  <xsl:map-entry key="'end'" select="$startEnd eq 'end' or empty($startEnd)"/>
                  <xsl:map-entry key="'layout'" select="$layoutName"/>
                </xsl:map>            
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
    </xsl:variable>
    
    <xsl:sequence select="$result"/>
  </xsl:function>
</xsl:stylesheet>