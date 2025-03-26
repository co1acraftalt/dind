FROM debian:sid-slim

RUN DEBIAN_FRONTEND=noninteractive apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install sudo --no-install-recommends --yes
RUN DEBIAN_FRONTEND=noninteractive apt-get install wget --no-install-recommends --yes
RUN DEBIAN_FRONTEND=noninteractive apt-get install ca-certificates --no-install-recommends --yes
RUN DEBIAN_FRONTEND=noninteractive apt-get install iptables --no-install-recommends --yes
RUN DEBIAN_FRONTEND=noninteractive apt-get install qemu-utils --no-install-recommends --yes
RUN DEBIAN_FRONTEND=noninteractive apt-get install p7zip-full --no-install-recommends --yes
RUN DEBIAN_FRONTEND=noninteractive apt-get install openssh-server --no-install-recommends --yes
RUN DEBIAN_FRONTEND=noninteractive apt-get install htop --no-install-recommends --yes

RUN rm --recursive --force /var/lib/apt/lists/*

RUN update-alternatives --set iptables /usr/sbin/iptables-legacy
RUN update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

# https://www.speedtest.net/apps/cli
RUN wget https://github.com/ItzLevvie/artifacts/releases/download/latest/speedtest --output-document /usr/local/bin/speedtest
RUN chmod +x /usr/local/bin/speedtest

# https://github.com/fastfetch-cli/fastfetch/actions/workflows/ci.yml
RUN wget https://github.com/ItzLevvie/artifacts/releases/download/latest/fastfetch --output-document /usr/local/bin/fastfetch
RUN chmod +x /usr/local/bin/fastfetch

# https://pkgs.tailscale.com/unstable
RUN wget https://github.com/ItzLevvie/artifacts/releases/download/latest/tailscale --output-document /usr/local/bin/tailscale
RUN wget https://github.com/ItzLevvie/artifacts/releases/download/latest/tailscaled --output-document /usr/local/bin/tailscaled
RUN chmod +x /usr/local/bin/tailscale
RUN chmod +x /usr/local/bin/tailscaled

# https://github.com/moby/moby/actions/workflows/buildkit.yml
RUN wget https://github.com/ItzLevvie/artifacts/releases/download/latest/docker-proxy --output-document /usr/local/bin/docker-proxy
RUN wget https://github.com/ItzLevvie/artifacts/releases/download/latest/dockerd --output-document /usr/local/bin/dockerd
RUN chmod +x /usr/local/bin/docker-proxy
RUN chmod +x /usr/local/bin/dockerd

# https://github.com/docker/cli/actions/workflows/build.yml
RUN wget https://github.com/ItzLevvie/artifacts/releases/download/latest/docker-linux-amd64 --output-document /usr/local/bin/docker
RUN chmod +x /usr/local/bin/docker

# https://github.com/containerd/containerd/actions/workflows/release.yml
RUN wget https://github.com/ItzLevvie/artifacts/releases/download/latest/containerd-shim-runc-v2 --output-document /usr/local/bin/containerd-shim-runc-v2
RUN wget https://github.com/ItzLevvie/artifacts/releases/download/latest/containerd --output-document /usr/local/bin/containerd
RUN chmod +x /usr/local/bin/containerd-shim-runc-v2
RUN chmod +x /usr/local/bin/containerd

# https://github.com/opencontainers/runc/actions/workflows/validate.yml
RUN wget https://github.com/ItzLevvie/artifacts/releases/download/latest/runc.amd64 --output-document /usr/local/bin/runc
RUN chmod +x /usr/local/bin/runc

# https://github.com/docker/compose/actions/workflows/ci.yml
RUN mkdir --parents /usr/local/lib/docker/cli-plugins
RUN wget https://github.com/ItzLevvie/artifacts/releases/download/latest/docker-compose-linux-x86_64 --output-document /usr/local/lib/docker/cli-plugins/docker-compose
RUN chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

# https://github.com/docker/buildx/actions/workflows/build.yml
RUN wget https://github.com/ItzLevvie/artifacts/releases/download/latest/buildx.linux-amd64 --output-document /usr/local/lib/docker/cli-plugins/docker-buildx
RUN chmod +x /usr/local/lib/docker/cli-plugins/docker-buildx
