<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs tei" version="2.0">

	<xsl:output omit-xml-declaration="yes" method="text" encoding="UTF-8" indent="yes"/>
	<xsl:strip-space elements="*"/>

	<xsl:variable name="return">
		<xsl:text>	
		</xsl:text>
	</xsl:variable>

<!--  Laura's code from Class 2
	  =========================
	<xsl:template match="list">
		<xsl:for-each select="item">
			<xsl:apply-templates select="document(@code)/tei:TEI"/>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="tei:TEI">
		<xsl:result-document>
			<xsl:apply-templates select="tei:text"/>
		</xsl:result-document>
	</xsl:template>
-->
	
<!-- Matt's new code for Class 3 -->
	<xsl:template match="list">
		<xsl:for-each select="item">
			<xsl:variable name="dir" select="@dir"/>
			<xsl:for-each select="collection(iri-to-uri(concat(@dir, '?select=*.xml')))">  
															<!-- use '?select=*.xml;recurse=yes' for multiple folder structure-->
				<xsl:variable name="outpath"
					select="concat($dir, substring-before(tokenize(document-uri(.), '/')[last()], '.xml'))"/>
				<xsl:result-document href="{concat($outpath, '.txt')}">
					<xsl:apply-templates select="tei:TEI/tei:text"/>
				</xsl:result-document>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>


	<!-- second part -->

	<xsl:template match="tei:head">
		<xsl:value-of select="$return"/>
		<xsl:apply-templates/>
		<xsl:value-of select="$return"/>
	</xsl:template>

	<xsl:template match="tei:title">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="tei:byline">
		<xsl:value-of select="$return"/>
		<xsl:apply-templates/>
		<xsl:value-of select="$return"/>
	</xsl:template>

	<xsl:template match="tei:lg">
		<xsl:value-of select="$return"/>
		<xsl:value-of select="$return"/>
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="tei:l">
		<xsl:value-of select="$return"/>
		<xsl:apply-templates/>
	</xsl:template>

</xsl:stylesheet>
