sleep 120

tailscaled -statedir /workspaces/$(basename $PWD)/.devcontainer/tailscale &> /dev/null &
tailscale web &> /dev/null &
tailscale status --web &> /dev/null &

dockerd --seccomp-profile unconfined --experimental &> /dev/null &
