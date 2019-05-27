#!/bin/bash
rm -f userdetails.unencrypted.txt;for i in $(seq 1 50) ; do echo "dba$i: '"$(pwgen 10 1|tee -a userdetails.unencrypted.txt|mkpasswd -s --method=sha-512)"'" ; done > files/passwords.yml
chmod 600 files/passwords.yml
USR=1;while IFS='' read -r line || [[ -n "$line" ]]; do echo "dba$USR $line"; USR=$(($USR+1)); done < userdetails.unencrypted.txt > passwords-unencrypted.txt
rm userdetails.unencrypted.txt;
