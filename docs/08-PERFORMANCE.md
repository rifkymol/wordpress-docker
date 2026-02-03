# Modul 8: Performance Optimization

## Tujuan Pembelajaran
Setelah menyelesaikan modul ini, Anda akan:
- Mengimplementasi caching (Redis, Object Cache)
- Mengoptimasi gambar produk
- Melakukan database optimization
- Mengintegrasikan CDN
- Melakukan performance testing

---

## 8.1 Caching

### Jenis-jenis Caching

```
┌─────────────────────────────────────────────────────────┐
│                    CACHING LAYERS                        │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  🌐 Browser Cache                                        │
│     → Menyimpan asset di browser user                   │
│     → CSS, JS, Images                                   │
│                                                          │
│  📄 Page Cache                                           │
│     → Menyimpan halaman HTML lengkap                    │
│     → Tidak perlu render ulang                          │
│                                                          │
│  🗃️ Object Cache (Redis/Memcached)                      │
│     → Menyimpan query database                          │
│     → Sessions, transients                              │
│                                                          │
│  💾 Opcode Cache (OPcache)                              │
│     → Menyimpan compiled PHP                            │
│     → Built-in di PHP 7+                                │
│                                                          │
│  🌍 CDN Cache                                           │
│     → Menyimpan asset di edge servers                   │
│     → Cloudflare, Fastly, BunnyCDN                      │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

### Page Caching dengan WP Super Cache

```
1. Plugins > Add New > "WP Super Cache"
2. Settings > WP Super Cache:
   - Caching: On
   - Cache Delivery Method: Simple (recommended)
3. Advanced tab:
   - Cache hits: Enable
   - Don't cache for logged in users: Enable
   - Compress pages: Enable
   - Cache rebuild: Enable
   - Mobile device support: Enable (if responsive theme)
4. Preload tab:
   - Preload mode: Enable
   - Refresh time: 1440 minutes (daily)
5. CDN tab: (jika pakai CDN)
   - Enable CDN support
   - Off-site URL: cdn.yourdomain.com
```

### Object Caching dengan Redis

Redis menyimpan database queries di memory = super fast!

#### Setup Redis di Docker

Update `docker-compose.yml`:

```yaml
services:
  wordpress:
    image: wordpress:latest
    ports:
      - "8080:80"
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress
      WORDPRESS_DB_NAME: wordpress
    volumes:
      - wordpress_data:/var/www/html
      - ./wp-content:/var/www/html/wp-content
    depends_on:
      - db
      - redis

  db:
    image: mysql:5.7
    environment:
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress
      MYSQL_ROOT_PASSWORD: somewordpress
    volumes:
      - db_data:/var/lib/mysql

  redis:
    image: redis:alpine
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data

volumes:
  wordpress_data:
  db_data:
  redis_data:
```

#### Install Redis Object Cache Plugin

```
1. Plugins > Add New > "Redis Object Cache"
2. Install & Activate
3. Settings > Redis:
   - Host: redis (Docker service name)
   - Port: 6379
4. Click "Enable Object Cache"
5. Status should show "Connected"
```

#### Verify Redis Working

```bash
# Connect to Redis container
docker exec -it wordpress-docker-redis-1 redis-cli

# Check stats
INFO stats

# See cached keys
KEYS *
```

### Browser Caching

Add to `.htaccess`:

```apache
# Browser Caching
<IfModule mod_expires.c>
    ExpiresActive On
    
    # Images
    ExpiresByType image/jpeg "access plus 1 year"
    ExpiresByType image/png "access plus 1 year"
    ExpiresByType image/gif "access plus 1 year"
    ExpiresByType image/webp "access plus 1 year"
    ExpiresByType image/svg+xml "access plus 1 year"
    ExpiresByType image/x-icon "access plus 1 year"
    
    # CSS & JavaScript
    ExpiresByType text/css "access plus 1 month"
    ExpiresByType application/javascript "access plus 1 month"
    
    # Fonts
    ExpiresByType font/woff2 "access plus 1 year"
    ExpiresByType font/woff "access plus 1 year"
    
    # Default
    ExpiresDefault "access plus 2 days"
</IfModule>
```

---

## 8.2 Image Optimization

### Mengapa Image Optimization Penting?
- Images = 50-80% page weight
- Slow images = high bounce rate
- Google uses image speed in ranking

### Image Optimization Checklist

| Aspect | Before | After |
|--------|--------|-------|
| Format | JPEG/PNG | WebP |
| Size | 2000x2000 | 800x800 |
| File size | 2 MB | 100 KB |
| Lazy load | No | Yes |

### Best Practices untuk Product Images

**Ukuran Optimal:**
- Thumbnail: 300 x 300 px
- Single Product: 600 x 600 px
- Full Size: 1200 x 1200 px (max)

**Format:**
- Product photos: WebP (dengan JPEG fallback)
- Graphics/logos: PNG atau SVG
- Animations: WebP atau GIF

### Plugin: Smush

```
1. Plugins > Add New > "Smush"
2. Smush > Dashboard:
   - Auto-Smush: Enable
   - Strip metadata: Enable
   - Resize originals: 2048px max
   - Lazy Load: Enable (images, iframes)
   - WebP: Enable (Smush Pro)
