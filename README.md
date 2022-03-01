# ISITUP
![image](https://user-images.githubusercontent.com/8977898/156212274-62e4dca3-3855-469c-84d3-6477e69f49d2.png)<br>
Started out with **isup.sh**, ended up with **isitup.sh**<br>
ICMP was not enough, rewrote and reused some parts, cred to ```gitnepal``` on github (```@___0x00```)<br>

## Usage
```bash
> ./isitup.sh list.txt
> ./isitup.sh -h
```
Outputs two files called ```validlist.txt``` & ```notvalid.txt``` into /tmp/ in scriptdirectory<br>


## Dependencies
Note that ive built in the installation of Hping3 and Lolcat. Remove if you have those already.<br>
Row 21 of the script<br>
```bash
> sudo apt-get -y install lolcat hping3
```
