<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp   "&#160;">
	<!ENTITY copy   "&#169;">
	<!ENTITY reg    "&#174;">
	<!ENTITY trade  "&#8482;">
	<!ENTITY dagger "&#8224;">
]>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

<!-- ////////////////////////////////////////////////////////////////// -->
<!-- ////////////////////////////////////////////////// Variables Start -->
<!-- ////////////////////////////////////////////////////////////////// -->

<!-- fonts -->
<xsl:variable name="navFontFam">font-family:'Palatino Linotype', 'Book Antiqua', Palatino, serif;</xsl:variable>
<xsl:variable name="shortFontFam">font-family:Arial, Helvetica, sans-serif;</xsl:variable>
<xsl:variable name="mainFontFam">font-family:Helvetica, 'Trebuchet MS', Arial, sans-serif;</xsl:variable>

<!-- silverpop query string -->
<xsl:variable name="spQS">Email_Address=%%EMAIL%%&amp;srccode=<xsl:value-of select="//metadata/srccode" />&amp;promotion=<xsl:value-of select="//metadata/promocode" />&amp;utm_source=promotional&amp;utm_medium=Email&amp;utm_campaign=promotional-Email&amp;<xsl:value-of select="//metadata/convertro" /></xsl:variable>

<!--// cellWid1: width of cells for 1st product row //-->
<xsl:variable name="cellWid1">
    <xsl:choose>
        <!-- Check last <prodSku> in <row1> in final.xml -->
        <xsl:when test="//content/products/row1/*[6]/*[2] != ''">
            <xsl:value-of select="'30%'" />
        </xsl:when>

        <xsl:otherwise>
             <xsl:value-of select="'45%'" />
        </xsl:otherwise>
    </xsl:choose>
</xsl:variable>

<!--// cellWid2: width of cells for 2nd product row //-->
<xsl:variable name="cellWid2">
    <xsl:choose>
        <!-- Check last <prodSku> in <row2> in final.xml -->
        <xsl:when test="//content/products/row2/*[6]/*[2] != ''">
            <xsl:value-of select="'30%'" />
        </xsl:when>

        <xsl:otherwise>
             <xsl:value-of select="'45%'" />
        </xsl:otherwise>
    </xsl:choose>
</xsl:variable>

<!-- Turn on/off borders -->
<xsl:variable name="prodTableClass">
    <xsl:choose>
        <xsl:when test="//content/products/borders = 'all'">
            <xsl:value-of select="'responsiveTableWithBorder'" />
        </xsl:when>

        <xsl:otherwise>
            <xsl:value-of select="'responsiveTable'" />
        </xsl:otherwise>
    </xsl:choose>
</xsl:variable>

<!-- Used to upper case SKU -->
<xsl:variable name="lCase" select="'abcdefghijklmnopqrstuvwxyz'" />
<xsl:variable name="uCase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

<xsl:param name="prodCnt" select="'1'" />

<!-- ////////////////////////////////////////////////////////////////// -->
<!-- ////////////////////////////////////////////////// Templates Start -->
<!-- ////////////////////////////////////////////////////////////////// -->

<!--// Banner //-->
<xsl:template name="banner">
	<table border="0" cellspacing="0" align="center" bgcolor="{//presentation/banner/bgColor}" width="698" class="responsiveTable">
	<tr>
    <xsl:choose>
		<xsl:when test="//presentation/banner/type = 'SHOP NOW' or //presentation/banner/type = 'ORDER NOW'">
		<td align="left" class="centered"><a href="{//content/banner/link}" target="_blank" style="color:{//presentation/banner/fontColor}; font-family:'Times New Roman', Times, serif; font-size:24px; padding-left:20px; text-decoration:none"><xsl:value-of select="//content/banner/copy" /></a></td>
		<td align="right" class="no-mobile" style="padding:12px;">
          <table border="0" cellspacing="0" cellpadding="6" align="right" style="border:1px solid #ffffff;" width="150">
          <tr><td align="center"><a href="#" style="font-size:17px; {$mainFontFam} color:{//presentation/banner/fontColor}; text-align:center; text-decoration:none; letter-spacing:1px"><xsl:value-of select="//presentation/banner/type" /><img src="http://contentz.mkt2983.com/ra/2015/10240/12/13277316/TF20151219A_images_tf-arrow-white.png" width="9" height="14" border="0" alt="" /></a></td></tr>   
          </table>        
		</td>
        </xsl:when>
        
        <xsl:otherwise>
		<td><a href="{//content/banner/link}" target="_blank"><img src="images/{//presentation/banner/type}" width="698" border="0" alt="{//content/banner/copy}" style="display:block;" class="responsiveImg" /></a></td>
        </xsl:otherwise>
    </xsl:choose>
	</tr>
	</table>
</xsl:template>

<!--// Logo //-->
<xsl:template name="logo">
<table border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="{//presentation/logo/color}" width="{//presentation/logo/size}" class="responsiveTable"><tr><td><a href="http://www.teleflora.com" target="_blank"><img src="http://contentz.mkt2983.com/lp/10240/580452/teleflora-logo-reverse-{//presentation/logo/size}.png" width="{//presentation/logo/size}" border="0" alt="teleflora" style="display:block;" class="responsiveImg" /></a></td></tr></table>
</xsl:template>

