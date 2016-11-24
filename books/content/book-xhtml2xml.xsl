<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xhtml="http://www.w3.org/1999/xhtml">
	
	<xsl:output method="xml" indent="yes" encoding="UTF-8" media-type="text/xml" standalone="yes"/>

	<xsl:strip-space elements="*"/>
	
	
	<!-- head -->
	<xsl:template match="/">
		<xsl:element name="book">
			<xsl:element name="head">
				<xsl:element name="title">
					<xsl:value-of select="//xhtml:h1[@class='booktitle']"/>
				</xsl:element>
				<xsl:element name="author">
					<xsl:value-of select="//xhtml:h2[@class='author']"/>
				</xsl:element>
				<xsl:element name="publisher">
					<xsl:value-of select="//xhtml:div[@class='publisher']"/>
				</xsl:element>
				<xsl:element name="date">
					<xsl:value-of select="//xhtml:div[@class='publisherdate']"/>
				</xsl:element>
				<xsl:element name="version">
					<xsl:value-of select="//xhtml:meta[@name='version']/@content"/>
				</xsl:element>
				<xsl:element name="timestamp">
					<xsl:value-of select="//xhtml:meta[@name='timestamp']/@content"/>
				</xsl:element>
				<xsl:element name="language">
					<xsl:value-of select="//xhtml:html/@xml:lang"/>
				</xsl:element>
			</xsl:element>
			<xsl:element name="body">
				<xsl:apply-templates/>
			</xsl:element>
		</xsl:element>
	</xsl:template>


	<xsl:template match="xhtml:head"/>
	<xsl:template match="xhtml:div[@class='contents']"/>
	<xsl:template match="xhtml:div[@class='colophon']"/>


	<!-- motto -->
	<xsl:template match="xhtml:div[@class='frontispiece']">
		<xsl:apply-templates select="xhtml:div[@class='motto']"/>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='motto']">
		<xsl:element name="motto">
			<xsl:if test="string-length(@id) > 0">
				<xsl:attribute name="id">
					<xsl:value-of select="@id"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="string-length(@xml:lang) > 0">
				<xsl:attribute name="language">
					<xsl:value-of select="@xml:lang"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>


	<!-- text -->
	<xsl:template match="xhtml:div[@class='text']">
		<xsl:element name="text">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='chapter']">
		<xsl:element name="chapter">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='chapter']//xhtml:h2"/>
	
	<xsl:template match="xhtml:div[@class='chapter']//xhtml:h3[string-length(@class)=0]">
		<xsl:element name="title">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='chapter']//xhtml:h3[@class='chapterend']"/>

	<xsl:template match="xhtml:div[@class='chapter']//xhtml:h3[@class='theend']"/>

	<xsl:template match="xhtml:div[@class='page']">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="xhtml:div[@class='pagenumber']"/>

	<xsl:template match="xhtml:div[@class='break']">
		<xsl:element name="break">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='speech']">
		<xsl:element name="speech">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='speaker']">
		<xsl:element name="speaker">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:p[@class='speech2']">
		<xsl:element name="speech2">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='song']">
		<xsl:element name="song">
			<xsl:if test="string-length(@xml:lang) > 0">
				<xsl:attribute name="language">
					<xsl:value-of select="@xml:lang"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:h4[@class='songtitle']">
		<xsl:element name="songtitle">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:p[@class='songverse']">
		<xsl:element name="songverse">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:p[@class='songdirection']">
		<xsl:element name="songdirection">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='letter']">
		<xsl:element name="letter">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='signatory']">
		<xsl:element name="signatory">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='address']">
		<xsl:element name="address">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='ps']">
		<xsl:element name="ps">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>


	<!-- notes -->
	<xsl:template match="xhtml:div[@class='notes']">
		<xsl:element name="notes">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='notes']/xhtml:h2"/>

	<xsl:template match="xhtml:div[@class='notessection']">
		<xsl:element name="notessection">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='notessection']/xhtml:h4">
		<xsl:element name="title">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='notessection']/xhtml:ol/xhtml:li">
		<xsl:element name="note">
			<xsl:attribute name="id">
				<xsl:value-of select="@id"/>
			</xsl:attribute>
			<xsl:attribute name="idref">
				<xsl:value-of select="substring(xhtml:p[last()]/xhtml:a[last()]/@href, 2)"/>
			</xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='notessection']/xhtml:ol/xhtml:li//xhtml:a">
		<xsl:if test="position() != last()">
			<xsl:element name="link">
				<xsl:attribute name="href">
					<xsl:value-of select="@href"/>
				</xsl:attribute>
				<xsl:apply-templates/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<!-- general -->
	<xsl:template match="xhtml:p">
		<xsl:element name="paragraph">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='blockquote']">
		<xsl:element name="blockquote">
			<xsl:if test="string-length(@id) > 0">
				<xsl:attribute name="id">
					<xsl:value-of select="@id"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="string-length(@xml:lang) > 0">
				<xsl:attribute name="language">
					<xsl:value-of select="@xml:lang"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='blockquote' or @class='motto']/xhtml:div[@class='original']">
		<xsl:element name="original">
			<xsl:if test="string-length(@xml:lang) > 0">
				<xsl:attribute name="language">
					<xsl:value-of select="@xml:lang"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='blockquote' or @class='motto']/xhtml:div[@class='translation']">
		<xsl:element name="translation">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='blockquote' or @class='motto']/xhtml:div[@class='attribution']">
		<xsl:element name="attribution">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:div[@class='blockquote' or @class='motto']/xhtml:div[@class='attribution']/text()[1]">
		<xsl:value-of select="translate(current(), '&#8212;', '')"/>
	</xsl:template>

	<xsl:template match="xhtml:span[@class='firstwords']">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="xhtml:span[@class='notable']">
		<xsl:element name="notable">
			<xsl:attribute name="id">
				<xsl:value-of select="@id"/>
			</xsl:attribute>
			<xsl:if test="string-length(@xml:lang) > 0">
				<xsl:attribute name="language">
					<xsl:value-of select="@xml:lang"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:span[@class='line']">
		<xsl:element name="line">
			<xsl:if test="string-length(@xml:lang) > 0">
				<xsl:attribute name="language">
					<xsl:value-of select="@xml:lang"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:span[@class='capitals']">
		<xsl:element name="capitals">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:span[@class='smallcapitals']">
		<xsl:element name="smallcapitals">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:span[@class='marker']"/>

	<xsl:template match="xhtml:span[string-length(@class) = 0 and string-length(@xml:lang) > 0]">
		<xsl:element name="span">
			<xsl:attribute name="language">
				<xsl:value-of select="@xml:lang"/>
			</xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:a">
		<xsl:element name="link">
			<xsl:attribute name="idref">
				<xsl:value-of select="substring(@href, 2)"/>
			</xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:i">
		<xsl:element name="italic">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:b">
		<xsl:element name="bold">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="xhtml:br"/>

</xsl:stylesheet>
