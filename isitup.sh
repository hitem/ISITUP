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
sudo apt-get -y install lolcat hping3 prips
clear

#CODE
if [ -z $TARGET ]; then
echo -e "  ▄ .▄▪  ▄▄▄▄▄▄▄▄ .• ▌ ▄ ·. .▄▄ · ▄▄▄ . ▄▄·  \n ██▪▐███ •██  ▀▄.▀··██ ▐███▪▐█ ▀. ▀▄.▀·▐█ ▌▪ \n ██▀▐█▐█· ▐█.▪▐▀▀▪▄▐█ ▌▐▌▐█·▄▀▀▀█▄▐▀▀▪▄██ ▄▄ \n ██▌▐▀▐█▌ ▐█▌·▐█▄▄▌██ ██▌▐█▌▐█▄▪▐█▐█▄▄▌▐███▌ \n ▀▀▀ ·▀▀▀ ▀▀▀  ▀▀▀ ▀▀  █▪▀▀▀ ▀▀▀▀  ▀▀▀ ·▀▀▀  " | lolcat
echo -e ""
echo -e "$ORANGE              ~:ISITUP:~"
echo -e "$ORANGE Improve your reconnaissance by$RED hitemSec"
echo -e ""
echo -e "$GREEN [+] https://twitter.com/hitemSec"
echo -e "$GREEN [+] https://github.com/hitem"
echo -e "$GREEN [-] Usage: isitup.sh [-h --help] [-s --scope] [<targetlist>]"
echo -e "$ORANGE __________________________________________"
exit
fi

if [[ $TARGET == "--help" ]] || [[ $TARGET == "-h" ]]; then
echo -e "  ▄ .▄▪  ▄▄▄▄▄▄▄▄ .• ▌ ▄ ·. .▄▄ · ▄▄▄ . ▄▄·  \n ██▪▐███ •██  ▀▄.▀··██ ▐███▪▐█ ▀. ▀▄.▀·▐█ ▌▪ \n ██▀▐█▐█· ▐█.▪▐▀▀▪▄▐█ ▌▐▌▐█·▄▀▀▀█▄▐▀▀▪▄██ ▄▄ \n ██▌▐▀▐█▌ ▐█▌·▐█▄▄▌██ ██▌▐█▌▐█▄▪▐█▐█▄▄▌▐███▌ \n ▀▀▀ ·▀▀▀ ▀▀▀  ▀▀▀ ▀▀  █▪▀▀▀ ▀▀▀▀  ▀▀▀ ·▀▀▀  " | lolcat
echo -e ""
echo -e "$ORANGE              ~:ISITUP:~"
echo -e "$ORANGE Improve your reconnaissance by$RED hitemSec"
echo -e ""
echo -e "$GREEN [+] https://twitter.com/hitemSec"
echo -e "$GREEN [+] https://github.com/hitem"
echo -e "$GREEN [-]$BLUE Usage: isitup.sh [-h --help] [-s --scope] [targetlist]"
echo -e "$GREEN [-]$BLUE Usage: Modify script to include other ports on line 85 or 135"
echo -e "$GREEN [-]$ORANGE Example ./isitup.sh myiplist.txt"
echo -e "$GREEN [-]$ORANGE Example ./isitup.sh -s"
echo -e "$GREEN [-]$ORANGE Example ./isitup.sh --help"
echo -e "$ORANGE __________________________________________"
exit
fi

CREATEDIR=$(mkdir -p "$CURRENT_PATH/tmp/")
if [[ $TARGET == "--scope" ]] || [[ $TARGET == "-s" ]]; then
echo -e "  ▄ .▄▪  ▄▄▄▄▄▄▄▄ .• ▌ ▄ ·. .▄▄ · ▄▄▄ . ▄▄·  \n ██▪▐███ •██  ▀▄.▀··██ ▐███▪▐█ ▀. ▀▄.▀·▐█ ▌▪ \n ██▀▐█▐█· ▐█.▪▐▀▀▪▄▐█ ▌▐▌▐█·▄▀▀▀█▄▐▀▀▪▄██ ▄▄ \n ██▌▐▀▐█▌ ▐█▌·▐█▄▄▌██ ██▌▐█▌▐█▄▪▐█▐█▄▄▌▐███▌ \n ▀▀▀ ·▀▀▀ ▀▀▀  ▀▀▀ ▀▀  █▪▀▀▀ ▀▀▀▀  ▀▀▀ ·▀▀▀  " | lolcat
echo -e ""
echo -e "$ORANGE              ~:ISITUP:~"
echo -e "$ORANGE Improve your reconnaissance by$RED hitemSec"
echo -e ""
echo -e "$BLUE Enter a valid IP scope, example$RESET 192.168.0.0/24$BLUE ,$RESET 10.0.1.0/16"
echo -e "$BLUE If you have selected a large scope, this process will take time! $RESET"
echo -e "$ORANGE __________________________________________$RESET"
echo -e ""
echo -e " Enter your scope and press $IGREEN[ENTER]$RESET to begin"
read SCOPE
prips $SCOPE > $CURRENT_PATH/tmp/ManualScope.txt
echo -e ""
echo -e " ######################################################     [INITIATING] " | lolcat
echo -e ""
for ENTRIES in $(cat $CURRENT_PATH/tmp/ManualScope.txt) 
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
TOTALC=$(cat $CURRENT_PATH/tmp/ManualScope.txt | sort -u | wc -l )
echo -e "$BLUE  [TOTAL]: ${TOTALC} $RESET     $IGREEN[ALIVE]: ${ALIVEC} $RESET     $IRED[DOWN]: ${DOWNC}"
echo -e " ######################################################     [COMPLETED] " | lolcat
exit
fi

if [ ! -f $TARGET ]; then
echo -e ""
echo -e "$IRED ######################     [FILE NOT FOUND] "
echo -e ""
echo -e "$GREEN [+]$BLUE Usage: isitup.sh [targetlist]"
echo -e "$GREEN [-]$ORANGE Example ./isitup.sh myiplist.txt"
exit
fi

REMOVEDIR=$(rm -r "$CURRENT_PATH/tmp/")
CREATEDIR=$(mkdir -p "$CURRENT_PATH/tmp/")
FILENAME=$(basename $TARGET)

echo -e "  ▄ .▄▪  ▄▄▄▄▄▄▄▄ .• ▌ ▄ ·. .▄▄ · ▄▄▄ . ▄▄·  \n ██▪▐███ •██  ▀▄.▀··██ ▐███▪▐█ ▀. ▀▄.▀·▐█ ▌▪ \n ██▀▐█▐█· ▐█.▪▐▀▀▪▄▐█ ▌▐▌▐█·▄▀▀▀█▄▐▀▀▪▄██ ▄▄ \n ██▌▐▀▐█▌ ▐█▌·▐█▄▄▌██ ██▌▐█▌▐█▄▪▐█▐█▄▄▌▐███▌ \n ▀▀▀ ·▀▀▀ ▀▀▀  ▀▀▀ ▀▀  █▪▀▀▀ ▀▀▀▀  ▀▀▀ ·▀▀▀  " | lolcat
echo -e ""
echo -e "$ORANGE              ~:ISITUP:~"
echo -e "$ORANGE Improve your reconnaissance by$RED hitemSec"
echo -e ""
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
