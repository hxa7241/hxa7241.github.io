<?xml version="1.0" encoding="UTF-8"?>


<!-- 
not quite finished...
(and its not completely good either)
	
it doesnt:
	* replace non basic character entities with simpler substitutes (needs modified entity definitions)
	* wrap and cut lines at a particular column (not sure how/whether do-able with xsl)
	* format note content perfectly always

but these can be done separately/manually (if doing <10 files):
	1. edit the xhtml entity dtd files to define substitutions for non basic characters
	2. run this xsl
	4. wrap and cut lines
		(textpad does this well because it retains indentation)
		(the lines of '-' around the title section are 70 chars wide)
	5. edit notes to suit

to do:
	* fix xsl for doing the notes
	* add xsl for wrapping and cutting lines (retaining indentation)
	  or, write external scripts for this
-->


<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xhtml="http://www.w3.org/1999/xhtml">
	
	<xsl:output method="text" encoding="UTF-8" media-type="text"/>
	
	<xsl:strip-space elements="*"/>

	
	<xsl:template match="xhtml:head"/>

	<xsl:template match="xhtml:div[@class='notes' or @class='paper' or @class='print']">
		<xsl:apply-templates/>
	</xsl:template>


	<!-- frontispiece -->
	<xsl:template match="xhtml:div[@class='frontispiece']">
		<xsl:text>&#x0A;----------------------------------------------------------------------&#x0A;&#x0A;    </xsl:text>
		<xsl:value-of select="translate(//xhtml:h1[@class='booktitle'], 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
		<xsl:text>&#x0A;&#x0A;        by        &#x0A;&#x0A;    </xsl:text>
		<xsl:value-of select="//xhtml:h2[@class='author']"/>
		<xsl:text>&#x0A;&#x0A;&#x0A;        *&#x0A;</xsl:text>
		
		<xsl:for-each select="xhtml:div[@class='motto']">
			<xsl:apply-templates/>
			<xsl:text>&#x0A;&#x0A;</xsl:text>
		</xsl:for-each>
		
		<xsl:text>        *&#x0A;&#x0A;        </xsl:text>
		<xsl:value-of select="//xhtml:div[@class='date']"/>
		<xsl:text>&#x0A;&#x0A;    </xsl:text>
		<xsl:value-of select="translate(//xhtml:div[@class='publisher'], '&#160;&#x09;&#x0A;', '  ')"/>
		<xsl:text>&#x0A;        </xsl:text>
		<xsl:value-of select="//xhtml:div[@class='publisherdate']"/>
		<xsl:text>&#x0A;&#x0A;----------------------------------------------------------------------&#x0A;&#x0A;&#x0A;&#x0A;</xsl:text>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='motto']">
		<xsl:apply-templates/>
	</xsl:template>


	<!-- colophon -->
	<xsl:template match="xhtml:div[@class='colophon']">
		<xsl:text>&#x0A;&#x0A;&#x0A;&#x0A;&#x0A;----------------------------------------------------------------------&#x0A;&#x0A;</xsl:text>
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='colophon']//xhtml:a">
		<xsl:value-of select="@href"/>
		<xsl:text>&#x0A;</xsl:text>
	</xsl:template>


	<!-- contents -->
	<xsl:template match="xhtml:div[@class='contents']">
		<xsl:text>&#x0A;    CONTENTS&#x0A;&#x0A;</xsl:text>
		<xsl:apply-templates select="xhtml:ul"/>
		<xsl:text>&#x0A;&#x0A;&#x0A;&#x0A;&#x0A;</xsl:text>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='contents']//xhtml:li">
		<xsl:text>    </xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#x0A;</xsl:text>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='contents']//xhtml:a">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='pagelinks']"/>


	<!-- chapter -->
	<xsl:template match="xhtml:div[@class='chapter']">
		<xsl:apply-templates/>
		<xsl:text>&#x0A;&#x0A;&#x0A;&#x0A;</xsl:text>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='chapter']//xhtml:h2">
		<xsl:text>    CHAPTER </xsl:text>
		<xsl:number count="xhtml:div[@class='chapter']" format="1"/>
		<xsl:text>&#x0A;&#x0A;</xsl:text>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='chapter']//xhtml:h3[1][string-length(@class)=0]">
		<xsl:text>    </xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#x0A;&#x0A;</xsl:text>
	</xsl:template>

	<xsl:template match="xhtml:h3[@class='chapterend']">
		<xsl:text>    -&lt;&gt;-&#x0A;</xsl:text>
	</xsl:template>

	<xsl:template match="xhtml:h3[@class='theend']">
		<xsl:text>&#x0A;    THE END</xsl:text>
	</xsl:template>


	<!-- page -->
	<xsl:template match="xhtml:div[@class='page']">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='pagenumber']"/>

	<!-- if pages are wanted, use these instead -->
	<!--<xsl:template match="xhtml:div[@class='page']">
		<xsl:apply-templates/>
		<xsl:text>&#x0A;&#x0A;</xsl:text>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='pagenumber']">
		<xsl:text>                                                                  </xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#x0A;&#x0A;</xsl:text>
	</xsl:template>-->


	<!-- text -->
	<xsl:template match="xhtml:div[@class='original' or @class='translation']">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='attribution']">
		<xsl:text>    </xsl:text>
		<xsl:if test="ancestor::xhtml:div/ancestor::xhtml:li">
			<xsl:text>    </xsl:text>
		</xsl:if>
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='break']">
		<xsl:text>    *&#x0A;&#x0A;</xsl:text>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='speech' or @class='song']">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='speaker']">
		<xsl:apply-templates/>
		<xsl:text>&#x0A;</xsl:text>
	</xsl:template>

	<xsl:template match="xhtml:h4[@class='songtitle']">
		<xsl:text>        </xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#x0A;&#x0A;</xsl:text>
	</xsl:template>

	<xsl:template match="xhtml:p[@class='songdirection']">
		<xsl:text>        </xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#x0A;&#x0A;</xsl:text>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='letter']/xhtml:p">
		<xsl:text>    </xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#x0A;</xsl:text>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='signatory']">
		<xsl:text>&#x0A;    </xsl:text>
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='ps']">
		<xsl:text>&#x0A;&#x0A;    </xsl:text>
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='ps']/xhtml:p">
		<xsl:apply-templates/>
		<xsl:text>&#x0A;</xsl:text>
	</xsl:template>

	<xsl:template match="xhtml:a">
		<xsl:apply-templates/>
		<xsl:text> {</xsl:text>
		<xsl:value-of select="substring(@href, 2)"/>
		<xsl:text>}</xsl:text>
	</xsl:template>

	<xsl:template match="xhtml:span[@class='marker']"/>


	<!-- notes -->
	<xsl:template match="xhtml:div[@class='notes']/xhtml:h2">
		<xsl:text>&#x0A;-------------------------------&#x0A;</xsl:text>
		<xsl:text>&#x0A;    NOTES&#x0A;&#x0A;</xsl:text>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='notes']/xhtml:p">
		<xsl:text>&#x0A;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#x0A;&#x0A;</xsl:text>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='notessection']/xhtml:h4">
		<xsl:apply-templates/>
		<xsl:text>&#x0A;&#x0A;</xsl:text>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='notessection']">
		<xsl:text>&#x0A;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#x0A;</xsl:text>
	</xsl:template>

	<!--<xsl:template match="xhtml:div[@class='notessection']/xhtml:ol/xhtml:li">
		<xsl:text> </xsl:text>
		<xsl:number format="1"/>
		<xsl:text>. </xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#x0A;</xsl:text>
	</xsl:template>-->

	<xsl:template match="xhtml:div[@class='notessection']/xhtml:ol/xhtml:li">
		<xsl:text> </xsl:text>
		<xsl:text>{</xsl:text>
		<xsl:value-of select="@id"/>
		<xsl:text>} </xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&#x0A;</xsl:text>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='notessection']/xhtml:ol/xhtml:li//xhtml:a">
		<xsl:if test="position() != last()">
			<xsl:apply-templates/>
			<xsl:text> (</xsl:text>
			<xsl:value-of select="@href"/>
			<xsl:text>)</xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='notessection']//xhtml:div">
		<xsl:text>&#x0A;</xsl:text>
		<xsl:if test="not(xhtml:span[@class='line'])">
			<xsl:text>     </xsl:text>
		</xsl:if>
		<xsl:apply-templates/>
		<xsl:text>&#x0A;    </xsl:text>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='notessection']//xhtml:p">
		<xsl:apply-templates/>
	</xsl:template>

	<!--<xsl:template match="xhtml:li//xhtml:span[@class='line']">
		<xsl:text>        </xsl:text>
		<xsl:apply-templates/>
	</xsl:template>--><!-- this should work, but doesnt... -->


	<!-- general -->
	<xsl:template match="xhtml:p">
		<xsl:apply-templates/>
		<xsl:text>&#x0A;&#x0A;</xsl:text>
	</xsl:template>

	<xsl:template match="xhtml:div">
		<xsl:apply-templates/>
		<xsl:text>&#x0A;&#x0A;</xsl:text>
	</xsl:template>

	<xsl:template match="xhtml:br">
		<xsl:text>&#x0A;</xsl:text>
	</xsl:template>

	<xsl:template match="xhtml:i">
		<xsl:text>_</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>_</xsl:text>
	</xsl:template>

	<xsl:template match="xhtml:span[@class='line']">
		<xsl:text>    </xsl:text>
		<xsl:if test="ancestor::xhtml:div/ancestor::xhtml:li">
			<xsl:text>    </xsl:text>
		</xsl:if>
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="xhtml:h2">
		<xsl:apply-templates/>
		<xsl:text>&#x0A;</xsl:text>
	</xsl:template>

	<xsl:template match="xhtml:h3">
		<xsl:apply-templates/>
		<xsl:text>&#x0A;&#x0A;</xsl:text>
	</xsl:template>

	<xsl:template match="text()">
		<xsl:value-of select="translate(current(), '&#160;&#x09;&#x0A;', '  ')"/>
	</xsl:template>

</xsl:stylesheet>
