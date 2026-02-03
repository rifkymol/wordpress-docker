# Modul 3: WooCommerce Setup

## Tujuan Pembelajaran
Setelah menyelesaikan modul ini, Anda akan:
- Memahami apa itu WooCommerce
- Menginstall dan menjalankan Setup Wizard
- Mengkonfigurasi mata uang, pajak, dan pengiriman
- Setup payment gateways

---

## 3.1 Pengenalan WooCommerce

### Apa itu WooCommerce?
WooCommerce adalah **plugin e-commerce #1 di dunia** untuk WordPress. Gratis, open-source, dan digunakan oleh 28% dari semua toko online!

### Fitur Utama WooCommerce:
- 🛒 Shopping cart & checkout
- 📦 Manajemen produk lengkap
- 💳 Multiple payment gateways
- 🚚 Shipping options fleksibel
- 📊 Reports & analytics
- 🔌 Ribuan extensions
- 🌍 Multi-currency & multi-language ready

### WooCommerce vs Platform Lain

| Fitur | WooCommerce | Shopify | Magento |
|-------|-------------|---------|---------|
| Harga | Gratis | $29+/bulan | Gratis (Open Source) |
| Hosting | Self-hosted | Hosted | Self-hosted |
| Customization | Unlimited | Limited | Complex |
| Ease of Use | Medium | Easy | Difficult |
| Scalability | Good | Good | Excellent |
| Extensions | 50,000+ | 8,000+ | 5,000+ |

---

## 3.2 Instalasi & Wizard Setup

### Step 1: Install WooCommerce

1. Login ke WordPress Admin
2. `Plugins > Add New`
3. Search "WooCommerce"
4. Klik "Install Now" lalu "Activate"

### Step 2: Setup Wizard

Setelah aktivasi, WooCommerce akan menampilkan Setup Wizard:

#### Page 1: Store Details
- **Country/Region**: Indonesia
- **Address**: Alamat bisnis Anda
- **Postcode**: Kode pos
- **City**: Kota
- **Email**: Email bisnis

#### Page 2: Industry
Pilih industri toko Anda:
- Fashion, apparel, accessories
- Electronics
- Food & drink
- Health & beauty
- dll.

#### Page 3: Product Types
- Physical products (barang fisik)
- Digital products (ebook, software)
- Subscriptions (langganan)
- Memberships (keanggotaan)

#### Page 4: Business Details
- Jumlah produk yang akan dijual
- Apakah sudah jualan di tempat lain

#### Page 5: Theme
- Pilih tema atau gunakan tema saat ini
- Storefront direkomendasikan

#### Page 6: Recommended Features (Skip untuk sekarang)
- WooCommerce Payments
- WooCommerce Tax
- dll.

### 🔧 Praktik: Install WooCommerce

```bash
# Pastikan WordPress berjalan
docker compose ps

# Buka browser
# http://localhost:8080/wp-admin
```

1. Install WooCommerce
2. Jalankan Setup Wizard
3. Pilih Indonesia sebagai lokasi
4. Skip fitur tambahan untuk sekarang

---

## 3.3 Konfigurasi Toko

### General Settings (`WooCommerce > Settings > General`)

#### Store Address
```
Address: Jl. Contoh No. 123
City: Jakarta
Country/Region: Indonesia
Postcode: 12345
```

#### General Options
- **Selling location(s)**: Sell to all countries / Sell to specific countries
- **Shipping location(s)**: Ship to all countries / Ship to specific countries
- **Default customer location**: Shop base address

#### Currency Options
- **Currency**: Indonesian rupiah (Rp)
- **Currency position**: Left (Rp1.000.000)
- **Thousand separator**: . (titik)
- **Decimal separator**: , (koma)
- **Number of decimals**: 0 (untuk Rupiah tidak perlu desimal)

### Products Settings (`WooCommerce > Settings > Products`)

#### General
- **Shop page**: Pilih halaman Shop
- **Add to cart behaviour**: Redirect to cart after add

#### Inventory
- **Manage stock**: Enable
- **Hold stock**: 60 minutes
- **Notifications**: Enable low stock & out of stock emails
- **Low stock threshold**: 5
- **Out of stock threshold**: 0

#### Downloadable Products (jika menjual digital)
- **File download method**: Force downloads
- **Access restriction**: Downloads require login

### Tax Settings (`WooCommerce > Settings > Tax`)

#### Enable Taxes
1. Centang "Enable tax rates and calculations"
2. Pilih:
   - **Prices entered with tax**: Yes, I will enter prices inclusive of tax
   - **Calculate tax based on**: Customer billing address
   - **Display prices in shop**: Including tax
   - **Display prices during cart and checkout**: Including tax

#### Standard Rates
Untuk Indonesia (PPN 11%):

| Country | State | Postcode | City | Rate | Tax Name | Compound | Shipping |
|---------|-------|----------|------|------|----------|----------|----------|
| ID | * | * | * | 11.0000 | PPN | No | Yes |

### Shipping Settings (`WooCommerce > Settings > Shipping`)

#### Shipping Zones
1. Klik "Add shipping zone"
2. **Zone name**: Indonesia
3. **Zone regions**: Indonesia
4. **Shipping methods**:

**Flat Rate:**
- Method title: Regular Shipping
- Cost: 15000 (Rp 15.000)

**Free Shipping:**
- Method title: Free Shipping
- Requires: Minimum order amount
- Minimum order: 500000 (Rp 500.000)

**Local Pickup:**
- Method title: Ambil di Toko
- Cost: 0

#### Shipping Classes (untuk variasi ongkir)
Contoh:
- Small Items (ongkir murah)
- Large Items (ongkir mahal)
- Fragile (ongkir khusus)