3. Smush > Bulk Smush:
   - Click "Bulk Smush Now"
```

### Plugin: ShortPixel (Alternative)

```
1. Plugins > Add New > "ShortPixel"
2. Settings > ShortPixel:
   - API Key: Get from shortpixel.com (100 free/month)
   - Compression: Lossy (recommended for e-commerce)
   - WebP: Create WebP versions
   - Resize: 2048px max
3. Media > Bulk ShortPixel:
   - Process all images
```

### Manual Optimization Tools

- **TinyPNG/TinyJPG**: tinypng.com
- **Squoosh**: squoosh.app (Google's tool)
- **GIMP**: Free image editor

### WebP Conversion

```php
// functions.php
add_filter('upload_mimes', function($mimes) {
    $mimes['webp'] = 'image/webp';
    return $mimes;
});
```

---

## 8.3 Database Optimization

### Mengapa Database Perlu Optimasi?
- WordPress menyimpan revisions, drafts, trash
- Plugins meninggalkan data orphan
- Transients dan options menumpuk
- Slow queries = slow website

### Database Optimization Tasks

| Task | Frekuensi | Impact |
|------|-----------|--------|
| Delete post revisions | Monthly | Medium |
| Delete spam comments | Weekly | Low |
| Delete transients | Monthly | Medium |
| Optimize tables | Monthly | Medium |
| Delete orphan data | Quarterly | High |

### Plugin: WP-Optimize

```
1. Plugins > Add New > "WP-Optimize"
2. WP-Optimize > Database:
   - Clean all post revisions
   - Clean all auto-draft posts
   - Clean all trashed posts
   - Remove spam & trashed comments
   - Remove expired transients
   - Optimize database tables
3. WP-Optimize > Settings:
   - Scheduled cleanup: Weekly
   - Keep last 2 weeks of data
```

### Manual Database Cleanup

**Via phpMyAdmin atau MySQL CLI:**

```sql
-- Delete post revisions
DELETE FROM wp_posts WHERE post_type = 'revision';

-- Delete spam comments
DELETE FROM wp_comments WHERE comment_approved = 'spam';

-- Delete trashed comments
DELETE FROM wp_comments WHERE comment_approved = 'trash';

-- Delete orphan postmeta
DELETE pm FROM wp_postmeta pm
LEFT JOIN wp_posts p ON pm.post_id = p.ID
WHERE p.ID IS NULL;

-- Delete expired transients
DELETE FROM wp_options WHERE option_name LIKE '%_transient_%';

-- Optimize tables
OPTIMIZE TABLE wp_posts, wp_postmeta, wp_options, wp_comments;
```

### Limit Post Revisions

```php
// wp-config.php
define('WP_POST_REVISIONS', 3); // Keep only 3 revisions
// atau
define('WP_POST_REVISIONS', false); // Disable revisions
```

### Disable Heartbeat (Optional)

Heartbeat API menggunakan AJAX yang bisa membebani server.

```php
// functions.php
add_action('init', function() {
    // Disable on frontend
    if (!is_admin()) {
        wp_deregister_script('heartbeat');
    }
});
```

---

## 8.4 CDN Integration

### Apa itu CDN?
Content Delivery Network = jaringan server global yang menyimpan copy static files Anda.

```
┌─────────────────────────────────────────────────────────┐
│                     WITHOUT CDN                          │
│                                                          │
│    User (USA) ──────────────────────► Server (Indonesia)│
│    User (Europe) ───────────────────► Server (Indonesia)│
│    User (Indonesia) ────────────────► Server (Indonesia)│
│                                                          │
│                     WITH CDN                             │
│                                                          │
│    User (USA) ──► Edge Server (USA) ──► Origin (Indo)  │
│    User (Europe) ──► Edge Server (EU) ──► Origin (Indo)│
│    User (Indonesia) ──► Edge Server (SG) ──► Origin    │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

### CDN Options

| CDN | Harga | Kelebihan |
|-----|-------|-----------|
| **Cloudflare** | Free | Easy setup, WAF included |
| **BunnyCDN** | $0.01/GB | Murah, cepat |
| **KeyCDN** | $0.04/GB | Bagus untuk Asia |
| **AWS CloudFront** | Pay-per-use | Skalabel |

