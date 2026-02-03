# Modul 6: Essential Plugins

## Tujuan Pembelajaran
Setelah menyelesaikan modul ini, Anda akan:
- Memilih plugin keamanan terbaik
- Mengoptimasi SEO dengan plugin
- Meningkatkan performa website
- Setup backup otomatis
- Integrasi analytics

---

## 6.1 Plugin Keamanan

### Mengapa Keamanan Penting?
- WordPress digunakan 43% website di dunia = target favorit hacker
- E-commerce menyimpan data sensitif customer
- Downtime = kehilangan penjualan

### Rekomendasi Plugin Keamanan

#### 1. Wordfence Security (★★★★★)
**Fitur Utama:**
- Web Application Firewall (WAF)
- Malware scanner
- Login security (2FA, reCAPTCHA)
- Real-time threat defense
- Brute force protection

**Setup Dasar:**
1. Install & Activate
2. Get free API key
3. Enable firewall
4. Enable scan scheduling
5. Configure login security

#### 2. Sucuri Security (★★★★☆)
**Fitur Utama:**
- Security hardening
- Malware scanning
- Security activity auditing
- Post-hack actions
- CDN integration (premium)

#### 3. iThemes Security (★★★★☆)
**Fitur Utama:**
- 30+ security measures
- Two-factor authentication
- Scheduled malware scanning
- Password requirements
- Database backups

### Setup Wordfence (Recommended)

```
1. Plugins > Add New > "Wordfence"
2. Install & Activate
3. Get Free License (email verification)
4. Wordfence > Dashboard > Enable Firewall
5. Wordfence > Scan > Start New Scan
6. Wordfence > Login Security > Enable 2FA
```

### Pengaturan Penting:

**Firewall:**
- Learning Mode: 1 minggu, lalu switch ke Enabled
- Rate Limiting: Block IPs dengan banyak 404
- Brute Force Protection: Aktifkan

**Scan Options:**
- Scan files outside WordPress: Yes
- Check for modified files: Yes
- Scan theme/plugin files: Yes

**Login Security:**
- Enable Two-Factor Authentication
- Require strong passwords
- Limit login attempts: 5

---

## 6.2 Plugin SEO

### Mengapa SEO Penting untuk E-Commerce?
- Organic traffic = traffic gratis
- 53% traffic e-commerce berasal dari organic search
- SEO yang baik = lebih banyak penjualan

### Rekomendasi Plugin SEO

#### 1. Yoast SEO (★★★★★)
**Fitur Utama:**
- Content analysis
- XML sitemaps
- Meta tags optimization
- Schema markup
- Breadcrumbs
- Social media previews

**Setup Dasar:**
1. Install & Activate
2. Run Configuration Wizard
3. Connect Google Search Console
4. Set up social profiles
5. Configure titles & meta

#### 2. Rank Math (★★★★★)
**Fitur Utama:**
- Similar to Yoast, lebih banyak fitur gratis
- Multiple focus keywords
- Rich snippets
- Local SEO
- WooCommerce SEO
- 404 Monitor

#### 3. All in One SEO (★★★★☆)
**Fitur Utama:**
- Beginner-friendly
- TruSEO score
- Smart XML sitemaps
- Schema markup

### Setup Yoast SEO untuk WooCommerce

```
1. Plugins > Add New > "Yoast SEO"
2. Install & Activate
3. Yoast SEO > Configuration Wizard
   - Site type: Online Shop
   - Organization/Person: Organization
   - Social profiles: Isi semua
4. Yoast SEO > Settings
   - Content Types > Products: Enable SEO
   - Taxonomies > Categories: Enable
5. Yoast SEO > Integrations > Semrush: Connect
```

### Optimasi SEO per Produk:

Di setiap produk, scroll ke "Yoast SEO" panel:
- **Focus keyphrase**: Kata kunci utama
- **SEO Title**: Judul yang muncul di Google
- **Meta Description**: Deskripsi 155 karakter
- **URL Slug**: URL yang SEO-friendly

