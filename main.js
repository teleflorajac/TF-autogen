/*****************/
/*** FUNCTIONS ***/
/*****************/

// Load XML Doc
function loadXMLDoc(dname, format) {
	if (window.XMLHttpRequest) {
		xhttp = new XMLHttpRequest();
		} else {
		xhttp = new ActiveXObject('Microsoft.XMLHTTP');
		}
	xhttp.open('GET', dname, false);
	xhttp.send(null);
	
	if (format == 'xml') {
		return xhttp.responseXML;
		} else {
		return xhttp.responseText;
		}
	}

/****************/
/***** CODE *****/
/****************/

// Display by default. If there is no error this will get replaced with email contents.
bod = document.getElementById('body');
bod.innerHTML = '<div style="padding:20px;">Loading...<center><img src="http://assets.teleflora.com/images/ajax-loader.gif" /></center></div>';

// Get final.xml
xml = loadXMLDoc('final.xml', 'xml');

// Get template value from final.xml
tplt = xml.getElementsByTagName('dir')[0].childNodes[0];
//localStorage['tplt'] = tplt.nodeValue;

// Matrix of element positions in based on design template
matrix = {
	'S': {'logo': '2', 'nav': '4', 'bnnr': '1', 'cta': '0'},
	'I1':	{'logo': '3', 'nav': '1', 'bnnr': '2', 'cta': '0'},
	'B':	{'logo': '3', 'nav': '1', 'bnnr': '2', 'cta': '0'},
	'F1':	{'logo': '3', 'nav': '1', 'bnnr': '2', 'cta': '0'},
	'F2':	{'logo': '3', 'nav': '1', 'bnnr': '2', 'cta': '0'},
	'E1': {'logo': '1', 'nav': '2', 'bnnr': '3', 'cta': '0'},
	'I2': {'logo': '1', 'nav': '2', 'bnnr': '3', 'cta': '0'},
	'E3': {'logo': '1', 'nav': '2', 'bnnr': '3', 'cta': '0'},
	'W1': {'logo': '1', 'nav': '2', 'bnnr': '3', 'cta': '0'},
	'W2': {'logo': '1', 'nav': '2', 'bnnr': '3', 'cta': '0'},
	'E2':	{'logo': '2', 'nav': '3', 'bnnr': '1', 'cta': '0'},
	'T2': {'logo': '1', 'nav': '2', 'bnnr': '3', 'cta': '4'},
	'N': {'logo': '2', 'nav': '1', 'bnnr': '0', 'cta': '0'},
	'J': {'logo': '2', 'nav': '1', 'bnnr': '0', 'cta': '0'},
	'M': {'logo': '2', 'nav': '1', 'bnnr': '0', 'cta': '0'},
	'T1':	{'logo': '4', 'nav': '5', 'bnnr': '1', 'cta': '3'},
	'D':  {'logo': '5', 'nav': '1', 'bnnr': '2', 'cta': '0'},
	'O1': {'logo': '5', 'nav': '1', 'bnnr': '2', 'cta': '0'},
	'O2': {'logo': '5', 'nav': '1', 'bnnr': '2', 'cta': '0'},
	'L2': {'logo': '5', 'nav': '1', 'bnnr': '2', 'cta': '0'},
	'R': {'logo': '4', 'nav': '5', 'bnnr': '1', 'cta': '0'},
	'K':	{'logo': '1', 'nav': '5', 'bnnr': '0', 'cta': '0'},
	'H': {'logo': '1', 'nav': '3', 'bnnr': '0', 'cta': '0'},
	'C':	{'logo': '1', 'nav': '5', 'bnnr': '2', 'cta': '0'},
	'L1':	{'logo': '1', 'nav': '5', 'bnnr': '2', 'cta': '0'}
	};
design = xml.getElementsByTagName('template')[0].childNodes[0].nodeValue;
// Set positions of elements in XML. Comment out these 3 lins of positions will be hard-coded in XML
xml.getElementsByTagName('nav')[0].children[0].childNodes[0].nodeValue = matrix[design]['nav'];
xml.getElementsByTagName('logo')[0].children[0].childNodes[0].nodeValue = matrix[design]['logo'];
xml.getElementsByTagName('banner')[0].children[0].childNodes[0].nodeValue = matrix[design]['bnnr'];
xml.getElementsByTagName('ctaButton')[0].children[0].childNodes[0].nodeValue = matrix[design]['cta'];

maxProds = 6; // Maximum products allowed in email
totProds = 0; // Total products found in XML

// Start - Generate product query string for scraper
qs = '';

