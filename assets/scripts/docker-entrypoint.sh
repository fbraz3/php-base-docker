#!/bin/bash

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

RESTART_MONIT="false"
if [ -d "/entrypoints" ]; then
	for file in /entrypoints/*.sh; do
     [ -f "$file" ] || continue
     source $file
 done
fi

if [[ -d /etc/monit/ ]] && [[ "$RESTART_MONIT" == "true" ]]; then
  sleep 1
  /usr/sbin/service monit start
fi

exec $ENTRYPOINT_COMMAND "$@"