<!--// Nav //-->
<xsl:template name="navbar">
<table border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="{//presentation/nav/bgColor}" width="698" class="no-mobile"><tr><td align="center"><!-- Outer Table HAS WIDTH=698 -->
        <table border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="{//presentation/nav/bgColor}" class="fnavTable"><!-- innter table NO WIDTH -->
        <tr>
            <td align="center" valign="middle" style="padding:10px 0" class="fnav">
            <a href="{//content/nav/firstLink}" target="_blank" name="BNAV1" xt="SPCLICKSTREAM" style="color:{//presentation/nav/linkColor}; font-size:17px; {$navFontFam} text-decoration:none;"><span style="color:{//presentation/nav/linkColor};"><xsl:value-of select="//content/nav/firstText" /></span></a><span style="color:{//presentation/nav/linkColor};" class="no-mobile">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
            </td>
            <td align="center" valign="middle" style="padding:10px 0" class="fnav">
            <a href="{//content/nav/secondLink}" target="_blank" name="BNAV2" xt="SPCLICKSTREAM" style="color:{//presentation/nav/linkColor}; font-size:17px; {$navFontFam} text-decoration:none;"><span style="color:{//presentation/nav/linkColor}"><xsl:value-of select="//content/nav/secondText" /></span></a><span style="color:{//presentation/nav/linkColor};" class="no-mobile">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
            </td>
            <td align="center" valign="middle" style="padding:10px 0" class="fnav">
            <a href="{//content/nav/thirdLink}" target="_blank" name="BNAV3" xt="SPCLICKSTREAM" style="color:{//presentation/nav/linkColor}; font-size:17px; {$navFontFam} text-decoration:none;"><span style="color:{//presentation/nav/linkColor}"><xsl:value-of select="//content/nav/thirdText" /></span></a><span style="color:{//presentation/nav/linkColor};" class="no-mobile">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
            </td>
            <td align="center" valign="middle" style="padding:10px 0" class="fnav">
            <a href="{//content/nav/fourthLink}" target="_blank" name="BNAV4" xt="SPCLICKSTREAM" style="color:{//presentation/nav/linkColor}; font-size:17px; {$navFontFam} text-decoration:none;"><span style="color:{//presentation/nav/linkColor}"><xsl:value-of select="//content/nav/fourthText" /></span></a><span style="color:{//presentation/nav/linkColor};" class="no-mobile">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
            </td>
            <td align="center" valign="middle" style="padding:10px 0" class="fnav">
            <a href="{//content/nav/fifthLink}" target="_blank" name="BNAV5" xt="SPCLICKSTREAM" style="color:{//presentation/nav/linkColor}; font-size:17px; {$navFontFam} text-decoration:none;"><span style="color:{//presentation/nav/linkColor}"><xsl:value-of select="//content/nav/fifthText" /></span></a>
            </td>
        </tr>
        </table>
    </td></tr></table>
</xsl:template>

<!--// Hero Product //-->
<xsl:template name="heroproduct">
	<xsl:variable name="heroSku">
		<xsl:value-of select="translate(substring-before(substring-after(content/hero/heroURL, '/p_'), '?'), $lCase, $uCase)" />
	</xsl:variable>

	<tr>
    	<td align="center"><a href="{content/hero/heroURL}" target="_blank"><img src="http://s7d2.scene7.com/is/image/Teleflora/{$heroSku}?wid=488&amp;fmt=jpeg&amp;qlt=80,0&amp;op_sharpen=0&amp;resMode=bilin&amp;op_usm=3.0,0.5,1.0,0&amp;iccEmbed=0&amp;layer=1&amp;opac=0&amp;layer=2&amp;opac=55&amp;layer=5&amp;opac=0&amp;layer=3&amp;opac=0&amp;align=0,1" border="0" class="responsiveImg" /></a></td>
	</tr>
    <tr>
        <td align="center" valign="middle"><a href="{content/hero/heroURL}" target="_blank" style="color:{presentation/hiliteTextColor2}; text-decoration:none; {$shortFontFam} font-size:14px;"><xsl:value-of select="content/hero/name" /></a></td>
    </tr>
    <tr>
        <td align="center" valign="middle"><a href="{content/hero/heroURL}" style="color:#000000; text-decoration:none; {$shortFontFam} font-size:14px; font-weight:bold"><span style="text-decoration:line-through"><xsl:value-of select="content/hero/price" /></span> $37.46</a></td>
    </tr>        
    <tr>
        <td align="center">
        <table bgcolor="{presentation/defaultLinkColor}" border="0" cellpadding="0" cellspacing="0" height="19" width="79">
        <tr><td><a href="{content/hero/heroURL}"><img alt="Buy Now" src="http://contentz.mkt2984.com/lp/10241/366931/shopnow_0.png" border="0" height="19" width="79" style="display:block" /></a></td></tr>
        </table>
        </td>
    </tr> 
</xsl:template>

