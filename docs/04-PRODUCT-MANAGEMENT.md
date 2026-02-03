# Modul 4: Product Management

## Tujuan Pembelajaran
Setelah menyelesaikan modul ini, Anda akan:
- Memahami jenis-jenis produk di WooCommerce
- Membuat dan mengedit produk
- Mengelola kategori, tags, dan atribut
- Mengatur inventory/stok
- Import dan export produk massal

---

## 4.1 Jenis-jenis Produk

### Product Types di WooCommerce

```
┌─────────────────────────────────────────────────────────┐
│                    PRODUCT TYPES                         │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  📦 Simple Product                                       │
│     → Produk tunggal tanpa variasi                      │
│     → Contoh: Buku, Mug                                 │
│                                                          │
│  🎨 Variable Product                                     │
│     → Produk dengan variasi (size, color)               │
│     → Contoh: Kaos (S/M/L), Sepatu (38/39/40)          │
│                                                          │
│  📎 Grouped Product                                      │
│     → Kumpulan produk dijual bersama                    │
│     → Contoh: Set Furniture                             │
│                                                          │
│  🔗 External/Affiliate Product                          │
│     → Link ke produk di website lain                    │
│     → Contoh: Affiliate Amazon                          │
│                                                          │
│  📥 Downloadable Product                                 │
│     → Produk digital yang bisa didownload               │
│     → Contoh: Ebook, Software, Template                 │
│                                                          │
│  🔄 Virtual Product                                      │
│     → Produk non-fisik tanpa pengiriman                 │
│     → Contoh: Konsultasi, Jasa Design                   │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

### Kapan Menggunakan Tipe Mana?

| Produk Anda | Tipe yang Tepat |
|-------------|-----------------|
| Buku | Simple |
| Kaos dengan ukuran S/M/L | Variable |
| Paket bundling 3 produk | Grouped |
| Link affiliate | External |
| Ebook PDF | Simple + Downloadable |
| Kursus online | Simple + Virtual |
| Kaos custom print | Variable + Virtual option |

---

## 4.2 Menambah & Mengedit Produk

### Membuat Simple Product

`Products > Add New`

#### General Tab
```
Product name: Kaos Polos Hitam
Regular price: 150000
Sale price: 125000 (opsional)
```

#### Product Short Description
```
Kaos polos berbahan cotton combed 30s. 
Nyaman dipakai sehari-hari.
```

#### Product Long Description
```
Kaos polos premium dengan bahan cotton combed 30s yang lembut 
dan menyerap keringat. Cocok untuk daily wear, olahraga ringan, 
atau sebagai inner layer.

Spesifikasi:
- Bahan: Cotton Combed 30s
- Gramasi: 180 gsm
- Jahitan: Double stitch
- Sablon: Ready untuk sablon DTG/DTF

