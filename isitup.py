#!/usr/bin/env python3

# # # # # # # # # # # # # # # # # # # # # # # #
# made by hitemSec
# purpose: 
#  More reliant checks for domains-lists!
# github: https://github.com/hitem
# mastodon: @hitem@infosec.exchange 
# # # # # # # # # # # # # # # # # # # # # # # #

# Import necessary modules
import sys
import getopt
import requests
import socket
import time
import concurrent.futures
from urllib3.exceptions import InsecureRequestWarning
from urllib3 import disable_warnings

# Disable insecure request warning
disable_warnings(InsecureRequestWarning)

# Define a class for colored output
class bcolors:
    HEADER = '\033[95m'
    OKGREEN = '\033[92m'
    OKCYAN = '\033[96m'
    OKGRAY = '\033[90m'
    OKRED = '\033[91m'
    WARNING = '\033[93m'
    INFO = '\033[94m'  # Informational responses color
    REDIRECT = '\033[93m'  # Orange for redirection messages
    SERVER_ERROR = '\033[94m'  # Blue for server error responses
    ENDC = '\033[0m'
    FAIL = '\033[91m'  # Red for failed connections

# Gradient color and logo functions
def interpolate_color(color1, color2, factor):
    """Interpolate between two RGB colors."""
    return [int(color1[i] + (color2[i] - color1[i]) * factor) for i in range(3)]

def rgb_to_ansi(r, g, b):
    """Convert RGB to ANSI color code."""
    return f'\033[38;2;{r};{g};{b}m'

def print_logo_and_instructions():
    logo = """
  ▄ .▄▪  ▄▄▄▄▄▄▄▄ .• ▌ ▄ ·. .▄▄ · ▄▄▄ . ▄▄·  
 ██▪▐███ •██  ▀▄.▀··██ ▐███▪▐█ ▀. ▀▄.▀·▐█ ▌▪ 
 ██▀▐█▐█· ▐█.▪▐▀▀▪▄▐█ ▌▐▌▐█·▄▀▀▀█▄▐▀▀▪▄██ ▄▄ 
 ██▌▐▀▐█▌ ▐█▌·▐█▄▄▌██ ██▌▐█▌▐█▄▪▐█▐█▄▄▌▐███▌ 
 ▀▀▀ ·▀▀▀ ▀▀▀  ▀▀▀ ▀▀  █▪▀▀▀ ▀▀▀▀  ▀▀▀ ·▀▀▀  
    """
    colors = [
        (255, 0, 255),  # Purple
        (0, 0, 255)     # Blue
    ]

    num_colors = len(colors)
    rainbow_logo = ""
    color_index = 0
    num_chars = sum(len(line) for line in logo.split("\n"))
    for char in logo:
        if char != " " and char != "\n":
            factor = (color_index / num_chars) * (num_colors - 1)
            idx = int(factor)
            next_idx = min(idx + 1, num_colors - 1)
            local_factor = factor - idx
            color = interpolate_color(colors[idx], colors[next_idx], local_factor)
            rainbow_logo += rgb_to_ansi(*color) + char
            color_index += 1
        else:
            rainbow_logo += char

    instructions = f"""
    {rainbow_logo}{bcolors.ENDC}
    {bcolors.OKGRAY}Improve your reconnaissance by{bcolors.ENDC} {bcolors.OKRED}hitemSec{bcolors.ENDC}
    {bcolors.OKGRAY}How-To: {bcolors.WARNING}.\\isitup.py -h{bcolors.ENDC}
    
    {bcolors.OKGRAY}ISITUP - Usage Instructions{bcolors.ENDC}
    {bcolors.WARNING}---------------------------{bcolors.ENDC}
    {bcolors.OKGRAY}This tool checks if domains are up!{bcolors.ENDC}

    {bcolors.WARNING}Usage:{bcolors.ENDC}
    {bcolors.OKGRAY}python3 .\\isitup.py -i <input_file> -o <output_file_prefix>{bcolors.ENDC}
    
    {bcolors.WARNING}Examples:{bcolors.ENDC}
    {bcolors.OKGRAY}isitup.py -i {bcolors.OKCYAN}input_file{bcolors.WARNING} -o {bcolors.OKGREEN}output_file_prefix{bcolors.ENDC}
    {bcolors.OKGRAY}Example: {bcolors.WARNING}.\\isitup.py -i {bcolors.OKCYAN}/root/usr/input.txt{bcolors.WARNING} -o {bcolors.OKGREEN}/root/usr/output{bcolors.ENDC}
    {bcolors.ENDC}
    """
    print(instructions)

