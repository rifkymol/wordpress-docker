# Modul 9: SEO untuk E-Commerce

## Tujuan Pembelajaran
Setelah menyelesaikan modul ini, Anda akan:
- Menguasai on-page SEO
- Mengoptimasi halaman produk untuk search
- Mengimplementasi schema markup
- Setup Google Search Console & Analytics

---

## 9.1 On-Page SEO

### Apa itu On-Page SEO?
Optimasi yang dilakukan di dalam website Anda untuk meningkatkan ranking di search engine.

### Elemen On-Page SEO

```
┌─────────────────────────────────────────────────────────┐
│                    ON-PAGE SEO ELEMENTS                  │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  📝 Title Tag (Judul di Google)                         │
│     → 50-60 karakter                                    │
│     → Include keyword + brand                           │
│                                                          │
│  📄 Meta Description                                     │
│     → 150-160 karakter                                  │
│     → Call to action                                    │
│                                                          │
│  🔗 URL Structure                                        │
│     → Short, descriptive                                │
│     → Include keyword                                   │
│                                                          │
│  📊 Heading Structure (H1, H2, H3)                      │
│     → 1 H1 per page                                     │
│     → Hierarchy yang jelas                              │
│                                                          │
│  🖼️ Image Alt Text                                      │
│     → Descriptive                                       │
│     → Include keyword naturally                         │
│                                                          │
│  📱 Internal Linking                                     │
│     → Link ke related products/pages                    │
│     → Anchor text descriptive                           │
│                                                          │
│  📖 Content Quality                                      │
│     → Unique, helpful                                   │
│     → Answer user intent                                │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

### Title Tag Best Practices

**Format untuk E-Commerce:**
```
[Product Name] - [Key Feature] | [Brand Name]
[Category] - [Benefit] | [Brand Name]
```

**Contoh:**
- ❌ "Home" 
- ✅ "Kaos Polos Premium Cotton - Nyaman Seharian | TokoKu"
- ✅ "Sepatu Running Nike Air Max 270 - Free Shipping | TokoKu"

### Meta Description Best Practices

**Format:**
```
[Deskripsi produk singkat]. [Benefit/USP]. [Call to action]!
```

**Contoh:**
```
Kaos polos premium dengan bahan cotton combed 30s yang lembut 
dan menyerap keringat. Tersedia ukuran S-XXL. Beli sekarang, 
gratis ongkir!
```

### URL Structure

**Good:**
```
/kaos-polos-hitam/
/sepatu-nike-air-max-270/
/kategori/pakaian/kaos/
```

**Bad:**
```
/?p=123
/product/12345/
/shop/uncategorized/product-name-very-long-with-unnecessary-words/
```

### Heading Structure

```html
<h1>Kaos Polos Premium Cotton</h1>
  <h2>Deskripsi Produk</h2>
    <h3>Material</h3>
    <h3>Ukuran</h3>
  <h2>Spesifikasi</h2>
  <h2>Review Pelanggan</h2>
```

### Image Alt Text

```html
<!-- Bad -->
<img src="image1.jpg" alt="">
<img src="product.jpg" alt="image">

<!-- Good -->
<img src="kaos-polos-hitam.jpg" alt="Kaos Polos Hitam Cotton Combed 30s">
<img src="kaos-detail.jpg" alt="Detail jahitan kaos polos hitam">
```

---

## 9.2 Product SEO

### Optimasi Halaman Produk

Setiap produk harus dioptimasi untuk keyword spesifik.

#### Step 1: Keyword Research

**Tools Gratis:**
- Google Keyword Planner
- Ubersuggest
- Google Trends
- "People also ask" di Google

**Jenis Keywords untuk Produk:**
```
[Product] + [Brand] = "sepatu nike"
[Product] + [Model] = "air max 270"
[Product] + [Color] = "sepatu nike hitam"
[Product] + [Intent] = "beli sepatu nike murah"
[Product] + [Location] = "sepatu nike jakarta"
```

#### Step 2: Optimasi di WooCommerce

**Product Title:**
```
✅ Sepatu Nike Air Max 270 - Hitam/Putih
❌ Nike AM270 BLK
```

**Product Description:**
- Minimal 300 kata
- Include keywords naturally
- Use bullet points
- Add specifications
- Include FAQs

**Template Deskripsi Produk:**
```markdown
## [Product Name]

[Opening paragraph with main keyword - 2-3 sentences describing the product]

