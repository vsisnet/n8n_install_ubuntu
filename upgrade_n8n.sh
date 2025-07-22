#!/bin/bash

# Kiểm tra xem script có được chạy với quyền root không
if [[ $EUID -ne 0 ]]; then
   echo "This script needs to be run with root privileges"
   exit 1
fi

# Định nghĩa thư mục n8n
N8N_DIR="/home/n8n"

# Kiểm tra xem thư mục n8n có tồn tại không
if [ ! -d "$N8N_DIR" ]; then
    echo "n8n directory $N8N_DIR does not exist. Please check your installation."
    exit 1
fi

# Di chuyển đến thư mục n8n
cd $N8N_DIR

# Sao lưu dữ liệu hiện tại
echo "Backing up current n8n data..."
tar -czf n8n_backup_$(date +%Y%m%d_%H%M%S).tar.gz .n8n

# Dừng các container đang chạy
echo "Stopping running containers..."
docker-compose down

# Kéo phiên bản mới nhất của image n8n
echo "Pulling the latest n8n image..."
docker pull n8nio/n8n:latest

# Kéo phiên bản mới nhất của image Caddy
echo "Pulling the latest Caddy image..."
docker pull caddy:2

# Khởi động lại các container
echo "Starting containers with the updated images..."
docker-compose up -d

echo ""
echo "╔═════════════════════════════════════════════════════════════╗"
echo "║                                                             "
echo "║  ✅ n8n has been successfully upgraded!                     "
echo "║                                                             "
echo "║  🌐 Access: https://${DOMAIN}                               "
echo "║                                                             "
echo "║  📁 Backup stored at: $N8N_DIR/n8n_backup_*.tar.gz          "
echo "║                                                             "
echo "╚═════════════════════════════════════════════════════════════╝"
echo ""
