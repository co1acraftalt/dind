clear

tailscale up --hostname codespaces --advertise-exit-node --qr
clear

echo "IPv4: $(tailscale ip --4)"
echo "IPv6: $(tailscale ip --6)"
echo "DNS: $(tailscale whois $(tailscale ip --4) | grep -oP '[a-z0-9-]+\.[a-z0-9-]+\.ts\.net')"