Perawatan:
- Cuci dengan air dingin
- Jangan gunakan pemutih
- Setrika suhu rendah
```

#### Product Data Panel

**General:**
- Regular price: Harga normal
- Sale price: Harga diskon
- Schedule: Jadwal sale (opsional)

**Inventory:**
- SKU: KAOS-HTM-001
- Manage stock: ✓
- Stock quantity: 50
- Allow backorders: No
- Low stock threshold: 5
- Sold individually: No

**Shipping:**
- Weight: 0.2 (kg)
- Dimensions: 30 x 25 x 2 (cm)
- Shipping class: Regular

**Linked Products:**
- Upsells: Produk lebih mahal yang direkomendasikan
- Cross-sells: Produk pelengkap di cart

**Attributes:**
- Akan dibahas di section 4.3

**Advanced:**
- Purchase note: Catatan setelah pembelian
- Menu order: Urutan di katalog
- Enable reviews: ✓

#### Product Image & Gallery
1. **Product Image**: Gambar utama (featured)
2. **Product Gallery**: Gambar tambahan (dari berbagai sudut)

**Tips Gambar Produk:**
- Ukuran minimal: 800 x 800 px
- Format: JPEG atau WebP
- Background: Putih atau konsisten
- Lighting: Terang dan jelas
- Multiple angles: Depan, belakang, detail

#### Product Categories & Tags
- Categories: Pakaian > Kaos
- Tags: kaos, polos, hitam, cotton

### Membuat Variable Product

Contoh: Kaos dengan variasi ukuran (S, M, L, XL)

#### Step 1: Set Product Type
- Product data: Variable product

#### Step 2: Create Attributes
`Attributes tab:`
1. Add new attribute
2. Name: Ukuran
3. Values: S | M | L | XL (pisah dengan |)
4. Visible on product page: ✓
5. Used for variations: ✓
6. Save attributes

#### Step 3: Create Variations
`Variations tab:`
1. "Create variations from all attributes"
2. Atau "Add variation" secara manual
3. Untuk setiap variasi, set:
   - SKU: KAOS-HTM-S, KAOS-HTM-M, dll
   - Price: 150000
   - Stock: 20
   - Weight & dimensions

**Tips Variable Product:**
- Bisa set harga berbeda per variasi
- Bisa set gambar berbeda per variasi
- Bisa set stok terpisah per variasi

### 🔧 Praktik: Buat Produk

1. **Simple Product:**
   - Nama: "Topi Baseball"
   - Harga: Rp 75.000
   - Stok: 30
   - Kategori: Aksesoris

2. **Variable Product:**
   - Nama: "Kaos Oversize"
   - Variasi: S, M, L, XL
   - Harga: Rp 150.000
   - Gambar berbeda per variasi

---

## 4.3 Kategori, Tags & Atribut

### Product Categories

Struktur hierarki untuk mengorganisir produk.

```
📁 Pakaian
   ├── 👕 Kaos
   ├── 👖 Celana
   └── 🧥 Jaket
📁 Aksesoris
   ├── 🧢 Topi
   ├── 👜 Tas
   └── ⌚ Jam Tangan
📁 Sepatu
   ├── 👟 Sneakers
   └── 👞 Formal
```

#### Membuat Kategori
`Products > Categories`

1. Name: Pakaian
2. Slug: pakaian (URL-friendly)
3. Parent category: None (top-level) atau pilih parent
4. Description: Deskripsi kategori (bagus untuk SEO)
5. Thumbnail: Gambar kategori

### Product Tags

Label fleksibel untuk filtering dan SEO.

**Contoh Tags:**
- new-arrival
- best-seller
- sale
- limited-edition
- eco-friendly
- made-in-indonesia

**Perbedaan Categories vs Tags:**

| Aspect | Categories | Tags |
|--------|------------|------|
| Hierarki | Ya (parent-child) | Tidak |
| Wajib | Ya (minimal 1) | Tidak |
| Jumlah | Sedikit, terstruktur | Banyak, fleksibel |
| Navigasi | Menu utama | Filtering, search |

### Product Attributes

Karakteristik produk yang bisa digunakan untuk variasi dan filtering.

#### Global Attributes (reusable)
`Products > Attributes`

**Contoh:**
```
Attribute: Warna
Terms: Hitam, Putih, Merah, Biru, Hijau

Attribute: Ukuran
Terms: S, M, L, XL, XXL

