
if [[ $1 = "" ]]; then
	echo -e "\n\nuso:\n\tsh ./extract_links.sh <TERMO DE PESQUISA> <DATA INICIO> <DATA FINAL> <PAGINA INICIAL> <QTDDE DE PÁG> <FILTROS>"
	echo -e "\nex:\n\tsh ./extract_links.sh \"'claro s/a' indeferido\" 2020-01-01 2020-01-31 1 200 \"'claro%sa' indeferido\"\n\n"
	exit 1
fi

SEEK=$1
FROM=$2
TO=$3
LIMIT=$4
STOP=$5
FILTER=$SEEK

if [[ $2 != "" ]]; then
	FROM=$2
else
	FROM="1990-01-01"
fi

if [[ $3 != "" ]]; then
	TO=$3
else
	TO="2020-12-31"
fi

if [[ $4 != "" ]]; then
	LIMIT=$4
else
	LIMIT="1"
fi

if [[ $5 != "" ]]; then
	STOP=$5
else
	STOP="200"
fi

if [[ $6 != "" ]]; then
	FILTER=$6
fi


RESTRICTION="BaseSnippetWrapper-title-anchor"
QUERY="q=$SEEK&dateFrom=$FROM&dateTo=$TO" 
URL="https://www.jusbrasil.com.br/diarios/busca?"$( echo $QUERY |  sed 's/ /+/g')
FILENAME=$( echo $QUERY | sed 's/[^0-9a-zA-Z]//g' )

echo "" > "var/"$FILENAME".txt"
while [ $STOP -gt 0 ]; do
	FULLFILENAME=$FILENAME"_p"$LIMIT".html"
	echo -e "\n\n|> generating "$FULLFILENAME;

	mkdir -p var tmp
       	
	#php gen_links.php $FULLFILENAME
	#exit 1	

	links -source $URL"&p="$LIMIT  | tee "tmp/"$FULLFILENAME > /dev/null 2>&1

	echo -e "|"
	echo -e "\__> pag: "$LIMIT

	if [ -z "$( grep -nE "BaseSnippetWrapper-title-anchor" "tmp/"$FULLFILENAME )" ]; then
		rm "tmp/"$FULLFILENAME
		printf "\____> done until $LIMIT\n"
		break
	else
		echo -e "\__> creating tmp tmp/"$FILENAME"_p"$LIMIT
		mkdir -p "tmp/"$FILENAME"_p"$LIMIT
		mkdir -p "var/"$FILENAME"_p"$LIMIT
		ITER=0;
		for i in $(cat "tmp/"$FULLFILENAME | grep -Eoi '<a [^>]+>' | grep 'BaseSnippetWrapper-title-anchor' | awk -F'href=\"' '{print $2}' | cut -d' ' -f1 | sed 's/\"/ /g' | grep -v "trt"); do
			echo -e "|"
			echo -e "\____> "$i
			echo -e "\____> dumping"
			links -source $i | tee --append "var/"$FILENAME"_p"$LIMIT"_"$ITER".html" > /dev/null 2>&1
			ITER=$((ITER+1))
			# sleep .5 > /dev/null 2>&1
			# links -dump $i | tee --append "var/"$FILENAME".txt" > /dev/null 2>&1
			sleep .1 > /dev/null 2>&1
		done
		echo -e "|"
		echo -e "\__> cleaning\n"
		rm -rf "tmp/"$FILENAME"_p"$LIMIT
		rm -rf "var/"$FILENAME"_p"$LIMIT
		rm "tmp/"$FULLFILENAME
	fi
	LIMIT=$((LIMIT+1))
	STOP=$((STOP-1))
	# rm $FULLFILENAME
	sleep 1 > /dev/null 2>&1
	# break # test porpouse
done
# php refactor.php "var/"$FILENAME $FILTER
