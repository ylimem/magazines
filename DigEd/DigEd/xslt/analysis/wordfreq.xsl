<?xml version="1.0" encoding="UTF-8"?>

<!-- Stylesheet from Michael Kay, _XPATH 2.0_, 2004, pp. 14-15 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="no" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="/">
        <xsl:apply-templates select="tei:TEI"/>
    </xsl:template>
    
    <xsl:template match="tei:TEI">
        <xsl:apply-templates select="tei:text"/>
    </xsl:template>
    
    <xsl:template match="tei:text">
        <wordcount>
            <xsl:for-each-group group-by="." select="
                for $w in tokenize(string(.), '\W+') return lower-case($w)">
                <xsl:sort select="count(current-group())" order="descending"/>
                <word word="{current-grouping-key()}" 
                    frequency="{count(current-group())}"/>
            </xsl:for-each-group>
        </wordcount>
    </xsl:template>
    
</xsl:stylesheet>