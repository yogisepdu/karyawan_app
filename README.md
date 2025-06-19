# 📱 Karyawan App (Flutter)

Aplikasi mobile berbasis Flutter untuk mengelola data karyawan menggunakan **SQLite** dan menampilkan repositori dari **GitHub API**. Aplikasi ini mendukung fitur tambah, edit, filter, dan hapus data, serta pencarian berdasarkan nama dan tanggal masuk.

---

## 🧩 Fitur Utama

- ✅ Tambah data karyawan (ID, Nama, Tanggal Masuk, Usia)
- ✏️ Edit dan hapus data
- 🔍 Filter data berdasarkan nama dan rentang tanggal masuk
- 💾 Penyimpanan data lokal menggunakan SQLite
- 🌐 Fetch data dari [GitHub REST API](https://api.github.com)
- 📱 Antarmuka sederhana dan mobile-friendly

---

## 🛠️ Teknologi

- [Flutter](https://flutter.dev) 3.x
- SQLite (via `sqflite`)
- State Management: `StatefulWidget`
- API HTTP Client: `http`
- Platform: Android (juga dapat berjalan di web & desktop dengan keterbatasan)

---

## 🚀 Cara Menjalankan

### 🔧 1. Clone Repo

```bash
git clone https://github.com/username/karyawan_app.git
cd karyawan_app
```

```bash
flutter pub get
```

```bash
flutter run -d android   # atau: chrome, emulator, dll
```

---

## 👤 Pengembang

- Nama: Yogi Sepdu Dehiya
- Framework: Flutter
- Lisensi: MIT

---
