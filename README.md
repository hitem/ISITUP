# ISITUP
![image](https://user-images.githubusercontent.com/8977898/156657079-ca13f13c-9dd4-4431-bf6d-a68a31091938.png)<br>
ISITUP will make your reconnaissance more reliable and validate a chosen list of IP or Domains and output them into a valid and notvalid list.
ICMP was not enough (from isup), so i rewrote, added and reused some parts and ended up with this TCP based bash script dubbed ISITUP!<br>

## Usage
```bash
> ./isitup.sh list.txt
> ./isitup.sh [-s --scope]
> ./isitup.sh [-h --help]
```
Outputs two files called ```validlist.txt``` & ```notvalid.txt``` into /tmp/ in scriptdirectory.<br>
Change ports you want to ping (if any other then ```80```,```443```,```8080``` in the isitup.sh).<br><br>
![image](https://i.imgur.com/T6qPNTI.gif)


## Dependencies
Note that ive built in the installation of Hping3, prips and Lolcat. Remove if you have those already.<br>
```bash
> sudo apt-get -y install lolcat hping3 prips
```
## Credits
Cred to ```gitnepal``` on github and the creator ```@___0x00``` of isup where i started this journey<br>
