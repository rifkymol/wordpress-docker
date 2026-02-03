# Modul 7: Security

## Tujuan Pembelajaran
Setelah menyelesaikan modul ini, Anda akan:
- Setup SSL/HTTPS untuk website
- Melakukan hardening WordPress
- Mengkonfigurasi firewall & brute force protection
- Membuat strategi backup yang solid

---

## 7.1 SSL/HTTPS Setup

### Apa itu SSL/HTTPS?
- **SSL** (Secure Sockets Layer): Protokol enkripsi data
- **HTTPS**: HTTP + SSL = koneksi aman
- **Padlock icon**: Indikator website aman

### Mengapa SSL Wajib untuk E-Commerce?
1. **Keamanan**: Enkripsi data customer (kartu kredit, password)
2. **Trust**: Customer percaya belanja di website Anda
3. **SEO**: Google memprioritaskan HTTPS
4. **Compliance**: PCI DSS requirement untuk pembayaran
5. **Browser warning**: Chrome menandai HTTP sebagai "Not Secure"

### Setup SSL di Local (Development)

Untuk development dengan Docker, kita bisa menggunakan self-signed certificate atau mkcert.

**Option 1: Using mkcert (Recommended)**

1. Install mkcert:
```powershell
# Windows dengan Chocolatey
choco install mkcert

# Atau download dari GitHub
# https://github.com/FiloSottile/mkcert/releases
```

2. Generate certificate:
```powershell
cd c:\Users\rifky\Documents\PERSONAL\wordpress-docker
mkcert -install
mkcert localhost 127.0.0.1 ::1
```

3. Update docker-compose untuk SSL (advanced setup)

**Option 2: Let's Encrypt (Production)**

Untuk production, gunakan Let's Encrypt dengan Certbot atau traefik.

### Setup SSL di Production

Kebanyakan hosting sudah menyediakan free SSL. Jika self-managed:

1. **Cloudflare** (Recommended - Free):
   - Daftar di cloudflare.com
   - Add website
   - Change nameservers
   - Enable "Full (strict)" SSL

2. **Let's Encrypt + Certbot**:
   - Install certbot
   - Run: `certbot --nginx -d yourdomain.com`
   - Auto-renew setiap 90 hari

### WordPress HTTPS Configuration

Setelah SSL aktif:

1. **Update URLs**:
```
Settings > General:
- WordPress Address (URL): https://yourdomain.com
- Site Address (URL): https://yourdomain.com
```

2. **Force HTTPS** (wp-config.php):
```php
define('FORCE_SSL_ADMIN', true);
```

3. **Redirect HTTP to HTTPS** (.htaccess):
```apache
RewriteEngine On
RewriteCond %{HTTPS} off
RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]
```

4. **Plugin: Really Simple SSL**:
   - Install & activate
   - Click "Go ahead, activate SSL!"
   - Fixes mixed content issues

---

## 7.2 Hardening WordPress

### Apa itu WordPress Hardening?
Proses mengamankan WordPress dengan menutup celah keamanan yang umum.

### Checklist Hardening:

#### 1. Update Regularly
```
Dashboard > Updates:
- WordPress core
- Themes
- Plugins
```

**Enable Auto-Updates:**
```php
// wp-config.php
define('WP_AUTO_UPDATE_CORE', true);
```

#### 2. Strong Passwords
- Minimal 12 karakter
- Kombinasi huruf, angka, simbol
- Unik untuk setiap akun
- Gunakan password manager (Bitwarden, 1Password)

#### 3. Change Database Prefix
Default: `wp_` → Target mudah untuk SQL injection

Saat instalasi baru, gunakan prefix unik: `xyz123_`

#### 4. Disable File Editing
```php
// wp-config.php
define('DISALLOW_FILE_EDIT', true);
```

Ini mencegah editing theme/plugin via dashboard (jika hacker masuk).

#### 5. Hide WordPress Version
```php
// functions.php (child theme)
remove_action('wp_head', 'wp_generator');
```

