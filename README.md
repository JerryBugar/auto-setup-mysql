# ☁️ MySQL Cloud Setup + Auto Backup to Google Drive

Script ini akan otomatis:
- Install dan setup MySQL server di VPS Ubuntu
- Konfigurasi agar MySQL bisa diakses dari mana saja (remote access)
- Backup database MySQL ke Google Drive menggunakan `rclone`
- Bisa dijalankan manual atau otomatis via cronjob

---

## 🧰 Prasyarat

- VPS Ubuntu (bisa trial)
- Akses root ke VPS
- Akun Google Drive aktif

---

## 🚀 1. Jalankan Script Setup MySQL

### 📥 Download & Jalankan
```bash
wget https://raw.githubusercontent.com/USERNAME/REPO-NAME/main/mysql-cloud-setup.sh
chmod +x mysql-cloud-setup.sh
./mysql-cloud-setup.sh
```

> Ganti `USERNAME/REPO-NAME` sesuai dengan repo GitHub kamu.

Script ini akan:
- Install MySQL
- Membuat user MySQL
- Konfigurasi akses publik
- Membuka port 3306

---

## ☁️ 2. Konfigurasi Rclone ke Google Drive

### 🔧 Install Rclone
```bash
curl https://rclone.org/install.sh | sudo bash
```

### 🔗 Setup Remote
```bash
rclone config
```
- Pilih `n` untuk membuat remote baru
- Nama remote: `gdrive`
- Pilih: `Google Drive`
- Ikuti proses login via browser dan izinkan akses

---

## 💾 3. Jalankan Script Backup MySQL ke Google Drive

### 📥 Download & Jalankan
```bash
wget https://raw.githubusercontent.com/USERNAME/REPO-NAME/main/mysql-backup-gdrive.sh
chmod +x mysql-backup-gdrive.sh
./mysql-backup-gdrive.sh
```

Script ini akan:
- Mendeteksi semua database (kecuali bawaan sistem)
- Backup masing-masing database ke `.sql`
- Upload otomatis ke Google Drive folder `backup-mysql`
- Hapus file lokal setelah selesai

---

## 🔁 4. (Opsional) Backup Otomatis via Cron

### 🕒 Tambahkan ke Cronjob
```bash
crontab -e
```
Tambahkan baris berikut untuk backup tiap hari jam 03:00:
```bash
0 3 * * * /root/mysql-backup-gdrive.sh >> /root/backup.log 2>&1
```

---

## 📂 Struktur Folder Google Drive

Rclone akan mengupload ke:
```
Google Drive → backup-mysql → file-backup.sql
```

---

## 🛡️ Tips Keamanan

- Jangan upload script ini ke repo publik jika menyimpan password MySQL
- Gunakan `.env` file atau `read -sp` di script jika ingin lebih aman

---

## ✨ Credits

Script dibuat oleh Jefri untuk auto setup dan backup database di VPS trial

---

Happy coding & semoga datanya gak hilang walau VPS trial! 🚀

