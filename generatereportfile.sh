#!/bin/bash

touch report.txt
> report.txt #clears the previous data if existed
date >> report.txt
echo "Current user: " >> report.txt
whoami >> report.txt
echo "Internal IP address & hostname: " >> report.txt
ip -a addr show enp0s3 | egrep inet[^6]\s* >> report.txt
echo "External ip address: " >> report.txt
# or just curl ifconfig.me
# many ways and i picked the most complicated one
dig +short txt ch whoami.cloudflare @1.0.0.1 | sed 's/"*//g' >> report.txt

echo "OS name and version: " >> report.txt

. /etc/os-release && echo $PRETTY_NAME >> report.txt
echo "System uptime: " >> report.txt
uptime >> report.txt
echo "Memory used and free space /in GB" >> report.txt
df -h | gawk '/\/dev\/sda2/ {print "Used: " $3" Free: "$4}' >> report.txt



echo "Available and total RAM: "  >> report.txt
free --mega | gawk '/Mem:/{print $7"Mb "$2"Mb"}' >> report.txt

# cpu

echo "Number and freq of CPU cores: " >> report.txt

cat /proc/cpuinfo | egrep "cpu cores|cpu MHz" >> report.txt


echo "Information can be found in report.txt file."
