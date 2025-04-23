FROM php:8.2-cli AS php-tools

RUN apt-get update && apt-get install -y curl
RUN mkdir -p /opt/tools

# WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /opt/tools/wp && \
    ln -s /opt/tools/wp /usr/local/bin/wp

ARG PHP_VERSION=8.2
ARG BUILD_ARCH="amd64"
FROM fbraz3/php-base:$PHP_VERSION-$BUILD_ARCH

COPY --from=php-tools /usr/local/bin/wp /usr/local/bin/wp

ENTRYPOINT ["/docker-entrypoint.sh"]
