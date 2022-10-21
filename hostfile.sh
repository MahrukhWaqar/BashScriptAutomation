#!/bin/sh
ETC_HOSTS="/etc/hosts"
test='([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])'
flag=1

echo "Enter hostname:"
read hs
echo "Enter IP address:"
read ip_address

#IP validation check
while [ $flag == 1 ]; do
    if [[ $ip_address =~ ^$test\.$test\.$test\.$test$ ]]; then
        flag=0
    else
        echo "IP address entered is not valid."
        echo "Enter IP address again:"
        read ip_address
    fi
done

#check to see if hostname exists in hostfile
if [ -n  "$(grep -w $hs $ETC_HOSTS)" ]; then
    sudo sed -i '/sdwantool.com/d' $ETC_HOSTS
    echo "$ip_address   $hs" >> $ETC_HOSTS
    echo "Hostname and ip address have been added to host file" ;

else
    echo "Hostname does not exist in hostfile";
    echo "$ip_address   $hs" >> $ETC_HOSTS
    echo "Hostname and ip address have been added to host file" ;
fi