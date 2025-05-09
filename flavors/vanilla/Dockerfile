FROM ubuntu:22.04

ARG PHP_VERSION=8.2
ENV DEBIAN_FRONTEND=noninteractive
ENV ENTRYPOINT_COMMAND=/usr/bin/php

COPY --chmod=755 ../../assets/scripts/docker-entrypoint.sh /
RUN mkdir /entrypoints
RUN echo "#!/bin/bash" > /entrypoints/null.sh

RUN echo $PHP_VERSION > /PHP_VERSION

# Add support for add-apt-repository
RUN apt-get update && apt-get install -yq software-properties-common apt-transport-https

# Add php repository
RUN for i in {1..10}; do \
      add-apt-repository -y ppa:ondrej/php && break || sleep 10; \
    done

# Add utilities
RUN apt-get -yq install vim ssmtp wget unzip curl less git

# Add PHP packages
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
    fi; \
    apt -fy remove apache2; apt -fy autoremove;

# Apply latest security updates
RUN /usr/bin/unattended-upgrades -v

# Add SSMTP configuration
COPY --chmod=755 ../../assets/conf/ssmtp.conf.template /etc/ssmtp/
COPY --chmod=755 ../../assets/startup/ssmtp.sh /entrypoints/

# Enforce php version
RUN update-alternatives  --set php /usr/bin/php$PHP_VERSION

#add php user
RUN useradd -u 1000 -m -s /bin/bash php; \
    mkdir /workspace; \
    chown -R php:php /workspace; \
    chmod -R 777 /etc/ssmtp/

WORKDIR /workspace
USER php

ENTRYPOINT ["/docker-entrypoint.sh"]