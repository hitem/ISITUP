#!/usr/bin/env python3

# # # # # # # # # # # # # # # # # # # # # # # #
# made by hitemSec
# purpose: 
#  Checks for domains!
#  Started out with isup.sh, ended up with isitup.sh and now isitup.py
#  ICMP was not enough, rewrote, added and reworked the whole thing! cred to @___0x00 (github: gitnepal)
# github: https://github.com/hitem
# twitter: https://twitter.com/hitemSec
# # # # # # # # # # # # # # # # # # # # # # # #

#IMPORTS
import requests
import json
import time
import sys

#COLORS
class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    OKRED = '\033[91m'
    OKGRAY = '\033[90m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

#VARIABLES & File inputs
#For static input/output (incase you want to make this tool part of your reconnaissance chain) you have to replace input_file and output_file with these lines:
#input_file = ('c:\\users\\myuser\\desktop\\test.txt')
#output_file = ('c:\\users\\myuser\\desktop\\test2.txt')
print(f"{bcolors.HEADER}  ▄ .▄▪  ▄▄▄▄▄▄▄▄ .• ▌ ▄ ·. .▄▄ · ▄▄▄ . ▄▄·  \n ██▪▐███ •██  ▀▄.▀··██ ▐███▪▐█ ▀. ▀▄.▀·▐█ ▌▪ \n ██▀▐█▐█· ▐█.▪▐▀▀▪▄▐█ ▌▐▌▐█·▄▀▀▀█▄▐▀▀▪▄██ ▄▄ \n ██▌▐▀▐█▌ ▐█▌·▐█▄▄▌██ ██▌▐█▌▐█▄▪▐█▐█▄▄▌▐███▌ \n ▀▀▀ ·▀▀▀ ▀▀▀  ▀▀▀ ▀▀  █▪▀▀▀ ▀▀▀▀  ▀▀▀ ·▀▀▀  {bcolors.ENDC}")
print(f"{bcolors.OKGRAY}Improve your reconnaissance by{bcolors.ENDC} {bcolors.OKRED}hitemSec{bcolors.ENDC}")
print("")
input_file = input('Enter the file to\033[1m \033[93mimport\033[0m: ')
output_file = input('Enter the file to\033[1m \033[96mexport\033[0m: ')
print("")

#THE MAGIC
try:
    finput_file = open(input_file,'r').read().splitlines()
except Exception as e:
    print(f"{bcolors.OKRED}Please insert a valid file ({bcolors.WARNING}check file or directory{bcolors.OKRED}){bcolors.ENDC}")
    print(f"{bcolors.OKRED}Error {e}{bcolors.ENDC}")
    sys.exit(1)
with open(output_file, 'w') as U:
    for line in finput_file:
        #HEADERS
        headers = {'user-agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:103.0) Gecko/20100101 Firefox/103.0','content-type' : 'application/x-www-form-urlencoded'} 
        try:
            #REQUEST
            line2 = requests.get(line, headers=headers, allow_redirects=True, timeout=5)
            if line2.ok:
                #ALL OK REQUESTS (successfull, such as 200, 301)
                print (f"{bcolors.OKGREEN}[+] [{bcolors.ENDC}",line2.status_code,f"{bcolors.OKGREEN}]{bcolors.ENDC}", line)
                U.write(line)
                U.write('\n')
            else:
                #ALL FAILED REQUESTS (such as 400-405 etc)
                print (f"{bcolors.FAIL}[-] [{bcolors.ENDC}",line2.status_code,f"{bcolors.FAIL}]{bcolors.ENDC}", line)
        except:
                #THROW A "404" ERROR (If the domain could not be resolved, reached etc)
                #I troubledshoot this extensivly and this was the easiest and most relayable solution
            print (f"{bcolors.FAIL}[-] [{bcolors.ENDC}","404",f"{bcolors.FAIL}]{bcolors.ENDC}", line)
            pass