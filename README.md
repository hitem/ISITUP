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
> ./isitup.sh list.txt
> ./isitup.sh -s [--scope]
> ./isitup.sh -h [--help]
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

## Bonus: Python
```python
LINUX
> ./isitup.py -h
> ./isitup.py -i [--input_file] -o [--output_file]
> ./isitup.py -i /root/usr/input.txt -o /root/usr/output.txt

WINDOWS
> pip install requests urllib3
> python3 .\isitup.py -h
```
When you launch the ```isitup.py``` you have to supply the following arguments: ```-i <path to file>``` and ```-o <path to file>```, it will go ahead and send a request.get command using http socks and save the successful requests to the ```-o <path to file>```. Note that this tool dont care if you have ```https://```, ```http://``` or ```no prefix``` on the url in the inputfile - if no prefix it will try both just to be sure. \
<img width="447" alt="Snag_372d1e4" src="https://github.com/hitem/ISITUP/assets/8977898/048989b5-5c0f-41f6-83c6-ce27f3d973ac"> \
You can integrate the script into your reconnaissance tools and use variables for input/output (xargs or cat -> pipe), but in that case i could recommend ```httpx``` (faster for large lists).