<!--// Sub Product //-->
<xsl:template name="subproduct">
	<!-- Sub Products -->
	<xsl:variable name="dir">
	    <xsl:value-of select="substring-after(substring-before(url, '/p_'), 'teleflora.com')" />
    </xsl:variable>

	<xsl:variable name="sku">
	    <xsl:value-of select="translate(substring-before(substring-after(url, '/p_'), '?'), $lCase, $uCase)" />
	</xsl:variable>

	<!-- Side1 Product -->
	<xsl:variable name="dir1">
	    <xsl:value-of select="substring-after(substring-before(sideURL, '/p_'), 'teleflora.com')" />
    </xsl:variable>

	<xsl:variable name="sku1">
	    <xsl:value-of select="translate(substring-before(substring-after(sideURL, '/p_'), '?'), $lCase, $uCase)" />
	</xsl:variable>

	<xsl:value-of select="url/@for" />

	<!-- Set product width based on container widths -->
	<xsl:variable name="cellHt">
	    <xsl:choose>
	        <xsl:when test="$cellWid2 = '45%'">
                <xsl:value-of select="304" />
            </xsl:when>
            <xsl:otherwise>
                 <xsl:value-of select="262" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
	<!-- Set product height based on container widths -->
	<xsl:variable name="imgWd">
	    <xsl:choose>
	        <xsl:when test="$cellWid2 = '45%'">
                <xsl:value-of select="209" />
            </xsl:when>
            <xsl:otherwise>
                 <xsl:value-of select="180" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

        <table border="0" cellpadding="0" cellspacing="0" align="center" class="productTbl">
        <tr>
	        <td align="center"><a href="http://www.teleflora.com{$dir}/p_{$sku}?skuId={$sku}" target="_blank" style="font-size:22px; {$mainFontFam} color:{//presentation/hiliteTextColor1}; text-decoration:none"><xsl:value-of select="title" /></a></td>
        </tr> 
        <tr>
            <td align="center" valign="bottom" height="{$cellHt}" class="no-height"><a href="http://www.teleflora.com{$dir}{$dir1}/p_{$sku}{$sku1}?skuId={$sku}{$sku1}" target="_blank"><img src="http://s7d2.scene7.com/is/image/Teleflora/{$sku}{$sku1}?wid=272&amp;fmt=jpeg&amp;qlt=80,0&amp;op_sharpen=0&amp;resMode=bilin&amp;op_usm=3.0,0.5,1.0,0&amp;iccEmbed=0&amp;layer=1&amp;opac=0&amp;layer=2&amp;opac=55&amp;layer=5&amp;opac=0&amp;layer=3&amp;opac=0&amp;align=0,1" border="0" width="{$imgWd}" height="auto" class="responsiveImgS7" /></a></td>
        </tr>
        <tr>
            <td align="center" valign="middle"><a href="http://www.teleflora.com{$dir}{$dir1}/p_{$sku}{$sku1}?skuId={$sku}{$sku1}" target="_blank" style="color:{//presentation/defaultLinkColor}; text-decoration:none; {$shortFontFam} font-size:14px;"><xsl:value-of select="name" /></a></td>
        </tr>
        <tr>
            <td align="center" valign="middle"><a href="http://www.teleflora.com{$dir}{$dir1}/p_{$sku}{$sku1}?skuId={$sku}{$sku1}" style="color:#000000; text-decoration:none; {$shortFontFam} font-size:14px; font-weight:bold"><span style="text-decoration:line-through"><xsl:value-of select="price" /></span> $70.96</a></td>
        </tr>        
        <tr>
            <td align="center">
            <table bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0"><tr>
            	<td><a href="http://www.teleflora.com{$dir}{$dir1}/p_{$sku}{$sku1}?skuId={$sku}{$sku1}" style="font-size:14px; {$shortFontFam} color:{//presentation/defaultLinkColor}; text-decoration:none; text-align:center; font-weight:bold;">Buy Now&nbsp;</a></td>
                <td valign="middle"><table border="0" cellspacing="0" cellpadding="0" align="center"><tr><td align="center" style="font-size:14px; line-height:14px; background-color:{//presentation/defaultLinkColor};" width="8" height="14"><a href="http://www.teleflora.com{$dir}{$dir1}/p_{$sku}{$sku1}?skuId={$sku}{$sku1}"><img src="http://contentz.mkt2983.com/ra/2016/10240/02/13854668/TF20160302_images_arrow-transparent.gif" width="8" height="14" alt="Buy Now" border="0" style="display:block;" /></a></td></tr></table>
                </td>
            </tr></table>
            </td>
        </tr>
        <tr><td height="15"></td></tr>                    
        </table>

</xsl:template>

<!--// CTA -->
<xsl:template name="CTA">
<!-- [ Headline/Copy/CTA ] -->
	<table border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff" width="698" class="responsiveTable">
	<!-- Headline -->
	<xsl:if test="//content/headline/copy != ''">
    <tr>
		<td align="center"><a href="{//content/headline/link}" target="_blank" style="{$navFontFam} font-size:45px; color:{//content/headline/color}; text-decoration:none; padding: 0 15px;" class="headline"><xsl:value-of select="//content/headline/copy" /></a></td>
	</tr>
	<tr>
    	<td style="height:10px"></td>
	</tr>        
	</xsl:if>

	<!-- CTA Copy -->
	<xsl:if test="//content/cta/copy != ''">
    <tr>
    	<td align="center" style="{$shortFontFam} font-size: 17px; color:#333333; padding:0 40px" class="copy"><xsl:value-of select="//content/cta/copy" /></td>
	</tr>
	<tr>
    	<td style="height:15px"></td>
	</tr>
	</xsl:if>

	<!-- CTA Button -->
	<xsl:if test="//content/ctaButton/copy != ''">
    <tr>
    	<td align="center">
		<table border="0" cellpadding="0" cellspacing="0" bgcolor="{//presentation/ctaButton/bgColor}">
        <tr>
        	<td><img src="http://contentz.mkt2983.com/lp/10240/580452/cta_left.png" width="15" height="41" border="0" alt="" style="display:block" /></td>
			<td><a href="{//content/ctaButton/link}" target="_blank" style="font-family:Geneva, Verdana, sans-serif; font-size: 16px; color:{//presentation/ctaButton/linkColor}; text-decoration:none;" class="CTA"><xsl:value-of select="//content/ctaButton/copy" /></a></td>
        	<td><img src="http://contentz.mkt2983.com/lp/10240/580452/cta_right.png" width="15" height="41" border="0" alt="" style="display:block" /></td>
		</tr>
		</table>
        </td>
	</tr>                    
	<tr>
    	<td style="height:15px"></td>
	</tr>
	</xsl:if>
	</table>
