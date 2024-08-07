<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  xmlns:opentopic="http://www.idiominc.com/opentopic" 
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:local="urn:local-functions" 
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  xmlns:sps="urn:ns:dita-community:split-page-sequences"
  exclude-result-prefixes="xs xd opentopic local dita-ot sps" 
  expand-text="yes"
  version="3.0">
  <!-- ==============================================================
       Mode to split a single page sequence into multiple page
       sequences based on the presence of 
       sps:page-sequence-start/sps:page-sequence-end pairs 
       markers anywhere within the flow.
       
       See https://markmail.org/message/kmq2g4fidmw6cofz
       ============================================================== -->

  <xsl:mode name="sps:split-page-sequences"
    on-no-match="shallow-copy"
  />
  <xsl:mode name="sps:filter-out-page-sequence-markers"
    on-no-match="shallow-copy"
  />
  
  <xsl:template match="fo:root" mode="sps:split-page-sequences">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>

    <xsl:if test="$doDebug">
      <xsl:message expand-text="yes">+ [DEBUG] sps:split-page-sequences: Handling {name(.)}</xsl:message>
    </xsl:if>

    <!-- Verifiy that all start/end pairs match and bail on splitting if they do not -->
    
    <xsl:variable name="page-sequence-markers" as="element()*" select=".//sps:page-sequence-start | .//sps:page-sequence-end"/>
    
    <xsl:choose>
      <xsl:when test="exists($page-sequence-markers)">
        <xsl:variable name="isPaired" as="xs:boolean"
          select="sps:isMarkersPaired(.)"
        />
        <xsl:variable name="unmatched" as="map(*)*"
          select="sps:findUnmatchedMarkers(.)
          "
        />
        <xsl:if test="not($isPaired)">
          <xsl:message>- [WARN] Split page sequences: Did not find an equal number of page sequence start/end markers.</xsl:message>
        </xsl:if>
        <xsl:if test="exists($unmatched)">
          <xsl:message>- [WARN] Split page sequences: Have {count($unmatched)} unmatched start/end page sequence markers:</xsl:message>
          <xsl:for-each select="$unmatched">
            <xsl:message>- [WARN] Split page sequences:   <xsl:sequence select=".('end')"/>. Preceding marker is <xsl:sequence select=".('preceding')"/></xsl:message>              
          </xsl:for-each>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="not($isPaired) or exists($unmatched)">
            <xsl:message>- [WARN] Split page sequences: Cannot perform splitting.</xsl:message>
            <xsl:apply-templates select="." mode="sps:filter-out-page-sequence-markers">
              <xsl:with-param name="doDebug" as="xs:boolean" tunnel="yes" select="$doDebug"/>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:otherwise>
            <!-- All good -->
            <xsl:next-match/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <!-- No markers, just use what we were given as is -->
        <xsl:sequence select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template mode="sps:filter-out-page-sequence-markers" match="sps:*">
    <!-- Suppress -->
  </xsl:template>

  <xsl:template mode="sps:split-page-sequences" match="*" priority="-1">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
    
    <xsl:if test="$doDebug and false()">
      <xsl:message expand-text="yes">+ [DEBUG] sps:split-page-sequences: Fallbackk: Handling element {name(..)}/{name(.)}</xsl:message>
    </xsl:if>
    
    <xsl:copy>
      <xsl:apply-templates select="@*, node()" mode="#current"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template mode="sps:split-page-sequences" match="@* | processing-instruction() | comment() | text()">
    <xsl:copy-of select="."/>
  </xsl:template>
  
  <xsl:template mode="sps:split-page-sequences" match="fo:page-sequence[.//sps:page-sequence-start]">
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
          descendant::sps:page-sequence-start |
          descendant::sps:page-sequence-end"
          group-starting-with="sps:page-sequence-start | sps:page-sequence-end">
          <xsl:if test="$doDebug">
            <xsl:message>+ [DEBUG] split-page-sequences: group [{position()}] Context element is {name(.)}]</xsl:message>
          </xsl:if>
          <xsl:variable name="group-number" as="xs:integer" select="position()"/>
          <xsl:variable name="page-sequence-master" as="xs:string"
            select="
            if (self::sps:page-sequence-start)
            then string(@page-sequence-master)
            else $original-page-sequence/@master-reference"/>
          <xsl:if test="$doDebug">
            <xsl:message>+ [DEBUG] split-page-sequences:   page-sequence-master="{$page-sequence-master}"</xsl:message>
          </xsl:if>
          <xsl:if test="$doDebug">
            <xsl:message>+ [DEBUG] split-page-sequences:   Group count: {count(current-group())}</xsl:message>
          </xsl:if>
          
          <xsl:choose>
            <xsl:when test="count(current-group()) eq 1 and self::sps:page-sequence-end">
              <xsl:if test="$doDebug">
                <xsl:message>+ [DEBUG] split-page-sequences:   Ignoring group that is only a page sequence end.</xsl:message>
              </xsl:if>
              <!-- Ignore this -->              
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates select="$original-page-sequence/fo:flow" mode="sps:split-flow">
                <xsl:with-param name="doDebug" as="xs:boolean" tunnel="yes" select="$doDebug"/>
                <xsl:with-param name="restricted-to" as="node()*"
                  select="current-group()/ancestor-or-self::node()"
                  tunnel="yes"/>
                <xsl:with-param name="page-sequence-start" as="xs:boolean"
                  tunnel="yes"
                  select="exists(self::sps:page-sequence-start)"
                />        
                <xsl:with-param name="page-sequence-master" as="xs:string" tunnel="yes" select="$page-sequence-master"/>
                <xsl:with-param name="group-number" as="xs:integer" tunnel="yes" select="$group-number"/>
              </xsl:apply-templates>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each-group>      
      </xsl:document>
    </xsl:variable>
    
    <!-- Filter out duplicate IDs: -->
    <xsl:variable name="flows-filtered" as="element(fo:flow)*">
      <xsl:apply-templates select="$split-flow/*" mode="sps:filter-ids">
        <xsl:with-param name="doDebug" as="xs:boolean" tunnel="yes" select="$doDebug"/>
      </xsl:apply-templates>      
    </xsl:variable>
    
    <xsl:if test="$doDebug">
      <xsl:message>+ [DEBUG] split-page-sequences: flows-filtered:
