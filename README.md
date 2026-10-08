# 🚀 Deploy 9Router ke BotKeep Cloud

konfigurasi deployment **9Router Standalone** pada hosting BotKeep Cloud.

## 📋 Startup Command

Salin perintah berikut ke kolom **Startup Command** di panel BotKeep Cloud.

```bash
cd /home/container/9r-standalone-d24d98a && \
test -f custom-server.js && \
test -f server.js && \
test -f .next/BUILD_ID && \
test -d node_modules && \
export NODE_ENV=production \
       HOSTNAME=0.0.0.0 \
       DATA_DIR=/home/container/.9router \
       PORT="${SERVER_PORT:?SERVER_PORT is required}" && \
exec node custom-server.js --port "$PORT" --hostname 0.0.0.0
```

## ⚙️ Environment Variables

Tambahkan variabel lingkungan berikut melalui menu **Environment Variables** pada panel BotKeep Cloud.

| Variable                     | Value          |
| ---------------------------- | -------------- |
| `INITIAL_PASSWORD`           | `yourpassword` |
| `ALLOW_REMOTE_DEFAULT_LOGIN` | `true`         |

### 🔐 Catatan Keamanan

* Ganti `yourpassword` dengan kata sandi awal yang kuat dan unik sebelum menjalankan server.
* Jangan menyimpan kata sandi asli, token autentikasi, atau kredensial sensitif di repositori GitHub publik.
* Gunakan fitur Environment Variables pada panel hosting untuk menyimpan konfigurasi sensitif.


## 🛠️ Troubleshooting

Jika server gagal dijalankan, periksa log startup dan pastikan:

1. Direktori aplikasi sesuai dengan path pada Startup Command.
2. Dependensi Node.js sudah terpasang.
3. Build produksi Next.js tersedia.
4. Variabel `SERVER_PORT` disediakan oleh hosting.
5. File konfigurasi dan izin akses direktori sudah benar.



