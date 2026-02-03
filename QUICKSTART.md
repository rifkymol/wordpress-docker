# WordPress Docker Quick Start Guide

This guide will help you get WordPress running in under 5 minutes!

## Quick Start (3 Steps)

### Step 1: Start Docker
```bash
docker-compose up -d
```

### Step 2: Wait (30 seconds)
Give the database time to initialize.

### Step 3: Open Browser
Go to: [http://localhost:8080](http://localhost:8080)

That's it! Follow the WordPress installation wizard.

## Access Points

- **WordPress**: http://localhost:8080
- **phpMyAdmin**: http://localhost:8081
  - Server: `db`
  - Username: `root`
  - Password: `rootpassword`

## Common Commands

```bash
# Start services
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f

# Restart services
docker-compose restart

# Check status
docker-compose ps
```

## First Time Setup

1. Navigate to http://localhost:8080
2. Choose your language
3. Create admin account:
   - Username: (your choice)
   - Password: (strong password)
   - Email: (your email)
4. Click "Install WordPress"
5. Start learning!

## Tips for Learning

1. **Theme Development**: Edit files in `./wordpress/wp-content/themes/`
2. **Plugin Development**: Add plugins to `./wordpress/wp-content/plugins/`
3. **Database**: Use phpMyAdmin at http://localhost:8081 to explore the database
4. **Logs**: Run `docker-compose logs -f wordpress` to see WordPress logs
5. **Reset**: Run `docker-compose down -v && rm -rf wordpress/` to start fresh

## Need Help?

Check the main [README.md](README.md) for detailed documentation.
