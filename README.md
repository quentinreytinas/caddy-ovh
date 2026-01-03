# caddy-ovh

Image Docker **Caddy** construite avec le plugin DNS **OVH** pour gérer les
certificats via le challenge DNS-01. Le dépôt fournit aussi des exemples de
configuration, des scripts utiles et un workflow GitHub pour publier l’image sur
GHCR.

## Contenu du dépôt

- `Dockerfile` : construit un binaire Caddy incluant `caddy-dns/ovh`.
- `Caddyfile` : exemple de configuration (reverse-proxy + snippets TLS/headers).
- `docker-compose.yaml` : stack de déploiement locale avec variables OVH.
- `Makefile` : commandes de build/push locales.
- `build.md` : documentation build multi-arch + publication GHCR.
- `ufw.md` : exemple de règles UFW pour un serveur perso.
- `adresses_ip.md` : commandes utiles pour diagnostiquer les IP locales.

## Prérequis

- Docker + Docker Compose (ou `docker compose`)
- Un compte OVH avec des identifiants API :
  - `OVH_APPLICATION_KEY`
  - `OVH_APPLICATION_SECRET`
  - `OVH_CONSUMER_KEY`
  - `OVH_ENDPOINT` (par défaut `ovh-eu`)

## Utilisation rapide

1. Adapte le `Caddyfile` à tes domaines et services.
2. Crée un fichier `.env` avec tes secrets OVH.
3. Lance le conteneur :

```bash
docker compose up -d
```

Le service expose les ports `80` et `443` et monte le `Caddyfile` local.

## Build local

Construire l’image en local :

```bash
make image
```

Build multi-architecture + push (nécessite buildx) :

```bash
make image-multiarch
```

Pour plus de détails, voir [`build.md`](build.md).

## Publication automatique

Le workflow `.github/workflows/release.yml` publie automatiquement l’image sur
GHCR lors d’une release GitHub, d’un tag `v*` ou d’un déclenchement manuel.
Il génère aussi des archives OCI pour les assets de release (voir `build.md`).

## Exemple de variables d’environnement

```env
OVH_ENDPOINT=ovh-eu
OVH_APPLICATION_KEY=your_app_key
OVH_APPLICATION_SECRET=your_app_secret
OVH_CONSUMER_KEY=your_consumer_key
```

## Notes

- Le `Caddyfile` fourni est un exemple. Adapte les domaines, reverse-proxy et
  en-têtes de sécurité à ton infra.
- Les fichiers `ufw.md` et `adresses_ip.md` donnent des commandes utiles pour
  diagnostiquer et sécuriser l’hôte.
