ARG PHP_VERSION=8.2
ARG BUILD_ARCH="amd64"
FROM fbraz3/php-cli:$PHP_VERSION

ARG PHP_VERSION
ARG BUILD_ARCH
ENV DEBIAN_FRONTEND=noninteractive
ENV ENTRYPOINT_COMMAND=/usr/bin/php

#ensure php repo is up-to-date
RUN for i in {1..10}; do \
      add-apt-repository -y ppa:ondrej/php && break || sleep 10; \
    done

RUN apt-get update

RUN if dpkg --compare-versions "${PHP_VERSION}" gt "7.2"; then \
      apt-get install -y "php${PHP_VERSION}-psr"; \
    else \
        apt-get install -y "php-psr"; \
    fi

# Install required packages
RUN if dpkg --compare-versions "${PHP_VERSION}" gt "7.1" && dpkg --compare-versions "${PHP_VERSION}" lt "8.0"; then \
      apt-get install -y "php${PHP_VERSION}-phalcon4"; \
    else \
      apt-get install -y "php${PHP_VERSION}-phalcon"; \
    fi

RUN update-alternatives  --set php /usr/bin/php$PHP_VERSION

ENTRYPOINT ["/docker-entrypoint.sh"]