#### 6. Limit Login Attempts
Plugin: Wordfence atau Limit Login Attempts Reloaded

Settings:
- Max attempts: 5
- Lockout duration: 15 minutes
- Increase lockout: 24 hours after 3 lockouts

#### 7. Protect wp-config.php
```apache
# .htaccess
<files wp-config.php>
order allow,deny
deny from all
</files>
```

#### 8. Disable XML-RPC
Jika tidak menggunakan mobile app atau Jetpack:

```apache
# .htaccess
<Files xmlrpc.php>
order deny,allow
deny from all
</Files>
```

Atau gunakan plugin: Disable XML-RPC

#### 9. Secure wp-admin
```apache
# .htaccess di /wp-admin/
<Files admin-ajax.php>
    Order allow,deny
    Allow from all
    Satisfy any 
</Files>

AuthType Basic
AuthName "Restricted Area"
AuthUserFile /path/to/.htpasswd
require valid-user
```

#### 10. File Permissions
```
Directories: 755 (drwxr-xr-x)
Files: 644 (-rw-r--r--)
wp-config.php: 600 (-rw-------)
```

### Security Headers

Tambahkan ke .htaccess atau nginx config:

```apache
# Security Headers
Header set X-Content-Type-Options "nosniff"
Header set X-Frame-Options "SAMEORIGIN"
Header set X-XSS-Protection "1; mode=block"
Header set Referrer-Policy "strict-origin-when-cross-origin"
Header set Permissions-Policy "geolocation=(), microphone=(), camera=()"
```

---

## 7.3 Firewall & Brute Force Protection

### Web Application Firewall (WAF)

WAF memfilter traffic berbahaya sebelum mencapai website Anda.

#### Level 1: Plugin-based WAF
**Wordfence Firewall:**
```
Wordfence > Firewall:
1. Web Application Firewall Status: Enabled
2. Protection Level: Extended Protection
3. Firewall Rules: Enable all
4. Brute Force Protection: Enable
   - Lock out after 5 failed attempts
   - Lock out for 15 minutes
```

#### Level 2: Server-level WAF
**ModSecurity** (untuk Apache):
```apache
<IfModule mod_security2.c>
    SecRuleEngine On
    SecRequestBodyLimit 13107200
    SecRequestBodyNoFilesLimit 131072
</IfModule>
```

#### Level 3: CDN-based WAF
**Cloudflare** (Recommended):
- Free tier includes basic WAF
- DDoS protection
- Bot management
- Rate limiting

### Brute Force Protection

#### What is Brute Force Attack?
Attacker mencoba ribuan kombinasi username/password sampai berhasil.

#### Protection Measures:

**1. Rename Login URL:**
Plugin: WPS Hide Login
```
Settings > WPS Hide Login:
Login URL: mysecretsignin
```

**2. Two-Factor Authentication:**
Plugin: Wordfence atau Google Authenticator
```
Wordfence > Login Security:
- Enable 2FA for Administrators
- Enable 2FA for Editors (optional)
```

**3. reCAPTCHA:**
Plugin: reCaptcha by BestWebSoft
```
Settings > reCAPTCHA:
- Enable for: Login form, Registration, Comments
- Type: reCAPTCHA v3 (invisible)
```

**4. Login Attempt Limiting:**
```
Wordfence > All Options > Brute Force Protection:
- Lock out after how many failures: 5
- Lock out after how many forgot password: 3
- Count failures over what time period: 4 hours
- Lock out for how long: 4 hours
- Immediately lock out invalid usernames: Yes
```

### Monitoring & Alerts

**Wordfence Alerts:**
```
Wordfence > All Options > Email Alert Preferences:
- Administrator login: Yes
- User locked out: Yes
- Firewall blocked IP: Yes (daily digest)
- Scan results: Yes
```

**Activity Log:**
Plugin: WP Activity Log
- Track all user actions
- Failed login attempts
- Content changes
- Plugin/theme changes

---

## 7.4 Backup Strategy

### Backup Components

