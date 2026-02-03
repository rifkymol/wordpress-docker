# Modul 1: Docker Fundamentals

## Tujuan Pembelajaran
Setelah menyelesaikan modul ini, Anda akan:
- Memahami apa itu Docker dan mengapa penting
- Menguasai perintah Docker dasar
- Memahami Docker Compose untuk multi-container
- Mengelola volumes dan networking

---

## 1.1 Pengenalan Docker & Konsep Container

### Apa itu Docker?
Docker adalah platform open-source yang memungkinkan Anda **mengemas aplikasi** beserta semua dependensinya ke dalam unit standar yang disebut **container**. 

### Analogi Sederhana
Bayangkan Anda ingin mengirim barang:
- **Tanpa Docker** = Kirim barang terpisah-pisah, rentan rusak, sulit diatur
- **Dengan Docker** = Semua barang dalam kontainer standar, aman, mudah dipindah

### Mengapa Docker Penting untuk WordPress?
1. **Konsistensi**: Environment development = production
2. **Isolasi**: WordPress tidak mengganggu sistem utama
3. **Portabilitas**: Bisa dijalankan di mana saja (laptop, server, cloud)
4. **Skalabilitas**: Mudah scale up/down sesuai kebutuhan
5. **Version Control**: Mudah rollback jika ada masalah

### Perbedaan Docker vs Virtual Machine

| Aspek | Docker Container | Virtual Machine |
|-------|-----------------|-----------------|
| Ukuran | MB (ringan) | GB (berat) |
| Startup | Detik | Menit |
| OS | Berbagi kernel host | OS sendiri |
| Resource | Efisien | Boros |
| Isolasi | Process-level | Full isolation |

### Komponen Utama Docker

```
┌─────────────────────────────────────────────────────┐
│                   Docker Client                      │
│                   (docker CLI)                       │
└─────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────┐
│                   Docker Daemon                      │
│                   (dockerd)                          │
└─────────────────────────────────────────────────────┘
                          │
          ┌───────────────┼───────────────┐
          ▼               ▼               ▼
    ┌──────────┐    ┌──────────┐    ┌──────────┐
    │  Images  │    │Containers│    │ Volumes  │
    └──────────┘    └──────────┘    └──────────┘
```

1. **Docker Client**: Interface untuk berinteraksi dengan Docker
2. **Docker Daemon**: Service yang mengelola container
3. **Images**: Template read-only untuk membuat container
4. **Containers**: Instance dari image yang berjalan
5. **Volumes**: Penyimpanan persisten untuk data

---

## 1.2 Docker Commands Dasar

### Perintah Paling Sering Digunakan

```bash
# Cek versi Docker
docker --version

# Cek info sistem Docker
docker info

# Test instalasi
docker run hello-world
```

### Mengelola Images

```bash
# List semua images
docker images

# Download image dari Docker Hub
docker pull wordpress:latest
docker pull mysql:5.7

# Hapus image
docker rmi <image_id>

# Hapus semua images tidak terpakai
docker image prune
```

### Mengelola Containers

```bash
# List container yang berjalan
docker ps

# List semua container (termasuk stopped)
docker ps -a

# Jalankan container baru
docker run -d --name my-wordpress -p 8080:80 wordpress

# Stop container
docker stop <container_id>

# Start container yang stopped
docker start <container_id>

# Restart container
docker restart <container_id>

# Hapus container
docker rm <container_id>

# Hapus semua container stopped
docker container prune
```

### Masuk ke Container

```bash
# Masuk ke shell container
docker exec -it <container_name> bash

# Contoh: masuk ke container WordPress
docker exec -it wordpress-docker-wordpress-1 bash

# Jalankan perintah tanpa masuk
docker exec <container_name> ls /var/www/html
```

### Melihat Logs

```bash
# Lihat logs container
docker logs <container_name>

# Follow logs (real-time)
docker logs -f <container_name>

# Lihat 100 baris terakhir
docker logs --tail 100 <container_name>
```

### 🔧 Praktik 1: Docker Dasar

1. Jalankan hello-world:
```bash
docker run hello-world
```

2. Download dan jalankan nginx:
```bash
docker run -d --name test-nginx -p 8081:80 nginx
```

