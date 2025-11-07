# Dockerfile
FROM caddy:builder AS builder

# Build Caddy avec le module OVH
RUN xcaddy build \
    --with github.com/caddy-dns/ovh

# Image finale légère
FROM caddy:latest

# Copie le binaire custom
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Métadonnées
LABEL org.opencontainers.image.source="https://github.com/quentinreytinas/caddy-ovh"
LABEL org.opencontainers.image.description="Caddy with OVH DNS plugin"
