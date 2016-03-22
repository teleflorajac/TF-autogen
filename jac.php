<?php
// Parse provided PDP's on TFcom to gather Name and Price.
/* Sample data to be returned: 
{ 
"row1" : { 
	"product1" : "Teleflora's Sunny Day Pitcher of Sunflowers", 
	"price1" : " $62.95", 
	"product2" : "Teleflora's Fun 'n Festive Bouquet", 
	"price2" : " $49.95"
	}, 
"row2" : { 
	"product3" : "WeberÂ® Hot Off The Grill by Teleflora Flower Arrangement", 
	"price3" : " $49.95", 
	"product4" : "Teleflora's Sunny Day Pitcher of Sunflowers", 
	"price4" : " $62.95", 
	"product5" : "Teleflora's Fun 'n Festive Bouquet", 
	"price5" : " $49.95"
	} 
}
*/

if (isset($_REQUEST['products'])) {
	$c = -1;
	$n = 0;
	foreach($_REQUEST['products'] AS $row => $rowArr) {
		$json1 .= ', '. $row .' : { ';
		
		foreach($rowArr AS $prod) {
			// "row0" means it's the hero and no need to increment "n"
			if ($row == '"hero"') {
				$c++;
				$n = '';
				} else {
				$n++;
				$c = '';
				}
		
			$html = @file_get_contents('http://www.teleflora.com'. $prod);
		
			/*** a new dom object ***/
			$dom = new domDocument;
			
			/*** load the html into the object ***/
			@$dom->loadHTML($html);
			
			/*** discard white space ***/
			$dom->preserveWhiteSpace = false;
			
			/*** get product name from title ***/
			$title = $dom->getElementsByTagName('title');
			$json2 .= ', "product'. $n . $c .'" : "'. str_replace('Â', '', str_replace(' - Teleflora', '', $title->item(0)->nodeValue)) .'"';
			
			/** get standard price **/
			$price = $dom->getElementById('standard_size_price');
			$json2 .= ', "price'. $n . $c .'" : "'. $price->nodeValue .'"';
		
		
			/*** get all rows from the table ***/
			//$rows = $tables->item(0)->getElementsByTagName('tr');
		
			/*** loop over the table rows ***/
			//foreach ($rows as $row) {
				/*** get each column by tag name ***/
				//$cols = $row->getElementsByTagName('td');
				/*** echo the values ***/
				//echo $cols->item(0)->nodeValue.'<br />';
				//echo $cols->item(1)->nodeValue.'<br />';
				//echo $cols->item(2)->nodeValue;
				//echo '<hr />';
			//}
			}
		
		$json1 .= substr($json2, 1) .'}';
		$json2 = ''; // reset
		}
	} else {
	$json = '"Error" : "Could not load product SKU: '. $_REQUEST['products'] .'"';
	}

echo '{ '. substr($json1, 1) .' }';
?>