// Check if hero is a product
if (typeof xml.getElementsByTagName('mainImg')[0].childNodes[0] == 'undefined' && typeof xml.getElementsByTagName('heroURL')[0].childNodes[0] != 'undefined') {
	heroURL = xml.getElementsByTagName('heroURL')[0].childNodes[0].nodeValue;
	heroDir = heroURL.substr(0, heroURL.indexOf('/p_')).replace('http://www.teleflora.com', '');
	heroSku = heroURL.substr(heroURL.indexOf('/p_')+3, heroURL.indexOf('?')-heroURL.indexOf('/p_')-3);
	qs += 'products["hero"][]='+ heroDir +'/p_'+ heroSku.toLowerCase();
	}

// Get side product URL(s)
sideUrls = 	xml.getElementsByTagName('sideURL')
for(n=0; n <= 2; n++) { // No more than 2 side products
	if (typeof sideUrls[n] != 'undefined' && typeof sideUrls[n].childNodes[0] != 'undefined') {
		//row = xml.getElementsByTagName('url')[0].parentNode.parentNode.tagName;
		//prodURL = xml.getElementsByTagName('url')[0].childNodes[0].nodeValue;
		row = sideUrls[n].parentNode.parentNode.tagName;
		prodURL = sideUrls[n].childNodes[0].nodeValue;

		dir = prodURL.substr(0, prodURL.indexOf('/p_')).replace('http://www.teleflora.com', '');
		//alert(dir);
		sku = prodURL.substr(prodURL.indexOf('/p_')+3, prodURL.indexOf('?')-prodURL.indexOf('/p_')-3);
		//alert(sku);
		qs += '&products["hero"][]='+ dir +'/p_'+ sku.toLowerCase();
		totProds += 1;
		}
	}

// Check if side1 product
/*if (typeof xml.getElementsByTagName('side1URL')[0].childNodes[0] != 'undefined') {
	side1URL = xml.getElementsByTagName('side1URL')[0].childNodes[0].nodeValue;
	side1Dir = side1URL.substr(0, side1URL.indexOf('/p_')).replace('http://www.teleflora.com', '');
	side1Sku = side1URL.substr(side1URL.indexOf('/p_')+3, side1URL.indexOf('?')-side1URL.indexOf('/p_')-3);
	qs += '&products["hero"][]='+ side1Dir +'/p_'+ side1Sku.toLowerCase();
	}
*/
// Get sub-products URLs
urls = 	xml.getElementsByTagName('url')
for(n=0; n <= maxProds; n++) {
	//if (typeof xml.getElementsByTagName('prod'+ n +'Sku')[0].childNodes[0] != 'undefined') {
	//	sku = xml.getElementsByTagName('prod'+ n +'Sku')[0].childNodes[0].nodeValue;
	//	dir = xml.getElementsByTagName('prod'+ n +'Dir')[0].childNodes[0].nodeValue;
	//if (typeof xml.getElementsByTagName('prodSku')[0].childNodes[0] != 'undefined') {
	//	sku = xml.getElementsByTagName('prodSku')[0].childNodes[0].nodeValue;
	//	dir = xml.getElementsByTagName('prodDir')[0].childNodes[0].nodeValue;
	if (typeof urls[n] != 'undefined' && typeof urls[n].childNodes[0] != 'undefined') {
		//row = xml.getElementsByTagName('url')[0].parentNode.parentNode.tagName;
		//prodURL = xml.getElementsByTagName('url')[0].childNodes[0].nodeValue;
		row = urls[n].parentNode.parentNode.tagName;
		prodURL = urls[n].childNodes[0].nodeValue;

		dir = prodURL.substr(0, prodURL.indexOf('/p_')).replace('http://www.teleflora.com', '');
		//alert(dir);
		sku = prodURL.substr(prodURL.indexOf('/p_')+3, prodURL.indexOf('?')-prodURL.indexOf('/p_')-3);
		//alert(sku);
		qs += '&products["'+ row +'"][]='+ dir +'/p_'+ sku.toLowerCase();
		totProds += 1;
		}
	}
