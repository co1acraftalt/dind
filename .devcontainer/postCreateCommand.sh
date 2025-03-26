export REPOSITORY=dind

mkdir --parents /tmp/$REPOSITORY/windows
rm --recursive --force /tmp/$REPOSITORY/windows/*

mv --force /workspaces/$REPOSITORY/.devcontainer /tmp/$REPOSITORY/.devcontainer
cd /workspaces
rm --recursive --force /workspaces/$REPOSITORY
mkdir --parents /workspaces/$REPOSITORY
mv --force /tmp/$REPOSITORY/.devcontainer /workspaces/$REPOSITORY/.devcontainer

cp /workspaces/$REPOSITORY/.devcontainer/helpers/start /usr/local/bin/start
cp /workspaces/$REPOSITORY/.devcontainer/helpers/stop /usr/local/bin/stop
cp /workspaces/$REPOSITORY/.devcontainer/helpers/restart /usr/local/bin/restart
cp /workspaces/$REPOSITORY/.devcontainer/helpers/reset /usr/local/bin/reset
chmod +x /usr/local/bin/start
chmod +x /usr/local/bin/stop
chmod +x /usr/local/bin/restart
chmod +x /usr/local/bin/reset

swapoff /tmp/swap
fallocate --length 16G /tmp/swap
chmod 600 /tmp/swap
mkswap /tmp/swap
swapon /tmp/swap

mkdir --parents /workspaces/$REPOSITORY/windows
echo "data.img" > /workspaces/$REPOSITORY/windows/windows.boot

wget https://github.com/ItzLevvie/artifacts/releases/download/27774/data.7z.001 --output-document /tmp/$REPOSITORY/windows/data.7z.001
wget https://github.com/ItzLevvie/artifacts/releases/download/27774/data.7z.002 --output-document /tmp/$REPOSITORY/windows/data.7z.002
wget https://github.com/ItzLevvie/artifacts/releases/download/27774/data.7z.003 --output-document /tmp/$REPOSITORY/windows/data.7z.003
wget https://github.com/ItzLevvie/artifacts/releases/download/27774/data.7z.004 --output-document /tmp/$REPOSITORY/windows/data.7z.004

7z x /tmp/$REPOSITORY/windows/data.7z.001 -o/tmp/$REPOSITORY/windows
rm --force /tmp/$REPOSITORY/windows/data.7z.*
qemu-img convert -p -O raw -o preallocation=off /tmp/$REPOSITORY/windows/data.vhdx /tmp/$REPOSITORY/windows/data.img
rm --force /tmp/$REPOSITORY/windows/data.vhdx
cp /tmp/$REPOSITORY/windows/data.img /workspaces/$REPOSITORY/windows/data.img

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

sleep 240
