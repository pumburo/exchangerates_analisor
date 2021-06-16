#!/bin/bash

clear
line=$( cat data.txt | wc -l )
find exchangerates > /dev/null
fcreator=$( echo $? )
if [[ $fcreator != 0 ]]; then
	mkdir exchangerates
fi
for (( x = 1; x <= $line; x++ )); do
	a=$( cat data.txt | head -n $x | tail -1 )
	find ./exchangerates/$a.json 
	res=$( echo $? )
	if [[ $res == 0 ]]; then
		:
	elif [[ $res != 0 ]]; then
		echo $a >> ./exchangerates/missingdates.txt
	fi
done
newline=$( cat ./exchangerates/missingdates.txt | wc -l )
for (( i = 0; i < $newline; i++ )); do
	newdate=$( cat ./exchangerates/missingdates.txt | head -n $i | tail -1 )
	curl -s https://api.exchangeratesapi.io/$newdate | python -m json.tool > ./exchangerates/$newdate.json
	cat ./exchangerates/$newdate.json | grep "There is no data" > /dev/null
	savereq=$( echo $? )
	if [[ $savereq == 0 ]]; then
		rm ./exchangerates/$newdate.json
	fi
	clear
	if [[ $savereq != 0 ]]; then
		cat ./exchangerates/$newdate.json
	fi
done
rm ./exchangerates/missingdates.txt
clear
echo "Sequence is complete. All json files saved in exchangerates folder."
rm data.txt