</xsl:template>

<!--// Spacer //-->
<xsl:template name="spacer">
    <table border="0" cellpadding="0" cellspacing="0" align="center"><tr><td height="15"></td></tr></table>	
</xsl:template>


<!-- ////////////////////////////////////////////////////////////////// -->
<!--//////////////////////////////////////////////////////// EMAIL BODY -->
<!-- ////////////////////////////////////////////////////////////////// -->
<xsl:template name="emailbody" match="/">
<xsl:for-each select="root">
<!-- EMAIL THUMBNAIL DISPLAY IMAGE START -->
<script type="application/ld+json">
{
	"@context": "http://schema.org",
	"@type": "EmailMessage",
	"publisher": 
	{
		"@type": "Organization",
		"name": "Teleflora",
		"url": "http://www.teleflora.com",
		"url/googlePlus": "https://plus.google.com/+teleflora"
	},
	"about":
	{
		"@type": "Offer",
		"image": "http://s7d2.scene7.com/is/image/Teleflora/T15X600A?&amp;wid=445&amp;hei=550&amp;fmt=jpeg&amp;qlt=80,0&amp;op_sharpen=0&amp;resMode=bilin&amp;op_usm=1.0,0.5,1.0,0&amp;iccEmbed=0&amp;layer=1&amp;opac=0&amp;layer=2&amp;opac=55&amp;layer=5&amp;opac=0&amp;layer=3&amp;opac=0"
	}
}
</script>
<!-- EMAIL THUMBNAIL DISPLAY IMAGE END -->

<!-- System Text -->
<table border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff" width="698" class="responsiveTable">
<tr>
	<td align="left" class="responsiveColumn">
	<a href="" style="color:#666666; {$shortFontFam} font-size:14px; text-decoration:none;"><b><xsl:value-of select="content/emailOffer" /></b></a>
    </td>
	<td align="right" class="responsiveColumn">
	<a href="#SPCLICKTOVIEW" name="ViewWithImages" xt="SPCLICKTOVIEW" style="font-size:14px; {$shortFontFam} text-align:right; color:#666666; text-decoration:none;">View with images</a>
    </td>
</tr>
</table>

<!-- body -->
<table border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff" width="698" style="border:1px solid #cccccc" class="responsiveTable"><tr><td>

<!--////////////////////////////////////////////////// POSITION - (1) //-->
<span id="position1">
<!-- Banner -->
<xsl:if test="presentation/banner/position = 1 and content/banner/link != ''">
    <xsl:call-template name="banner" />
</xsl:if>
<!-- Logo -->
<xsl:if test="presentation/logo/position = 1">
    <xsl:call-template name="logo" />
</xsl:if>
<!-- Nav -->
<xsl:if test="presentation/nav/position = 1">
    <xsl:call-template name="navbar" />
</xsl:if>
</span>

<!--////////////////////////////////////////////////// POSITION - (2) //-->
<span id="position2">
<!-- Banner -->
<xsl:if test="presentation/banner/position = 2 and content/banner/link != ''">
	<xsl:call-template name="banner" />
</xsl:if>
<!-- Logo -->
<xsl:if test="presentation/logo/position = 2">
	<xsl:call-template name="logo" />
</xsl:if>
<!-- Nav -->
<xsl:if test="presentation/nav/position = 2">
    <xsl:call-template name="navbar" />
</xsl:if>
</span>

<!--////////////////////////////////////////////////// POSITION - (3) //-->
<span id="position3">
<!-- Banner -->
<xsl:if test="presentation/banner/position = 3 and content/banner/link != ''">
	<xsl:call-template name="banner" />
</xsl:if>

<!-- Logo -->
<xsl:if test="presentation/logo/position = 3">
    <xsl:call-template name="logo" />
</xsl:if>

<!-- Products Row1 -->
<xsl:if test="presentation/prodLayout = 'split'">
    <table border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff" width="698" class="responsiveTable">
    <xsl:if test="content/products/row1/headerText != ''">
    <tr>
        <td align="center" colspan="3"><a href="http://www.teleflora.com" target="_blank" style="font-size:22px; {$mainFontFam} color:{content/products/row1/headerText}; text-decoration:none"><xsl:value-of select="content/products/row1/headerText" /></a></td>
    </tr> 
    </xsl:if>
    <tr>
    <xsl:for-each select="//content/products/row1/product">
        <xsl:if test="url != ''">
        <td width="{$cellWid1}" valign="bottom" class="responsiveColumn"><!--xsl:value-of select="position()" /-->
            <xsl:call-template name="subproduct" />
        </td>
        </xsl:if>
    </xsl:for-each>
    </tr>
    </table>
</xsl:if>

<!-- Hero (Image, Product, 3-Products) -->
	<table border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff" width="698" class="responsiveTable">
	<tr><td height="15" class="no-mobile"></td></tr>
