FROM php:8.2-cli AS php-tools

RUN apt-get update && apt-get install -y curl
RUN mkdir -p /opt/tools

# Symfony CLI
RUN curl -sS https://get.symfony.com/cli/installer | bash && \
    mv $HOME/.symfony*/bin/symfony /opt/tools/symfony && \
    ln -s /opt/tools/symfony /usr/local/bin/symfony

ARG PHP_VERSION=8.2
ARG BUILD_ARCH="amd64"
FROM fbraz3/php-base:$PHP_VERSION-$BUILD_ARCH

COPY --from=php-tools /usr/local/bin/symfony /usr/local/bin/symfony

ENTRYPOINT ["/docker-entrypoint.sh"]
