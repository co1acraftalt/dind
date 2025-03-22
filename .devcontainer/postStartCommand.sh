tailscaled -statedir /workspaces/$(basename $PWD)/.devcontainer/tailscale &> /dev/null &
tailscale web &> /dev/null &
tailscale status --web &> /dev/null &

dockerd --experimental --seccomp-profile &> /dev/null &