<xsl:choose>
	<!-- Image -->
   	<xsl:when test="content/hero/mainImg != ''">
    <tr>
    	<td><a href="{content/hero/heroURL}" target="_blank"><img src="images/{content/hero/mainImg}" border="0" style="display:block;" alt="{content/ctaButton/copy}" class="responsiveImg" /></a></td>
	</tr>
	</xsl:when>

	<!-- Product -->
   	<xsl:otherwise>
		<xsl:variable name="heroSku">
			<xsl:value-of select="substring-before(substring-after(content/hero/heroURL, '/p_'), '?')" />
		</xsl:variable>
        
        <xsl:choose>
            <xsl:when test="content/hero/sideHero/sideURL != ''">
           <tr>
                <td width="70%" class="responsiveColumn" valign="bottom">
                    <table border="0" cellpadding="0" cellspacing="0" align="center">
                <!-- Hero -->
				<xsl:call-template name="heroproduct" />
                    <tr><td height="20"></td></tr>
                    </table>
                </td>
                <td width="30%" valign="button" class="responsiveColumn">
                <xsl:for-each select="//content/hero/sideHero">
                    <xsl:if test="sideImg = '' and sideURL != ''">
                        <xsl:call-template name="subproduct" />
                    </xsl:if>
                </xsl:for-each>
                </td>
            </tr>
            </xsl:when>

			<xsl:when test="content/hero/heroURL != ''">
				<xsl:call-template name="heroproduct" />
			</xsl:when>
		</xsl:choose>

	</xsl:otherwise>

</xsl:choose>
    </table>

<!-- CTA -->
<xsl:if test="presentation/ctaButton/position = 0">
	<xsl:call-template name="CTA" />
</xsl:if>

<!-- Nav -->
<xsl:if test="presentation/nav/position = 3">
    <xsl:call-template name="navbar" />
</xsl:if>
</span>

<!--////////////////////////////////////////////////// POSITION - (4) //-->
<span id="position4">
<!-- Products Row1/2/3 -->
<xsl:choose>
	<xsl:when test="presentation/prodLayout = 'split'">
		<!-- Row2 -->
        <table border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff" width="698" class="responsiveTable">
        <tr>
        <xsl:for-each select="//content/products/row2/product">
            <xsl:if test="url != ''">
            <td width="{$cellWid2}" valign="bottom" class="responsiveColumn"><!--xsl:value-of select="position()" /-->
                <xsl:call-template name="subproduct" />
            </td>
            </xsl:if>
        </xsl:for-each>
        </tr>
        </table>
	</xsl:when>

    <xsl:otherwise>
		<!-- Row1 -->
        <table border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff" width="670" class="{$prodTableClass}">
		<xsl:if test="content/products/row1/headerText != ''">
        <tr>
	        <td align="center" colspan="3"><a href="http://www.teleflora.com" target="_blank" style="font-size:22px; {$mainFontFam} color:{content/products/row1/headerText}; text-decoration:none"><xsl:value-of select="content/products/row1/headerText" /></a></td>
        </tr> 
        </xsl:if>
        
        <tr>
        <xsl:for-each select="//content/products/row1/product">
            <xsl:if test="url != ''">
            <td width="{$cellWid1}" valign="bottom" class="responsiveColumn"><!--xsl:value-of select="position()" /-->
                <xsl:call-template name="subproduct" />
            </td>
            </xsl:if>
        </xsl:for-each>
        </tr>

		<!-- Row2 -->
		<xsl:if test="content/products/row2/headerText != ''">
        <tr>
	        <td align="center" colspan="3"><a href="http://www.teleflora.com" target="_blank" style="font-size:22px; {$mainFontFam} color:{content/products/row2/headerText}; text-decoration:none"><xsl:value-of select="content/products/row2/headerText" /></a></td>
        </tr> 
        </xsl:if>

        <tr>
        <xsl:for-each select="//content/products/row2/product">
            <xsl:if test="url != ''">
            <td width="{$cellWid2}" valign="bottom" class="responsiveColumn">
                <xsl:call-template name="subproduct" />
            </td>
            </xsl:if>
        </xsl:for-each>
        </tr>

		<!-- Row3 -->
		<xsl:if test="content/products/row3/headerText != ''">
        <tr>
	        <td align="center" colspan="3"><a href="http://www.teleflora.com" target="_blank" style="font-size:22px; {$mainFontFam} color:{content/products/row3/headerText}; text-decoration:none"><xsl:value-of select="content/products/row3/headerText" /></a></td>
        </tr> 
        </xsl:if>

        <tr>
        <xsl:for-each select="//content/products/row3/product">
            <xsl:if test="url != ''">
            <td width="{$cellWid2}" valign="bottom" class="responsiveColumn">
                <xsl:call-template name="subproduct" />
            </td>
            </xsl:if>
        </xsl:for-each>
        </tr>

        </table>
	</xsl:otherwise>
</xsl:choose>

<!-- CTA -->
<xsl:if test="presentation/ctaButton/position = 3 or presentation/ctaButton/position = 4">
	<xsl:call-template name="CTA" />
</xsl:if>

<!-- Logo -->
<xsl:if test="presentation/logo/position = 4">
    <xsl:call-template name="logo" />
</xsl:if>

<!-- Nav -->
<xsl:if test="presentation/nav/position = 4">
    <xsl:call-template name="navbar" />
</xsl:if>
</span>

<!--////////////////////////////////////////////////// POSITION - (5) //-->
<span id="position5">
<!-- Logo -->
<xsl:if test="presentation/logo/position = 5">
    <xsl:call-template name="logo" />
