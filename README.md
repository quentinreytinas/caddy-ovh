# caddy-ovh

Image Docker **Caddy** avec le plugin DNS **OVH** (DNS-01) et le plugin
**Sablier** (start/stop de services à la demande).
Le dépôt fournit une stack locale, un exemple de configuration et des scripts
utiles.

## Modules inclus

- `dns.providers.ovh`
- `http.handlers.sablier`

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

## Exploitation Sablier (memo)

Sablier n'arrete que les conteneurs explicitement references dans le `Caddyfile`
via les directives `sablier ... names ...`.

Workflow recommande:

1. Lister les conteneurs:

```bash
docker ps --format '{{.Names}}'
```

2. Ajouter/retirer les `names` dans le bloc Sablier cible.
3. Ajuster `session_duration` (`30m`, `2h`, `4h`, etc.).
4. Valider/recharger Caddy:

```bash
docker exec caddy caddy validate --config /etc/caddy/Caddyfile
docker exec caddy caddy reload --config /etc/caddy/Caddyfile
```

Bonnes pratiques:

- Ne pas inclure les services domotiques critiques (Home Assistant, Zigbee2MQTT, Node-RED).
- Garder `blocking.timeout` coherent avec le temps de warmup des modeles.