<xsl:sequence select="
  for $node in $flows-filtered
  return '&#x0a; + ' || name($node) || ', page-sequence-master=' || $node/*[1]/@page-sequence-master 
  "/>        
      </xsl:message>      
    </xsl:if>
    
    <!-- Now reconsitute the page sequences. -->
    
    <!-- First page sequence will always reflect the original -->
    <xsl:element name="{name($original-page-sequence)}">
      <xsl:sequence select="$original-page-sequence/@*"/>
      <xsl:sequence select="$static-content"/>
      <xsl:sequence select="$flows-filtered[1]"></xsl:sequence>
    </xsl:element>
    
    <xsl:for-each select="$flows-filtered[position() != 1]">
      <xsl:variable name="page-sequence-master" as="xs:string?"
        select="./fo:block[1]/@page-sequence-master"
      />
      <xsl:if test="$doDebug">
        <xsl:message>+ [DEBUG] split-page-sequences: [{position()}] page-sequence-master="{$page-sequence-master}"</xsl:message>      
      </xsl:if>
      <xsl:choose>
        <xsl:when test="exists($page-sequence-master)">
          <xsl:if test="$doDebug">
            <xsl:message>+ [DEBUG] split-page-sequences:   Generating new page sequence with master name "{$page-sequence-master}"</xsl:message>      
          </xsl:if>
          <fo:page-sequence master-reference="{$page-sequence-master}">
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
          <xsl:if test="$doDebug">
            <xsl:message>+ [DEBUG] split-page-sequences:   No page sequence master name, using original page sequence name.</xsl:message>      
          </xsl:if>
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
    
    <xsl:if test="exists(. intersect $restricted-to) or ((self::text() or self::fo:inline) and exists(ancestor::fo:block[1] intersect $restricted-to))">
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
      <xsl:message>+ [DEBUG] split-flow: root fo:block. page-sequence-master="<xsl:value-of select="$page-sequence-master"/>"</xsl:message>
      <xsl:message>+ [DEBUG] split-flow:   page-sequence-start="<xsl:value-of select="$page-sequence-start"/>"</xsl:message>
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
    match="sps:page-sequence-start | 
           sps:page-sequence-end">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
    <xsl:if test="$doDebug">
      <xsl:message>+ [DEBUG] split-flow: Ignoring {name(.)}</xsl:message>
    </xsl:if>
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

    <xsl:if test="$doDebug">
      <xsl:message>+ [DEBUG] split-flow: {name(.)}/@page-sequence-master="{@page-sequence-master}"</xsl:message>
    </xsl:if>
    
    <xsl:copy>
      <xsl:sequence select="@* except (@page-sequence-master)"/>
      <xsl:sequence select="node()"/>
    </xsl:copy>
    
  </xsl:template>
  
  <xsl:template mode="sps:filter-bad-attributes" match="node()" priority="-1">
    <xsl:sequence select="."/>
  </xsl:template>
  
  <xsl:template mode="sps:filter-ids" match="@id" priority="10">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>    
    
    <xsl:variable name="first-with-id" as="element()"
      select="key('id', xs:string(.), root(.))[1]"
    />
    <xsl:if test=".. is $first-with-id">
      <xsl:sequence select="."/>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="node() | @*" mode="sps:filter-ids">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>    
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" mode="#current"/>
    </xsl:copy>
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
  
  <!--
    Determines if the markers in the FO document are properly paired.
    
    @param context fo:root element
    @return True if there are even numbers of start/end markers.
    -->
  <xsl:function name="sps:isMarkersPaired" as="xs:boolean">
    <xsl:param name="context" as="element(fo:root)"/>
    
    <xsl:variable name="result" as="xs:boolean"
      select="count($context//sps:page-sequence-start) eq count($context//sps:page-sequence-end)"
    />
    <xsl:sequence select="$result"/>
  </xsl:function>
  
  <!--
    Finds any unmatched markers
    @param context fo:root element
    @return List, possibly empty, of sps:page-sequence-end elements that are not matched with a page-sequence-start element.
    -->
  <xsl:function name="sps:findUnmatchedMarkers" as="map(*)*">
    <xsl:param name="context" as="element(fo:root)"/>
    <xsl:variable name="page-sequence-markers" as="element()*" 
      select="$context//sps:page-sequence-start | $context//sps:page-sequence-end"
    />
    <xsl:variable name="result"
      select="
    for $end in $page-sequence-markers/self::sps:page-sequence-end
    return
    let $preceding := $end/(preceding::sps:page-sequence-start|preceding::sps:page-sequence-end)[last()]
    return 
    if (exists($preceding/self::sps:page-sequence-start) and ($preceding/@page-sequence-master eq $end/@page-sequence-master))
    then ()
    else map{'end' : $end, 'preceding' : $preceding}
    "/>
    <xsl:sequence select="$result"/>
  </xsl:function>
</xsl:stylesheet>
