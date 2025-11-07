# Exemple de build/push multi-arch vers GHCR

```bash
export GH_USERNAME="your-gh-username"
export GH_TOKEN="ghp_XXXX"          # Token avec scope "write:packages"

echo "$GH_TOKEN" | docker login ghcr.io -u "$GH_USERNAME" --password-stdin

# Créer (ou réutiliser) un builder multi-plateforme
docker buildx create --name multiarch --use 2>/dev/null || docker buildx use multiarch
docker buildx inspect --bootstrap

# Build et push pour AMD64 + ARM64
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t "ghcr.io/${GH_USERNAME}/caddy-ovh:latest" \
  --push \
  .
```
