# Modul 10: Deployment & Production

## Tujuan Pembelajaran
Setelah menyelesaikan modul ini, Anda akan:
- Memilih hosting yang tepat
- Deploy Docker ke production server
- Setup domain & DNS
- Mengimplementasi CI/CD pipeline
- Melakukan monitoring & maintenance

---

## 10.1 Memilih Hosting

### Jenis Hosting untuk WordPress + Docker

| Jenis | Harga | Cocok Untuk | Contoh |
|-------|-------|-------------|--------|
| **Shared Hosting** | $3-10/bulan | ❌ Tidak support Docker | - |
| **VPS** | $5-50/bulan | ✅ Small-Medium store | DigitalOcean, Linode, Vultr |
| **Cloud** | $10-100+/bulan | ✅ Scalable | AWS, GCP, Azure |
| **Managed WordPress** | $20-100/bulan | ⚠️ Biasanya no Docker | Kinsta, WP Engine |
| **Managed Docker** | $5-50/bulan | ✅ Easiest | Railway, Render, Fly.io |

### Rekomendasi untuk Pemula

**1. DigitalOcean (★★★★★)**
- Harga: Mulai $6/bulan (1GB RAM)
- Pros: Simple, good docs, Singapore datacenter
- Cons: Perlu setup sendiri
- Best for: Learning, small-medium stores

**2. Vultr (★★★★☆)**
- Harga: Mulai $5/bulan (1GB RAM)
- Pros: Murah, banyak lokasi
- Cons: UI kurang intuitif
- Best for: Budget hosting

**3. Railway (★★★★★)**
- Harga: Free tier available, $5/bulan untuk production
- Pros: Paling mudah untuk Docker
- Cons: Kurang kontrol
- Best for: Beginners

### Minimum Requirements

| Resource | Minimum | Recommended |
|----------|---------|-------------|
| RAM | 1 GB | 2-4 GB |
| CPU | 1 vCPU | 2 vCPU |
| Storage | 25 GB SSD | 50+ GB SSD |
| Bandwidth | 1 TB | 2+ TB |
| OS | Ubuntu 22.04 | Ubuntu 22.04 LTS |

---

## 10.2 Docker di Production Server

### Option 1: Manual VPS Setup

#### Step 1: Create VPS

1. Create account di DigitalOcean/Vultr/Linode
2. Create Droplet/Instance:
   - Region: Singapore (closest to Indonesia)
   - OS: Ubuntu 22.04 LTS
   - Size: 2GB RAM, 1 vCPU ($12/month)
   - Add SSH key

#### Step 2: Initial Server Setup

```bash
# Connect to server
ssh root@your_server_ip

# Update system
apt update && apt upgrade -y

# Create non-root user
adduser deployer
usermod -aG sudo deployer

# Setup firewall
ufw allow OpenSSH
ufw allow 80
ufw allow 443
ufw enable

# Switch to new user
su - deployer
```

#### Step 3: Install Docker

```bash
# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Add user to docker group
sudo usermod -aG docker $USER

# Logout and login again
exit
ssh deployer@your_server_ip

# Verify
docker --version
docker compose version
```

#### Step 4: Setup Project

```bash
# Create project directory
mkdir -p ~/wordpress-ecommerce
cd ~/wordpress-ecommerce

# Create docker-compose.yml
nano docker-compose.yml
```

**Production docker-compose.yml:**

```yaml
services:
  wordpress:
    image: wordpress:latest
    restart: always
    ports:
      - "80:80"
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: ${DB_USER}
      WORDPRESS_DB_PASSWORD: ${DB_PASSWORD}
      WORDPRESS_DB_NAME: ${DB_NAME}
    volumes:
      - wordpress_data:/var/www/html
      - ./wp-content:/var/www/html/wp-content
    depends_on:
      - db
      - redis

  db:
    image: mysql:8.0
    restart: always
    environment:
      MYSQL_DATABASE: ${DB_NAME}
      MYSQL_USER: ${DB_USER}
      MYSQL_PASSWORD: ${DB_PASSWORD}
      MYSQL_ROOT_PASSWORD: ${DB_ROOT_PASSWORD}
    volumes:
      - db_data:/var/lib/mysql

  redis:
    image: redis:alpine
    restart: always
    volumes:
      - redis_data:/data

  nginx:
    image: nginx:alpine
    restart: always
    ports:
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - ./ssl:/etc/nginx/ssl:ro
    depends_on:
      - wordpress

volumes:
  wordpress_data:
  db_data:
  redis_data:
```

**Create .env file:**

