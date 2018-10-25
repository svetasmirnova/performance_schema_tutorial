#!/bin/bash
export PATH=/home/vagrant/tutorial:$PATH

if [ "x$CLIENT_ID" != "x" ] ; then
	echo "Non-replication environment start mysql cli, type: use test"
	echo "Replication environment start mysql cli on master, type: m test"
	echo "Replication environment start mysql cli on slave, type: s1 test"
	echo ""
	exit
fi

if [ `w|egrep '\<'$USER'\>'|wc -l` -gt 1 ] ; then
	echo "You are already connected"
	kill -HUP $PPID
fi

HEIGHT=20
WIDTH=60
CHOICE_HEIGHT=15
BACKTITLE="Percona tutorials"
TITLE="Performance Schema tutorial tasks"
MENU="Choose one of the following options:"

count=0

grep DESCRIPTION /home/vagrant/tutorial/[0-9]*.sh | sed -e 's/^files\///;s/:DESCRIPTION="/|/;s/"$//' > /tmp/description.txt
while IFS='|' read f d ; do 
  echo "File '$f', Description '$d'"
  COMMANDS[$((count/2 + 1 ))]="$f"
  OPTIONS[$((++count))-1]=$((count/2 + 1 ))
  OPTIONS[$((++count))-1]="$d"
done < /tmp/description.txt
rm /tmp/description.txt

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

/usr/bin/clear
if [ -e "${COMMANDS[$CHOICE]}" ] ; then
  nice -n 19 "${COMMANDS[$CHOICE]}" 
  exec /home/vagrant/tutorial/tutorials.sh
fi
echo "Exiting from tutorial, $PPID"
kill -HUP $PPID
