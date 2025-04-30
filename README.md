# Braz PHP Docker

## Objective

The **Braz PHP Docker** project provides a set of Docker images tailored for various PHP environments and use cases.

It simplifies the process of setting up PHP development environments by offering pre-configured images for different frameworks and tools, such as Vanilla PHP, Composer, Symfony, WP-CLI, and Phalcon.

These images support multiple PHP versions and architectures, ensuring compatibility and flexibility for developers.


| Docker Image                                                 | Entrypoint                | Command Example                                                               | Build Status                                                                                                                                                                                           |
|--------------------------------------------------------------|---------------------------|-------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [php-cli](https://hub.docker.com/r/fbraz3/php-cli)           | `/usr/bin/php`            | `docker run -v $pwd:/workspace --rm fbraz3/php-cli:8.4 myscript.php`          | [![Build Base Images](https://github.com/fbraz3/php-base-docker/actions/workflows/base-images.yml/badge.svg)](https://github.com/fbraz3/php-base-docker/actions/workflows/base-images.yml)             |
| [phalcon](https://hub.docker.com/r/fbraz3/php-cli)           | `/usr/bin/php`            | `docker run -v $pwd:/workspace --rm fbraz3/php-cli:8.4-phalcon myscript.php`  | [![Build Phalcon Images](https://github.com/fbraz3/php-base-docker/actions/workflows/phalcon-images.yml/badge.svg)](https://github.com/fbraz3/php-base-docker/actions/workflows/phalcon-images.yml)    |
| [php-composer](https://hub.docker.com/r/fbraz3/php-composer) | `/usr/local/bin/composer` | `docker run -v $pwd:/workspace --rm fbraz3/php-composer:8.4 init`             | [![Build Composer Images](https://github.com/fbraz3/php-base-docker/actions/workflows/composer-images.yml/badge.svg)](https://github.com/fbraz3/php-base-docker/actions/workflows/composer-images.yml) |
| [wp-cli](https://hub.docker.com/r/fbraz3/wp-cli)             | `/usr/local/bin/wp`       | `docker run -v $pwd:/workspace --rm fbraz3/wp-cli:8.4 plugin install bbpress` | [![Build WP-Cli Images](https://github.com/fbraz3/php-base-docker/actions/workflows/wp-cli-images.yml/badge.svg)](https://github.com/fbraz3/php-base-docker/actions/workflows/wp-cli-images.yml)       |
| [symfony-cli](https://hub.docker.com/r/fbraz3/symfony-cli)   | `/usr/local/bin/symfony`  | `docker run -v $pwd:/workspace --rm fbraz3/symfony-cli:8.4 server:start`      | [![Build Symfony Images](https://github.com/fbraz3/php-base-docker/actions/workflows/symfony-images.yml/badge.svg)](https://github.com/fbraz3/php-base-docker/actions/workflows/symfony-images.yml)    |

⚠️ Ask Devin AI about this project on [DeepWiki](https://deepwiki.com/fbraz3/php-base-docker).

## Tags

Each image is tagged with the PHP version and architecture. For example:
- `fbraz3/php-cli:8.4` for PHP 8.4
- `fbraz3/php-cli:8.4-phalcon` for PHP 8.4 with Phalcon extension
- `fbraz3/php-composer:8.4` for PHP 8.4 with Composer
- `fbraz3/symfony-cli:8.4` for PHP 8.4 with Symfony CLI
- `fbraz3/wp-cli:8.4` for PHP 8.4 with WP-CLI

## Flavors

This project includes the following flavors:

- **Vanilla PHP**: A base PHP image with essential extensions and tools.
- **Composer**: An image with Composer pre-installed for dependency management.
- **Symfony**: An image with the Symfony CLI pre-installed for Symfony projects.
- **WP-CLI**: An image with WP-CLI pre-installed for managing WordPress installations.
- **Phalcon**: An image with the Phalcon PHP framework pre-installed.

Each flavor supports multiple PHP versions, ranging from 5.6 to 8.4, and is available for both `amd64` and `arm64` architectures.

## Permissions

The images are designed to run as the `php` user by default (uid 1000). If you need to run commands as the root user, you can use the `--user` flag when running the container.

If you need to write to a mounted volume, ensure that the `php` user has the necessary permissions. You can set the ownership of the mounted directory to the `php` user by running:

```sh
chown -R 1000:1000 /path/to/your/directory
```

A workaround for this is to chmod the mounted directory to `777` before running the container. This will allow all users to read, write, and execute files in that directory. However, this is not recommended for production environments due to security concerns.

There is another workaround for this running the container with the `--user` flag set to `root`, but this is also not recommended for production environments.

The default directory for the container is `/workspace`, but you can change it by setting the `WORKDIR` environment variable in your Dockerfile or when running the container.

## Sending Emails

All images have ssmtp pre-installed and configured to send emails. The default SMTP server is `localhost` on port `25`. You can use the `mail()` function in PHP to send emails from the container.

It's recommended to change the default SMTP server to your own SMTP server. You can do this by setting the `SMTP` environment variable when running the container. For example:

```sh
docker run -v $pwd:/workspace -e SMTP_MAIL_SERVER=smtp.example.com -e SMTP_AUTH_USER=username -e SMTP_AUTH_PASSWORD=password --rm fbraz3/php-cli:8.4 mail_sending.php
```

‼️Note: avoid setting the password in the command line, use a .env file instead.

For example, create a `.env` file with the following content:

```env
SMTP_MAIL_SERVER=smtp.example.com
SMTP_AUTH_USER=username
SMTP_AUTH_PASSWORD=password
```

Then run the container with the `--env-file` option:

```sh
docker run -v $pwd:/workspace --env-file .env --rm fbraz3/php-cli:8.4 mail_sending.php
```

To validate all environment variables you can use for mail sending, please check the file [ssmtp.sh](./assets/startup/ssmtp.sh).

Is also recommended to refer to [ssmtp documentation](https://wiki.archlinux.org/title/SSMTP) for more information about its configuration.

## Contribution

Contributions are welcome! Feel free to open issues or submit pull requests to improve the project.

Please visit the [CONTRIBUTING.md](CONTRIBUTING.md) file for guidelines on how to contribute to this project.

Useful links:
- [How to create a pull request](https://docs.github.com/pt/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request)
- [How to report an issue](https://docs.github.com/pt/issues/tracking-your-work-with-issues/creating-an-issue)

## Donation

I spend a lot of time and effort maintaining this project. If you find it useful, consider supporting me with a donation:
- [Patreon](https://www.patreon.com/fbraz3)
- [GitHub Sponsor](https://github.com/sponsors/fbraz3)

## License

This project is licensed under the [Apache License 2.0](LICENSE), so you can use it for personal and commercial projects. However, please note that the images are provided "as is" without any warranty or guarantee of any kind. Use them at your own risk.