3. Buka browser ke `http://localhost:8081`

4. Lihat logs:
```bash
docker logs test-nginx
```

5. Stop dan hapus:
```bash
docker stop test-nginx
docker rm test-nginx
```

---

## 1.3 Docker Compose untuk Multi-Container

### Apa itu Docker Compose?
Docker Compose adalah tool untuk mendefinisikan dan menjalankan **multi-container** Docker applications menggunakan file YAML.

### Mengapa Perlu Docker Compose?
WordPress membutuhkan:
- Container WordPress (PHP + Apache)
- Container Database (MySQL)
- Network untuk komunikasi antar container
- Volumes untuk data persistence

Tanpa Compose, Anda perlu menjalankan banyak perintah. Dengan Compose, cukup 1 file dan 1 perintah!

### Struktur docker-compose.yml

```yaml
# Definisi services (containers)
services:
  # Service 1: WordPress
  wordpress:
    image: wordpress:latest      # Image yang digunakan
    ports:
      - "8080:80"                # Port mapping host:container
    environment:                  # Environment variables
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress
      WORDPRESS_DB_NAME: wordpress
    volumes:                      # Volume mounting
      - wordpress_data:/var/www/html
      - ./wp-content:/var/www/html/wp-content
    depends_on:                   # Dependency order
      - db

  # Service 2: Database
  db:
    image: mysql:5.7
    environment:
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress
      MYSQL_ROOT_PASSWORD: somewordpress
    volumes:
      - db_data:/var/lib/mysql

# Definisi volumes
volumes:
  wordpress_data:    # Named volume untuk WordPress
  db_data:           # Named volume untuk database
```

### Docker Compose Commands

```bash
# Navigasi ke folder project
cd c:\Users\rifky\Documents\PERSONAL\wordpress-docker

# Start semua services (background)
docker compose up -d

# Lihat status services
docker compose ps

# Lihat logs semua services
docker compose logs

# Lihat logs service tertentu
docker compose logs wordpress
docker compose logs db

# Stop semua services
docker compose down

# Stop dan hapus volumes (HATI-HATI: data hilang!)
docker compose down -v

# Restart services
docker compose restart

# Rebuild dan start
docker compose up -d --build

# Scale service (advanced)
docker compose up -d --scale wordpress=3
```

### 🔧 Praktik 2: Docker Compose

1. Pastikan di folder project:
```bash
cd c:\Users\rifky\Documents\PERSONAL\wordpress-docker
```

2. Lihat isi docker-compose.yml:
```bash
cat docker-compose.yml
```

3. Start services:
```bash
docker compose up -d
```

4. Cek status:
```bash
docker compose ps
```

5. Lihat logs:
```bash
docker compose logs -f
```

6. Buka `http://localhost:8080`

---

## 1.4 Volumes & Networking

### Docker Volumes

Volumes adalah mekanisme untuk **menyimpan data secara persisten**. Tanpa volume, data hilang saat container dihapus.

#### Jenis Volume:

1. **Named Volume** (Dikelola Docker)
```yaml
volumes:
  - wordpress_data:/var/www/html
```
- Lokasi: Docker mengelola sendiri
- Cocok untuk: Database, data aplikasi
- Backup: `docker volume create backup`

2. **Bind Mount** (Folder lokal)
```yaml
volumes:
  - ./wp-content:/var/www/html/wp-content
```
- Lokasi: Folder di komputer Anda
- Cocok untuk: Development, edit file langsung
- Akses mudah via file explorer

#### Perintah Volume:

```bash
# List volumes
docker volume ls

# Inspect volume
docker volume inspect wordpress-docker_wordpress_data

# Hapus volume
docker volume rm <volume_name>

# Hapus semua volumes tidak terpakai
docker volume prune
```

### Docker Networking

Docker otomatis membuat network untuk container berkomunikasi.

```
┌─────────────────────────────────────────────────────┐
│              wordpress-docker_default               │
│                    (bridge network)                 │
│                                                     │
│  ┌─────────────┐              ┌─────────────┐      │
│  │  wordpress  │◄────────────►│     db      │      │
│  │  (port 80)  │    TCP/IP    │ (port 3306) │      │
│  └─────────────┘              └─────────────┘      │
│         │                                          │
└─────────│──────────────────────────────────────────┘
          │
          ▼ Port 8080
    ┌───────────┐
    │   Host    │
    │  Browser  │
    └───────────┘
```