//alert(qs);
// jQuery JsonP call scraper (non-IE)
url = 'http://webproducer.telefloramarketing.com/emailautogen/jac.php?'+ qs;
var prod = [];
$.getJSON(url, function(data) {
	//alert(data['row1']['product1'] +'\n'+ data['row1']['price']);

	//dyntag = xml.getElementsByTagName('dynamic')[0];
//alert(prodEle[0].children[1].nodeName);
//alert('test1 '+ xml.getElementsByTagName('presentation')[0].childNodes[1].childNodes[0].nodeValue);

	bod.innerHTML = bod.innerHTML +'<div style="padding-left:20px;">Scraping...</div>';

	// Create XML tags for hero Product(s)
	if (typeof data['hero'] != 'undefined') {
		if (typeof data['hero']['product0'] != 'undefined') { // HERO product
			prodName = xml.createTextNode(data['hero']['product0']);
			prodPrice = xml.createTextNode(data['hero']['price0']);
		prodEle = xml.getElementsByTagName('hero');
		//tag = xml.createElement('prod'+ n +'name');
		nameTag = xml.createElement('name');
		// Create product price tag for XML
		priceTag = xml.createElement('price');
			
		nameTag.appendChild(prodName);
		prodEle[0].appendChild(nameTag);
	
		priceTag.appendChild(prodPrice);
		prodEle[0].appendChild(priceTag);
			}

		if (typeof data['hero']['product1'] != 'undefined') { // Side1 product
			prodEle = xml.getElementsByTagName('sideHero');
			prodName = xml.createTextNode(data['hero']['product1']);
			prodPrice = xml.createTextNode(data['hero']['price1']);
		//tag = xml.createElement('prod'+ n +'name');
		nameTag = xml.createElement('name');
		// Create product price tag for XML
		priceTag = xml.createElement('price');
			
		nameTag.appendChild(prodName);
		prodEle[0].appendChild(nameTag);
	
		priceTag.appendChild(prodPrice);
		prodEle[0].appendChild(priceTag);
			}

		if (typeof data['hero']['product2'] != 'undefined') { // Side2 product
			prodEle = xml.getElementsByTagName('sideHero');
			prodName = xml.createTextNode(data['hero']['product2']);
			prodPrice = xml.createTextNode(data['hero']['price2']);
		//tag = xml.createElement('prod'+ n +'name');
		nameTag = xml.createElement('name');
		// Create product price tag for XML
		priceTag = xml.createElement('price');
			
		nameTag.appendChild(prodName);
		prodEle[1].appendChild(nameTag);
	
		priceTag.appendChild(prodPrice);
		prodEle[1].appendChild(priceTag);
			}

		}

	// Create XML tags for sub-products
	prodEle = xml.getElementsByTagName('product');
	xmlCnt = 0;
	for(n=1; n <= maxProds; n++) { // n counts the number of products from PHP returned json
		// Create product name tag for XML
		//tag = xml.createElement('prod'+ n +'name');
		nameTag = xml.createElement('name');

		// Create product price tag for XML
		priceTag = xml.createElement('price');

		if (typeof data['row1'] != 'undefined' && typeof data['row1']['product'+ n] != 'undefined') { // Sub products
			prodName = xml.createTextNode(data['row1']['product'+ n]);
			prodPrice = xml.createTextNode(data['row1']['price'+ n]);
			//alert(prodEle[n-1] +' - '+ data['row1']['product'+ n] +' '+ data['row1']['price'+ n]);
			
			} else if(typeof data['row2'] != 'undefined' && typeof data['row2']['product'+ n] != 'undefined') { // Sub products
			prodName = xml.createTextNode(data['row2']['product'+ n]);
			prodPrice = xml.createTextNode(data['row2']['price'+ n]);
			
			} else if(typeof data['row3'] != 'undefined' && typeof data['row3']['product'+ n] != 'undefined') { // Sub products
			prodName = xml.createTextNode(data['row3']['product'+ n]);
			prodPrice = xml.createTextNode(data['row3']['price'+ n]);
			}
		
		// Dynamically insert new tags into XML
		if (typeof prodEle[n-1] != 'undefined' && typeof prodName != 'undefined') {
			//alert(n);
			// Add product name tag to XML
			nameTag.appendChild(prodName);
			prodEle[n-1].appendChild(nameTag);
	
			// Add product name tag to XML
			priceTag.appendChild(prodPrice);
			prodEle[n-1].appendChild(priceTag);
			}
			
		// Add product price tag to XML
		//tag = xml.createElement('prod'+ n +'price');
		//text = xml.createTextNode(data['price'+ n]);
		//tag.appendChild(text);
		//dyntag.appendChild(tag);
		
		xmlCnt++;
		
		bod.innerHTML = bod.innerHTML +'<div style="padding-left:25px; color:#999999;"><i>- product '+ n +' scraped...</i></div>';
		}
	
	// Set path to XSL template
	xslfile = tplt.nodeValue +'/email.xsl';
	
	// Get XSL template
	xsl = loadXMLDoc(xslfile, 'xml');
	
	// Generate HTML page (non-IE)
	if (document.implementation && document.implementation.createDocument) {
		xsltProcessor = new XSLTProcessor();

		bod.innerHTML = bod.innerHTML +'<div style="padding-left:20px;">Importing XSL...</div>';
		xsltProcessor.importStylesheet(xsl);

		bod.innerHTML = bod.innerHTML +'<div style="padding-left:20px;">Merging XML & XSL</div>';
		resultSegment = xsltProcessor.transformToFragment(xml,document);

		document.getElementById('body').innerHTML = '';
		document.getElementById('body').appendChild(resultSegment);
		}
	})
