clear
tailscale up --hostname codespaces --advertise-exit-node --qr
clear
echo "IPv4: $(tailscale ip --4)"
echo "IPv6: $(tailscale ip --6)"
