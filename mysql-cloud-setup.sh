#!/bin/bash

# AUTO SETUP MYSQL CLOUD SERVER FOR UBUNTU
# By Jefri ✨

echo "🚀 Mulai setup MySQL Cloud Server..."

# Update sistem
sudo apt update && sudo apt upgrade -y

# Install MySQL
echo "📦 Menginstall MySQL Server..."
sudo apt install mysql-server -y

# Konfigurasi MySQL agar bisa remote
echo "🔧 Mengatur konfigurasi MySQL agar bisa diakses dari luar..."

MYSQL_CNF="/etc/mysql/mysql.conf.d/mysqld.cnf"
sudo sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" $MYSQL_CNF

# Restart MySQL
sudo systemctl restart mysql

# Buat user remote
echo "👤 Membuat user MySQL untuk remote access..."

REMOTE_USER="jefri"
REMOTE_PASS="Jerry@111*"   # Ganti nanti kalau mau lebih aman

sudo mysql -e "CREATE USER IF NOT EXISTS '$REMOTE_USER'@'%' IDENTIFIED BY '$REMOTE_PASS';"
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO '$REMOTE_USER'@'%' WITH GRANT OPTION;"
sudo mysql -e "FLUSH PRIVILEGES;"

# Buka port 3306
echo "🔥 Membuka port 3306 untuk remote MySQL..."
sudo ufw allow 3306

# Pastikan UFW aktif
sudo ufw enable

# Status akhir
echo "✅ MySQL Cloud Server selesai di-setup!"
echo "📡 Akses dari luar pakai:"
echo "Host/IP VPS   : $(curl -s ifconfig.me)"
echo "Port          : 3306"
echo "User          : $REMOTE_USER"
echo "Password      : $REMOTE_PASS"
echo "💡 Gunakan tools seperti DBeaver / MySQL Workbench untuk akses dari luar."
