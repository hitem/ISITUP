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
> ./isitup.py -h
> ./isitup.py -i [--input_file] -o [--output_file]
> ./isitup.py -i /root/usr/input.txt -o /root/usr/output.txt
```
When you launch the ```isitup.py``` you have to supply the following arguments: ```-i <path to file>``` and ```-o <path to file>```, it will go ahead and send a request.get command using http socks and save the successful requests to the ```-o <path to file>```. \
<img width="320" alt="Snag_20fad63" src="https://github.com/hitem/ISITUP/assets/8977898/364ca0d3-9067-4b43-9ccf-dd852ee8f3b9"> \
You can integrate the script into your reconnaissance tools and use variables for input/output, but in that case i could recommend ```httpx``` (faster for large lists). \
The script dont care if you have http/https or no prefix in the list input.

