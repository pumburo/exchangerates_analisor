#!/bin/bash

echo "Started"
sleep 3
line=$( ls -l ./exchangerates | wc -l )
sayac=1
while :
do
	let sayac++
	prefile=$( ls -l ./exchangerates | head -n $sayac | tail -1 | awk '{ print $9 }' )
	file="$prefile"
	cat ./exchangerates/$file >> newfile.txt
	if [[ $sayac == $line ]]; then
		break
	fi
	echo "$sayac / $line"
done

echo "Sequence is complete. "
sleep 5

echo "Delete newfile? 1=Yes"
read sil
if [[ $sil == 1 ]]; then
	rm newfile.txt
fi
