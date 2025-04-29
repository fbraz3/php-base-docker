#!/bin/bash

#if [ ! -f /donate ]; then
#  echo "If you enjoy using this image, please consider donating."
#  echo "https://github.com/sponsors/fbraz3"
#  echo "https://www.patreon.com/fbraz3"
#  echo "Thank you for your support!"
#  touch /donate
#fi

# DECLARE/SET VARIABLES
PHPVERSION=`cat /PHP_VERSION 2>/dev/null`
if [ -z "$PHPVERSION" ]; then
    PHPVERSION=`php -v|grep --only-matching --perl-regexp "7\.\\d+" |head -n1`
fi

if [ -z "$PHPVERSION" ]; then
    PHPVERSION='7.3'
fi

if [ -z "$ENTRYPOINT_COMMAND" ]; then
    ENTRYPOINT_COMMAND='/usr/bin/php'
fi

if [ -d "/entrypoints" ]; then
	for file in /entrypoints/*.sh; do
     [ -f "$file" ] || continue
     source $file
 done
fi

exec $ENTRYPOINT_COMMAND "$@"