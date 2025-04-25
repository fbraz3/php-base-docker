ARG PHP_VERSION=8.2
ARG BUILD_ARCH="amd64"
FROM fbraz3/php-cli:$PHP_VERSION

ARG PHP_VERSION
ARG BUILD_ARCH
ENV DEBIAN_FRONTEND=noninteractive
ENV ENTRYPOINT_COMMAND="/usr/local/bin/wp --allow-root"

#ensure php repo is up-to-date
RUN for i in {1..10}; do \
      add-apt-repository -y ppa:ondrej/php && break || sleep 10; \
    done

RUN apt-get update && apt-get install -y curl
RUN mkdir -p /opt/tools

# WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /opt/tools/wp && \
    ln -s /opt/tools/wp /usr/local/bin/wp

#RUN /usr/local/bin/wp --info || exit 1

ENTRYPOINT ["/docker-entrypoint.sh"]