### Setup Cloudflare (Recommended - Free)

**Step 1: Create Account**
1. Go to cloudflare.com
2. Sign up
3. Add site: yourdomain.com

**Step 2: Change Nameservers**
1. Cloudflare akan memberikan 2 nameservers
2. Update di domain registrar Anda
3. Wait 24-48 hours

**Step 3: Configure SSL**
```
SSL/TLS > Overview:
- Encryption mode: Full (strict)

SSL/TLS > Edge Certificates:
- Always Use HTTPS: On
- Automatic HTTPS Rewrites: On
```

**Step 4: Configure Caching**
```
Caching > Configuration:
- Caching Level: Standard
- Browser Cache TTL: 1 month
- Always Online: On

Caching > Cache Rules:
- Create rule for /wp-content/uploads/*
- Cache Level: Cache Everything
- Edge TTL: 1 month
```

**Step 5: Speed Optimization**
```
Speed > Optimization:
- Auto Minify: JavaScript, CSS, HTML
- Brotli: On
- Rocket Loader: Off (bisa konflik dengan WooCommerce)
```

### WordPress Plugin for CDN

**CDN Enabler (Simple):**
```
1. Plugins > Add New > "CDN Enabler"
2. Settings > CDN Enabler:
   - CDN URL: https://cdn.yourdomain.com
   - Included Directories: wp-content,wp-includes
   - Exclude: .php
```

---

## 8.5 Performance Testing

### Tools untuk Testing

| Tool | URL | Gunakan Untuk |
|------|-----|---------------|
| **GTmetrix** | gtmetrix.com | Comprehensive analysis |
| **PageSpeed Insights** | pagespeed.web.dev | Google's official tool |
| **WebPageTest** | webpagetest.org | Detailed waterfall |
| **Pingdom** | tools.pingdom.com | Simple speed test |

### Core Web Vitals

Google menggunakan 3 metrics utama:

| Metric | Good | Needs Improvement | Poor |
|--------|------|-------------------|------|
| **LCP** (Largest Contentful Paint) | < 2.5s | 2.5-4s | > 4s |
| **FID** (First Input Delay) | < 100ms | 100-300ms | > 300ms |
| **CLS** (Cumulative Layout Shift) | < 0.1 | 0.1-0.25 | > 0.25 |

### Running Performance Tests

**Before Optimization:**
1. Test dengan GTmetrix
2. Catat scores (Performance, Structure)
3. Screenshot waterfall chart
4. Note biggest issues

**After Each Optimization:**
1. Clear all caches
2. Wait 1-2 minutes
3. Re-test
4. Compare improvements

### 🔧 Praktik: Performance Audit

```
1. Open GTmetrix (gtmetrix.com)
2. Enter: http://localhost:8080
   (Note: localhost won't work, use ngrok for testing)
   
3. Alternative: Use browser DevTools
   - Open DevTools (F12)
   - Lighthouse tab
   - Generate report (Mobile & Desktop)
   
4. Record scores:
   - Performance: ___%
   - Accessibility: ___%
   - Best Practices: ___%
   - SEO: ___%
   
5. Note top 5 issues to fix
```

### Common Performance Issues & Fixes

| Issue | Solution |
|-------|----------|
| Large images | Smush, ShortPixel, WebP |
| No caching | WP Super Cache, Redis |
| Render-blocking JS | Defer, async loading |
| Too many HTTP requests | Combine files, CDN |
| Slow server response | Better hosting, cache |
| No compression | Enable GZIP |
| Unoptimized database | WP-Optimize |

### Performance Optimization Checklist

- [ ] Page caching enabled
- [ ] Object caching (Redis) enabled
- [ ] Browser caching configured
- [ ] Images optimized & lazy loaded
- [ ] WebP format enabled
- [ ] Database optimized
- [ ] CDN configured
- [ ] GZIP compression enabled
- [ ] CSS/JS minified
- [ ] Core Web Vitals passed

---

## Rangkuman Modul 8

### Quick Wins (Do First):
1. Install caching plugin
2. Optimize existing images
3. Enable lazy loading
4. Clean database

### Advanced Optimizations:
1. Setup Redis object cache
2. Configure CDN
3. Implement WebP
4. Fine-tune cache rules

---

## Quiz Modul 8

1. Apa perbedaan page cache dan object cache?
2. Mengapa Redis lebih cepat dari database?
3. Format gambar apa yang paling optimal untuk web?
4. Apa itu Core Web Vitals?
5. Bagaimana CDN mempercepat website?

---

**Selesai Modul 8? Lanjut ke [09-SEO-ECOMMERCE.md](09-SEO-ECOMMERCE.md)! 🚀**
