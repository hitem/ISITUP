# ISITUP
![image](https://user-images.githubusercontent.com/8977898/156657079-ca13f13c-9dd4-4431-bf6d-a68a31091938.png)<br>
ISITUP will make your reconnaissance more reliable and validate a chosen list of IP or Domains and output them into a valid and notvalid list.
ICMP was not enough (from isup), so i rewrote, added and reused some parts and ended up with this TCP based bash script dubbed ISITUP!<br>

# Usage
## BASH
```bash
> ./isitup.sh list.txt
> ./isitup.sh -s [--scope]
> ./isitup.sh -h [--help]
```
Outputs two files called ```validlist.txt``` & ```notvalid.txt``` into /tmp/ in scriptdirectory.<br>
Change ports you want to ping (if any other then ```80```,```443```,```8080``` in the ```isitup.sh```).<br><br>
![image](https://i.imgur.com/T6qPNTI.gif)

## Dependencies
Note that ive built in the installation of Hping3, prips and Lolcat. Remove if you have those already.<br>
```bash
> sudo apt-get -y install lolcat hping3 prips
```

## Bonus: Python
```python
> ./isitup.py
```
Before we start: Python version only works with domains (```example.com```) and with http/https (```https://example.com```). \
It requiers a little more of you to integrate the python version, but once you do its solid! \
When you luanch the ```isitup.py``` you are asked to enter a ```input``` and ```output``` file, note that the file must contain domainlist with the http/https prefixes, it will go ahead and send a request.get command using http socks and save the successfull requests to the ```outputfile```.
![image](https://user-images.githubusercontent.com/8977898/185981647-ca686555-c160-4be0-9dd0-e6a70d9ed27c.png) \
You can hardcore the input/output file to integrate the script into your reconnaissance tools, but in that case i could recommend ```httpx```

