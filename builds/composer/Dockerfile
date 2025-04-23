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

RUN apt-get update && apt-get install -y curl
RUN mkdir -p /opt/tools

# Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /opt/tools/composer && \
    ln -s /opt/tools/composer /usr/local/bin/composer

ENTRYPOINT ["/docker-entrypoint.sh"]
