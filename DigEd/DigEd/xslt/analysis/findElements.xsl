<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:key name="elements" match="tei:TEI/tei:text//*" use="name()"/>
    
    <xsl:template match="/">
        <elements>
        <xsl:for-each 
            select="//*[generate-id(.)=generate-id(key('elements',name())[1])]">
            <xsl:sort select="name()"/>
            <xsl:for-each select="key('elements', name())">
                <xsl:if test="position()=1">
                    <xsl:copy>
                    <xsl:apply-templates select="node()"/>
                    </xsl:copy>
                </xsl:if>
            </xsl:for-each>
        </xsl:for-each>
        </elements>
    </xsl:template>

    <xsl:template match="text()"/>
    
</xsl:stylesheet>