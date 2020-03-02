<?php
namespace faau;
require "lib/lib.php";

print_r($argv);

if(!isset($argv)||!sizeof($argv)||!isset($argv[1])){
	echo "\nusage:\n\tphp filter.php folder_to_scan/ var/output_file.txt regex\ (one|main) regex\ (two|second)";
	die;
}

$htmls = IO::scan($argv[1], "html", false);
$finalfile = $argv[2];
$regex1 = $argv[3];
$regex2 = $argv[4];
$overall = sizeof($htmls);
$months = [
	"Jan"=>"01"
	, "Fev"=>"02"
	, "Mar"=>"03"
	, "Abr"=>"04"
	, "Mai"=>"05"
	, "Jun"=>"06"
	, "Jul"=>"07"
	, "Ago"=>"08"
	, "Set"=>"09"
	, "Out"=>"10"
	, "Nov"=>"11"
	, "Dez"=>"12" 
];
$current = 0;
$count = 0;
IO::write($finalfile,""); 

foreach($htmls as $html){

	$obj = [];
	$file = \file_get_html($argv[1] . "/$html");
	
	if($file){

		// DATE
		$obj["date"] = "";
		if(sizeof($file->find(".BreadCrumb.breadcrumb a"))){
		 	$date = explode(' ', $file->find(".BreadCrumb.breadcrumb a")[2]->plaintext);
		 	if(isset($date[1])){
		 		$date[1] = isset($months[$date[1]]) ? $months[$date[1]] : $date[1];
		 	}
		 	$obj["date"] = implode('/', $date);
		}

		// PLAINTEXT
        $text = $file->find("body") && $file->find("body")[0] ? $file->find("body")[0]->plaintext : null;
		if($text){

			preg_match_all("/[0-9]{7}[-.\s][0-9]{2}[-.\s][0-9]{4}[-.\s][0-9]{1}[-.\s][0-9]{2}[-.\s][0-9]{4}/", $text, $founds, PREG_OFFSET_CAPTURE);

			if(sizeof($founds[0])){
				for($i=0; $i<sizeof($founds[0]); $i++){
					
					$exportabletext = isset($founds[0][$i+1]) ? substr($text, $founds[0][$i][1], $founds[0][$i+1][1]-$founds[0][$i][1]) : substr($text, $founds[0][$i][1]);
					$tx = normalize($exportabletext);

					if(preg_match("/$regex1/ui", $tx) && preg_match("/$regex2/ui", $tx)){

						$final = IO::read($finalfile);
						usleep(400);
						$final = IO::write($finalfile, $final."\n".$obj["date"].";".$founds[0][$i][0].";".trim(preg_replace("/;|\s+/"," ",substr($exportabletext,26))));
					}
					usleep(400);
				}
			}

		}

	}

}