#!bin/bash

login="astucia777"
psswd="rbgrldsqkzayguil"

new=`curl -u ${login}:${psswd} -s "https://mail.google.com/mail/feed/atom" | grep -c "<entry>"`
echo $new