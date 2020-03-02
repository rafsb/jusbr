<?php
namespace faau;
require "IO.php";
require "html.php";
require "default.php";

$htmls = IO::scan("var", "html", false);
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
// $all = [];

foreach($htmls as $html){

	$obj = [];
	$file = \file_get_html("var/$html");
	
	if($file){
		// DATE
		if(sizeof($file->find(".BreadCrumb.breadcrumb a"))){
			$date = explode(' ', $file->find(".BreadCrumb.breadcrumb a")[2]->plaintext);
			if(isset($date[1])){
				$date[1] = isset($months[$date[1]]) ? $months[$date[1]] : $date[1];
			}
			$obj["data"] = implode('/', $date);
		}
		$obj["data"] = "";

		// PLAINTEXT
		$text = $file->find(".DocumentView-content-text")&&$file->find(".DocumentView-content-text")[0] ? 
			$file->find(".DocumentView-content-text")[0]->plaintext 
			: ($file->find("body")&&$file->find("body")[0] ? $file->find("body")[0]->plaintext : IO::read("var/$html"));
		if($text){
			preg_match_all("/[0-9]{7}[-.][0-9]{2}[-.][0-9]{4}[-.][0-9]{1}[-.][0-9]{2}[-.][0-9]{4}/", $text, $founds, PREG_OFFSET_CAPTURE);
			$textarray = preg_split("/[0-9]{7}[-.][0-9]{2}[-.][0-9]{4}[-.][0-9]{1}[-.][0-9]{2}[-.][0-9]{4}/", $text);
			if(sizeof($founds)){
				foreach($founds as $id => $nproc){
					if(isset($nproc[0])){
						$obj["codigo"] = $nproc[0][0];
						$obj["texto"] = $textarray[$id];
						$txt = normalize($textarray[$id]);

						/*
						// PROVIMENTO
						$obj["provimento"] = false;
						preg_match("/(provid[ao])|(provimento)/", $txt, $matches, PREG_OFFSET_CAPTURE);
						if(sizeof($matches)){
							$txt = substr($tmp->body, $matches[0][1]-20, 50);
							$provtext = $matches[0][0];
							$obj["provimento"] = "PROVIDO";
							// NEGADOS
							preg_match("/(nao)|(negaram)|(negar)|(negad[ao])/", $txt, $matches, PREG_OFFSET_CAPTURE);
							if(sizeof($matches)) $obj["provimento"] = "NÃO PROVIMENTO";					
							// PARCIAILMENTE PROVIDOS
							preg_match("/(parcial)|(parte)/", $txt, $matches, PREG_OFFSET_CAPTURE);
							if(sizeof($matches)) $obj["provimento"] = "PROVIDO PARCIALMENTE";
							// PROVIDOS
							if(!$obj["provimento"]) $obj["provimento"] = "PROVIDO";
						}
						*/

						// AUTOR
						// $obj["autor"] = "";
						// preg_match("/(exeqte)|(recte\/recd[ao])|(apte\/apd[ao])|( agte)|(reqte)|(recorrente)|(requerente)|(interpost[ao])|(apelante)|(agravante)|(autor)/", $txt, $matches, PREG_OFFSET_CAPTURE);
						// if(sizeof($matches)) $obj["autor"] = trim(substr($txt, $matches[0][1], 40));

						// RÉU
						// $obj["reu"] = "";
						// preg_match("/(exectd[ao])|(rcrd[ao]\/rcrte)|(apd[ao]\/apte)|( agd[ao])|(executad[ao])|(exectd[ao])|(reqd[ao])|(requerid[ao])|(apelad[ao])|( reu[:\s])|(rA©u)|(demandad[ao])|(contra)|(desfavor)|(recorrid[ao])|(agravad[ao])|(interessad[ao])|( re:)|(agravad[ao])|(reclamad[ao])/", $txt, $matches, PREG_OFFSET_CAPTURE);
						// if(sizeof($matches)) $obj["reu"] = trim(substr($txt, $matches[0][1], 40));

						// $all[] = $obj;
						$name = preg_replace("/[^0-9a-zA-Z]/", "", $obj["data"]  . $obj["codigo"]);
						IO::jin("parsed_objects/$name.json", $obj);
						echo "\r " . barload($current, $overall) . " << $name";
						usleep(100);
					}
				}
			}
		}
	}

	if(false&&$current==10) break;

	$current++;
}