Attribute: Bahan
Terms: Cotton, Polyester, Denim, Linen
```

#### Custom Attributes (per produk)
Dibuat langsung di halaman edit produk, tidak bisa digunakan ulang.

### 🔧 Praktik: Organisasi Produk

1. **Buat Categories:**
   - Pakaian (parent)
     - Kaos (child)
     - Celana (child)
   - Aksesoris (parent)

2. **Buat Global Attributes:**
   - Ukuran: S, M, L, XL
   - Warna: Hitam, Putih, Navy

3. **Buat Tags:**
   - new-arrival
   - best-seller

---

## 4.4 Inventory Management

### Stock Management Settings

`WooCommerce > Settings > Products > Inventory`

- **Manage stock**: Enable stock management
- **Hold stock**: 60 minutes (hold saat checkout)
- **Notifications**: Email saat low/out of stock
- **Notification recipient**: Email admin
- **Low stock threshold**: 5
- **Out of stock threshold**: 0
- **Out of stock visibility**: Hide out of stock items

### Stock Status Options

| Status | Arti | Tampilan |
|--------|------|----------|
| In stock | Tersedia | Bisa dibeli |
| Out of stock | Habis | Tidak bisa dibeli |
| On backorder | Indent | Bisa dibeli, dikirim nanti |

### Managing Stock per Product

`Edit Product > Inventory tab`

```
☑ Manage stock
Stock quantity: 50
Allow backorders: Do not allow
Low stock threshold: 5
Sold individually: No
```

### Stock Reports

`WooCommerce > Reports > Stock`

- **Low in stock**: Produk hampir habis
- **Out of stock**: Produk habis
- **Most stocked**: Produk stok terbanyak

### Bulk Stock Update

`Products > All Products`
1. Select products dengan checkbox
2. Bulk actions: Edit
3. Update stock quantity untuk banyak produk sekaligus

---

## 4.5 Import/Export Produk

### Export Products

`Products > All Products > Export`

1. Pilih kolom yang ingin diexport
2. Pilih kategori (opsional)
3. Pilih tipe produk (opsional)
4. Generate CSV

### Import Products

`Products > All Products > Import`

1. Upload file CSV
2. Map columns ke fields WooCommerce
3. Run the importer

### CSV Format

```csv
ID,Type,SKU,Name,Published,Regular price,Sale price,Categories,Images,Stock
,simple,KAOS-001,Kaos Hitam,1,150000,125000,Pakaian > Kaos,http://example.com/kaos.jpg,50
,variable,KAOS-002,Kaos Putih,1,150000,,Pakaian > Kaos,http://example.com/kaos-putih.jpg,
```

### Import Images

Untuk gambar, gunakan URL atau upload terlebih dahulu ke media library.

**Tips Import:**
- Test dengan beberapa produk dulu
- Backup sebelum import besar
- Gunakan template CSV dari WooCommerce
- Pastikan encoding UTF-8

### 🔧 Praktik: Import/Export

1. **Export:**
   - Export semua produk yang sudah dibuat
   - Simpan file CSV

2. **Edit CSV:**
   - Buka dengan Excel/Google Sheets
   - Tambah 5 produk baru
   - Update harga beberapa produk

3. **Import:**
   - Import file CSV yang sudah diedit
   - Pilih "Update existing products"

---

## Rangkuman Modul 4

### Poin Penting:
- **Simple Product** untuk produk tanpa variasi
- **Variable Product** untuk produk dengan ukuran/warna
- **Categories** untuk struktur hierarki
- **Tags** untuk label fleksibel
- **Attributes** untuk karakteristik yang bisa difilter
- **SKU** adalah kode unik setiap produk

### Checklist Product Management:
- [ ] Kategori produk dibuat dengan struktur yang baik
- [ ] Global attributes dibuat (Ukuran, Warna, dll)
- [ ] Minimal 5 produk dibuat
- [ ] Setiap produk punya gambar berkualitas
- [ ] Stock management aktif
- [ ] SKU terisi untuk setiap produk/variasi

---

## Quiz Modul 4

1. Kapan menggunakan Variable Product vs Simple Product?
2. Apa perbedaan Categories dan Tags?
3. Bagaimana cara membuat variasi ukuran S/M/L?
4. Apa fungsi SKU?
5. Bagaimana cara import produk massal?

---

## Tugas Praktik

1. Buat minimal 10 produk:
   - 5 Simple Products
   - 3 Variable Products
   - 2 dengan Sale Price

2. Organisir produk ke dalam:
   - 3 Parent Categories
   - 5 Child Categories
   - 10 Tags

3. Setup inventory:
   - Semua produk punya stok
   - Low stock threshold: 3

4. Export semua produk ke CSV untuk backup

---

**Selesai Modul 4? Lanjut ke [05-THEME-DESIGN.md](05-THEME-DESIGN.md)! 🚀**
