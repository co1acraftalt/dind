tailscaled &> /dev/null &
tailscale web &> /dev/null &
tailscale status --web &> /dev/null &

dockerd &> /dev/null &
