# ISITUP
<img width="508" alt="Snag_1fa9c23" src="https://github.com/hitem/ISITUP/assets/8977898/42738190-aabf-407d-ac53-90e9afb09aff"><br>
ISITUP will make your reconnaissance more reliable and validate a chosen list of IP or Domains and output them into a valid and notvalid list.
ICMP was not enough (from isup), so i rewrote, added and reused some parts and ended up with this TCP based bash script dubbed ISITUP!<br>

# Install
```bash
git clone https://github.com/hitem/ISITUP.git
cd ISITUP
chmod u+x isitup.sh
```
# Usage
## BASH
```bash
LINUX
> ./isitup.sh list.txt
> ./isitup.sh -s [--scope]
> ./isitup.sh -h [--help]

EXAMPLES
> ./isitup.sh -s 10.0.1.0/1
> ./isitup.sh bunchofurls.txt
```
Outputs two files called ```validlist.txt``` & ```notvalid.txt``` into /tmp/ in scriptdirectory.<br>
Change ports you want to ping (if any other then ```80```,```443```,```8080``` in the ```isitup.sh```).\
If you want to scan more ports, or all, add them manualy or change to ```hping3 -S -8 All -c 1 -w 1 $ENTRIES``` in the script.<br><br>
![2023-06-01_16-02-37](https://github.com/hitem/ISITUP/assets/8977898/453d9b7e-1672-472e-9db1-8f4210fbf9d9)

## Dependencies
Note that ive built in the installation of Hping3, prips and Lolcat. Remove if you have those already.<br>
```bash
> sudo apt-get -y install lolcat hping3 prips
```


# Python Version
```python
LINUX
> ./isitup.py -h
> ./isitup.py -i [--input_file] -o [--output_file]

EXAMPLE
> ./isitup.py -i /root/usr/input.txt -o /root/usr/output.txt


WINDOWS
> pip install requests urllib3
> python3 .\isitup.py -h
```
## Usage

When you launch the `isitup.py` you have to supply the following arguments: `-i` and `-o`. It will send asynchronous HTTP requests and save the results to different output files based on the response status codes. Note that this tool doesn't care if you have `https://`, `http://`, or no prefix on the URL in the input file. If no prefix is provided.

The ISITUP tool then checks if domains are up and organizes the results based on HTTP response codes into different output files. Here is a brief explanation of the different HTTP response code categories and the corresponding output files created by the tool:

1. **Informational Responses (100 – 199)**
   - These responses indicate that the request was received and understood and is being processed.
   - Output File: `<output_file_prefix>_1xx.txt`
   - Example: `102 Processing`

2. **Successful Responses (200 – 299)**
   - These responses indicate that the request was successfully received, understood, and accepted.
   - Output File: `<output_file_prefix>_2xx.txt`
   - Example: `200 OK`

3. **Redirection Messages (300 – 399)**
   - These responses indicate that further action needs to be taken by the user agent in order to fulfill the request.
   - Output File: `<output_file_prefix>_3xx.txt`
   - Example: `301 Moved Permanently`

4. **Client Error Responses (400 – 499)**
   - These responses indicate that the request contains bad syntax or cannot be fulfilled.
   - Output File: `<output_file_prefix>_4xx.txt`
   - Example: `404 Not Found`

5. **Server Error Responses (500 – 599)**
   - These responses indicate that the server failed to fulfill a valid request.
   - Output File: `<output_file_prefix>_5xx.txt`
   - Example: `500 Internal Server Error`

6. **Error Handling**
   - URLs that encounter errors during the request process are recorded separately.
   - Output File: `<output_file_prefix>_errors.txt`
<img width="273" alt="Snag_5c7a946" src="https://github.com/hitem/ISITUP/assets/8977898/55c64240-ebc2-4041-affe-a57a704db55f">