</xsl:if>

<!-- Nav -->
<xsl:if test="presentation/nav/position = 5">
    <xsl:call-template name="navbar" />
</xsl:if>
</span>

<!--////////////////////////////////////////////////////////// BOTTOM //-->
<span class="bottom">
   	<!-- Start Bottom Tiles -->
	<table border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="{presentation/bottom/tileBgColor}" width="698" class="responsiveTable">
    <tr>
<xsl:choose>
    <xsl:when test="content/bottom/tile1 != '' and content/bottom/tile2 = ''">
    	<td>
		<a href="" name="EmailOffer"><img src="images/{content/bottom/tile1}" width="698" border="0" style="display:block;" alt="" class="responsiveImg" /></a>
        </td>
    </xsl:when>

	<xsl:otherwise>
    	<!-- Left Tile -->
    	<td class="responsiveColumn" width="50%">
    	<xsl:if test="content/bottom/tile1 != ''">
	    	<!-- Image -->
    		<a href="{content/bottom/link1}" target="_blank"><img src="images/{content/bottom/tile1}" border="0" alt="" align="left" style="display:block" class="responsiveImg" /></a>
    	</xsl:if>

    	<xsl:if test="content/bottom/title1 != ''">
            <table border="0" cellspacing="0" cellpadding="0" width="290" align="center" bgcolor="{presentation/bottom/tileBgColor}">
            <tr>
                <td align="center" style="color:#000000; font-size: 15px">
                <div style="font-family:'Book Antiqua', 'Palatino Linotype', Palatino, serif; font-size:26px; color:#d13ba2; margin-bottom:10px;"><xsl:value-of select="content/bottom/title1" /></div>
                <div style="font-family: Verdana, Geneva, sans-serif; font-size:15px; color:#000000; line-height:21px; margin-bottom:10px;"><xsl:value-of select="content/bottom/copy1" /></div>
                <div style="margin-bottom:10px">               
                <!-- CTA -->
                <table border="0" cellspacing="0" cellpadding="0" bgcolor="{presentation/bottom/tileBgColor}"><tr>
            	<td><img src="http://contentz.mkt2983.com/lp/10240/580452/cta_left.png" width="15" height="41" border="0" alt="" style="display:block" /></td>
                <td><a href="{content/bottom/link1}" style="font-family:'Arial Black', Gadget, sans-serif; font-size:18px; color:{//presentation/defaultLinkColor}; text-decoration:none; font-weight:bold"><xsl:value-of select="content/bottom/cta1text" /></a></td>
            	<td><img src="http://contentz.mkt2983.com/lp/10240/580452/cta_right.png" width="15" height="41" border="0" alt="" style="display:block" /></td>
                </tr></table><!-- End of CTA -->
            	</div>
                </td>
            </tr>
            </table>
    	</xsl:if>
		</td>
        
    	<!-- Right Tile -->
    	<td class="responsiveColumn" width="50%">
    <xsl:if test="content/bottom/tile2 != ''">
	    	<!-- Image -->
    		<a href="{content/bottom/link2}" target="_blank"><img src="images/{content/bottom/tile2}" border="0" alt="" align="right" style="display:block" class="responsiveImg" /></a>
    </xsl:if>

    <xsl:if test="content/bottom/tile1 != ''">
            <table border="0" cellspacing="0" cellpadding="0" width="290" align="center" bgcolor="{presentation/bottom/tileBgColor}">
            <tr>
                <td align="center" style="color:#000000; font-size: 15px">
                <div style="font-family:'Book Antiqua', 'Palatino Linotype', Palatino, serif; font-size:26px; color:#d13ba2; margin-bottom:10px;"><xsl:value-of select="content/bottom/title2" /></div>
                <div style="font-family: Verdana, Geneva, sans-serif; font-size:15px; color:#000000; line-height:21px; margin-bottom:10px;"><xsl:value-of select="content/bottom/copy2" /></div>
                <div style="margin-bottom:10px">               
                <!-- CTA -->
                <table border="0" cellspacing="0" cellpadding="0" bgcolor="{presentation/bottom/tileBgColor}"><tr>
            	<td><img src="http://contentz.mkt2983.com/lp/10240/580452/cta_left.png" width="15" height="41" border="0" alt="" style="display:block" /></td>
                <td><a href="{content/bottom/link2}" style="font-family:'Arial Black', Gadget, sans-serif; font-size:18px; color:{//presentation/defaultLinkColor}; text-decoration:none; font-weight:bold"><xsl:value-of select="content/bottom/cta2text" /></a></td>
            	<td><img src="http://contentz.mkt2983.com/lp/10240/580452/cta_right.png" width="15" height="41" border="0" alt="" style="display:block" /></td>
                </tr></table><!-- End of CTA -->
            	</div>
                </td>
            </tr>
            </table>
    </xsl:if>

		</td>
	</xsl:otherwise>