**Tips:**
- Gunakan keyphrase di judul, meta, dan deskripsi
- Tulis deskripsi produk minimal 300 kata
- Gunakan heading (H2, H3) dengan keyword
- Optimasi alt text gambar

---

## 6.3 Plugin Performa

### Mengapa Performa Penting?
- 1 detik delay = 7% penurunan konversi
- Google Core Web Vitals mempengaruhi ranking
- Mobile users tidak sabar

### Rekomendasi Plugin Performa

#### 1. WP Rocket (★★★★★) - Premium
**Fitur Utama:**
- Page caching
- Browser caching
- GZIP compression
- Lazy loading
- Database optimization
- CDN integration

**Harga:** $59/year

#### 2. LiteSpeed Cache (★★★★★) - Free
**Fitur Utama:**
- Membutuhkan LiteSpeed server
- Object cache
- Image optimization
- CDN (QUIC.cloud)
- Database optimization

#### 3. W3 Total Cache (★★★★☆) - Free
**Fitur Utama:**
- Page caching
- Database caching
- Object caching
- CDN support
- Minification

#### 4. Autoptimize (★★★★☆) - Free
**Fitur Utama:**
- Minify HTML, CSS, JS
- Optimize Google Fonts
- Lazy load images
- Async JavaScript

### Setup Performa untuk Docker (Gratis)

Karena kita menggunakan Docker, mari setup dengan plugin gratis:

**1. Install Autoptimize:**
```
Plugins > Add New > "Autoptimize"
Settings > Autoptimize:
- Optimize JavaScript: Yes
- Aggregate JS: Yes
- Optimize CSS: Yes
- Aggregate CSS: Yes
- Optimize HTML: Yes
```

**2. Install WP Super Cache:**
```
Plugins > Add New > "WP Super Cache"
Settings > WP Super Cache:
- Caching: On
- Cache Delivery Method: Simple
```

**3. Image Optimization dengan Smush:**
```
Plugins > Add New > "Smush"
Smush > Dashboard:
- Auto-Smush: On
- Lazy Load: On
- Resize full size images: Yes
```

### Tambahan: Redis Cache (Advanced)

Untuk performa lebih baik, tambahkan Redis ke Docker:

Update `docker-compose.yml`:
```yaml
services:
  redis:
    image: redis:alpine
    ports:
      - "6379:6379"
```

Install plugin "Redis Object Cache" dan configure.

---

## 6.4 Plugin Backup

### Mengapa Backup Penting?
- Hacker attack bisa menghapus semua data
- Update plugin/tema bisa merusak website
- Human error selalu mungkin terjadi
- "No backup, no mercy" - IT wisdom

### Strategi Backup 3-2-1:
- **3** copies of data
- **2** different storage media
- **1** offsite (cloud)

### Rekomendasi Plugin Backup

#### 1. UpdraftPlus (★★★★★)
**Fitur Utama:**
- Scheduled backups
- Cloud storage (Dropbox, Google Drive, S3)
- Easy restore
- Migrate/clone website
- Incremental backups (premium)

#### 2. Duplicator (★★★★☆)
**Fitur Utama:**
- Full site packages
- Migration tool
- Scheduled backups (pro)
- Cloud storage (pro)

#### 3. BackWPup (★★★★☆)
**Fitur Utama:**
- Free cloud backup
- Database backup
- Multiple storage destinations
- Scheduled jobs

### Setup UpdraftPlus

```
1. Plugins > Add New > "UpdraftPlus"
2. Settings > UpdraftPlus Backups
3. Settings tab:
   - Files backup schedule: Weekly
   - Database backup schedule: Daily
   - Retain backups: 4
4. Choose remote storage:
   - Google Drive (free 15GB)
   - Dropbox (free 2GB)
5. Authenticate with cloud service
6. Save Changes
7. Backup Now (test backup)
```

### Jadwal Backup Rekomendasi:

