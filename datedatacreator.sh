#!/bin/bash

thisday=$( date +%d )
ny=$( date +%Y )
if [[ $( echo $thisday | head -c 1 ) == 0 ]]; then
	thisday=$( echo $thisday | head -c 2 | tail -c 1 )
fi
thismonth=$( date +%m )
if [[ $( echo $thismonth | head -c 1 ) == 0 ]]; then
	thismonth=$( echo $thismonth | head -c 2 | tail -c 1 )
fi
thisyear=$( date +%Y )
today=$thisyear-$thismonth-$thisday
find data.txt > /dev/null
firstres=$( echo $? )
if [[ $firstres == 0 ]]; then
	rm data.txt
fi
for (( year = 1999; year <= $ny; year++ )); do
	for (( month = 1; month <= 12; month++ )); do
		if [ $month -eq 1 ] || [ $month -eq 5 ] || [ $month -eq 7 ] || [ $month -eq 8 ] || [ $month -eq 10 ] || [ $month -eq 12 ]; then
			for (( day = 1; day <= 31; day++ )); do
				loopday=$( echo $year-$month-$day )
				if [[ $loopday != $today ]]; then
					echo $loopday >> data.txt
					echo $loopday
				elif [[ $loopday == $today ]]; then
					echo $today >> data.txt
					echo $today
					break
				fi	
			done
		elif [ $month -eq 2 ] || [ $month -eq 4 ] || [ $month -eq 6 ] || [ $month -eq 9 ] || [ $month -eq 11 ]; then
			for (( day = 1; day <= 30; day++ )); do
				loopday=$( echo $year-$month-$day )
				if [[ $loopday != $today ]]; then
					echo $loopday >> data.txt
					echo $loopday
				elif [[ $loopday == $today ]]; then
					echo $today >> data.txt
					echo $today
					break
				fi
			done
		elif [ $month -eq 3 ]; then
			ysyd=`expr $year % 4`
			if [[ $ysyd == 0 ]]; then
				for (( day = 1; day <= 29; day++ )); do
					loopday=$( echo $year-$month-$day )
					if [[ $loopday != $today ]]; then
						echo $loopday >> data.txt
						echo $loopday
					elif [[ $loopday == $today ]]; then
						echo $today >> data.txt
						echo $today
						break
					fi
				done
			elif [[ $ysyd != 0 ]]; then
				for (( day = 1; day <= 28; day++ )); do
					loopday=$( echo $year-$month-$day )
					if [[ $loopday != $today ]]; then
						echo $loopday >> data.txt
						echo $loopday
					elif [[ $loopday == $today ]]; then
						echo $today >> data.txt
						echo $today
						break
					fi
				done
			fi
		fi	
		if [[ $loopday == $today ]]; then
			break
		fi
	done
done

clear 

echo "All dates created. You can find the dates in data.txt file. "
sleep 3