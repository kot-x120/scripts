#!/bin/bash

today=$(date "+%d/%m/%Y %H:%M:%S %Z")
new_ip=$(wget -qO - icanhazip.com)
old_ip=$(tail -1 log_ip | cut -c 36-37)

if [ "$old_ip" != "$new_ip" ]
	then 
		echo "$today Внешний IP: $new_ip" >> log_ip
	fi

echo
echo "Сегодня: $today"
echo "Новый адресс: $new_ip"
echo "Старый адресс: $old_ip"
echo

