ARG PHP_VERSION=8.2
ARG BUILD_ARCH="amd64"
FROM fbraz3/php-base:$PHP_VERSION-$BUILD_ARCH

ARG PHP_VERSION
ARG BUILD_ARCH
ENV DEBIAN_FRONTEND=noninteractive

#ensure php repo is up-to-date
RUN for i in {1..10}; do \
      add-apt-repository -y ppa:ondrej/php && break || sleep 10; \
    done

# Install required packages
RUN if dpkg --compare-versions "${PHP_VERSION}" gt "7.1" && dpkg --compare-versions "${PHP_VERSION}" lt "8.0"; then \
      apt-get update && apt-get install -y "php${PHP_VERSION}-phalcon4"; \
    else \
      apt-get update && apt-get install -y "php${PHP_VERSION}-phalcon"; \
    fi

ENTRYPOINT ["/docker-entrypoint.sh"]