| Component | Lokasi | Penting |
|-----------|--------|---------|
| Database | MySQL | ★★★★★ |
| wp-content/uploads | Media files | ★★★★★ |
| wp-content/themes | Custom themes | ★★★★☆ |
| wp-content/plugins | Plugin settings | ★★★☆☆ |
| wp-config.php | Configuration | ★★★★★ |
| .htaccess | URL rules | ★★★☆☆ |

### Backup Schedule

| Tipe | Frekuensi | Retain | Kapan |
|------|-----------|--------|-------|
| Database | Daily | 7 hari | 3 AM |
| Files | Weekly | 4 minggu | Minggu 3 AM |
| Full | Monthly | 3 bulan | 1st of month |

### Backup Locations (3-2-1 Rule)

1. **Local** (Docker volume)
2. **Cloud #1** (Google Drive)
3. **Cloud #2** (Dropbox atau S3)

### Automated Backup dengan UpdraftPlus

```
Settings > UpdraftPlus Backups:

1. Files backup schedule: Weekly, retain 4
2. Database backup schedule: Daily, retain 7
3. Remote storage: Google Drive
   - Authenticate
   - Folder: WordPress-Backups
4. Include in files backup:
   - Plugins: Yes
   - Themes: Yes
   - Uploads: Yes
   - Other directories: Yes
5. Email: Send report to admin email
6. Expert settings:
   - Split archives every: 400 MB
   - Delete local backup: Yes (after cloud upload)
```

### Manual Backup via Docker

**Database Backup:**
```bash
docker exec wordpress-docker-db-1 mysqldump -u wordpress -pwordpress wordpress > backup_$(date +%Y%m%d).sql
```

**Files Backup:**
```bash
docker cp wordpress-docker-wordpress-1:/var/www/html/wp-content ./wp-content-backup
```

**Full Backup Script:**
```powershell
# backup.ps1
$date = Get-Date -Format "yyyyMMdd"
$backupDir = "c:\Users\rifky\Documents\PERSONAL\wordpress-docker\backups\$date"

New-Item -ItemType Directory -Force -Path $backupDir

# Database
docker exec wordpress-docker-db-1 mysqldump -u wordpress -pwordpress wordpress > "$backupDir\database.sql"

# Files
docker cp wordpress-docker-wordpress-1:/var/www/html/wp-content "$backupDir\wp-content"

Write-Host "Backup completed: $backupDir"
```

### Restore Process

**From UpdraftPlus:**
```
Settings > UpdraftPlus Backups > Existing Backups:
1. Select backup date
2. Choose components to restore
3. Click Restore
4. Follow wizard
```

**From Docker backup:**
```bash
# Restore database
docker exec -i wordpress-docker-db-1 mysql -u wordpress -pwordpress wordpress < backup.sql

# Restore files
docker cp ./wp-content-backup/. wordpress-docker-wordpress-1:/var/www/html/wp-content
```

### Test Your Backups!

**Monthly Backup Test:**
1. Download backup
2. Setup staging environment
3. Restore backup
4. Verify website works
5. Check database integrity
6. Document results

---

## Security Checklist

### Initial Setup:
- [ ] SSL/HTTPS enabled
- [ ] Strong admin password
- [ ] Unique database prefix
- [ ] File editing disabled
- [ ] Security plugin installed

### Ongoing:
- [ ] Weekly updates check
- [ ] Monthly security scan
- [ ] Review login attempts
- [ ] Check backup integrity
- [ ] Review user accounts

### Advanced:
- [ ] WAF configured
- [ ] 2FA enabled
- [ ] Login URL changed
- [ ] Security headers set
- [ ] Activity logging enabled

---

## Quiz Modul 7

1. Mengapa SSL wajib untuk e-commerce?
2. Apa yang dilakukan DISALLOW_FILE_EDIT?
3. Bagaimana cara mencegah brute force attack?
4. Apa itu strategi backup 3-2-1?
5. Seberapa sering Anda harus test restore backup?

---

**Selesai Modul 7? Lanjut ke [08-PERFORMANCE.md](08-PERFORMANCE.md)! 🚀**