```bash
nano .env
```

```
DB_NAME=wordpress_prod
DB_USER=wp_user
DB_PASSWORD=your_secure_password_here
DB_ROOT_PASSWORD=your_root_password_here
```

#### Step 5: Setup SSL with Let's Encrypt

```bash
# Install Certbot
sudo apt install certbot

# Get certificate
sudo certbot certonly --standalone -d yourdomain.com -d www.yourdomain.com

# Certificates will be in /etc/letsencrypt/live/yourdomain.com/
```

#### Step 6: Launch

```bash
# Start containers
docker compose up -d

# Check status
docker compose ps

# View logs
docker compose logs -f
```

### Option 2: Railway (Easiest)

1. Go to railway.app
2. Connect GitHub
3. Create new project > Deploy from GitHub
4. Add services: WordPress, MySQL, Redis
5. Configure environment variables
6. Deploy!

### Option 3: DigitalOcean App Platform

1. Go to cloud.digitalocean.com
2. Create App > From GitHub
3. Select repository
4. Configure services
5. Deploy!

---

## 10.3 Domain & DNS Setup

### Membeli Domain

**Registrar Populer:**
- Namecheap ($10-15/year)
- Cloudflare Registrar (at cost, cheapest)
- Google Domains ($12/year)
- Niagahoster (Indonesia)

### DNS Configuration

**A Record (Direct to IP):**
```
Type: A
Name: @ (root domain)
Value: your_server_ip
TTL: 3600
```

**CNAME (for www):**
```
Type: CNAME
Name: www
Value: yourdomain.com
TTL: 3600
```

### Using Cloudflare DNS (Recommended)

1. Add site to Cloudflare
2. Change nameservers at registrar
3. Add DNS records:

```
Type: A      Name: @    Content: server_ip    Proxy: Yes
Type: CNAME  Name: www  Content: @            Proxy: Yes
```

Benefits:
- Free SSL
- DDoS protection
- CDN caching
- Analytics

### WordPress Configuration

After DNS propagates (24-48 hours):

```
Settings > General:
- WordPress Address: https://yourdomain.com
- Site Address: https://yourdomain.com
```

Or via wp-config.php:
```php
define('WP_HOME', 'https://yourdomain.com');
define('WP_SITEURL', 'https://yourdomain.com');
```

---

## 10.4 CI/CD Pipeline

### Apa itu CI/CD?

- **CI (Continuous Integration)**: Auto-test code changes
- **CD (Continuous Deployment)**: Auto-deploy to production

### Simple Deployment with GitHub Actions

**Create `.github/workflows/deploy.yml`:**

```yaml
name: Deploy to Production

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      
      - name: Deploy to server
        uses: appleboy/ssh-action@master
        with:
          host: ${{ secrets.SERVER_HOST }}
          username: ${{ secrets.SERVER_USER }}
          key: ${{ secrets.SSH_PRIVATE_KEY }}
          script: |
            cd ~/wordpress-ecommerce
            git pull origin main
            docker compose pull
            docker compose up -d --build
            docker system prune -f
```

**Setup Secrets di GitHub:**
1. Repository > Settings > Secrets
2. Add:
   - SERVER_HOST: your_server_ip
   - SERVER_USER: deployer
   - SSH_PRIVATE_KEY: (your private key)

### Workflow Deployment

```
┌─────────────────────────────────────────────────────────┐
│                   DEPLOYMENT FLOW                        │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  1. Local Development                                    │
│     └── Edit code                                       │
│         └── Test locally                                │
│             └── Commit & Push to GitHub                 │
│                                                          │
│  2. GitHub Actions (CI)                                  │
│     └── Run tests (optional)                            │
│         └── Build Docker image                          │
│             └── Push to registry (optional)             │
│                                                          │
│  3. Production Server (CD)                               │
│     └── Pull latest code                                │
│         └── Pull/build images                           │
│             └── Restart containers                      │
│                 └── 🎉 Live!                            │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

### Manual Deployment (Alternative)

Jika tidak ingin CI/CD:

```bash
# On local
git add .
git commit -m "Update"
git push origin main

# On server
ssh deployer@your_server
cd ~/wordpress-ecommerce
git pull
docker compose up -d
```

---

## 10.5 Monitoring & Maintenance

### Server Monitoring

#### Uptime Monitoring
**Free Options:**
- UptimeRobot (50 monitors free)
- Freshping
- Cronitor

**Setup UptimeRobot:**
1. Create account
2. Add Monitor:
   - Type: HTTP(s)
   - URL: https://yourdomain.com
   - Interval: 5 minutes
3. Set up alerts (email, Telegram, Slack)

#### Resource Monitoring

**Server-side:**
```bash
# Check resources
htop

