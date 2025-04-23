FROM ubuntu:22.04

ARG PHP_VERSION=8.2
ENV DEBIAN_FRONTEND=noninteractive

COPY ../../scripts/autoclean.sh /root/
COPY ../../scripts/docker-entrypoint.sh ./misc/cronfile.final ./misc/cronfile.system /
RUN mkdir /entrypoints
RUN echo "#!/bin/bash" > /entrypoints/null.sh

RUN echo $PHP_VERSION > /PHP_VERSION; \
    chmod +x /root/autoclean.sh; \
    chmod +x /docker-entrypoint.sh; \
    mkdir /app; \
    mkdir /run/php/; \
    mkdir -p /app/public; \
    apt-get update;

RUN apt-get install -yq software-properties-common apt-transport-https \
    cron vim ssmtp monit wget unzip curl less git; \
    /usr/bin/unattended-upgrades -v;

#php-base
RUN for i in {1..10}; do \
      add-apt-repository -y ppa:ondrej/php && break || sleep 10; \
    done

RUN apt-get install -yq php$PHP_VERSION php$PHP_VERSION-cli \
    php$PHP_VERSION-common php$PHP_VERSION-curl \
    php$PHP_VERSION-mysql php$PHP_VERSION-opcache php$PHP_VERSION-readline \
    php$PHP_VERSION-xml php$PHP_VERSION-xsl php$PHP_VERSION-gd php$PHP_VERSION-intl \
    php$PHP_VERSION-bz2 php$PHP_VERSION-bcmath php$PHP_VERSION-imap php$PHP_VERSION-gd \
    php$PHP_VERSION-mbstring php$PHP_VERSION-pgsql php$PHP_VERSION-sqlite3 \
    php$PHP_VERSION-xmlrpc php$PHP_VERSION-zip php$PHP_VERSION-odbc php$PHP_VERSION-snmp \
    php$PHP_VERSION-interbase php$PHP_VERSION-ldap php$PHP_VERSION-tidy \
    php$PHP_VERSION-memcached php$PHP_VERSION-redis php$PHP_VERSION-imagick php$PHP_VERSION-mongodb; \
    if [ $PHP_VERSION \< 8 ]; then \
      apt-get install -yq php$PHP_VERSION-json; \
    fi; \
    INSTALLED_VERSION=$(php -v |head -n1 | awk '{print $2}' | awk -F'.' '{print $1"."$2}'); \
    if [ ! -z "$INSTALLED_VERSION" ] && [ $PHP_VERSION != $INSTALLED_VERSION ]; then \
      apt remove -fyq php$INSTALLED_VERSION*; apt -fyq autoremove; \
    fi;

# Ensure PHP version is the correct one
RUN if [ $PHP_VERSION != $(php -v |head -n1 | awk '{print $2}' | awk -F'.' '{print $1"."$2}') ]; then exit 1; fi

COPY ../../conf/ssmtp.conf.template /etc/ssmtp/
COPY ../../monit/monitrc /etc/monit/
COPY ../../monit/cron /etc/monit/conf-enabled/
COPY ../../startup/ssmtp.sh /entrypoints

ENTRYPOINT ["/docker-entrypoint.sh"]