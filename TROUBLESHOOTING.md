# Troubleshooting Guide

Common issues and solutions for the WordPress Docker environment.

## Table of Contents
- [Docker Issues](#docker-issues)
- [WordPress Issues](#wordpress-issues)
- [Database Issues](#database-issues)
- [Network Issues](#network-issues)
- [Performance Issues](#performance-issues)

## Docker Issues

### Docker is not running
```
Error: Cannot connect to the Docker daemon
```

**Solution:**
- Start Docker Desktop (Windows/Mac) or Docker service (Linux)
- Linux: `sudo systemctl start docker`

### Port already in use
```
Error: Bind for 0.0.0.0:8080 failed: port is already allocated
```

**Solution:**
1. Find what's using the port:
   ```bash
   # Linux/Mac
   lsof -i :8080
   
   # Windows
   netstat -ano | findstr :8080
   ```

2. Either stop the conflicting service or change the port in `docker-compose.yml`:
   ```yaml
   wordpress:
     ports:
       - "8090:80"  # Changed from 8080
   ```

### Containers won't start
```
Error: Container wordpress-app exited with code 1
```

**Solution:**
1. Check logs:
   ```bash
   docker compose logs wordpress
   docker compose logs db
   ```

2. Restart containers:
   ```bash
   docker compose down
   docker compose up -d
   ```

3. If still failing, try a fresh start:
   ```bash
   docker compose down -v
   rm -rf wordpress/
   docker compose up -d
   ```

## WordPress Issues

### White screen or error page
**Solution:**
1. Wait 30-60 seconds for the database to initialize
2. Check database connection in logs:
   ```bash
   docker compose logs wordpress
   ```
3. Verify database credentials in `.env` match `docker-compose.yml`

### Cannot install/update plugins or themes
**Solution:**
This is usually a permissions issue:
```bash
# Fix WordPress directory permissions
docker compose exec wordpress chown -R www-data:www-data /var/www/html
docker compose exec wordpress chmod -R 755 /var/www/html
```

### "Error establishing database connection"
**Solution:**
1. Ensure database container is running:
   ```bash
   docker compose ps
   ```

2. Check database logs:
   ```bash
   docker compose logs db
   ```

3. Verify credentials in `.env` file

4. Restart containers:
   ```bash
   docker compose restart
   ```

### WordPress is slow to load
**Solution:**
1. Check Docker resource allocation (Docker Desktop > Settings > Resources)
2. Increase memory/CPU allocation
3. Disable unnecessary plugins in WordPress admin

## Database Issues

### Database won't start
```
Error: MySQL shutdown unexpectedly
```

**Solution:**
1. Check logs:
   ```bash
   docker compose logs db
   ```

2. Common cause: Corrupted data volume
   ```bash
   docker compose down -v
   docker compose up -d
   ```
   ⚠️ This will delete all data!

### Cannot access phpMyAdmin
**Solution:**
1. Verify phpMyAdmin container is running:
   ```bash
   docker compose ps
   ```

2. Check port 8081 is not in use:
   ```bash
   lsof -i :8081  # Linux/Mac
   ```

3. Check phpMyAdmin logs:
   ```bash
   docker compose logs phpmyadmin
   ```

### "Access denied" in phpMyAdmin
**Solution:**
Use correct credentials:
- Server: `db`
- Username: `root`
- Password: Value of `DB_ROOT_PASSWORD` from `.env` (default: `rootpassword`)

## Network Issues

### Containers can't communicate
**Solution:**
1. Check if containers are on the same network:
   ```bash
   docker network ls
   docker network inspect wordpress-docker_wordpress-network
   ```

2. Restart containers:
   ```bash
   docker compose down
   docker compose up -d
   ```

### Cannot access WordPress from browser
**Solution:**
1. Verify containers are running:
   ```bash
   docker compose ps
   ```

2. Check firewall settings (allow ports 8080 and 8081)

3. Try accessing by IP:
   ```bash
   # Get Docker host IP
   docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' wordpress-app
   ```

4. On Windows with WSL2, try:
   - http://localhost:8080
   - http://127.0.0.1:8080
   - http://<your-windows-ip>:8080

## Performance Issues

### Slow performance on Mac/Windows
**Solution:**
1. Increase Docker Desktop resource allocation:
   - Docker Desktop > Settings > Resources
   - Increase CPUs and Memory

2. Use volumes instead of bind mounts for better performance

3. Consider using Docker Desktop's experimental features

### High disk usage
**Solution:**
1. Clean up unused Docker resources:
   ```bash
   docker system prune -a
   docker volume prune
   ```

2. Keep only necessary backups:
   ```bash
   rm backup-*.sql  # Remove old database backups
   ```

## General Tips

### View all logs
```bash
docker compose logs -f
```

### Check container status
```bash
docker compose ps
```

### Restart specific service
```bash
docker compose restart wordpress
docker compose restart db
```

### Access WordPress files
```bash
# Files are in the ./wordpress directory
ls -la wordpress/
```

### Access container shell
```bash
# WordPress container
docker compose exec wordpress bash

# Database container
docker compose exec db bash
```

### Export database manually
```bash
docker compose exec db mysqldump -u root -p wordpress > backup.sql
# Enter root password when prompted
```

### Import database manually
```bash
docker compose exec -T db mysql -u root -p wordpress < backup.sql
# Enter root password when prompted
```

## Still Having Issues?

1. Check [GitHub Issues](https://github.com/rifkymol/wordpress-docker/issues)
2. Review [Docker documentation](https://docs.docker.com/)
3. Check [WordPress support forums](https://wordpress.org/support/)
4. Create a new issue with:
   - Your OS and Docker version
   - Error messages
   - Output of `docker compose logs`

## Complete Reset

If nothing else works, perform a complete reset:

```bash
# Stop all containers
docker compose down -v

# Remove all WordPress files
rm -rf wordpress/

# Remove all Docker images (optional)
docker compose down --rmi all

# Start fresh
docker compose up -d
```

⚠️ **Warning**: This will delete ALL data including WordPress content and database!
