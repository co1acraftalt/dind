export REPOSITORY=dind

sysctl --write net.ipv6.conf.all.forwarding=1

ethtool --features eth0 rx-udp-gro-forwarding on
ethtool --features eth0 tx-udp-segmentation on

swapoff /tmp/swap
fallocate --length 16G /tmp/swap
chmod 600 /tmp/swap
mkswap /tmp/swap
swapon /tmp/swap

dockerd --seccomp-profile unconfined --experimental &> /dev/null &

tailscaled -statedir /workspaces/$REPOSITORY/.devcontainer/tailscale &> /dev/null &
