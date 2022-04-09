#!/usr/bin/env bash
set -Eeuo pipefail

sed -e '/RUN set -eux;/i COPY 0001-Add-support-for-security-invoker-views.patch /usr/src/postgresql/' \
    -e "/apk add --no-cache --virtual .build-deps/a patch \\\\" \
    -e "/cd \/usr\/src\/postgresql;/a patch -p1 -i 0001-Add-support-for-security-invoker-views.patch; \\\\" \
  postgres/14/alpine/Dockerfile > Dockerfile

cp postgres/14/alpine/docker-entrypoint.sh .

# confirm adding patch was successful
grep 'security-invoker' Dockerfile