# Check disk
df -h

# Check Docker
docker stats
```

**Tools:**
- Netdata (self-hosted, beautiful dashboards)
- Prometheus + Grafana (advanced)
- DigitalOcean Monitoring (built-in)

### WordPress Maintenance

#### Daily:
- [ ] Check uptime alerts
- [ ] Monitor orders/sales

#### Weekly:
- [ ] Backup verification
- [ ] Security scan (Wordfence)
- [ ] Check error logs

#### Monthly:
- [ ] Update WordPress core
- [ ] Update plugins
- [ ] Update themes
- [ ] Database optimization
- [ ] Performance test
- [ ] Review analytics

#### Quarterly:
- [ ] Full security audit
- [ ] Review & clean unused plugins
- [ ] Test backup restore
- [ ] Review hosting needs

### Automated Maintenance

**WP-CLI for Automation:**
```bash
# Install WP-CLI in container
docker exec wordpress wp core update
docker exec wordpress wp plugin update --all
docker exec wordpress wp theme update --all
```

**Cron Job for Updates:**
```bash
# Edit crontab
crontab -e

# Add weekly update (Sunday 3 AM)
0 3 * * 0 cd ~/wordpress-ecommerce && docker compose exec wordpress wp core update --quiet
```

### Emergency Procedures

**Website Down:**
1. Check uptime monitor
2. SSH to server
3. Check Docker: `docker compose ps`
4. Check logs: `docker compose logs`
5. Restart if needed: `docker compose restart`

**Hacked:**
1. Take site offline
2. Restore from backup
3. Change all passwords
4. Scan for malware
5. Update everything
6. Review access logs
7. Implement additional security

**Database Corrupted:**
1. Stop WordPress container
2. Restore database from backup
3. Verify integrity
4. Restart containers

---

## Production Checklist

### Before Launch:
- [ ] All products added
- [ ] Payment gateway tested
- [ ] Shipping configured
- [ ] SSL working
- [ ] Backup system active
- [ ] Security plugins configured
- [ ] Performance optimized
- [ ] SEO basics done
- [ ] Legal pages (Privacy, Terms, Refund)
- [ ] Contact info correct
- [ ] Email notifications working

### Launch Day:
- [ ] DNS pointing to production
- [ ] SSL certificate active
- [ ] Test complete checkout flow
- [ ] Mobile testing
- [ ] Monitor for errors

### Post-Launch:
- [ ] Submit to Google Search Console
- [ ] Setup Google Analytics goals
- [ ] Create Google Business Profile
- [ ] Share on social media
- [ ] Monitor first orders

---

## Rangkuman Modul 10

### Deployment Options:
1. **VPS** (DigitalOcean, Vultr): Most control, medium difficulty
2. **Managed Docker** (Railway): Easiest, less control
3. **Cloud** (AWS, GCP): Most scalable, most complex

### Key Steps:
1. Choose hosting
2. Setup server & Docker
3. Configure SSL
4. Point domain
5. Deploy
6. Monitor

---

## Quiz Final

1. Apa minimum RAM untuk WordPress production?
2. Bagaimana cara mendapatkan SSL gratis?
3. Apa fungsi CI/CD?
4. Seberapa sering harus update WordPress?
5. Apa yang harus dilakukan jika website di-hack?

---

## 🎉 Selamat!

Anda telah menyelesaikan seluruh tutorial **Membangun Website E-Commerce dengan WordPress & Docker**!

### Apa Selanjutnya?
1. **Praktek**: Bangun toko online Anda sendiri
2. **Explore**: Pelajari lebih dalam topik yang menarik
3. **Scale**: Saat traffic naik, upgrade hosting
4. **Learn**: WordPress & WooCommerce terus berkembang

### Resources Tambahan:
- [WooCommerce Documentation](https://woocommerce.com/documentation/)
- [WordPress Developer Resources](https://developer.wordpress.org/)
- [Docker Documentation](https://docs.docker.com/)
- [DigitalOcean Community Tutorials](https://www.digitalocean.com/community/tutorials)

### Butuh Bantuan?
- WordPress Forums: wordpress.org/support
- WooCommerce Forums: wordpress.org/support/plugin/woocommerce
- Stack Overflow: Tag [wordpress], [woocommerce], [docker]

---

**Terima kasih telah mengikuti tutorial ini! 🚀**

*Happy selling!*
