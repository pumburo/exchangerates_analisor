#!/bin/bash
echo "Creating the date data."
sleep 3
bash datedatacreator.sh
echo "Exchange rates mining is started."
sleep 3
bash exchangeratesminer.sh
bash watcs.sh