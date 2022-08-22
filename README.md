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
> ./isitup.py -h
> ./isitup.py -i [--input_file] -o [--output_file]
> ./isitup.py -i /root/usr/input.txt -o /root/usr/output.txt
```
Before we start: Python version only works with domains and with http/https prefix (```https://example.com```). \
When you luanch the ```isitup.py``` you have to suplly the following arguments: ```-i <path to file>``` and ```-o <path to file>```, it will go ahead and send a request.get command using http socks and save the successfull requests to the ```-o <path to file>```. \
![image](https://user-images.githubusercontent.com/8977898/185992964-fcfdc759-2669-4a6e-9b15-7e8d6d3f6b21.png) \
You can integrate the script into your reconnaissance tools and use variables for input/output, but in that case i could recommend ```httpx``` (faster for large lists)

