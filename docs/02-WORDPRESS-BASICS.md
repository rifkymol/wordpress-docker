# Modul 2: WordPress Basics

## Tujuan Pembelajaran
Setelah menyelesaikan modul ini, Anda akan:
- Memahami arsitektur WordPress
- Melakukan instalasi dan konfigurasi awal
- Menguasai WordPress Dashboard
- Mengelola users dan permissions
- Memahami themes dan customization dasar

---

## 2.1 Arsitektur WordPress

### Struktur Folder WordPress

```
/var/www/html/
├── wp-admin/           # File admin dashboard
├── wp-content/         # Konten user (themes, plugins, uploads)
│   ├── plugins/        # Plugin yang terinstall
│   ├── themes/         # Tema yang terinstall
│   ├── uploads/        # Media yang diupload
│   └── languages/      # File bahasa
├── wp-includes/        # Core WordPress files
├── wp-config.php       # Konfigurasi database & settings
├── index.php           # Entry point
└── .htaccess           # Apache config (URL rewriting)
```

### Yang Boleh & Tidak Boleh Diedit

| Folder/File | Boleh Edit? | Keterangan |
|-------------|-------------|------------|
| `wp-content/themes/` | ✅ Ya | Untuk tema custom |
| `wp-content/plugins/` | ✅ Ya | Untuk plugin custom |
| `wp-content/uploads/` | ✅ Ya | Media files |
| `wp-config.php` | ⚠️ Hati-hati | Hanya jika perlu |
| `wp-admin/` | ❌ Tidak | Akan tertimpa saat update |
| `wp-includes/` | ❌ Tidak | Akan tertimpa saat update |

### Database Structure

WordPress menggunakan MySQL dengan tabel-tabel berikut:

```
┌─────────────────────────────────────────┐
│              WordPress Database         │
├─────────────────────────────────────────┤
│ wp_posts        → Semua konten          │
│ wp_postmeta     → Metadata posts        │
│ wp_users        → Data user             │
│ wp_usermeta     → Metadata user         │
│ wp_options      → Settings website      │
│ wp_terms        → Kategori & tags       │
│ wp_term_taxonomy→ Taxonomy relationships│
│ wp_comments     → Komentar              │
│ wp_commentmeta  → Metadata komentar     │
│ wp_links        → Blogroll (legacy)     │
└─────────────────────────────────────────┘
```

---

## 2.2 Instalasi & Konfigurasi Awal

### Step 1: Akses WordPress
1. Pastikan Docker berjalan:
```bash
cd c:\Users\rifky\Documents\PERSONAL\wordpress-docker
docker compose up -d
docker compose ps
```

2. Buka browser: `http://localhost:8080`

### Step 2: Wizard Instalasi

1. **Pilih Bahasa**: Pilih Bahasa Indonesia atau English
2. **Informasi Situs**:
   - Site Title: Nama toko Anda (contoh: "Toko Online Saya")
   - Username: admin username (jangan pakai "admin"!)
   - Password: Password kuat (simpan baik-baik!)
   - Email: Email admin aktif
   - Search Engine Visibility: Centang saat development

3. **Klik "Install WordPress"**

### Step 3: Login ke Dashboard
- URL: `http://localhost:8080/wp-admin`
- Masukkan username dan password

### 🔧 Praktik: Instalasi WordPress

1. Buka `http://localhost:8080`
2. Pilih "English (United States)"
3. Isi informasi:
   - Site Title: `My E-Commerce Store`
   - Username: `myadmin` (bukan "admin"!)
   - Password: Gunakan password generator
   - Email: email Anda
4. Install dan login

---

## 2.3 Dashboard & Settings

### Navigasi Dashboard

