#!/bin/bash

$(which chmod) 700 /etc/monit/monitrc

FILE_TO_WATCH="/dev/null"

# CLEAR TMP FILES
/root/autoclean.sh

# ADD CRON
CRONFILE="/cronfile.final"
SYSTEMCRON="/cronfile.system"
USERCRON="/cronfile"

echo > $CRONFILE
if [ -f "$SYSTEMCRON" ]; then
	cat $SYSTEMCRON >> $CRONFILE
fi
if [ -f "$USERCRON" ]; then
	cat $USERCRON >> $CRONFILE
fi
/usr/bin/crontab $CRONFILE

# DECLARE/SET VARIABLES
PHPVERSION=`cat /PHP_VERSION 2>/dev/null`
if [ -z "$PHPVERSION" ]; then
    PHPVERSION=`php -v|grep --only-matching --perl-regexp "7\.\\d+" |head -n1`
fi

if [ -z "$PHPVERSION" ]; then
    PHPVERSION='7.3'
fi

# PUPULATE TEMPLATES
if [ -d "/entrypoints" ]; then
	for file in /entrypoints/*.sh; do
     [ -f "$file" ] || continue
	 echo "> Running: $file"
     source $file
 done
fi

# START SERVICES
echo "> Starting Services"
/usr/sbin/service cron restart
sleep 1
/usr/sbin/service monit start

# KEEP CONTAINER ALIVE
if [ ! -z "$FILE_TO_WATCH" ]; then
	/usr/bin/tail -f $FILE_TO_WATCH
fi
