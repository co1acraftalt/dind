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
RUN update-alternatives --set iptables /usr/sbin/iptables-legacy
RUN update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