</xsl:choose>
	</tr>        
    </table>
   	<!-- End Bottom Tiles -->

    <!-- Nav (MOBILE) -->
    <!--[if !mso 9]><!-->
	<div style="display:none; font-size:0; max-height:0; mso-hide:all; overflow:hidden; float:left; width:0;" class="hideDesktop">
    <table border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="{presentation/nav/bgColor}" width="100%"><tr><td align="center">
        <table border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="{presentation/nav/bgColor}" class="fnavTable">
        <tr>
            <td align="center" valign="middle" style="padding:10px 0;" class="fnav">
            <a href="{content/nav/firstLink}" target="_blank" name="BNAV1" xt="SPCLICKSTREAM" style="color:{presentation/nav/linkColor}; font-size:17px; {$navFontFam} text-decoration:none;"><span style="color:{presentation/nav/linkColor}"><xsl:value-of select="content/nav/firstText" /></span></a><span style="color:{presentation/nav/linkColor};" class="no-mobile">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
            </td>
            <td align="center" valign="middle" style="padding:10px 0;" class="fnav">
            <a href="{content/nav/secondLink}" target="_blank" name="BNAV2" xt="SPCLICKSTREAM" style="color:{presentation/nav/linkColor}; font-size:17px; {$navFontFam} text-decoration:none;"><span style="color:{presentation/nav/linkColor}"><xsl:value-of select="content/nav/secondText" /></span></a><span style="color:{presentation/nav/linkColor};" class="no-mobile">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
            </td>
            <td align="center" valign="middle" style="padding:10px 0;" class="fnav">
            <a href="{content/nav/thirdLink}" target="_blank" name="BNAV3" xt="SPCLICKSTREAM" style="color:{presentation/nav/linkColor}; font-size:17px; {$navFontFam} text-decoration:none;"><span style="color:{presentation/nav/linkColor}"><xsl:value-of select="content/nav/thirdText" /></span></a><span style="color:{presentation/nav/linkColor};" class="no-mobile">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
            </td>
            <td align="center" valign="middle" style="padding:10px 0;" class="fnav">
            <a href="{content/nav/fourthLink}" target="_blank" name="BNAV4" xt="SPCLICKSTREAM" style="color:{presentation/nav/linkColor}; font-size:17px; {$navFontFam} text-decoration:none;"><span style="color:{presentation/nav/linkColor}"><xsl:value-of select="content/nav/fourthText" /></span></a><span style="color:{presentation/nav/linkColor};" class="no-mobile">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
            </td>
            <td align="center" valign="middle" style="padding:10px 0;" class="fnav">
            <a href="{content/nav/fifthLink}" target="_blank" name="BNAV5" xt="SPCLICKSTREAM" style="color:{presentation/nav/linkColor}; font-size:17px; {$navFontFam} text-decoration:none;"><span style="color:{presentation/nav/linkColor}"><xsl:value-of select="content/nav/fifthText" /></span></a>
            </td>
        </tr>
        </table>
    </td></tr></table>
	</div>
    <!--<![endif]-->  

	<!-- Social Media -->
<xsl:choose>
    <xsl:when test="content/socialicons = 'rainbow'">
    <table border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff" height="50" width="100%">
    <tr><td valign="middle" align="right" width="43%" style="padding:10px 0">
    <span class="no-mobile"><img src="http://webproducer.telefloramarketing.com/TFEmail_T/stay-connected.png" width="136" height="26" border="0" alt="" style="vertical-align:middle;" /></span>
    </td><td valign="middle" style="padding:10px 0">
    <span><a href="https://www.facebook.com/teleflora" target="_blank"><img src="http://contentz.mkt2983.com/lp/10240/513672/fbicon.png" width="24" height="24" alt="facebook" border="0" style="vertical-align:middle;" class="responsiveImgSocial" /></a>&nbsp;</span>
    <span><a href="https://twitter.com/teleflora" target="_blank"><img src="http://contentz.mkt2983.com/lp/10240/513672/twiticon.png" width="24" height="24" alt="Twitter" border="0" style="vertical-align:middle;" class="responsiveImgSocial" /></a>&nbsp;</span>
    <span><a href="http://www.pinterest.com/teleflora" target="_blank"><img src="http://contentz.mkt2983.com/lp/10240/513672/pinticon.png" width="24" height="24" alt="Pinterest" border="0" style="vertical-align:middle;" class="responsiveImgSocial" /></a>&nbsp;</span>
    <span><a href="https://www.youtube.com/teleflora" target="_blank"><img src="http://contentz.mkt2983.com/lp/10240/513672/youticon.png" width="24" height="24" alt="YouTube" border="0" style="vertical-align:middle;" class="responsiveImgSocial" /></a>&nbsp;</span>
    <span><a href="http://instagram.com/teleflora" target="_blank"><img src="http://contentz.mkt2983.com/lp/10240/513672/instaicon.png" width="24" height="24" alt="Instagram" border="0" style="vertical-align:middle;" class="responsiveImgSocial" /></a>&nbsp;</span>
    <span><a href="https://plus.google.com/+teleflora" target="_blank"><img src="http://contentz.mkt2983.com/lp/10240/513672/goopicon.png" width="24" height="24" alt="Google+" border="0" style="vertical-align:middle;" class="responsiveImgSocial" /></a>&nbsp;</span>
    <span><a href="http://teleflora.tumblr.com" target="_blank"><img src="http://contentz.mkt2983.com/lp/10240/513672/tumbicon.png" width="24" height="24" alt="tumblr" border="0" style="vertical-align:middle;" class="responsiveImgSocial" /></a>&nbsp;</span>
    <span><a href="http://www.teleflora.com/blog" target="_blank"><img src="http://contentz.mkt2983.com/lp/10240/513672/rssicon.png" width="24" height="24" alt="RSS" border="0" style="vertical-align:middle;" class="responsiveImgSocial" /></a></span>
	</td></tr>
	</table>
    </xsl:when>

    <xsl:when test="content/socialicons != ''">
    <table border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
        <td align="left" style="font-size:14px; {$shortFontFam} color:{content/socialicons};" class="responsiveColumn">Connect with us&nbsp;</td>
        <td class="responsiveColumn">
            <table border="0" cellpadding="5" cellspacing="0" align="center"><tr>
            <td>
                <table border="0" cellpadding="0" cellspacing="0" width="18" height="18" class="fnavGreyTable"><tr><td style="background-color:{content/socialicons};"><a href="https://www.facebook.com/teleflora" target="_blank"><img width="18" height="18" border="0" alt="Facebook" src="http://contentz.mkt2983.com/ra/2015/10240/12/13271975/tf14196-1218_images_facebook.png" style="display:block;" class="fnavGreyImage" /></a></td></tr></table>
            </td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0" width="18" height="18" class="fnavGreyTable"><tr><td style="background-color:{content/socialicons};"><a href="https://twitter.com/teleflora" target="_blank"><img width="18" height="18" border="0" alt="Twitter" src="http://contentz.mkt2983.com/ra/2015/10240/12/13271975/tf14196-1218_images_twitter.png" style="display:block;" class="fnavGreyImage" /></a></td></tr></table>
            </td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0" width="18" height="18" class="fnavGreyTable"><tr><td style="background-color:{content/socialicons};"><a href="http://instagram.com/teleflora" target="_blank"><img width="18" height="18" border="0" alt="Instagram" src="http://contentz.mkt2983.com/ra/2015/10240/12/13271975/tf14196-1218_images_instagram.png" style="display:block;" class="fnavGreyImage" /></a></td></tr></table>
            </td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0" width="18" height="18" class="fnavGreyTable"><tr><td style="background-color:{content/socialicons};"><a href="https://www.youtube.com/teleflora" target="_blank"><img width="18" height="18" border="0" alt="YouTube" src="http://contentz.mkt2983.com/ra/2015/10240/12/13271975/tf14196-1218_images_video.png" style="display:block;" class="fnavGreyImage" /></a></td></tr></table>
            </td>
            <td>
                <table border="0" cellpadding="0" cellspacing="0" width="18" height="18" class="fnavGreyTable"><tr><td style="background-color:{content/socialicons};"><a href="http://www.pinterest.com/teleflora" target="_blank"><img width="18" height="18" border="0" alt="Pinterest" src="http://contentz.mkt2983.com/ra/2015/10240/12/13271975/tf14196-1218_images_pinterest.png" style="display:block;" class="fnavGreyImage" /></a></td></tr></table>
            </td>
            </tr></table><!-- closed ss table -->
        </td>
    </tr>
    </table>                
    </xsl:when>