### Fitur Utama
- [Feature 1 with keyword]
- [Feature 2]
- [Feature 3]

### Spesifikasi
| Spesifikasi | Detail |
|-------------|--------|
| Material | Cotton Combed 30s |
| Ukuran | S, M, L, XL |
| Warna | Hitam, Putih, Navy |

### Cara Perawatan
[Instructions with relevant keywords]

### FAQ
**Q: [Common question with keyword]?**
A: [Answer]

**Q: [Another question]?**
A: [Answer]
```

#### Step 3: Yoast SEO untuk Produk

```
Edit Product > Scroll to Yoast SEO:

1. Focus keyphrase: "kaos polos hitam cotton"
2. SEO Title: Kaos Polos Hitam Cotton Premium | TokoKu
3. Slug: kaos-polos-hitam-cotton
4. Meta description: Kaos polos hitam premium dengan bahan 
   cotton combed 30s. Nyaman, adem, dan tahan lama. 
   Tersedia S-XXL. Gratis ongkir min. 300rb!

Check:
✅ Keyphrase in title
✅ Keyphrase in meta description
✅ Keyphrase in URL
✅ Keyphrase in intro
✅ Keyphrase density (1-2%)
✅ Outbound links
✅ Internal links
✅ Image alt attributes
```

### Category Page SEO

Jangan lupakan halaman kategori!

```
Products > Categories > Edit "Kaos":

Name: Kaos
Slug: kaos
Description: 
  Koleksi kaos premium dari TokoKu. Tersedia berbagai model 
  kaos polos, kaos distro, dan kaos oversize dengan bahan 
  berkualitas. Ukuran lengkap S-XXL.

Yoast SEO:
- Title: Kaos Premium Berkualitas | TokoKu
- Description: Beli kaos premium dengan bahan cotton combed. 
  Kaos polos, distro, oversize. Ukuran S-XXL. Gratis ongkir!
```

---

## 9.3 Schema Markup

### Apa itu Schema Markup?
Kode yang membantu search engine memahami konten Anda lebih baik, menghasilkan **rich snippets** di search results.

### Rich Snippets untuk E-Commerce

```
┌─────────────────────────────────────────────────────────┐
│  🔍 Google Search Result                                 │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  Kaos Polos Hitam Cotton Premium | TokoKu               │
│  https://tokoku.com/kaos-polos-hitam                    │
│  ⭐⭐⭐⭐⭐ 4.8 (125 reviews) · Rp 150.000               │
│  ✅ In Stock                                             │
│  Kaos polos premium dengan bahan cotton combed 30s...   │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

### Schema Types untuk E-Commerce

| Schema Type | Gunakan Untuk |
|-------------|---------------|
| Product | Halaman produk |
| Offer | Harga & availability |
| AggregateRating | Review rating |
| Review | Individual reviews |
| BreadcrumbList | Navigasi breadcrumb |
| Organization | Info perusahaan |
| LocalBusiness | Toko fisik |
| FAQPage | FAQ section |

### Setup Schema dengan Yoast SEO

Yoast otomatis menambahkan schema dasar. Untuk WooCommerce:

```
Yoast SEO > Settings > Content Types > Products:
- Schema type: Product
```

### Schema Manual (Advanced)

Tambahkan di tema atau plugin:

```json
{
  "@context": "https://schema.org/",
  "@type": "Product",
  "name": "Kaos Polos Hitam Cotton Premium",
  "image": "https://tokoku.com/images/kaos-hitam.jpg",
  "description": "Kaos polos premium dengan bahan cotton combed 30s",
  "brand": {
    "@type": "Brand",
    "name": "TokoKu"
  },
  "offers": {
    "@type": "Offer",
    "url": "https://tokoku.com/kaos-polos-hitam",
    "priceCurrency": "IDR",
    "price": "150000",
    "availability": "https://schema.org/InStock",
    "seller": {
      "@type": "Organization",
      "name": "TokoKu"
    }
  },
  "aggregateRating": {
    "@type": "AggregateRating",
    "ratingValue": "4.8",
    "reviewCount": "125"
  }
}
```

### Plugin: Schema Pro atau Rank Math

Rank Math memiliki schema builder yang lebih lengkap:

```
Rank Math > Schema Templates:
- Product schema dengan semua fields
- Auto-generate dari WooCommerce data
- FAQ schema builder
- Review schema
```

### Test Schema

