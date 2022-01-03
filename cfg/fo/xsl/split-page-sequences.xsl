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
       Mode to split a single page sequence into multiple page
       sequences based on the presence of 
       dita-ot:page-sequence-start/dita-ot:page-sequence-end 
       markers anywhere within the flow.
       
       See https://markmail.org/message/kmq2g4fidmw6cofz
       ============================================================== -->
  
  <xsl:template mode="sps:split-page-sequences" match="fo:page-sequence">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
    
    <xsl:if test="$doDebug">
      <xsl:message>+ [DEBUG] split-page-sequences: Starting...</xsl:message>
    </xsl:if>
    
    <xsl:variable name="original-page-sequence" as="element(fo:page-sequence)" select="."/>
    <xsl:variable name="static-content" as="element(fo:static-content)*"
      select="fo:static-content"
    />
    
    <xsl:variable name="split-flow" as="document-node()">
      <xsl:document>
        <xsl:for-each-group 
          select="descendant::fo:block[empty(.//fo:block | .//fo:table)] | 
          descendant::fo:table |
          descendant::dita-ot:page-sequence-start |
          descendant::dita-ot:page-sequence-end"
          group-starting-with="dita-ot:page-sequence-start">
          <xsl:if test="$doDebug">
            <xsl:message>+ [DEBUG] split-page-sequences: group [<xsl:value-of select="position()"/>] Context element is <xsl:value-of select="name(.)"/>]</xsl:message>
          </xsl:if>
          <xsl:variable name="group-number" as="xs:integer" select="position()"/>
          <xsl:variable name="page-sequence-master" as="xs:string"
            select="
            if (self::dita-ot:page-sequence-start)
            then string(@page-sequence-master)
            else $original-page-sequence/@master-reference"/>
          <xsl:if test="$doDebug">
            <xsl:message>+ [DEBUG] split-page-sequences:   page-sequence-master="<xsl:value-of select="$page-sequence-master"/>"</xsl:message>
          </xsl:if>
          
          <xsl:apply-templates select="$original-page-sequence/fo:flow" mode="sps:split-flow">
            <xsl:with-param name="doDebug" as="xs:boolean" tunnel="yes" select="$doDebug"/>
            <xsl:with-param name="restricted-to" as="node()*"
              select="current-group()/ancestor-or-self::node()"
              tunnel="yes"/>
            <xsl:with-param name="page-sequence-start" as="xs:boolean"
              tunnel="yes"
              select="exists(self::dita-ot:page-sequence-start)"
            />        
            <xsl:with-param name="page-sequence-master" as="xs:string" tunnel="yes" select="$page-sequence-master"/>
            <xsl:with-param name="group-number" as="xs:integer" tunnel="yes" select="$group-number"/>
          </xsl:apply-templates>
        </xsl:for-each-group>      
      </xsl:document>
    </xsl:variable>
    
    <!-- Filter out duplicate IDs: -->
    <xsl:variable name="flows-filtered" as="element(fo:flow)*">
      <xsl:apply-templates select="$split-flow/*" mode="sps:filter-ids">
        <xsl:with-param name="doDebug" as="xs:boolean" tunnel="yes" select="$doDebug"/>
      </xsl:apply-templates>      
    </xsl:variable>
    
    <!-- Now reconsitute the page sequences. -->
    
    <!-- First page sequence will always reflect the original -->
    <xsl:element name="{name($original-page-sequence)}">
      <xsl:sequence select="$original-page-sequence/@*"/>
      <xsl:sequence select="$static-content"/>
      <xsl:sequence select="$flows-filtered[1]"></xsl:sequence>
    </xsl:element>
    
    <xsl:for-each select="$flows-filtered[position() gt 1]">
      <xsl:variable name="page-sequence-master" as="xs:string?"
        select="./fo:block[1]/@page-sequence-master"
      />
      <xsl:choose>
        <xsl:when test="exists($page-sequence-master)">
          <fo:page-sequence master-reference="{$page-sequence-master}-pages">
            <xsl:apply-templates mode="sps:construct-static-content-for-page-sequence"
              select="$original-page-sequence">
              <xsl:with-param name="page-sequence-master" as="xs:string" tunnel="yes" select="$page-sequence-master"/>
            </xsl:apply-templates>
            <xsl:apply-templates select="." mode="sps:filter-bad-attributes">
              <xsl:with-param name="doDebug" as="xs:boolean" tunnel="yes" select="$doDebug"/>
            </xsl:apply-templates>
          </fo:page-sequence>
        </xsl:when>
        <xsl:otherwise>
          <xsl:element name="{name($original-page-sequence)}">
            <xsl:sequence select="$original-page-sequence/@* except ($original-page-sequence/@initial-page-number)"/>
            <xsl:sequence select="$static-content"/>
            <xsl:sequence select="."/>
          </xsl:element>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    
    <xsl:if test="$doDebug">
      <xsl:message>+ [DEBUG] split-page-sequences: Done...</xsl:message>
    </xsl:if>
    
  </xsl:template>
  
  <!-- Leaf blocks and tables will never split across page sequences -->
  <xsl:template match="fo:block[empty(.//fo:block | .//fo:table)] | fo:table" mode="sps:split-flow" priority="2">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>    
    <xsl:param name="restricted-to" as="node()+" tunnel="yes"/>
    
    <xsl:if test="exists(. intersect $restricted-to)">
      <xsl:sequence select="."/>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="node()" mode="sps:split-flow" priority="1">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>    
    <xsl:param name="restricted-to" as="node()+" tunnel="yes"/>
    
    <xsl:if test="exists(. intersect $restricted-to)">
      <xsl:next-match/>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="node() | @*" mode="sps:split-flow">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>    
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" mode="#current"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="fo:block[empty(ancestor::fo:block)] | fo:table" mode="sps:split-flow">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>    
    <xsl:param name="restricted-to" tunnel="yes" as="node()*"/>
    <xsl:param name="page-sequence-start" tunnel="yes" as="xs:boolean"/>
    <xsl:param name="page-sequence-master" as="xs:string" tunnel="yes"/>
    
    <xsl:if test="$doDebug">
      <xsl:message>+ [DEBUG] split: root fo:block. page-sequence-master="<xsl:value-of select="$page-sequence-master"/>"</xsl:message>
      <xsl:message>+ [DEBUG] split:   page-sequence-start="<xsl:value-of select="$page-sequence-start"/>"</xsl:message>
    </xsl:if>
    
    <xsl:copy>
      <xsl:apply-templates select="@*" mode="#current"/>
      <xsl:if test="$page-sequence-start">
        <xsl:attribute name="page-sequence-master" select="$page-sequence-master"/>                
      </xsl:if>
      <xsl:apply-templates mode="#current"/>
    </xsl:copy>
  </xsl:template>  
  
  <xsl:template mode="sps:split-flow" 
    match="dita-ot:page-sequence-start | 
           dita-ot:page-sequence-end">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
  </xsl:template>
  
  <xsl:template mode="sps:filter-bad-attributes" match="*[.//fo:block[@page-sequence-master]]">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
    
    <xsl:copy>
      <xsl:sequence select="@*"/>
      <xsl:apply-templates mode="#current">
        <xsl:with-param name="doDebug" as="xs:boolean" tunnel="yes" select="$doDebug"/>
      </xsl:apply-templates>
    </xsl:copy>
    
  </xsl:template>

  <xsl:template mode="sps:filter-bad-attributes" match="fo:block[@page-sequence-master]">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
    
    <xsl:copy>
      <xsl:sequence select="@* except (@page-sequence-master)"/>
      <xsl:sequence select="node()"/>
    </xsl:copy>
    
  </xsl:template>
  
  <xsl:template mode="sps:filter-bad-attributes" match="node()" priority="-1">
    <xsl:sequence select="."/>
  </xsl:template>
  
  <!-- ===============================================================
       Mode sps:construct-static-content-for-page-sequence
       
       Constructs the static content for a page sequence.
       
       By default just copies the static content from the original
       page sequence.
       
       Override this template to do something different.
       
       =============================================================== -->
  
  <xsl:template mode="sps:construct-static-content-for-page-sequence" match="fo:page-sequence">
    <xsl:param name="page-sequence-master" as="xs:string" tunnel="yes"/>
    
    <xsl:copy-of select="fo:static-content" copy-namespaces="no"/>
    
  </xsl:template>
  
</xsl:stylesheet>