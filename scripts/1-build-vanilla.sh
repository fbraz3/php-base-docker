#!/bin/bash

php_versions=("5.6" "7.0" "7.1" "7.2" "7.3" "7.4" "8.0" "8.1" "8.2" "8.3" "8.4")
build_arch="arm64"
dockerfile="flavors/vanilla/Dockerfile"

cd ..
for version in "${php_versions[@]}"; do
  echo "Building image for PHP $version..."
  docker build --build-arg PHP_VERSION="$version" --build-arg BUILD_ARCH="$build_arch" --file "$dockerfile" -t "fbraz3/php-cli:$version" .
done

#Run all tests togheter after build
for version in "${php_versions[@]}"; do
   echo -ne "Testing PHP \033[1m$version : Version\033[0m : "
   docker run --rm fbraz3/php-cli:"$version" -v | grep -q "$version" && echo -e "\033[0;32mOK\033[0m" || echo -e "\033[0;31mFAIL\033[0m"
done