</xsl:choose>
</span>

</td></tr></table>

<!--////////////////////////////////////////////////////////// FOOTER //-->
<span class="footer">
<table border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff" width="698" class="responsiveTable">
<tr>
	<td colspan="3" height="10"></td>
</tr>
<tr>
    <td class="mhide" width="10"></td>
    <td align="left" style="{$shortFontFam} color: #666666; font-size: 13px" class="">
Offer is available through <a href="http://www.teleflora.com?{$spQS}" name="TelefloraLogo" xt="SPCLICKSTREAM" style="color:#666666; text-decoration:none;">Teleflora.com</a> or by calling <b><a target="_blank" href="#" style="color:#666665; text-decoration:none;" xt="SPBOOKMARK" name="Bookmark">1-800-835-3356</a></b>. Promotion code <b>EMP0207C</b> valid through <b>2/7/2016</b>. May not be combined with any other promotion and is not valid toward previous purchases. Not valid at retail locations or affiliate sites. Gift cards and taxes do not qualify for the offer. Offer terms and conditions are subject to change at any time.
<br /><br />
This email was sent to: <a target="_blank" href="mailto:%%EMAIL%%" style="color:#666665 !important; text-decoration:none;" xt="SPEMAIL" name="__EMAIL___null">%%EMAIL%%</a>. If you prefer not to receive Teleflora&reg; email messages, please <a href="#LPWEBFORMOPTOUT" name="BFooterUnsubscribe" style="color:#666666;" xt="LPWEBFORMOPTOUT" xtwebform="11579334">click here</a>. Comments? Questions? Please contact us at <a xt="SPEMAIL" style="color: #666666" href="mailto:service@teleflora.com" name="BFooterCustomerService">service@teleflora.com.</a>
<br /><br />
Don't miss out! Make sure to add <a target="_blank" href="mailto:teleflora@email.teleflora.com" style="color:#666665; text-decoration:none;" xt="SPEMAIL" name="teleflora_email_teleflora_com_null">teleflora@email.teleflora.com</a> to your address book.
<br />
<a name="BFooterPrivacyPolicy" href="http://www.teleflora.com/info/securityprivacy?{$spQS}" style="color: #666666" xt="SPCLICKSTREAM">Teleflora Privacy Policy</a> <br />
<br />
&copy; 2016 Teleflora LLC. All Rights Reserved. TELEFLORA, MAKE SOMEONE SMILE, BE HAPPY, PRESENT PERFECT, SEND A HUG, and the accompanying logos are trademarks of Teleflora. All other trademarks are the property of their respective owners. Teleflora LLC, P.O. Box 60910, Los Angeles, CA 90060-0910 USA.</td>    <td class="mhide" width="10"></td>
</tr>
<tr>
	<td colspan="3" height="10"></td>
</tr>
</table>
</span>
</xsl:for-each>
</xsl:template>
</xsl:stylesheet>