#### Komunikasi antar Container:
- WordPress mengakses database via hostname `db` (nama service)
- Port internal: MySQL 3306, WordPress 80
- Port external: hanya WordPress 8080 (ke host)

#### Perintah Network:

```bash
# List networks
docker network ls

# Inspect network
docker network inspect wordpress-docker_default

# Buat network custom
docker network create my-network
```

### 🔧 Praktik 3: Volumes & Network

1. Lihat volumes yang dibuat:
```bash
docker volume ls
```

2. Inspect volume database:
```bash
docker volume inspect wordpress-docker_db_data
```

3. Lihat network:
```bash
docker network ls
docker network inspect wordpress-docker_default
```

4. Cek file lokal (bind mount):
```bash
dir .\wp-content
```

---

## Rangkuman Modul 1

### Konsep Kunci:
- **Docker** = Platform untuk menjalankan aplikasi dalam container
- **Image** = Template untuk membuat container
- **Container** = Instance dari image yang berjalan
- **Docker Compose** = Tool untuk multi-container apps
- **Volume** = Penyimpanan data persisten
- **Network** = Komunikasi antar container

### Perintah Penting:

| Perintah | Fungsi |
|----------|--------|
| `docker ps` | Lihat container berjalan |
| `docker images` | Lihat images |
| `docker logs <name>` | Lihat logs |
| `docker exec -it <name> bash` | Masuk ke container |
| `docker compose up -d` | Start services |
| `docker compose down` | Stop services |
| `docker compose logs` | Lihat logs |

---

## Quiz Modul 1

1. Apa perbedaan utama Docker container dengan Virtual Machine?
- Docker adalah platform kontainerisasi ringan yang berbagi kernel OS host, sehingga lebih cepat dan efisien (MB) untuk menjalankan aplikasi. Sebaliknya, Virtual Machine (VM) memvirtualisasikan perangkat keras penuh, menjalankan OS tamu sendiri di atas hypervisor, lebih aman, namun berat (GB). Docker unggul dalam portabilitas dan skala, sedangkan VM cocok untuk isolasi penuh. 
2. Apa fungsi file `docker-compose.yml`?
- Docker Compose adalah tool untuk mendefinisikan dan menjalankan **multi-container** Docker applications menggunakan file YAML.
3. Bagaimana cara melihat container yang sedang berjalan?
- Menggunakan command `docker ps`
4. Apa perbedaan named volume dan bind mount?
- Docker Volume adalah metode yang dikelola penuh oleh Docker, disimpan di direktori khusus Docker (/var/lib/docker/volumes/), dan direkomendasikan untuk produksi karena keamanan serta portabilitas yang lebih baik. Sebaliknya, Bind Mount mengikat file/direktori absolut dari host langsung ke kontainer, lebih fleksibel untuk pengembangan, tetapi bergantung pada struktur sistem file host.
5. Bagaimana container WordPress berkomunikasi dengan database?
- Container WordPress berkomunikasi dengan database (biasanya MySQL atau MariaDB) utamanya melalui jaringan internal Docker, di mana WordPress menggunakan nama host container database sebagai alamat host database. Koneksi ini dikonfigurasi melalui variabel lingkungan (environment variables) di dalam file docker-compose.yml atau saat menjalankan perintah docker run. 

---

## Tugas Praktik

1. Modifikasi `docker-compose.yml` untuk mengubah port dari 8080 ke 8888
2. Tambahkan phpMyAdmin untuk akses database via browser
3. Buat backup volume database

### Hint untuk phpMyAdmin:
```yaml
phpmyadmin:
  image: phpmyadmin:latest
  ports:
    - "8081:80"
  environment:
    PMA_HOST: db
    PMA_USER: wordpress
    PMA_PASSWORD: wordpress
  depends_on:
    - db
```

---

**Selesai Modul 1? Lanjut ke [02-WORDPRESS-BASICS.md](02-WORDPRESS-BASICS.md)! 🚀**
