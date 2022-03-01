# ISITUP
![image](https://user-images.githubusercontent.com/8977898/156216699-d7334be0-f567-446f-b9be-c29870d63c27.png)<br>
Started out with **isup.sh**, ended up with **isitup.sh**<br>
ICMP was not enough, rewrote and reused some parts, cred to ```gitnepal``` on github and the creator ```@___0x00```<br>

## Usage
```bash
> ./isitup.sh list.txt
> ./isitup.sh -h
```
Outputs two files called ```validlist.txt``` & ```notvalid.txt``` into /tmp/ in scriptdirectory<br>
Change ports you want to ping (if any other then ```80```,```443```,```8080``` in the isitup.sh)


## Dependencies
Note that ive built in the installation of Hping3 and Lolcat. Remove if you have those already.<br>
Row 21 of the script<br>
```bash
> sudo apt-get -y install lolcat hping3
```