### 🔧 Praktik: Konfigurasi Toko

1. **General Settings:**
   - Set currency ke Rupiah
   - Thousand separator: titik
   - Decimals: 0

2. **Tax:**
   - Enable tax
   - Tambah rate PPN 11%

3. **Shipping:**
   - Buat zone "Indonesia"
   - Tambah Flat Rate: Rp 15.000
   - Tambah Free Shipping: Min Rp 500.000

---

## 3.4 Payment Gateways

### Payment Methods di Indonesia

| Gateway | Tipe | Biaya | Integrasi |
|---------|------|-------|-----------|
| **Midtrans** | Full payment | 2.9% + Rp 2.000 | Plugin resmi |
| **Xendit** | Full payment | Bervariasi | Plugin resmi |
| **DOKU** | Full payment | Bervariasi | Plugin resmi |
| **PayPal** | International | 4.4% + fee | Built-in |
| **Bank Transfer** | Manual | Gratis | Built-in |
| **COD** | Cash on Delivery | Gratis | Built-in |

### Setup Bank Transfer (BACS)

`WooCommerce > Settings > Payments > Direct bank transfer`

1. Enable: Yes
2. Title: Transfer Bank
3. Description: "Silakan transfer ke rekening berikut..."
4. Instructions: Detail instruksi pembayaran
5. Account Details:
   - Account name: Nama pemilik rekening
   - Account number: Nomor rekening
   - Bank name: Nama bank (BCA, Mandiri, dll)
   - IBAN/BIC: Kosongkan untuk Indonesia

### Setup Cash on Delivery

`WooCommerce > Settings > Payments > Cash on delivery`

1. Enable: Yes
2. Title: Bayar di Tempat (COD)
3. Description: "Bayar saat barang diterima"
4. Enable for shipping methods: Pilih metode shipping yang support COD

### Setup Midtrans (Payment Gateway Indonesia)

1. **Daftar akun Midtrans**: https://midtrans.com
2. **Install plugin**:
   - `Plugins > Add New`
   - Search "Midtrans WooCommerce"
   - Install & Activate

3. **Konfigurasi**:
   - `WooCommerce > Settings > Payments > Midtrans`
   - Masukkan Server Key & Client Key dari dashboard Midtrans
   - Enable Snap payment (popup checkout)

4. **Payment Methods via Midtrans**:
   - Credit Card (Visa, Mastercard)
   - Bank Transfer (BCA, Mandiri, BNI, BRI, Permata)
   - E-Wallet (GoPay, ShopeePay, OVO, Dana)
   - Convenience Store (Alfamart, Indomaret)
   - Cardless Credit (Akulaku, Kredivo)

### Testing Payments

WooCommerce menyediakan mode Sandbox/Test:

1. Gunakan test credentials dari payment gateway
2. Midtrans Sandbox: https://dashboard.sandbox.midtrans.com
3. Test dengan nomor kartu test:
   - Visa: 4811 1111 1111 1114
   - Mastercard: 5211 1111 1111 1117

### 🔧 Praktik: Setup Payment

1. **Enable Bank Transfer:**
   - Tambahkan detail rekening Anda
   - BCA, Mandiri, atau bank lain

2. **Enable COD:**
   - Aktifkan untuk area tertentu

3. **(Opsional) Setup Midtrans Sandbox:**
   - Daftar di sandbox.midtrans.com
   - Install plugin
   - Test transaksi

---

## Halaman WooCommerce Otomatis

Setelah setup, WooCommerce membuat halaman otomatis:

| Halaman | URL | Fungsi |
|---------|-----|--------|
| Shop | `/shop/` | Katalog produk |
| Cart | `/cart/` | Keranjang belanja |
| Checkout | `/checkout/` | Halaman pembayaran |
| My Account | `/my-account/` | Dashboard customer |

Anda bisa mengatur halaman ini di:
`WooCommerce > Settings > Advanced > Page Setup`

---

## Rangkuman Modul 3

### Poin Penting:
- WooCommerce adalah plugin e-commerce terbaik untuk WordPress
- Konfigurasi currency Indonesia: Rp, separator titik, 0 decimal
- PPN Indonesia: 11%
- Gunakan shipping zones untuk atur ongkir per wilayah
- Midtrans adalah pilihan terbaik untuk payment gateway Indonesia

### Checklist Setup WooCommerce:
- [ ] WooCommerce terinstall & activated
- [ ] Setup Wizard selesai
- [ ] Currency diset ke Rupiah
- [ ] Tax PPN 11% dikonfigurasi
- [ ] Shipping zones dibuat
- [ ] Minimal 1 payment gateway aktif
- [ ] Halaman Shop, Cart, Checkout ada

---

## Quiz Modul 3

1. Berapa persen PPN di Indonesia?
2. Apa perbedaan Flat Rate dan Free Shipping?
3. Sebutkan 3 payment gateway populer di Indonesia!
4. Di mana mengatur halaman Shop dan Checkout?
5. Bagaimana cara test pembayaran tanpa uang sungguhan?

---

## Tugas Praktik

1. Konfigurasi WooCommerce dengan:
   - Currency: Rupiah (Rp)
   - Tax: PPN 11%
   - Shipping: Flat rate Rp 20.000, Free shipping min Rp 300.000

2. Setup 2 metode pembayaran:
   - Bank Transfer (dengan rekening Anda)
   - COD

3. Cek semua halaman WooCommerce (Shop, Cart, Checkout, My Account)

---

**Selesai Modul 3? Lanjut ke [04-PRODUCT-MANAGEMENT.md](04-PRODUCT-MANAGEMENT.md)! 🚀**
