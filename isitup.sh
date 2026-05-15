#!/bin/bash

export LANG=C.UTF-8
export LC_ALL=C.UTF-8
export LANGUAGE=C

# # # # # # # # # # # # # # # # # # # # # # # #
# made by hitemSec
# purpose: 
#  More reliant checks for domains and ip-lists!
# github: https://github.com/hitem
# mastodon: @hitem@infosec.exchange 
# # # # # # # # # # # # # # # # # # # # # # # #

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
FILENAME=$(basename "$TARGET")

#DEPENDENCIES
#sudo apt-get -y install lolcat prips parallel netcat-openbsd
missing_deps=()

command -v lolcat >/dev/null 2>&1 || missing_deps+=("lolcat")
command -v prips >/dev/null 2>&1 || missing_deps+=("prips")
command -v parallel >/dev/null 2>&1 || missing_deps+=("parallel")
command -v nc >/dev/null 2>&1 || missing_deps+=("netcat-openbsd")

if [ ${#missing_deps[@]} -gt 0 ]; then
    echo "[+] Installing missing dependencies: ${missing_deps[*]}"
    sudo apt-get update -qq
    sudo apt-get install -qq -y "${missing_deps[@]}" >/dev/null
fi

hitemsec () {
echo -e "  ▄ .▄▪  ▄▄▄▄▄▄▄▄ .• ▌ ▄ ·. .▄▄ · ▄▄▄ . ▄▄·  \n ██▪▐███ •██  ▀▄.▀··██ ▐███▪▐█ ▀. ▀▄.▀·▐█ ▌▪ \n ██▀▐█▐█· ▐█.▪▐▀▀▪▄▐█ ▌▐▌▐█·▄▀▀▀█▄▐▀▀▪▄██ ▄▄ \n ██▌▐▀▐█▌ ▐█▌·▐█▄▄▌██ ██▌▐█▌▐█▄▪▐█▐█▄▄▌▐███▌ \n ▀▀▀ ·▀▀▀ ▀▀▀  ▀▀▀ ▀▀  █▪▀▀▀ ▀▀▀▀  ▀▀▀ ·▀▀▀  " | lolcat
echo -e ""
echo -e "$ORANGE              ~:ISITUP:~"
echo -e "$ORANGE Improve your reconnaissance by$RED hitemSec"
echo -e ""
}

hitemsecc () {
echo -e "$GREEN [+] @hitem@infosec.exchange"
echo -e "$GREEN [+] https://github.com/hitem"
}

# Function to check if a host is up
check_host() {
    local host="$1"

    # Skip IPv6 if this machine has no IPv6 internet connectivity.
    if [[ "$host" == *:* ]]; then
        if ! ping -6 -c 1 -W 1 2606:4700:4700::1111 >/dev/null 2>&1; then
            echo -e "$ORANGE [~] Skipping IPv6, no IPv6 connectivity: $host $RESET"
            echo "$host" >> "$CURRENT_PATH/tmp/notvalid-$FILENAME"
            return
        fi

        if nc -6 -z -w 2 "$host" 443 >/dev/null 2>&1 || nc -6 -z -w 2 "$host" 80 >/dev/null 2>&1 || nc -6 -z -w 2 "$host" 8080 >/dev/null 2>&1; then
            echo -e "$IGREEN [+] $host $RESET"
            echo "$host" >> "$CURRENT_PATH/tmp/valid-$FILENAME"
        else
            echo -e "$RED [-] $host $RESET"
            echo "$host" >> "$CURRENT_PATH/tmp/notvalid-$FILENAME"
        fi

        return
    fi

    if nc -4 -z -w 2 "$host" 443 >/dev/null 2>&1 || nc -4 -z -w 2 "$host" 80 >/dev/null 2>&1 || nc -4 -z -w 2 "$host" 8080 >/dev/null 2>&1; then
        echo -e "$IGREEN [+] $host $RESET"
        echo "$host" >> "$CURRENT_PATH/tmp/valid-$FILENAME"
    else
        echo -e "$RED [-] $host $RESET"
        echo "$host" >> "$CURRENT_PATH/tmp/notvalid-$FILENAME"
    fi
}

export -f check_host
export CURRENT_PATH
export FILENAME
export IGREEN
export RED
export ORANGE
export RESET

#CODE
if [ -z "$TARGET" ]; then
    hitemsec
    hitemsecc
    echo -e "$GREEN [-] Usage: isitup.sh [-h --help] [-s --scope] [<targetlist>]"
    echo -e "$ORANGE __________________________________________"
    exit
fi

if [[ $TARGET == "--help" ]] || [[ $TARGET == "-h" ]]; then
    hitemsec
    hitemsecc
    echo -e "$GREEN [-]$BLUE Usage: isitup.sh [-h --help] [-s --scope] [targetlist]"
    echo -e "$GREEN [-]$BLUE Usage: Modify script to include other ports, default:$RESET 80$BLUE,$RESET 443$BLUE,$RESET 8080"
    echo -e "$GREEN [-]$ORANGE Example ./isitup.sh myiplist.txt"
    echo -e "$GREEN [-]$ORANGE Example ./isitup.sh -s"
    echo -e "$GREEN [-]$ORANGE Example ./isitup.sh --help"
    echo -e "$ORANGE __________________________________________"
    exit
fi

CREATEDIR=$(mkdir -p "$CURRENT_PATH/tmp/")
if [[ $TARGET == "--scope" ]] || [[ $TARGET == "-s" ]]; then
    FILENAME="ips.txt"
    export FILENAME
    hitemsec
    hitemsecc
    echo -e "$BLUE Enter a valid IP scope, example$RESET 192.168.0.0/24$BLUE ,$RESET 10.0.1.0/16"
    echo -e "$BLUE If you have selected a large scope, this process will take time! $RESET"
    echo -e "$ORANGE __________________________________________$RESET"
    echo -e ""
    echo -e " Enter your scope and press $IGREEN[ENTER]$RESET to begin"
    read SCOPE
    prips $SCOPE > $CURRENT_PATH/tmp/ManualScope.txt
    echo -e ""
    echo -e " ##################################################     [INITIATING] " | lolcat
    echo -e ""

    parallel -j 10 check_host ::: $(cat $CURRENT_PATH/tmp/ManualScope.txt)

    echo -e ""
    echo -e "$BLUE Valid domains saved to: $ORANGE   tmp/valid-ips.txt  $RESET"
    echo -e "$BLUE Invalid domains saved to: $ORANGE tmp/notvalid-ips.txt  $RESET"
    echo -e ""
    ALIVEC=$(cat $CURRENT_PATH/tmp/valid-ips.txt | sort -u | wc -l)
    DOWNC=$(cat $CURRENT_PATH/tmp/notvalid-ips.txt | sort -u | wc -l)
    TOTALC=$(cat $CURRENT_PATH/tmp/ManualScope.txt | sort -u | wc -l)
    echo -e "$BLUE [TOTAL]: ${TOTALC} $RESET     $IGREEN[ALIVE]: ${ALIVEC} $RESET     $IRED[DOWN]: ${DOWNC}"
    echo -e " ##################################################     [COMPLETED] " | lolcat
    exit
fi

if [ ! -f "$TARGET" ]; then
    hitemsec
    hitemsecc
    echo -e ""
    echo -e "$IRED ----------:[FILE NOT FOUND]:----------"
    echo -e ""
    echo -e "$GREEN [+]$BLUE Usage: isitup.sh [targetlist]"
    echo -e "$GREEN [-]$ORANGE Example ./isitup.sh myiplist.txt"
    exit
fi

rm -rf "$CURRENT_PATH/tmp/"
mkdir -p "$CURRENT_PATH/tmp/"
hitemsec
hitemsecc
echo -e ""
echo -e " ##################################################     [INITIATING] " | lolcat
echo -e ""

parallel -j 10 check_host :::: "$TARGET"

touch "$CURRENT_PATH/tmp/valid-$FILENAME"
touch "$CURRENT_PATH/tmp/notvalid-$FILENAME"

echo -e ""
echo -e "$BLUE Valid domains saved to: $ORANGE   tmp/valid-$FILENAME  $RESET"
echo -e "$BLUE Invalid domains saved to: $ORANGE tmp/notvalid-$FILENAME  $RESET"
echo -e ""
ALIVEC=$(cat $CURRENT_PATH/tmp/valid-$FILENAME | sort -u | wc -l)
DOWNC=$(cat $CURRENT_PATH/tmp/notvalid-$FILENAME | sort -u | wc -l)
TOTALC=$(sort -u "$TARGET" | wc -l)
echo -e "$BLUE [TOTAL]: ${TOTALC} $RESET     $IGREEN[ALIVE]: ${ALIVEC} $RESET     $IRED[DOWN]: ${DOWNC}"
echo -e " ##################################################     [COMPLETED] " | lolcat
