#!/bin/bash

# Started out with isup.sh, ended up with isitup.sh
# ICMP was not enough, rewrote and reused some parts, thanks @___0x00 (github: gitnepal), pogchamp
# hitemSec 2022

BLUE='\033[94m'
RED='\033[91m'
GREEN='\033[92m'
ORANGE='\033[93m'
IRED='\033[0;91m'
IGREEN='\033[0;92m'
RESET='\e[0m'
TARGET="$1"
CURRENT_PATH=$(pwd)

sudo apt-get -y install lolcat
sudo apt-get -y install hping3
clear

if [ -z $TARGET ]; then
echo -e " ▄ .▄▪  ▄▄▄▄▄▄▄▄ .• ▌ ▄ ·. .▄▄ · ▄▄▄ . ▄▄·  " | lolcat
echo -e "██▪▐███ •██  ▀▄.▀··██ ▐███▪▐█ ▀. ▀▄.▀·▐█ ▌▪ " | lolcat
echo -e "██▀▐█▐█· ▐█.▪▐▀▀▪▄▐█ ▌▐▌▐█·▄▀▀▀█▄▐▀▀▪▄██ ▄▄ " | lolcat
echo -e "██▌▐▀▐█▌ ▐█▌·▐█▄▄▌██ ██▌▐█▌▐█▄▪▐█▐█▄▄▌▐███▌ " | lolcat
echo -e "▀▀▀ ·▀▀▀ ▀▀▀  ▀▀▀ ▀▀  █▪▀▀▀ ▀▀▀▀  ▀▀▀ ·▀▀▀  " | lolcat
echo -e ""
echo -e "$ORANGE [+] hitemSec inspired by $RED@___0x00"
  	echo ""
	echo -e "$GREEN [+] hitemSec"
	echo -e "$GREEN [+] https://twitter.com/hitemSec"
	echo -e "$GREEN [-] Usage: isitup.sh <targetlist>"
	echo -e "$GREEN [-] Usage: Modify script to include other ports on line 62"
	exit
fi

if [[ $TARGET == "--help" ]] || [[ $TARGET == "-h" ]]; then
echo -e " ▄ .▄▪  ▄▄▄▄▄▄▄▄ .• ▌ ▄ ·. .▄▄ · ▄▄▄ . ▄▄·  " | lolcat
echo -e "██▪▐███ •██  ▀▄.▀··██ ▐███▪▐█ ▀. ▀▄.▀·▐█ ▌▪ " | lolcat
echo -e "██▀▐█▐█· ▐█.▪▐▀▀▪▄▐█ ▌▐▌▐█·▄▀▀▀█▄▐▀▀▪▄██ ▄▄ " | lolcat
echo -e "██▌▐▀▐█▌ ▐█▌·▐█▄▄▌██ ██▌▐█▌▐█▄▪▐█▐█▄▄▌▐███▌ " | lolcat
echo -e "▀▀▀ ·▀▀▀ ▀▀▀  ▀▀▀ ▀▀  █▪▀▀▀ ▀▀▀▀  ▀▀▀ ·▀▀▀  " | lolcat
echo -e ""
echo -e "$ORANGE [+] hitemSec inspired by $RED@___0x00"
        echo ""
	echo -e "$GREEN [+] hitemSec"
	echo -e "$GREEN [+] https://twitter.com/hitemSec"
        echo -e "$GREEN [+] Find alive host from huge domains dumps"
c
    exit
fi

if [ ! -f $TARGET ]; then
    echo -e "$IRED ######################     [FILE NOT FOUND] "
    exit
fi

createdir=$(mkdir -p "$CURRENT_PATH/tmp/")
FILENAME=$( basename $TARGET )
echo -e " ▄ .▄▪  ▄▄▄▄▄▄▄▄ .• ▌ ▄ ·. .▄▄ · ▄▄▄ . ▄▄·  " | lolcat
echo -e "██▪▐███ •██  ▀▄.▀··██ ▐███▪▐█ ▀. ▀▄.▀·▐█ ▌▪ " | lolcat
echo -e "██▀▐█▐█· ▐█.▪▐▀▀▪▄▐█ ▌▐▌▐█·▄▀▀▀█▄▐▀▀▪▄██ ▄▄ " | lolcat
echo -e "██▌▐▀▐█▌ ▐█▌·▐█▄▄▌██ ██▌▐█▌▐█▄▪▐█▐█▄▄▌▐███▌ " | lolcat
echo -e "▀▀▀ ·▀▀▀ ▀▀▀  ▀▀▀ ▀▀  █▪▀▀▀ ▀▀▀▀  ▀▀▀ ·▀▀▀  " | lolcat
echo -e ""
echo -e "$ORANGE [+] hitemSec inspired by $RED@___0x00"
echo -e " ######################################################     [INITIATING] " | lolcat
echo -e ""
for foo in $(cat $TARGET) 
do
    hping3 -S -p 80,443,8080 -c 1 -w 1 $foo > /dev/null 2>&1
    if [[ $? -eq 0 ]];
    then
        echo -e "$IGREEN [+] $foo $RESET"
        echo -e " $foo" | tee -a $CURRENT_PATH/tmp/valid-$FILENAME > /dev/null 2>&1

    else
        echo -e " $foo" | tee -a $CURRENT_PATH/tmp/notvalid-$FILENAME
    fi
done
echo -e ""
echo -e "$BLUE  Working SubDomains saved to: $ORANGE tmp/valid-$FILENAME  $RESET"
echo -e "$BLUE  Invalid SubDomains saved to: $ORANGE tmp/notvalid-$FILENAME  $RESET"
echo -e ""
vcounter=$(cat $CURRENT_PATH/tmp/valid-$FILENAME | sort -u | wc -l )
fcounter=$(cat $CURRENT_PATH/tmp/notvalid-$FILENAME | sort -u | wc -l )
orgcounter=$(cat $TARGET | sort -u | wc -l )
echo -e "$BLUE  [TOTAL]: ${orgcounter} $RESET     $IGREEN[ALIVE]: ${vcounter} $RESET     $IRED[DOWN]: ${fcounter}"
echo -e " ######################################################     [COMPLETED] " | lolcat
