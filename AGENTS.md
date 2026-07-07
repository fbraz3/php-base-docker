# AI Agent Instructions for this Project (php-base-docker)

This document defines guidelines, behavioral rules, and detailed technical standards for AI assistants (agents) operating within the **php-base-docker** project. Follow these instructions strictly to ensure consistency, quality, and predictability in all interactions.

## 1. Project Overview and Philosophy
The **php-base-docker** project provides a set of Docker images tailored for various PHP environments and use cases (e.g., Vanilla PHP, Composer, Symfony, WP-CLI, and Phalcon). 
The core philosophy is modularity and reusability, supporting multiple PHP versions and architectures (`amd64`, `arm64`).

## 2. General Agent Directives
- **Understand Before Acting**: Before changing configurations (Dockerfiles, entrypoints, shell scripts), deeply read and understand the current file and how it integrates with other flavors.
- **Idempotency**: All scripts and Docker commands must be idempotent.
- **Fail-Fast**: Shell scripts (`.sh`) must include `set -e` (and ideally `set -euo pipefail`) to fail immediately on errors. 
- **Agent Persona**: Remember the initial directive: "I'm Mr. Meeseeks! Look at me!" and follow the global rules defined by the user.

## 3. Architecture and Directory Structure
- `/flavors`: Contains subdirectories for different environments/tools (vanilla, composer, symfony, wp-cli, phalcon). Each flavor must be self-contained.
- `/src`: Contains source code and configuration files used across different flavors or for base image generation.
- `/scripts`: Accessory scripts for CI/CD, building, or publishing images.
- `/assets`: Contains startup scripts (e.g., `ssmtp.sh`), configs, and other shared assets to be copied into the containers.

## 4. Docker and Container Best Practices
### 4.1. Dockerfiles
- **Base Images**: Ensure we use official base images when building our images, keeping architecture support in mind.
- **Layer Optimization**: Combine `RUN` commands where logical to reduce image layers. 
- **Package Management**:
  - Use the `--no-install-recommends` flag with `apt-get install` to minimize bloat.
  - ALWAYS clear the apt cache in the same layer: `rm -rf /var/lib/apt/lists/*`.
- **Permissions**: By default, containers should be designed to run as the `php` user (uid 1000). Avoid running services as `root` unless strictly necessary.
- **Extensions (PHP)**: Use standard helper scripts provided by the official PHP images (like `docker-php-ext-install`, `docker-php-ext-enable`).

## 5. Scripting and Automation
- **Entrypoints**: Keep entrypoint scripts clean and ensure they handle arguments properly (using `"$@"`).
- **Environment Variables**: Document and use environment variables for configurable settings (e.g., SMTP settings via `ssmtp.sh`).
- **Permissions Workarounds**: Ensure documentation and scripts account for volume permission issues gracefully.

## 6. Testing and Validation
- **Build Checks**: Any new flavor or PHP version bump must pass GitHub Actions workflows (e.g., `base-images.yml`, `phalcon-images.yml`).
- **Functionality Tests**: Ensure new tools (like WP-CLI or Symfony CLI) are properly installed and executable within the container.

## 7. Communication, Workflow, and Documentation
- **Planning**: Architectural changes require user validation and a clear plan. Do not execute destructive changes without approval.
- **Documentation**: Non-trivial changes must be summarized clearly. Update the `README.md` if adding new flavors or environment variables.
- **Language**: Comments in code, Dockerfiles, and compose files must be in English to maintain project consistency.
