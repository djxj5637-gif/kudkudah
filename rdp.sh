#!/bin/bash
# ============================================
# 🚀 Auto Installer: Windows 11 on Docker
# ============================================

set -e

echo "=== Running as root ==="
if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root!"
  exit 1
fi

echo "=== Updating system ==="
apt update -y
apt install docker-compose -y

systemctl enable docker
systemctl start docker

echo "=== Creating docker directory ==="
mkdir -p /root/dockerwin
cd /root/dockerwin

echo "=== Creating windows.yml ==="
cat > windows.yml <<'EOF'
version: "3.9"
services:
  windows:
    image: dockurr/windows
    container_name: windows
    environment:
      VERSION: "11"
      USERNAME: "zommer"
      PASSWORD: "123"
      RAM_SIZE: "10G"
      CPU_CORES: "4"
      DISK_SIZE: "100G"
      GPU_TYPE: "gfxstream"
      AUTO_LOGON: "true"
      ENABLE_KVM: "true"
    devices:
      - /dev/kvm
      - /dev/net/tun
    cap_add:
      - NET_ADMIN
    ports:
      - "8006:8006"
      - "3389:3389/tcp"
      - "3389:3389/udp"
    volumes:
      - /tmp/windows-storage:/storage
    restart: always
EOF

echo "=== Launching Windows VM ==="
docker-compose -f windows.yml up -d

echo
echo "========================================"
echo "🎉 Windows VM installed!"
echo "🖥️  Connect via RDP: (your server IP):3389"
echo "👤 Username: zommer"
echo "🔑 Password: 123"
echo "========================================"
