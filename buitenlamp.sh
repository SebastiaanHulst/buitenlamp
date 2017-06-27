#!/bin/bash

#
# buitenlamps script is placed in /opt/buitenlamp
#

# check if root

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# set date to something usefull for this script

DATE=`date +%m%d`

# set ON and OFF to max-time

OFF=08:50
ON=22:10

# check if directory exist; if not, create

if [ ! -d /opt/tijden ]
    then
        mkdir -p /opt/tijden
fi

# check if ON and OFF are on local file

if [ -e /opt/tijden/$DATE ]
    then
        OFF=`cat /opt/tijden/$DATE|awk '{print $1}'`
        ON=`cat /opt/tijden/$DATE|awk '{print $2}'`

# check if sunset times can be found on the interwebs

else
    OFF=`curl -s http://zonsopgang.info|grep Opkomst  |cut -d ">" -f4|cut -d "<" -f1`
    ON=`curl -s http://zonsopgang.info|grep Ondergang|cut -d ">" -f4|cut -d "<" -f1`
    echo $OFF $ON > /opt/tijden/$DATE
fi

# set "at" to turn the light off and on

echo "/opt/buitenlamp/ch4_off.py"| at -m $OFF
echo "/opt/buitenlamp/ch4_on.py" | at -m $ON
