# caddy-ovh

Image Docker **Caddy** avec le plugin DNS **OVH** pour le challenge DNS-01.
Le dépôt fournit une stack locale, un exemple de configuration et des scripts
utiles.

## Démarrage rapide

1. Adapte le `Caddyfile` à tes domaines et services.
2. Crée un fichier `.env` avec tes secrets OVH.
3. Lance le conteneur :

```bash
docker compose up -d
```

Le service expose les ports `80` et `443` et monte le `Caddyfile` local.

## Variables d’environnement

```env
OVH_ENDPOINT=ovh-eu
OVH_APPLICATION_KEY=your_app_key
OVH_APPLICATION_SECRET=your_app_secret
OVH_CONSUMER_KEY=your_consumer_key
```

## Build & publication

Les commandes `make image` / `make image-multiarch` et la publication GHCR
sont documentées dans `build.md`.

## Références utiles

- `ufw.md` : règles UFW pour un serveur perso.
- `adresses_ip.md` : commandes pour diagnostiquer les IP locales.
