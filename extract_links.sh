
if [[ $1 = "" ]]; then
	echo -e "\n\nuso:\n\tsh ./extract_links.sh cfg/<CONFIG_FILENAME>\n\n"
	exit 1
fi

SEEK=$(cat $1     | grep -v  '#' | grep search_terms | cut -d'=' -f2 | sed 's/"//g')
FROM=$(cat $1     | grep -v  '#' | grep date_from    | cut -d'=' -f2 | sed 's/"//g')
TO=$(cat $1       | grep -v  '#' | grep date_to      | cut -d'=' -f2 | sed 's/"//g')
PAGE=$(cat $1     | grep -v  '#' | grep start_point  | cut -d'=' -f2 | sed 's/"//g')
STOP=$(cat $1     | grep -v  '#' | grep stop_point   | cut -d'=' -f2 | sed 's/"//g')
FILENAME=$(cat $1 | grep -v  '#' | grep output       | cut -d'=' -f2 | sed 's/"//g')

RESTRICTION="BaseSnippetWrapper-title-anchor"
QUERY="q=$SEEK&dateFrom=$FROM&dateTo=$TO" 
URL="https://www.jusbrasil.com.br/diarios/busca?"$( echo $QUERY |  sed 's/ /+/g')

while [ $STOP -gt 0 ]; do
	TMPFILE=$FILENAME"/p"$PAGE".html"
	mkdir -p var/$FILENAME tmp/$FILENAME
	echo -ne "\r -> $URL"&p="$PAGE"
	links -source $URL"&p="$PAGE  | tee "tmp/"$TMPFILE > /dev/null 2>&1

	if [ -z "$( grep -nE "BaseSnippetWrapper-title-anchor" "tmp/"$TMPFILE )" ]; then
		rm "tmp/"$TMPFILE
		break
	else
		mkdir -p "var/"$FILENAME"/i"$PAGE
		ITER=0;
		for i in $(cat "tmp/"$TMPFILE | grep -Eoi '<a [^>]+>' | grep 'BaseSnippetWrapper-title-anchor' | awk -F'href=\"' '{print $2}' | cut -d' ' -f1 | sed 's/\"/ /g' | grep -v "trt"); do
			links -source $i | tee --append "var/"$FILENAME"/i"$PAGE"/p"$ITER".html" > /dev/null 2>&1
			ITER=$((ITER+1))
			sleep .250 > /dev/null 2>&1
		done		
		rm "tmp/"$TMPFILE
	fi
	PAGE=$((PAGE+1))
	STOP=$((STOP-1))
	sleep 1 > /dev/null 2>&1
done