# VARIABLES & File inputs
print_logo_and_instructions()

# Function to check URL
def check_url(url, headers, timeout=5, max_retries=2):
    def dns_resolve(domain):
        try:
            socket.gethostbyname(domain)
            return True
        except socket.error:
            return False

    urls_to_try = []
    if url.startswith("http://") or url.startswith("https://"):
        domain = url.split("//")[1].split("/")[0]
        if not dns_resolve(domain):
            print(f"{bcolors.FAIL}[-] [DNS Error]{bcolors.ENDC} {url}")
            with open(f"{output_file_prefix}_errors.txt", 'a') as U:
                U.write(url + '\n')
            return None
        urls_to_try.append(url)
    else:
        urls_to_try.append(f"https://{url}")

    for url in urls_to_try:
        for attempt in range(max_retries):
            try:
                response = requests.get(url, headers=headers, allow_redirects=True, timeout=timeout, verify=False)
                status_code = response.status_code
                if 100 <= status_code < 200:
                    color = bcolors.INFO
                    output_file = f"{output_file_prefix}_1xx.txt"
                elif 200 <= status_code < 300:
                    color = bcolors.OKGREEN
                    output_file = f"{output_file_prefix}_2xx.txt"
                elif 300 <= status_code < 400:
                    color = bcolors.REDIRECT
                    output_file = f"{output_file_prefix}_3xx.txt"
                elif 400 <= status_code < 500:
                    color = bcolors.OKRED
                    output_file = f"{output_file_prefix}_4xx.txt"
                elif 500 <= status_code < 600:
                    color = bcolors.SERVER_ERROR
                    output_file = f"{output_file_prefix}_5xx.txt"
                else:
                    color = bcolors.ENDC
                    output_file = f"{output_file_prefix}_others.txt"

                with open(output_file, 'a') as U:
                    U.write(url + '\n')

                if status_code == 200:
                    print(f"{color}[+] [{status_code}]{bcolors.ENDC} {url}")
                    return url
                else:
                    print(f"{color}[-] [{status_code}]{bcolors.ENDC} {url}")
            except requests.exceptions.RequestException:
                print(f"{bcolors.FAIL}[-] [Error]{bcolors.ENDC} {url}")
                with open(f"{output_file_prefix}_errors.txt", 'a') as U:
                    U.write(url + '\n')
                time.sleep(2 ** attempt)  # Exponential backoff
                break
    return None

# Define the main function
def main(argv):
    global output_file_prefix
    input_file = ''
    output_file_prefix = ''
    try:
        opts, args = getopt.getopt(argv, "hi:o:", ["input_file=", "output_file_prefix="])
    except getopt.GetoptError:
        print(f"{bcolors.WARNING}isitup.py -i <input_file> -o <output_file_prefix>{bcolors.ENDC}")
        print("")
        sys.exit(1)
    for opt, arg in opts:
        if opt == '-h':
            print_logo_and_instructions()
            sys.exit(2)
        elif opt in ("-i", "--input_file"):
            input_file = arg
        elif opt in ("-o", "--output_file_prefix"):
            output_file_prefix = arg
            # THE MAGIC
            try:
                with open(input_file, 'r') as f:
                    lines = f.read().splitlines()
            except Exception as e:
                print(f"{bcolors.OKRED}Please insert a valid file ({bcolors.WARNING}check file or directory{bcolors.OKRED}){bcolors.ENDC}")
                print(f"{bcolors.OKRED}Error {e}{bcolors.ENDC}")
                print("")
                sys.exit(3)

            headers = {
                'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:113.0) Gecko/20100101 Firefox/127.0',
                'content-type': 'application/x-www-form-urlencoded'}

            with concurrent.futures.ThreadPoolExecutor(max_workers=10) as executor:
                future_to_url = {executor.submit(check_url, line, headers): line for line in lines}
                for future in concurrent.futures.as_completed(future_to_url):
                    url = future_to_url[future]
                    try:
                        result = future.result()
                    except Exception as exc:
                        print(f"{bcolors.FAIL}[-] [Error]{bcolors.ENDC} {url}")
                        with open(f"{output_file_prefix}_errors.txt", 'a') as U:
                            U.write(url + '\n')

# Call the main function
if __name__ == "__main__":
    main(sys.argv[1:])
