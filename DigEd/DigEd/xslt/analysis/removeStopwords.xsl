<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="text" omit-xml-declaration="yes" encoding="UTF-8"/>
    
    <!-- thanks to Martin Honnen, http://stackoverflow.com/questions/22857615/xslt-how-to-remove-certain-words-and-join-the-rest-using-or -->
        
    <xsl:param name="stop-words" select="document('stopwords2.xml')/stopwords/wd"/>
        
        <xsl:param name="rep" select="' '"/>
        
        <xsl:variable name="regex" 
            select="concat('(^|\W)(', string-join($stop-words, '|'), ')', '(\W(', string-join($stop-words, '|'), '))*($|\W)')"/>
    
    
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:teiHeader"/>
    
    <xsl:template match="node()">
        <xsl:text>
        </xsl:text>
        <xsl:apply-templates/>
        <xsl:text>
        </xsl:text>
    </xsl:template>
        
        <xsl:template match="text()">
            <xsl:analyze-string select="." regex="{$regex}" flags="i">
                <xsl:matching-substring>
                    <xsl:value-of select="concat(regex-group(1), $rep, regex-group(5))"/>
                </xsl:matching-substring>
                <xsl:non-matching-substring>
                    <xsl:value-of select="normalize-space(.)"/>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
        </xsl:template>
        
    
    
</xsl:stylesheet>