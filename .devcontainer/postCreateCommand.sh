export REPOSITORY=dind

rm --recursive --force /tmp/$REPOSITORY/windows/*
mkdir --parents /tmp/$REPOSITORY/windows

mv --force /workspaces/$REPOSITORY/.devcontainer /tmp/$REPOSITORY/.devcontainer
rm --recursive --force /workspaces/$REPOSITORY/.*
rm --recursive --force /workspaces/$REPOSITORY/*
mv --force /tmp/$REPOSITORY/.devcontainer /workspaces/$REPOSITORY/.devcontainer

cp /workspaces/$REPOSITORY/.devcontainer/start /usr/local/bin/start
cp /workspaces/$REPOSITORY/.devcontainer/stop /usr/local/bin/stop
cp /workspaces/$REPOSITORY/.devcontainer/restart /usr/local/bin/restart
cp /workspaces/$REPOSITORY/.devcontainer/reset /usr/local/bin/reset
chmod +x /usr/local/bin/start
chmod +x /usr/local/bin/stop
chmod +x /usr/local/bin/restart
chmod +x /usr/local/bin/reset

DEBIAN_FRONTEND=noninteractive apt-get install wget --no-install-recommends --yes
DEBIAN_FRONTEND=noninteractive apt-get install ca-certificates --no-install-recommends --yes
DEBIAN_FRONTEND=noninteractive apt-get install iptables --no-install-recommends --yes
DEBIAN_FRONTEND=noninteractive apt-get install qemu-utils --no-install-recommends --yes
DEBIAN_FRONTEND=noninteractive apt-get install p7zip-full --no-install-recommends --yes
DEBIAN_FRONTEND=noninteractive apt-get install openssh-server --no-install-recommends --yes
DEBIAN_FRONTEND=noninteractive apt-get install htop --no-install-recommends --yes

update-alternatives --set iptables /usr/sbin/iptables-legacy
update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

# https://www.speedtest.net/apps/cli
wget https://github.com/ItzLevvie/artifacts/releases/download/latest/speedtest --output-document /usr/local/bin/speedtest
chmod +x /usr/local/bin/speedtest

# https://github.com/fastfetch-cli/fastfetch/actions/workflows/ci.yml
wget https://github.com/ItzLevvie/artifacts/releases/download/latest/fastfetch --output-document /usr/local/bin/fastfetch
chmod +x /usr/local/bin/fastfetch

# https://pkgs.tailscale.com/unstable
wget https://github.com/ItzLevvie/artifacts/releases/download/latest/tailscale --output-document /usr/local/bin/tailscale
wget https://github.com/ItzLevvie/artifacts/releases/download/latest/tailscaled --output-document /usr/local/bin/tailscaled
chmod +x /usr/local/bin/tailscale
chmod +x /usr/local/bin/tailscaled

# https://github.com/moby/moby/actions/workflows/buildkit.yml
wget https://github.com/ItzLevvie/artifacts/releases/download/latest/docker-proxy --output-document /usr/local/bin/docker-proxy
wget https://github.com/ItzLevvie/artifacts/releases/download/latest/dockerd --output-document /usr/local/bin/dockerd
chmod +x /usr/local/bin/docker-proxy
chmod +x /usr/local/bin/dockerd

# https://github.com/docker/cli/actions/workflows/build.yml
wget https://github.com/ItzLevvie/artifacts/releases/download/latest/docker-linux-amd64 --output-document /usr/local/bin/docker
chmod +x /usr/local/bin/docker

# https://github.com/containerd/containerd/actions/workflows/release.yml
wget https://github.com/ItzLevvie/artifacts/releases/download/latest/containerd-shim-runc-v2 --output-document /usr/local/bin/containerd-shim-runc-v2
wget https://github.com/ItzLevvie/artifacts/releases/download/latest/containerd --output-document /usr/local/bin/containerd
chmod +x /usr/local/bin/containerd-shim-runc-v2
chmod +x /usr/local/bin/containerd

# https://github.com/opencontainers/runc/actions/workflows/validate.yml
wget https://github.com/ItzLevvie/artifacts/releases/download/latest/runc.amd64 --output-document /usr/local/bin/runc
chmod +x /usr/local/bin/runc

# https://github.com/docker/compose/actions/workflows/ci.yml
mkdir --parents /usr/local/lib/docker/cli-plugins
wget https://github.com/ItzLevvie/artifacts/releases/download/latest/docker-compose-linux-x86_64 --output-document /usr/local/lib/docker/cli-plugins/docker-compose
chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

# https://github.com/docker/buildx/actions/workflows/build.yml
wget https://github.com/ItzLevvie/artifacts/releases/download/latest/buildx.linux-amd64 --output-document /usr/local/lib/docker/cli-plugins/docker-buildx
chmod +x /usr/local/lib/docker/cli-plugins/docker-buildx

swapoff /tmp/swap
fallocate --length 16G /tmp/swap
chmod 600 /tmp/swap
mkswap /tmp/swap
swapon /tmp/swap

mkdir --parents /workspaces/$REPOSITORY/windows
echo "data.img" > /workspaces/$REPOSITORY/windows/windows.boot

wget https://github.com/ItzLevvie/artifacts/releases/download/27774/data.7z.001 --output-document /workspaces/$REPOSITORY/windows/data.7z.001
wget https://github.com/ItzLevvie/artifacts/releases/download/27774/data.7z.002 --output-document /workspaces/$REPOSITORY/windows/data.7z.002
wget https://github.com/ItzLevvie/artifacts/releases/download/27774/data.7z.003 --output-document /workspaces/$REPOSITORY/windows/data.7z.003
wget https://github.com/ItzLevvie/artifacts/releases/download/27774/data.7z.004 --output-document /workspaces/$REPOSITORY/windows/data.7z.004

7z x /workspaces/$REPOSITORY/windows/data.7z.001 -o/workspaces/$REPOSITORY/windows
rm --force /workspaces/$REPOSITORY/windows/data.7z.*
qemu-img convert -p -O raw -o preallocation=off /workspaces/$REPOSITORY/windows/data.vhdx /workspaces/$REPOSITORY/windows/data.img
rm --force /workspaces/$REPOSITORY/windows/data.vhdx
cp /workspaces/$REPOSITORY/windows/data.img /tmp/$REPOSITORY/windows/data.img

{
    echo "services:"
    echo "  windows:"
    echo "    container_name: windows"
    echo "    image: dockurr/windows:latest"
    echo "    environment:"
    echo "      CPU_CORES: $(nproc --all)"
    echo "      RAM_SIZE: $(free --gibi | grep 'Mem:' | awk '{print $7}')G"
    echo "      DISK_SIZE: $(df --human-readable --block-size G /workspaces | grep '/workspaces' | awk '{print $4}')"
    echo "      DISK2_SIZE: $(df --human-readable --block-size G /tmp | grep '/tmp' | awk '{print $4}')"
    echo "      RAM_CHECK: N"
    echo "      MTU: 1486"
    echo "      DISPLAY: web"
    echo "      DEBUG: Y"
    echo "    ports:"
    echo "      - 3389:3389/tcp"
    echo "      - 3389:3389/udp"
    echo "      - 5900:5900/tcp"
    echo "      - 5900:5900/udp"
    echo "      - 8006:8006/tcp"
    echo "      - 8006:8006/udp"
    echo "    cap_add:"
    echo "      - ALL"
    echo "    security_opt:"
    echo "      - seccomp=unconfined"
    echo "    volumes:"
    echo "      - /workspaces/$REPOSITORY/windows:/storage"
    echo "      - /tmp/$REPOSITORY/windows:/storage2"
    echo "      - /workspaces/$REPOSITORY:/data"
    echo "    privileged: true"
    echo "    restart: always"
} > /workspaces/$REPOSITORY/windows/windows.yaml
