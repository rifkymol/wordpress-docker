# WordPress Docker Development Environment

A simple Docker-based WordPress development environment perfect for learning and development. This setup includes WordPress, MySQL database, and phpMyAdmin for easy database management.

## 🚀 Features

- **WordPress**: Latest version running on Apache
- **MySQL 8.0**: Database server for WordPress
- **phpMyAdmin**: Web-based database management tool
- **Persistent Data**: Volumes for database and WordPress files
- **Easy Configuration**: Environment variables for customization

## 📋 Prerequisites

Before you begin, ensure you have the following installed:
- [Docker](https://docs.docker.com/get-docker/) (version 20.10 or higher)
- [Docker Compose](https://docs.docker.com/compose/install/) (version 1.29 or higher)

## 🛠️ Installation & Setup

### 1. Clone the Repository

```bash
git clone https://github.com/rifkymol/wordpress-docker.git
cd wordpress-docker
```

### 2. Configure Environment Variables (Optional)

Copy the example environment file and customize if needed:

```bash
cp .env.example .env
```

Edit `.env` to change default credentials:

```env
DB_NAME=wordpress
DB_USER=wordpress
DB_PASSWORD=your_secure_password
DB_ROOT_PASSWORD=your_root_password
```

### 3. Start the Docker Containers

```bash
docker-compose up -d
```

This command will:
- Download the necessary Docker images (first time only)
- Create and start the containers
- Set up the WordPress database

### 4. Access Your WordPress Site

Once the containers are running, you can access:

- **WordPress Site**: [http://localhost:8080](http://localhost:8080)
- **phpMyAdmin**: [http://localhost:8081](http://localhost:8081)

### 5. Complete WordPress Installation

1. Open your browser and navigate to [http://localhost:8080](http://localhost:8080)
2. Select your language
3. Fill in the site information:
   - Site Title
   - Username
   - Password
   - Email
4. Click "Install WordPress"

## 📝 Usage

### Starting the Environment

```bash
docker-compose up -d
```

### Stopping the Environment

```bash
docker-compose down
```

### Stopping and Removing All Data

⚠️ **Warning**: This will delete all WordPress files and database data!

```bash
docker-compose down -v
rm -rf wordpress/
```

### Viewing Logs

```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f wordpress
docker-compose logs -f db
```

### Restarting Services

```bash
docker-compose restart
```

## 🗂️ Project Structure

```
wordpress-docker/
├── docker-compose.yml    # Docker Compose configuration
├── .env.example         # Example environment variables
├── .env                 # Your environment variables (not tracked)
├── .gitignore          # Git ignore rules
├── wordpress/          # WordPress files (auto-generated, not tracked)
└── README.md           # This file
```

## 🔧 Customization

### Changing Ports

Edit `docker-compose.yml` and modify the ports section:

```yaml
wordpress:
  ports:
    - "8080:80"  # Change 8080 to your preferred port

phpmyadmin:
  ports:
    - "8081:80"  # Change 8081 to your preferred port
```

### Using a Different Database

You can switch to MariaDB by changing the database service in `docker-compose.yml`:

```yaml
db:
  image: mariadb:latest
  # ... rest of configuration
```

## 🐛 Troubleshooting

### Port Already in Use

If you see an error about ports being in use:

```bash
# Check what's using the port
lsof -i :8080
# or
netstat -an | grep 8080

# Change the port in docker-compose.yml or stop the conflicting service
```

### Database Connection Error

If WordPress can't connect to the database:

1. Wait a minute for the database to fully initialize
2. Check database credentials in `.env`
3. Restart the containers:
   ```bash
   docker-compose restart
   ```

### Reset WordPress Installation

```bash
docker-compose down -v
rm -rf wordpress/
docker-compose up -d
```

## 🎓 Learning Resources

- [WordPress Codex](https://codex.wordpress.org/)
- [WordPress Developer Resources](https://developer.wordpress.org/)
- [Docker Documentation](https://docs.docker.com/)
- [WordPress Theme Development](https://developer.wordpress.org/themes/)
- [WordPress Plugin Development](https://developer.wordpress.org/plugins/)

## 📦 What's Included

### Services

1. **WordPress (Port 8080)**
   - Official WordPress image
   - Apache web server
   - PHP with required extensions

2. **MySQL (Internal)**
   - MySQL 8.0 database
   - Persistent storage with Docker volumes

3. **phpMyAdmin (Port 8081)**
   - Web interface for database management
   - Direct access to WordPress database

### Database Credentials (Default)

- **Database Name**: wordpress
- **Database User**: wordpress
- **Database Password**: wordpress
- **Root Password**: rootpassword

⚠️ **Security Note**: Change these default passwords in production!

## 🤝 Contributing

Feel free to submit issues and enhancement requests!

## 📄 License

This project is open source and available for learning purposes.

## 🙏 Acknowledgments

- WordPress Team
- Docker Team
- The open-source community

---

**Happy Learning! 🎉**

For questions or issues, please open an issue on GitHub.