**Google Rich Results Test:**
1. Go to: search.google.com/test/rich-results
2. Enter URL atau paste HTML
3. Check for errors
4. Preview rich result

---

## 9.4 Google Search Console & Analytics

### Setup Google Search Console

**Step 1: Add Property**
1. Go to search.google.com/search-console
2. Add Property > URL prefix
3. Enter: https://yourdomain.com

**Step 2: Verify Ownership**
Options:
- HTML file upload
- HTML tag (Yoast can add this)
- Google Analytics
- DNS record

**Via Yoast:**
```
Yoast SEO > Settings > Site Connections:
- Google verification code: [paste code]
```

**Step 3: Submit Sitemap**
```
Search Console > Sitemaps:
- Add: sitemap_index.xml
- Submit
```

Yoast generates sitemap at: `yourdomain.com/sitemap_index.xml`

### Search Console Reports

| Report | Gunakan Untuk |
|--------|---------------|
| Performance | Keywords, clicks, impressions |
| Coverage | Index status, errors |
| Enhancements | Schema, mobile usability |
| Links | Backlinks, internal links |
| Core Web Vitals | LCP, FID, CLS |

### Key Metrics to Monitor

**Performance Report:**
```
1. Total clicks: Traffic dari Google
2. Total impressions: Berapa kali muncul di search
3. Average CTR: Click-through rate
4. Average position: Ranking rata-rata

Filter by:
- Query: Keywords yang mendatangkan traffic
- Page: Halaman mana yang perform
- Country: Traffic dari mana
- Device: Desktop vs mobile
```

### Setup Google Analytics 4 (GA4)

**Step 1: Create Property**
1. Go to analytics.google.com
2. Admin > Create Property
3. Enter property name
4. Select Indonesia, Rupiah

**Step 2: Create Data Stream**
1. Data Streams > Web
2. Enter website URL
3. Get Measurement ID (G-XXXXXXXXXX)

**Step 3: Install via MonsterInsights**
```
1. Plugins > Add New > "MonsterInsights"
2. Insights > Settings
3. Connect MonsterInsights
4. Authenticate with Google
5. Select GA4 property
```

**Step 4: Enable E-commerce Tracking**
```
GA4 > Admin > Data Streams > [Your stream]:
- Enhanced Measurement: On
- E-commerce: Enable

MonsterInsights > Settings > eCommerce:
- Use Enhanced eCommerce: Yes
```

### E-commerce Reports di GA4

| Report | Shows |
|--------|-------|
| Monetization Overview | Revenue, purchases, items |
| E-commerce Purchases | Transaction details |
| Purchase Journey | Funnel from view to purchase |
| Checkout Journey | Cart to completion |
| Product Performance | Top products, revenue |

### 🔧 Praktik: Setup Tracking

```
1. Create Google Search Console account
2. Verify website ownership
3. Submit sitemap
4. Create GA4 property
5. Install MonsterInsights
6. Enable e-commerce tracking
7. Wait 24-48 hours for data
8. Check first reports
```

---

## SEO Checklist untuk E-Commerce

### Technical SEO:
- [ ] SSL/HTTPS enabled
- [ ] XML sitemap submitted
- [ ] Robots.txt configured
- [ ] Site speed optimized
- [ ] Mobile-friendly
- [ ] Schema markup implemented

### On-Page SEO:
- [ ] Unique title tags (50-60 chars)
- [ ] Unique meta descriptions (150-160 chars)
- [ ] Clean URL structure
- [ ] Proper heading hierarchy
- [ ] Image alt texts
- [ ] Internal linking

### Content SEO:
- [ ] Unique product descriptions (300+ words)
- [ ] Category page descriptions
- [ ] Blog content (if applicable)
- [ ] FAQ pages
- [ ] About & Contact pages optimized

### Monitoring:
- [ ] Google Search Console connected
- [ ] Google Analytics tracking
- [ ] E-commerce tracking enabled
- [ ] Regular report reviews

---

## Quiz Modul 9

1. Berapa panjang ideal title tag?
2. Apa yang ditampilkan rich snippets untuk produk?
3. Bagaimana cara submit sitemap ke Google?
4. Apa perbedaan Search Console dan Analytics?
5. Metric apa yang menunjukkan berapa kali website muncul di Google?

---

**Selesai Modul 9? Lanjut ke [10-DEPLOYMENT.md](10-DEPLOYMENT.md)! 🚀**
