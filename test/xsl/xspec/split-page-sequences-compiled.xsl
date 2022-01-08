<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="#all"
                version="3.0">
   <!-- the tested stylesheet -->
   <xsl:import href="file:/Users/ekimber/workspace/dometic/toolkit-plugins/org.dita-community.split-page-sequences/test/xsl/test-split-page-sequences.xsl"/>
   <!-- XSpec library modules providing tools -->
   <xsl:include href="file:/Applications/Oxygen%20XML%20Editor/frameworks/xspec/src/common/runtime-utils.xsl"/>
   <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}stylesheet-uri"
                 as="Q{http://www.w3.org/2001/XMLSchema}anyURI">file:/Users/ekimber/workspace/dometic/toolkit-plugins/org.dita-community.split-page-sequences/test/xsl/test-split-page-sequences.xsl</xsl:variable>
   <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}xspec-uri"
                 as="Q{http://www.w3.org/2001/XMLSchema}anyURI">file:/Users/ekimber/workspace/dometic/toolkit-plugins/org.dita-community.split-page-sequences/test/xsl/split-page-sequences.xspec</xsl:variable>
   <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}is-external"
                 as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                 select="false()"/>
   <!-- the main template to run the suite -->
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}main"
                 as="empty-sequence()">
      <xsl:context-item use="absent"/>
      <!-- info message -->
      <xsl:message>
         <xsl:text>Testing with </xsl:text>
         <xsl:value-of select="system-property('Q{http://www.w3.org/1999/XSL/Transform}product-name')"/>
         <xsl:text> </xsl:text>
         <xsl:value-of select="system-property('Q{http://www.w3.org/1999/XSL/Transform}product-version')"/>
      </xsl:message>
      <!-- set up the result document (the report) -->
      <xsl:result-document format="Q{{http://www.jenitennison.com/xslt/xspec}}xml-report-serialization-parameters">
         <xsl:element name="report" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:attribute name="xspec" namespace="">file:/Users/ekimber/workspace/dometic/toolkit-plugins/org.dita-community.split-page-sequences/test/xsl/split-page-sequences.xspec</xsl:attribute>
            <xsl:attribute name="stylesheet" namespace="">file:/Users/ekimber/workspace/dometic/toolkit-plugins/org.dita-community.split-page-sequences/test/xsl/test-split-page-sequences.xsl</xsl:attribute>
            <xsl:attribute name="date" namespace="" select="current-dateTime()"/>
            <!-- invoke each compiled top-level x:scenario -->
            <xsl:for-each select="1 to 4">
               <xsl:choose>
                  <xsl:when test=". eq 1">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario1"/>
                  </xsl:when>
                  <xsl:when test=". eq 2">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario2"/>
                  </xsl:when>
                  <xsl:when test=". eq 3">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario3"/>
                  </xsl:when>
                  <xsl:when test=". eq 4">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario4"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:for-each>
         </xsl:element>
      </xsl:result-document>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>Split page sequences split on topics within a chapter</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario1</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/Users/ekimber/workspace/dometic/toolkit-plugins/org.dita-community.split-page-sequences/test/xsl/split-page-sequences.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Split page sequences split on topics within a chapter</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="sps">urn:ns:dita-community:split-page-sequences</xsl:namespace>
               <xsl:attribute name="as" namespace="">element()</xsl:attribute>
               <xsl:attribute name="href" namespace="">file:/Users/ekimber/workspace/dometic/toolkit-plugins/org.dita-community.split-page-sequences/test/resources/xsl-fo/input/base-fo-good-markers.fo</xsl:attribute>
               <xsl:attribute name="select" namespace="">/*</xsl:attribute>
               <xsl:attribute name="mode" namespace="">sps:split-page-sequences</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d55e0-doc"
                       as="document-node()"
                       select="doc('file:/Users/ekimber/workspace/dometic/toolkit-plugins/org.dita-community.split-page-sequences/test/resources/xsl-fo/input/base-fo-good-markers.fo')"/>
         <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                       xmlns:sps="urn:ns:dita-community:split-page-sequences"
                       name="Q{urn:x-xspec:compile:impl}context-d55e0"
                       as="element()"
                       select="$Q{urn:x-xspec:compile:impl}context-d55e0-doc ! ( /* )"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       select="$Q{urn:x-xspec:compile:impl}context-d55e0"/>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:apply-templates select="$Q{urn:x-xspec:compile:impl}context-d55e0"
                                 mode="Q{urn:ns:dita-community:split-page-sequences}split-page-sequences"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario1-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario1-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>Result pages sequences are as they should be.</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d53e4-doc"
                    as="document-node()"
                    select="doc('file:/Users/ekimber/workspace/dometic/toolkit-plugins/org.dita-community.split-page-sequences/test/resources/xsl-fo/expected/result-fo-splitting_expected.fo')"/>
      <xsl:variable xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    xmlns:sps="urn:ns:dita-community:split-page-sequences"
                    name="Q{urn:x-xspec:compile:impl}expect-d53e4"
                    select="$Q{urn:x-xspec:compile:impl}expect-d53e4-doc ! ( /* )"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d53e4, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario1-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Result pages sequences are as they should be.</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d53e4"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario2"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>PENDING: (Testing splitting) Split page sequences no split to be done</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario2</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/Users/ekimber/workspace/dometic/toolkit-plugins/org.dita-community.split-page-sequences/test/xsl/split-page-sequences.xspec</xsl:attribute>
         <xsl:attribute name="pending" namespace="">Testing splitting</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Split page sequences no split to be done</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="sps">urn:ns:dita-community:split-page-sequences</xsl:namespace>
               <xsl:attribute name="as" namespace="">element()</xsl:attribute>
               <xsl:attribute name="href" namespace="">file:/Users/ekimber/workspace/dometic/toolkit-plugins/org.dita-community.split-page-sequences/test/resources/xsl-fo/input/base-fo-no-markers.fo</xsl:attribute>
               <xsl:attribute name="select" namespace="">/*</xsl:attribute>
               <xsl:attribute name="mode" namespace="">sps:split-page-sequences</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario2-expect1"/>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario2-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:message>PENDING: (Testing splitting) Result should match input</xsl:message>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario2-expect1</xsl:attribute>
         <xsl:attribute name="pending" namespace="">Testing splitting</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Result should match input</xsl:text>
         </xsl:element>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario3"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>PENDING: (Testing splitting) Test sps:getPageSequenceData</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario3</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/Users/ekimber/workspace/dometic/toolkit-plugins/org.dita-community.split-page-sequences/test/xsl/split-page-sequences.xspec</xsl:attribute>
         <xsl:attribute name="pending" namespace="">Testing splitting</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Test sps:getPageSequenceData</xsl:text>
         </xsl:element>
         <xsl:for-each select="1 to 3">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario3-scenario1"/>
               </xsl:when>
               <xsl:when test=". eq 2">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario3-scenario2"/>
               </xsl:when>
               <xsl:when test=". eq 3">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario3-scenario3"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario3-scenario1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>PENDING: (Testing splitting) ..Test Page Sequence No start/end</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario3-scenario1</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/Users/ekimber/workspace/dometic/toolkit-plugins/org.dita-community.split-page-sequences/test/xsl/split-page-sequences.xspec</xsl:attribute>
         <xsl:attribute name="pending" namespace="">Testing splitting</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Test Page Sequence No start/end</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="sps">urn:ns:dita-community:split-page-sequences</xsl:namespace>
               <xsl:attribute name="function" namespace="">sps:getPageSequenceData</xsl:attribute>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:namespace name="sps">urn:ns:dita-community:split-page-sequences</xsl:namespace>
                  <xsl:attribute name="as" namespace="">element()</xsl:attribute>
                  <xsl:attribute name="name" namespace="">context</xsl:attribute>
                  <xsl:element name="topic" namespace="">
                     <xsl:namespace name="sps">urn:ns:dita-community:split-page-sequences</xsl:namespace>
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    xmlns:sps="urn:ns:dita-community:split-page-sequences"
                                    name="outputclass"
                                    namespace=""
                                    select="'', ''"
                                    separator="foo page-sequence_landscape-pages"/>
                  </xsl:element>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario3-scenario1-expect1"/>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario3-scenario1-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:message>PENDING: (Testing splitting) Expected map with true/true/landscape-pages</xsl:message>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario3-scenario1-expect1</xsl:attribute>
         <xsl:attribute name="pending" namespace="">Testing splitting</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Expected map with true/true/landscape-pages</xsl:text>
         </xsl:element>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario3-scenario2"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>PENDING: (Testing splitting) ..Test Page Sequence start</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario3-scenario2</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/Users/ekimber/workspace/dometic/toolkit-plugins/org.dita-community.split-page-sequences/test/xsl/split-page-sequences.xspec</xsl:attribute>
         <xsl:attribute name="pending" namespace="">Testing splitting</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Test Page Sequence start</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="sps">urn:ns:dita-community:split-page-sequences</xsl:namespace>
               <xsl:attribute name="function" namespace="">sps:getPageSequenceData</xsl:attribute>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:namespace name="sps">urn:ns:dita-community:split-page-sequences</xsl:namespace>
                  <xsl:attribute name="as" namespace="">element()</xsl:attribute>
                  <xsl:attribute name="name" namespace="">context</xsl:attribute>
                  <xsl:element name="topic" namespace="">
                     <xsl:namespace name="sps">urn:ns:dita-community:split-page-sequences</xsl:namespace>
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    xmlns:sps="urn:ns:dita-community:split-page-sequences"
                                    name="outputclass"
                                    namespace=""
                                    select="'', ''"
                                    separator="foo page-sequence-start_landscape-pages"/>
                  </xsl:element>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario3-scenario2-expect1"/>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario3-scenario2-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:message>PENDING: (Testing splitting) Expected map with start true, end false</xsl:message>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario3-scenario2-expect1</xsl:attribute>
         <xsl:attribute name="pending" namespace="">Testing splitting</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Expected map with start true, end false</xsl:text>
         </xsl:element>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario3-scenario3"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>PENDING: (Testing splitting) ..Test Page Sequence end</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario3-scenario3</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/Users/ekimber/workspace/dometic/toolkit-plugins/org.dita-community.split-page-sequences/test/xsl/split-page-sequences.xspec</xsl:attribute>
         <xsl:attribute name="pending" namespace="">Testing splitting</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Test Page Sequence end</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="sps">urn:ns:dita-community:split-page-sequences</xsl:namespace>
               <xsl:attribute name="function" namespace="">sps:getPageSequenceData</xsl:attribute>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:namespace name="sps">urn:ns:dita-community:split-page-sequences</xsl:namespace>
                  <xsl:attribute name="as" namespace="">element()</xsl:attribute>
                  <xsl:attribute name="name" namespace="">context</xsl:attribute>
                  <xsl:element name="topic" namespace="">
                     <xsl:namespace name="sps">urn:ns:dita-community:split-page-sequences</xsl:namespace>
                     <xsl:namespace name="x">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:x="http://www.jenitennison.com/xslt/xspec"
                                    xmlns:sps="urn:ns:dita-community:split-page-sequences"
                                    name="outputclass"
                                    namespace=""
                                    select="'', ''"
                                    separator="foo page-sequence-end_landscape-pages"/>
                  </xsl:element>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario3-scenario3-expect1"/>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario3-scenario3-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:message>PENDING: (Testing splitting) Expected map with start false, end true</xsl:message>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario3-scenario3-expect1</xsl:attribute>
         <xsl:attribute name="pending" namespace="">Testing splitting</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Expected map with start false, end true</xsl:text>
         </xsl:element>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario4"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>PENDING: (Testing splitting) Test error checking</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario4</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/Users/ekimber/workspace/dometic/toolkit-plugins/org.dita-community.split-page-sequences/test/xsl/split-page-sequences.xspec</xsl:attribute>
         <xsl:attribute name="pending" namespace="">Testing splitting</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Test error checking</xsl:text>
         </xsl:element>
         <xsl:for-each select="1 to 4">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario4-scenario1"/>
               </xsl:when>
               <xsl:when test=". eq 2">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario4-scenario2"/>
               </xsl:when>
               <xsl:when test=". eq 3">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario4-scenario3"/>
               </xsl:when>
               <xsl:when test=". eq 4">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario4-scenario4"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario4-scenario1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>PENDING: (Testing splitting) ..Good input with markers</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario4-scenario1</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/Users/ekimber/workspace/dometic/toolkit-plugins/org.dita-community.split-page-sequences/test/xsl/split-page-sequences.xspec</xsl:attribute>
         <xsl:attribute name="pending" namespace="">Testing splitting</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Good input with markers</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="sps">urn:ns:dita-community:split-page-sequences</xsl:namespace>
               <xsl:attribute name="function" namespace="">sps:isMarkersPaired</xsl:attribute>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:namespace name="sps">urn:ns:dita-community:split-page-sequences</xsl:namespace>
                  <xsl:attribute name="name" namespace="">context</xsl:attribute>
                  <xsl:attribute name="href" namespace="">file:/Users/ekimber/workspace/dometic/toolkit-plugins/org.dita-community.split-page-sequences/test/resources/xsl-fo/input/base-fo-good-markers.fo</xsl:attribute>
                  <xsl:attribute name="select" namespace="">/*</xsl:attribute>
                  <xsl:attribute name="as" namespace="">element()</xsl:attribute>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario4-scenario1-expect1"/>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario4-scenario1-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:message>PENDING: (Testing splitting) Expected true value</xsl:message>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario4-scenario1-expect1</xsl:attribute>
         <xsl:attribute name="pending" namespace="">Testing splitting</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Expected true value</xsl:text>
         </xsl:element>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario4-scenario2"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>PENDING: (Testing splitting) ..Good input without markers</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario4-scenario2</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/Users/ekimber/workspace/dometic/toolkit-plugins/org.dita-community.split-page-sequences/test/xsl/split-page-sequences.xspec</xsl:attribute>
         <xsl:attribute name="pending" namespace="">Testing splitting</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Good input without markers</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="sps">urn:ns:dita-community:split-page-sequences</xsl:namespace>
               <xsl:attribute name="function" namespace="">sps:isMarkersPaired</xsl:attribute>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:namespace name="sps">urn:ns:dita-community:split-page-sequences</xsl:namespace>
                  <xsl:attribute name="name" namespace="">context</xsl:attribute>
                  <xsl:attribute name="href" namespace="">file:/Users/ekimber/workspace/dometic/toolkit-plugins/org.dita-community.split-page-sequences/test/resources/xsl-fo/input/base-fo-no-markers.fo</xsl:attribute>
                  <xsl:attribute name="select" namespace="">/*</xsl:attribute>
                  <xsl:attribute name="as" namespace="">element()</xsl:attribute>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario4-scenario2-expect1"/>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario4-scenario2-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:message>PENDING: (Testing splitting) Expected true value</xsl:message>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario4-scenario2-expect1</xsl:attribute>
         <xsl:attribute name="pending" namespace="">Testing splitting</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Expected true value</xsl:text>
         </xsl:element>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario4-scenario3"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>PENDING: (Testing splitting) ..Not paired</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario4-scenario3</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/Users/ekimber/workspace/dometic/toolkit-plugins/org.dita-community.split-page-sequences/test/xsl/split-page-sequences.xspec</xsl:attribute>
         <xsl:attribute name="pending" namespace="">Testing splitting</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Not paired</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="sps">urn:ns:dita-community:split-page-sequences</xsl:namespace>
               <xsl:attribute name="function" namespace="">sps:isMarkersPaired</xsl:attribute>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:namespace name="sps">urn:ns:dita-community:split-page-sequences</xsl:namespace>
                  <xsl:attribute name="name" namespace="">context</xsl:attribute>
                  <xsl:attribute name="href" namespace="">file:/Users/ekimber/workspace/dometic/toolkit-plugins/org.dita-community.split-page-sequences/test/resources/xsl-fo/input/base-fo-mismatched-markers.fo</xsl:attribute>
                  <xsl:attribute name="select" namespace="">/*</xsl:attribute>
                  <xsl:attribute name="as" namespace="">element()</xsl:attribute>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario4-scenario3-expect1"/>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario4-scenario3-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:message>PENDING: (Testing splitting) Expected false value</xsl:message>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario4-scenario3-expect1</xsl:attribute>
         <xsl:attribute name="pending" namespace="">Testing splitting</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Expected false value</xsl:text>
         </xsl:element>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario4-scenario4"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>PENDING: (Testing splitting) ..Mismatched</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario4-scenario4</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/Users/ekimber/workspace/dometic/toolkit-plugins/org.dita-community.split-page-sequences/test/xsl/split-page-sequences.xspec</xsl:attribute>
         <xsl:attribute name="pending" namespace="">Testing splitting</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Mismatched</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="sps">urn:ns:dita-community:split-page-sequences</xsl:namespace>
               <xsl:attribute name="function" namespace="">sps:findUnmatchedMarkers</xsl:attribute>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:namespace name="sps">urn:ns:dita-community:split-page-sequences</xsl:namespace>
                  <xsl:attribute name="name" namespace="">context</xsl:attribute>
                  <xsl:attribute name="href" namespace="">file:/Users/ekimber/workspace/dometic/toolkit-plugins/org.dita-community.split-page-sequences/test/resources/xsl-fo/input/base-fo-mismatched-markers.fo</xsl:attribute>
                  <xsl:attribute name="select" namespace="">/*</xsl:attribute>
                  <xsl:attribute name="as" namespace="">element()</xsl:attribute>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario4-scenario4-expect1"/>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario4-scenario4-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:message>PENDING: (Testing splitting) Expected two unmatched items</xsl:message>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario4-scenario4-expect1</xsl:attribute>
         <xsl:attribute name="pending" namespace="">Testing splitting</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Expected two unmatched items</xsl:text>
         </xsl:element>
      </xsl:element>
   </xsl:template>
</xsl:stylesheet>
