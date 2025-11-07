> Exemple de script pour ajuster UFW (Uncomplicated Firewall).  
> Remplace les valeurs par ton propre plan d'adressage avant de l'exécuter.

```bash
bash -euxo pipefail <<'EOF'
LAN_CIDR="192.168.0.0/24"      # réseau local autorisé à joindre Caddy
VPN_PEER_IP="10.0.0.2"         # IP WireGuard/ZeroTier/etc. du proxy distant
VPN_INTERFACE="wg0"            # interface tunnel côté home

# --- Ouvertures utiles (idempotentes) ---
ufw allow in from "$LAN_CIDR" to any port 22 proto tcp || true
ufw allow in from "$LAN_CIDR" to any port 443 proto tcp || true
ufw allow in on "$VPN_INTERFACE" from "$VPN_PEER_IP" to any port 443 proto tcp || true

# --- Nettoyage : on ferme les anciens ports exposés directement ---
PORTS="8080 8081 8123 8443 9000"
for p in $PORTS; do
  ufw delete allow in from "$VPN_PEER_IP" to any port "$p" proto tcp 2>/dev/null || true
done

# --- Optionnel : fermer HTTP/80 si seuls les défis DNS-01 sont utilisés ---
ufw delete allow in from "$LAN_CIDR" to any port 80 proto tcp 2>/dev/null || true

# --- Supprimer d'éventuelles règles WireGuard serveur (port 51820) ---
mapfile -t RULES < <(ufw status numbered | sed -n 's/^\[\s*\([0-9]\+\)\]\s\+51820\/udp.*/\1/p')
for n in $(printf '%s\n' "${RULES[@]}" | sort -rn); do ufw --force delete "$n"; done

# --- Reload & affichage ---
ufw reload
ufw status numbered
EOF
```
