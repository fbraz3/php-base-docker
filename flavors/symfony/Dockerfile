ARG PHP_VERSION=8.2
ARG BUILD_ARCH="amd64"
FROM fbraz3/php-cli:$PHP_VERSION

ARG PHP_VERSION
ARG BUILD_ARCH
ENV DEBIAN_FRONTEND=noninteractive
ENV ENTRYPOINT_COMMAND=/usr/local/bin/symfony

#ensure php repo is up-to-date
RUN for i in {1..10}; do \
      add-apt-repository -y ppa:ondrej/php && break || sleep 10; \
    done

RUN apt-get update && apt-get install -y curl
RUN mkdir -p /opt/tools

# Symfony CLI
RUN curl -sS https://get.symfony.com/cli/installer | bash && \
    mv $HOME/.symfony*/bin/symfony /opt/tools/symfony && \
    ln -s /opt/tools/symfony /usr/local/bin/symfony

RUN update-alternatives  --set php /usr/bin/php$PHP_VERSION

ENTRYPOINT ["/docker-entrypoint.sh"]
