export REPOSITORY=dind

dockerd --seccomp-profile unconfined --experimental &> /dev/null &

tailscaled -statedir /workspaces/$REPOSITORY/.devcontainer/tailscale &> /dev/null &
