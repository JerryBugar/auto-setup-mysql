#!/bin/bash

# Auto Backup Semua Database MySQL ke Google Drive
# By Jefri 🦾

DB_USER="root"
DB_PASS="passwordmu"
BACKUP_DIR="/root/db_backup"
DATE=$(date +"%Y-%m-%d-%H-%M")
REMOTE_NAME="gdrive"
REMOTE_FOLDER="backup-mysql"

# DB bawaan yang tidak perlu dibackup
SKIP_DB=("information_schema" "performance_schema" "mysql" "sys")

# Buat folder backup lokal
mkdir -p $BACKUP_DIR

# Ambil semua nama database
echo "📋 Mengambil daftar database..."
DATABASES=$(mysql -u $DB_USER -p$DB_PASS -e "SHOW DATABASES;" | grep -Ev "Database|$(IFS='|'; echo "${SKIP_DB[*]}")")

# Loop & backup tiap database
for DB in $DATABASES; do
    BACKUP_FILE="${DB}-${DATE}.sql"
    echo "📦 Membackup $DB..."
    mysqldump -u $DB_USER -p$DB_PASS $DB > $BACKUP_DIR/$BACKUP_FILE

    echo "☁️ Mengupload $BACKUP_FILE ke Google Drive..."
    rclone copy $BACKUP_DIR/$BACKUP_FILE ${REMOTE_NAME}:${REMOTE_FOLDER}
    
    rm $BACKUP_DIR/$BACKUP_FILE
done

echo "✅ Semua database berhasil dibackup & diupload ke Google Drive!"
