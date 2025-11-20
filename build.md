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

## Publication automatique sur une release GitHub

Une fois qu'une release GitHub est publiée (bouton **Publish release** sur GitHub),
ou qu'un tag `v*` est poussé (ou déclenché manuellement via **Run workflow**),
le workflow `.github/workflows/release.yml` construit l'image multi-architecture,
la pousse vers `ghcr.io/${{ github.repository_owner }}/caddy-ovh` avec le tag
résolu **et** `latest`, puis ajoute quatre assets au release GitHub pour AMD64 et
ARM64 :

- `caddy-ovh-<tag>.tar.gz` et `caddy-ovh-<tag>.tar.gz.sha256` : archive OCI
  multi-architecture liée à la release publiée.
- `caddy-ovh-latest.tar.gz` et `caddy-ovh-latest.tar.gz.sha256` : archive OCI
  multi-architecture correspondant à l'image `latest` poussée sur GHCR.

Aucune action supplémentaire n'est requise côté utilisateur : publier une release
ouvre automatiquement ces artefacts pour téléchargement et met à jour l'image sur
le GitHub Container Registry.
