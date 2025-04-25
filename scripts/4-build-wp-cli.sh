#!/bin/bash

php_versions=("5.6" "7.0" "7.1" "7.2" "7.3" "7.4" "8.0" "8.1" "8.2" "8.3" "8.4")
build_arch="arm64"
dockerfile="flavors/wp-cli/Dockerfile"

cd ..
for version in "${php_versions[@]}"; do
  echo "Building image for PHP $version..."
  docker build --build-arg PHP_VERSION="$version" --build-arg BUILD_ARCH="$build_arch" --file "$dockerfile" -t "fbraz3/wp-cli:$version" .
done

#Run all tests togheter after build
for version in "${php_versions[@]}"; do
   echo -ne "Testing PHP \033[1m$version : WP Binary\033[0m : "
   docker run --rm fbraz3/wp-cli:"$version" --version 2>&1 | grep -q "WP-CLI" && echo -e "\033[0;32mOK\033[0m" || echo -e "\033[0;31mFAIL\033[0m"
done
