version: "3.9"
services:
  windows:
    image: dockurr/windows
    container_name: windows
    environment:
      VERSION: "11"
      USERNAME: "MASTER"
      PASSWORD: "admin@123"

      # 🧠 Производительность
      RAM_SIZE: "12G"
      CPU_CORES: "4"
      DISK_SIZE: "100G"

      # 🎮 Виртуальная GPU (самое важное!)
      GPU_TYPE: "gfxstream"

      # 🔐 Удобство
      AUTO_LOGON: "true"
      ENABLE_KVM: "true"

    devices:
      - /dev/kvm
      - /dev/net/tun

    cap_add:
      - NET_ADMIN

    ports:
      - "8006:8006"         # NoVNC console / Web UI
      - "3389:3389/tcp"     # RDP
      - "3389:3389/udp"

    volumes:
      - /tmp/windows-storage:/storage

    restart: always
    stop_grace_period: 2m