| Jenis | Frekuensi | Retain |
|-------|-----------|--------|
| Database | Daily | 7 |
| Files | Weekly | 4 |
| Full Backup | Monthly | 3 |

### 🔧 Praktik: Setup Backup

1. Install UpdraftPlus
2. Connect ke Google Drive
3. Set jadwal backup
4. Jalankan backup pertama
5. Test restore di staging

---

## 6.5 Plugin Analytics

### Mengapa Analytics Penting?
- Understand customer behavior
- Track sales & conversions
- Identify best-selling products
- Measure marketing ROI
- Make data-driven decisions

### Rekomendasi Plugin Analytics

#### 1. MonsterInsights (★★★★★)
**Fitur Utama:**
- Google Analytics integration
- E-commerce tracking
- Real-time stats
- Custom dimensions
- Dashboard reports

#### 2. Site Kit by Google (★★★★☆)
**Fitur Utama:**
- Official Google plugin
- Analytics, Search Console, AdSense
- PageSpeed Insights
- All in one dashboard

#### 3. WooCommerce Google Analytics Integration (★★★★☆)
**Fitur Utama:**
- Free, official WooCommerce
- Enhanced e-commerce tracking
- Event tracking
- Checkout funnel

### Setup Google Analytics dengan MonsterInsights

**Step 1: Create Google Analytics Account**
1. Go to analytics.google.com
2. Create Account & Property
3. Get Measurement ID (G-XXXXXXXXXX)

**Step 2: Install MonsterInsights**
```
1. Plugins > Add New > "MonsterInsights"
2. Install & Activate
3. Insights > Settings > Connect MonsterInsights
4. Authenticate with Google
5. Select your Analytics property
```

**Step 3: Enable E-commerce Tracking**
```
1. Insights > Settings > eCommerce
2. Enable Enhanced eCommerce: Yes
3. Use Enhanced Link Attribution: Yes
```

**Step 4: View Reports**
```
Insights > Reports:
- Overview: Traffic summary
- eCommerce: Sales, revenue, products
- Publishers: Top pages, sources
```

### Metrics Penting untuk E-Commerce:

| Metric | Arti | Target |
|--------|------|--------|
| Conversion Rate | Visitor → Buyer | 2-3% |
| Average Order Value | Rata-rata belanja | Meningkat |
| Cart Abandonment | Tinggalkan cart | < 70% |
| Revenue | Total penjualan | Meningkat |
| Traffic Sources | Asal pengunjung | Diversifikasi |

---

## Ringkasan Plugin Essential

### Plugin Wajib (Free Stack):

| Kategori | Plugin | Harga |
|----------|--------|-------|
| Security | Wordfence | Free |
| SEO | Yoast SEO | Free |
| Performance | Autoptimize + WP Super Cache + Smush | Free |
| Backup | UpdraftPlus | Free |
| Analytics | MonsterInsights Lite | Free |

### Plugin Premium (jika budget ada):

| Kategori | Plugin | Harga |
|----------|--------|-------|
| Performance | WP Rocket | $59/year |
| SEO | Yoast SEO Premium | $99/year |
| Backup | UpdraftPlus Premium | $70/year |
| Analytics | MonsterInsights Pro | $99/year |

---

## Rangkuman Modul 6

### Checklist Plugin Essential:
- [ ] Security plugin terinstall & configured
- [ ] 2FA enabled untuk admin
- [ ] SEO plugin terinstall
- [ ] Meta tags & sitemaps configured
- [ ] Caching plugin aktif
- [ ] Image optimization enabled
- [ ] Backup plugin dengan cloud storage
- [ ] Analytics tracking aktif

---

## Quiz Modul 6

1. Sebutkan 3 fitur utama Wordfence!
2. Apa itu focus keyphrase di Yoast SEO?
3. Mengapa caching penting untuk e-commerce?
4. Apa strategi backup 3-2-1?
5. Metric apa yang menunjukkan berapa % visitor yang membeli?

---

**Selesai Modul 6? Lanjut ke [07-SECURITY.md](07-SECURITY.md)! 🚀**
