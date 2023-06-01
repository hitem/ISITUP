#!/usr/bin/env python3

# # # # # # # # # # # # # # # # # # # # # # # #
# made by hitemSec
# purpose: 
#  Checks for domains!
#  Started out with isup.sh, ended up with isitup.sh and now isitup.py
#  ICMP was not enough, rewrote, added and reworked the whole thing! cred to @___0x00 (github: gitnepal)
# github: https://github.com/hitem
# mastodon: @hitem@infosec.exchange 
# # # # # # # # # # # # # # # # # # # # # # # #

#IMPORTS
import requests
import sys
import getopt

# COLORS
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

# VARIABLES & File inputs
print(f"{bcolors.HEADER}  ▄ .▄▪  ▄▄▄▄▄▄▄▄ .• ▌ ▄ ·. .▄▄ · ▄▄▄ . ▄▄·  \n ██▪▐███ •██  ▀▄.▀··██ ▐███▪▐█ ▀. ▀▄.▀·▐█ ▌▪ \n ██▀▐█▐█· ▐█.▪▐▀▀▪▄▐█ ▌▐▌▐█·▄▀▀▀█▄▐▀▀▪▄██ ▄▄ \n ██▌▐▀▐█▌ ▐█▌·▐█▄▄▌██ ██▌▐█▌▐█▄▪▐█▐█▄▄▌▐███▌ \n ▀▀▀ ·▀▀▀ ▀▀▀  ▀▀▀ ▀▀  █▪▀▀▀ ▀▀▀▀  ▀▀▀ ·▀▀▀  {bcolors.ENDC}")
print(f"{bcolors.OKGRAY}Improve your reconnaissance by{bcolors.ENDC} {bcolors.OKRED}hitemSec{bcolors.ENDC}")
print(f"{bcolors.OKGRAY}How-To: {bcolors.WARNING}isitup.py -h{bcolors.ENDC}")
print("")

# ARGS
def main(argv):
    input_file = ''
    output_file = ''
    try:
        opts, args = getopt.getopt(argv, "hi:o:", ["input_file=", "output_file="])
    except getopt.GetoptError:
        print(f"{bcolors.WARNING}isitup.py -i <input_file> -o <output_file>{bcolors.ENDC}")
        print("")
        sys.exit(1)
    for opt, arg in opts:
        if opt == '-h':
            print(f"{bcolors.OKGRAY}How-To:  {bcolors.WARNING}isitup.py -i {bcolors.OKCYAN}input_file{bcolors.WARNING} -o {bcolors.OKGREEN}output_file{bcolors.ENDC}")
            print(f"{bcolors.OKGRAY}Example: {bcolors.WARNING}isitup.py -i {bcolors.OKCYAN}/root/usr/input.txt{bcolors.WARNING} -o {bcolors.OKGREEN}/root/usr/output.txt{bcolors.ENDC}")
            print("")
            sys.exit(2)
        elif opt in ("-i", "--input_file"):
            input_file = arg
        elif opt in ("-o", "--output_file"):
            output_file = arg
            # THE MAGIC
            try:
                with open(input_file, 'r') as f:
                    lines = f.read().splitlines()
            except Exception as e:
                print(f"{bcolors.OKRED}Please insert a valid file ({bcolors.WARNING}check file or directory{bcolors.OKRED}){bcolors.ENDC}")
                print(f"{bcolors.OKRED}Error {e}{bcolors.ENDC}")
                print("")
                sys.exit(3)

            with open(output_file, 'w') as U:
                for line in lines:
                    # HEADERS
                    headers = {
                        'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:103.0) Gecko/20100101 Firefox/103.0',
                        'content-type': 'application/x-www-form-urlencoded'}
                    try:
                        if line.startswith("http://") or line.startswith("https://"):
                            url = line
                        else:
                            url = f"http://{line}"
                        response = requests.get(url, headers=headers, allow_redirects=True, timeout=5)
                        status_code = response.status_code
                        if status_code == 200:
                            print(f"{bcolors.OKGREEN}[+] [{bcolors.ENDC}", status_code, f"{bcolors.OKGREEN}]{bcolors.ENDC}", url)
                            U.write(url)
                            U.write('\n')
                        else:
                            print(f"{bcolors.FAIL}[-] [{bcolors.ENDC}", status_code, f"{bcolors.FAIL}]{bcolors.ENDC}", url)
                    except requests.exceptions.RequestException:
                        print(f"{bcolors.FAIL}[-] [{bcolors.ENDC}", status_code, f"{bcolors.FAIL}]{bcolors.ENDC}", line)
                        pass
                    except Exception:
                        print(f"{bcolors.FAIL}[-] [{bcolors.ENDC}", status_code, f"{bcolors.FAIL}]{bcolors.ENDC}", line)
                        pass

if __name__ == "__main__":
    main(sys.argv[1:])
