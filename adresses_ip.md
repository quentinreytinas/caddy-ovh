# Vérifier les IP locales utilisées par Caddy

```bash
# Adresse IPv4 de l'interface WireGuard (remplace wg0 si besoin)
ip -4 addr show dev wg0 | awk '/inet /{print $2}'

# Adresse IPv4 de ton interface LAN (adapter enpXsY / eth0 / br0, etc.)
ip -4 addr show dev enp1s0 | awk '/inet /{print $2}'

# Lister toutes les interfaces disponibles
ls /sys/class/net

# Connaitre la route par défaut et l'interface utilisée
ip route get 1.1.1.1

# Visualiser la configuration WireGuard locale
wg show
# (Sinon lire la section [Interface] Address dans /etc/wireguard/wg0.conf)

# Vérifier quels sockets écoutent sur 80/443
ss -ltnp | grep -E ':80|:443'
```
