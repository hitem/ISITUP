#!/bin/bash

# Started out with isup.sh, ended up with isitup.sh
# ICMP was not enough, rewrote and reused some parts, thanks @___0x00 (github: gitnepal), pogchamp
# hitemSec 2022

#COLORS
BLUE='\033[94m'
RED='\033[91m'
GREEN='\033[92m'
ORANGE='\033[93m'
IRED='\033[0;91m'
IGREEN='\033[0;92m'
RESET='\e[0m'

#PATHS
TARGET="$1"
CURRENT_PATH=$(pwd)

#DEPENDENCIES
sudo apt-get -y install lolcat hping3
clear

#CODE
if [ -z $TARGET ]; then
echo -e " ▄ .▄▪  ▄▄▄▄▄▄▄▄ .• ▌ ▄ ·. .▄▄ · ▄▄▄ . ▄▄·  " | lolcat
echo -e "██▪▐███ •██  ▀▄.▀··██ ▐███▪▐█ ▀. ▀▄.▀·▐█ ▌▪ " | lolcat
echo -e "██▀▐█▐█· ▐█.▪▐▀▀▪▄▐█ ▌▐▌▐█·▄▀▀▀█▄▐▀▀▪▄██ ▄▄ " | lolcat
echo -e "██▌▐▀▐█▌ ▐█▌·▐█▄▄▌██ ██▌▐█▌▐█▄▪▐█▐█▄▄▌▐███▌ " | lolcat
echo -e "▀▀▀ ·▀▀▀ ▀▀▀  ▀▀▀ ▀▀  █▪▀▀▀ ▀▀▀▀  ▀▀▀ ·▀▀▀  " | lolcat
echo -e ""
echo -e "$ORANGE              ~:ISITUP:~"
echo -e "$ORANGE Improve your reconnaissance by$RED hitemSec"
echo ""
echo -e "$GREEN [+] https://twitter.com/hitemSec"
echo -e "$GREEN [+] https://github.com/hitem"
echo -e "$GREEN [-] Usage: isitup.sh [-h --help] [<targetlist>]"
echo -e "$ORANGE __________________________________________"
exit
fi

if [[ $TARGET == "--help" ]] || [[ $TARGET == "-h" ]]; then
echo -e " ▄ .▄▪  ▄▄▄▄▄▄▄▄ .• ▌ ▄ ·. .▄▄ · ▄▄▄ . ▄▄·  " | lolcat
echo -e "██▪▐███ •██  ▀▄.▀··██ ▐███▪▐█ ▀. ▀▄.▀·▐█ ▌▪ " | lolcat
echo -e "██▀▐█▐█· ▐█.▪▐▀▀▪▄▐█ ▌▐▌▐█·▄▀▀▀█▄▐▀▀▪▄██ ▄▄ " | lolcat
echo -e "██▌▐▀▐█▌ ▐█▌·▐█▄▄▌██ ██▌▐█▌▐█▄▪▐█▐█▄▄▌▐███▌ " | lolcat
echo -e "▀▀▀ ·▀▀▀ ▀▀▀  ▀▀▀ ▀▀  █▪▀▀▀ ▀▀▀▀  ▀▀▀ ·▀▀▀  " | lolcat
echo -e ""
echo -e "$ORANGE              ~:ISITUP:~"
echo -e "$ORANGE Improve your reconnaissance by$RED hitemSec"
echo ""
echo -e "$GREEN [+] https://twitter.com/hitemSec"
echo -e "$GREEN [+] https://github.com/hitem"
echo -e "$GREEN [-]$BLUE Usage: isitup.sh [<targetlist>],$ORANGE example ./isitup.sh myiplist.txt"
echo -e "$GREEN [-]$BLUE Usage: Modify script to include other ports on line 83"
echo -e "$ORANGE __________________________________________"
exit
fi

if [ ! -f $TARGET ]; then
echo -e ""
echo -e "$IRED ######################     [FILE NOT FOUND] "
echo -e ""
echo -e "$GREEN [-]$BLUE Usage: isitup.sh [-h --help] [<targetlist>],$ORANGE example ./isitup.sh myiplist.txt"
exit
fi

REMOVEDIR=$(rm -r "$CURRENT_PATH/tmp/")
CREATEDIR=$(mkdir -p "$CURRENT_PATH/tmp/")
FILENAME=$(basename $TARGET)

echo -e " ▄ .▄▪  ▄▄▄▄▄▄▄▄ .• ▌ ▄ ·. .▄▄ · ▄▄▄ . ▄▄·  " | lolcat
echo -e "██▪▐███ •██  ▀▄.▀··██ ▐███▪▐█ ▀. ▀▄.▀·▐█ ▌▪ " | lolcat
echo -e "██▀▐█▐█· ▐█.▪▐▀▀▪▄▐█ ▌▐▌▐█·▄▀▀▀█▄▐▀▀▪▄██ ▄▄ " | lolcat
echo -e "██▌▐▀▐█▌ ▐█▌·▐█▄▄▌██ ██▌▐█▌▐█▄▪▐█▐█▄▄▌▐███▌ " | lolcat
echo -e "▀▀▀ ·▀▀▀ ▀▀▀  ▀▀▀ ▀▀  █▪▀▀▀ ▀▀▀▀  ▀▀▀ ·▀▀▀  " | lolcat
echo -e ""
echo -e "$ORANGE [+] hitemSec inspired by $RED@___0x00"
echo -e " ######################################################     [INITIATING] " | lolcat
echo -e ""
for ENTRIES in $(cat $TARGET) 
do
    hping3 -S -p 80,443,8080 -c 1 -w 1 $ENTRIES > /dev/null 2>&1
    if [[ $? -eq 0 ]];
    then
        echo -e "$IGREEN [+] $ENTRIES $RESET"
        echo -e " $ENTRIES" | tee -a $CURRENT_PATH/tmp/valid-$FILENAME > /dev/null 2>&1
    else
        echo -e " $ENTRIES" | tee -a $CURRENT_PATH/tmp/notvalid-$FILENAME 
    fi
done
echo -e ""
echo -e "$BLUE  Valid domains saved to: $ORANGE tmp/valid-$FILENAME  $RESET"
echo -e "$BLUE  Invalid domains saved to: $ORANGE tmp/notvalid-$FILENAME  $RESET"
echo -e ""

ALIVEC=$(cat $CURRENT_PATH/tmp/valid-$FILENAME | sort -u | wc -l)
DOWNC=$(cat $CURRENT_PATH/tmp/notvalid-$FILENAME | sort -u | wc -l)
TOTALC=$(cat $TARGET | sort -u | wc -l )
echo -e "$BLUE  [TOTAL]: ${TOTALC} $RESET     $IGREEN[ALIVE]: ${ALIVEC} $RESET     $IRED[DOWN]: ${DOWNC}"
echo -e " ######################################################     [COMPLETED] " | lolcat