```
┌─────────────────────────────────────────────────────────────┐
│  Dashboard                                                   │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  📊 Home        → Overview, quick actions                   │
│  📝 Posts       → Blog posts (akan diganti produk)          │
│  📄 Pages       → Halaman statis (About, Contact, dll)      │
│  💬 Comments    → Moderasi komentar                         │
│  📁 Media       → Library gambar & file                     │
│                                                              │
│  🎨 Appearance  → Themes, Customize, Widgets, Menus         │
│  🔌 Plugins     → Install & manage plugins                   │
│  👥 Users       → User management                           │
│  🛠️ Tools       → Import, Export, Site Health               │
│  ⚙️ Settings    → Konfigurasi website                       │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### Settings Penting

#### General Settings (`Settings > General`)
- **Site Title**: Nama website
- **Tagline**: Slogan/deskripsi singkat
- **Site Address**: URL website
- **Admin Email**: Email notifikasi
- **Timezone**: Pilih sesuai lokasi (Asia/Jakarta)
- **Date Format**: Format tanggal Indonesia
- **Language**: Site language

#### Permalink Settings (`Settings > Permalinks`)
**PENTING untuk SEO!**

Pilih: **Post name** (`/%postname%/`)

Ini akan membuat URL seperti:
- ❌ `?p=123` (buruk untuk SEO)
- ✅ `/nama-produk-anda/` (bagus untuk SEO)

#### Reading Settings (`Settings > Reading`)
- **Homepage displays**: Pilih "A static page" untuk e-commerce
- **Blog pages show**: Jumlah post per halaman

#### Discussion Settings (`Settings > Discussion`)
- **Default post settings**: Disable pingbacks
- **Comment moderation**: Aktifkan moderasi

### 🔧 Praktik: Konfigurasi Dasar

1. **Settings > General**:
   - Timezone: Asia/Jakarta
   - Date Format: F j, Y
   - Time Format: H:i

2. **Settings > Permalinks**:
   - Pilih "Post name"
   - Save Changes

3. **Settings > Discussion**:
   - Uncheck "Allow link notifications from other blogs"
   - Check "Comment must be manually approved"

---

## 2.4 Users, Roles & Permissions

### User Roles di WordPress

| Role | Kemampuan | Cocok Untuk |
|------|-----------|-------------|
| **Administrator** | Akses penuh | Pemilik website |
| **Editor** | Kelola semua konten | Content manager |
| **Author** | Publish & kelola postnya | Penulis blog |
| **Contributor** | Tulis draft, tidak bisa publish | Penulis tamu |
| **Subscriber** | Baca & kelola profil | Customer (WooCommerce) |

### WooCommerce Menambahkan Roles:
- **Shop Manager**: Kelola produk & orders
- **Customer**: Pembeli (default untuk registrasi)

### Membuat User Baru

1. `Users > Add New`
2. Isi informasi user
3. Pilih role yang sesuai
4. Klik "Add New User"

### Best Practices Security

1. **Jangan pakai "admin" sebagai username**
2. **Gunakan email berbeda untuk tiap role**
3. **Batasi jumlah Administrator**
4. **Gunakan password manager**
5. **Enable Two-Factor Authentication (plugin)**

### 🔧 Praktik: User Management

1. Buat user baru:
   - Username: `shopmanager`
   - Role: Editor (nanti akan diubah ke Shop Manager)
   
2. Edit profil Anda:
   - Tambahkan Display Name
   - Set avatar via Gravatar

---

## 2.5 Themes & Customization

### Memilih Tema

#### Kriteria Tema E-Commerce yang Baik:
1. **WooCommerce Compatible** - Wajib!
2. **Responsive** - Tampil baik di mobile
3. **Fast Loading** - Performance penting
4. **SEO Friendly** - Struktur HTML yang baik
5. **Regular Updates** - Aktif dikembangkan
6. **Good Reviews** - Rating 4+ stars

#### Tema Gratis Rekomendasi:
- **Storefront** - Tema resmi WooCommerce
- **Astra** - Ringan, banyak fitur
- **OceanWP** - Flexible, banyak demo

#### Tema Gratis Rekomendasi untuk E-Commerce:
- **Storefront** - Tema resmi WooCommerce (recommended!)
- **Astra** - Ringan & cepat
- **OceanWP** - Sangat customizable

### Menginstall Tema

**Via Dashboard:**
1. `Appearance > Themes > Add New`
2. Cari "Storefront" atau tema pilihan
3. Klik "Install" lalu "Activate"

**Via Upload (tema premium):**
1. `Appearance > Themes > Add New > Upload Theme`
2. Pilih file .zip tema
3. Install dan Activate

**Via File Manager (bind mount):**
1. Extract tema ke `wp-content/themes/`
2. Activate via dashboard

### Customizer

`Appearance > Customize` untuk mengatur:
- **Site Identity**: Logo, favicon, tagline
- **Colors**: Warna utama website
- **Typography**: Font (jika tema mendukung)
- **Header**: Layout header
- **Footer**: Widget & layout footer
- **Homepage**: Layout homepage
- **Menus**: Navigation menus
- **Widgets**: Sidebar & footer widgets

### Membuat Menu Navigasi

1. `Appearance > Menus`
2. Create New Menu: "Main Navigation"
3. Tambahkan halaman: Home, Shop, About, Contact
4. Set "Display location": Primary Menu
5. Save Menu

### 🔧 Praktik: Setup Tema

1. Install tema Storefront:
   - `Appearance > Themes > Add New`
   - Search "Storefront"
   - Install & Activate

2. Customize:
   - `Appearance > Customize`
   - Upload logo (jika ada)
   - Set warna brand Anda
   - Save & Publish

3. Buat halaman dasar:
   - `Pages > Add New`: Home, About, Contact
   - Publish semua

4. Setup Menu:
   - `Appearance > Menus`
   - Buat "Main Menu"
   - Tambahkan halaman
   - Assign ke "Primary Menu"

---

## Rangkuman Modul 2

### Poin Penting:
- **wp-content** adalah satu-satunya folder yang boleh diedit
- **Permalinks** harus diset ke "Post name" untuk SEO
- **User roles** penting untuk keamanan dan manajemen tim
- **Tema yang baik** harus WooCommerce compatible & responsive

### Checklist Konfigurasi Awal:
- [ ] WordPress terinstall
- [ ] Timezone diset ke Asia/Jakarta
- [ ] Permalinks diset ke Post name
- [ ] Tema WooCommerce-ready terinstall
- [ ] Halaman dasar dibuat (Home, About, Contact)
- [ ] Menu navigasi disetup
- [ ] User admin dengan password kuat

---

## Quiz Modul 2

1. Folder mana yang berisi themes dan plugins?
2. Mengapa setting Permalinks penting?
3. Apa perbedaan role Editor dan Author?
4. Bagaimana cara menginstall tema dari file .zip?
5. Di mana mengatur logo dan warna website?

---

## Tugas Praktik

1. Install dan aktifkan tema **Storefront**
2. Buat 3 halaman: Home, About Us, Contact
3. Setup menu navigasi dengan 3 halaman tersebut
4. Customize warna tema sesuai preferensi Anda
5. Upload favicon di Customizer

---

**Selesai Modul 2? Lanjut ke [03-WOOCOMMERCE-SETUP.md](03-WOOCOMMERCE-SETUP.md)! 🚀**
