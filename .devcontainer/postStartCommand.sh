tailscaled -state /workspaces/$(basename $PWD)/.devcontainer/tailscale/tailscaled.state &> /dev/null &
tailscale web &> /dev/null &
tailscale status --web &> /dev/null &

dockerd &> /dev/null &
