#!/bin/bash

# CONFIG
DB_USER="root"
DB_PASS="passwordmu"
DB_NAME="nama_database"
BACKUP_DIR="/root/db_backup"
DATE=$(date +"%Y-%m-%d-%H-%M")
BACKUP_FILE="${DB_NAME}-${DATE}.sql"
REMOTE_NAME="gdrive"
REMOTE_FOLDER="backup-mysql"

# Buat folder lokal backup
mkdir -p $BACKUP_DIR

# Export database
echo "📦 Membackup database $DB_NAME..."
mysqldump -u $DB_USER -p$DB_PASS $DB_NAME > $BACKUP_DIR/$BACKUP_FILE

# Upload ke Google Drive
echo "☁️ Mengupload ke Google Drive..."
rclone copy $BACKUP_DIR/$BACKUP_FILE ${REMOTE_NAME}:${REMOTE_FOLDER}

# Hapus file lokal
rm $BACKUP_DIR/$BACKUP_FILE

echo "✅ Backup sukses: $BACKUP_FILE"
