FROM php:8.2-cli AS php-tools

RUN apt-get update && apt-get install -y curl
RUN mkdir -p /opt/tools

# Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /opt/tools/composer && \
    ln -s /opt/tools/composer /usr/local/bin/composer

ARG PHP_VERSION=8.2
ARG BUILD_ARCH="amd64"
FROM fbraz3/php-base:$PHP_VERSION-$BUILD_ARCH

COPY --from=php-tools /usr/local/bin/composer /usr/local/bin/composer

ENTRYPOINT ["/docker-entrypoint.sh"]
