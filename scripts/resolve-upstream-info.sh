#!/usr/bin/env bash
set -euo pipefail

get_digest() {
  local image=$1
  local digest

  digest=$(docker buildx imagetools inspect "$image" | awk -F': ' '/^Digest:/ {print $2; exit}')

  if [ -z "$digest" ]; then
    echo "Unable to resolve digest for $image" >&2
    exit 1
  fi

  printf '%s' "$digest"
}

caddy_latest_digest="$(get_digest "caddy:latest")"
caddy_builder_digest="$(get_digest "caddy:builder")"
ovh_version="$(git ls-remote --tags https://github.com/caddy-dns/ovh.git \
  | awk -F/ '/refs\/tags\/v?[0-9]/{print $3}' \
  | sort -V \
  | tail -n1)"
if [ -z "${ovh_version}" ]; then
  ovh_version="$(git ls-remote https://github.com/caddy-dns/ovh.git HEAD | awk '{print $1}')"
fi

if [ -n "${GITHUB_OUTPUT:-}" ]; then
  {
    echo "caddy_latest_digest=${caddy_latest_digest}"
    echo "caddy_builder_digest=${caddy_builder_digest}"
    echo "ovh_version=${ovh_version}"
  } >> "$GITHUB_OUTPUT"
else
  echo "caddy_latest_digest=${caddy_latest_digest}"
  echo "caddy_builder_digest=${caddy_builder_digest}"
  echo "ovh_version=${ovh_version}"
fi
