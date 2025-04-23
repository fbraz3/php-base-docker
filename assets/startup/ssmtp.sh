#!/bin/bash

cp -f /etc/ssmtp/ssmtp.conf.template /etc/ssmtp/ssmtp.conf
sed -i 's/%MY_HOSTNAME%/'`/bin/hostname`'/g' /etc/ssmtp/ssmtp.conf

if [ ! -z "$SMTP_MAIL_SERVER" ]; then
	sed -i "s/mail:25/$SMTP_MAIL_SERVER/g" /etc/ssmtp/ssmtp.conf
fi

if [ ! -z "$SMTP_USE_TLS" ]; then
	sed -i 's/#SMTP_USE_TLS#//g' /etc/ssmtp/ssmtp.conf
	sed -i "s/%SMTP_USE_TLS%/$SMTP_USE_TLS/g" /etc/ssmtp/ssmtp.conf
fi

if [ ! -z "$SMTP_USE_STARTTLS" ]; then
	sed -i 's/#SMTP_USE_STARTTLS#//g' /etc/ssmtp/ssmtp.conf
	sed -i "s/%SMTP_USE_STARTTLS%/$SMTP_USE_STARTTLS/g" /etc/ssmtp/ssmtp.conf
fi

if [ ! -z "$SMTP_AUTH_USER" ]; then
	sed -i 's/#SMTP_AUTH_USER#//g' /etc/ssmtp/ssmtp.conf
	sed -i "s/%SMTP_AUTH_USER%/$SMTP_AUTH_USER/g" /etc/ssmtp/ssmtp.conf
fi

if [ ! -z "$SMTP_AUTH_PASSWORD" ]; then
	sed -i 's/#SMTP_AUTH_PASSWORD#//g' /etc/ssmtp/ssmtp.conf
	sed -i "s/%SMTP_AUTH_PASSWORD%/$SMTP_AUTH_PASSWORD/g" /etc/ssmtp/ssmtp.conf
fi

if [ ! -z "$SMTP_AUTH_METHOD" ]; then
	sed -i 's/#SMTP_AUTH_METHOD#//g' /etc/ssmtp/ssmtp.conf
	sed -i "s/%SMTP_AUTH_METHOD%/$SMTP_AUTH_METHOD/g" /etc/ssmtp/ssmtp.conf
fi