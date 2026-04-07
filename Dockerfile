# Dockerfile
ARG CADDY_VERSION=latest

FROM caddy:${CADDY_VERSION}-builder AS builder

# Build Caddy avec les modules OVH DNS + Sablier
RUN xcaddy build \
    --with github.com/caddy-dns/ovh \
    --with github.com/sablierapp/sablier-caddy-plugin@v1.0.1

# Image finale légère
FROM caddy:${CADDY_VERSION}

# Copie le binaire custom
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Métadonnées
LABEL org.opencontainers.image.source="https://github.com/quentinreytinas/caddy-ovh"
LABEL org.opencontainers.image.description="Caddy with OVH DNS and Sablier plugins"
