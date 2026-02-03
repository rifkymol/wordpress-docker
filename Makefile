.PHONY: help start stop restart logs clean reset status install

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

start: ## Start WordPress Docker environment
	@echo "Starting WordPress Docker environment..."
	docker-compose up -d
	@echo "WordPress is starting up..."
	@echo "WordPress: http://localhost:8080"
	@echo "phpMyAdmin: http://localhost:8081"

stop: ## Stop WordPress Docker environment
	@echo "Stopping WordPress Docker environment..."
	docker-compose down

restart: ## Restart WordPress Docker environment
	@echo "Restarting WordPress Docker environment..."
	docker-compose restart

logs: ## Show logs from all services
	docker-compose logs -f

logs-wordpress: ## Show logs from WordPress
	docker-compose logs -f wordpress

logs-db: ## Show logs from database
	docker-compose logs -f db

status: ## Show status of containers
	docker-compose ps

clean: ## Stop and remove containers (keeps data)
	@echo "Stopping and removing containers..."
	docker-compose down

reset: ## Complete reset (removes all data)
	@echo "WARNING: This will delete all WordPress data!"
	@read -p "Are you sure? [y/N] " -n 1 -r; \
	echo; \
	if [[ $$REPLY =~ ^[Yy]$$ ]]; then \
		docker-compose down -v; \
		rm -rf wordpress/; \
		echo "Reset complete. Run 'make start' to begin fresh."; \
	fi

install: ## Initial setup - copy env file
	@if [ ! -f .env ]; then \
		cp .env.example .env; \
		echo ".env file created. Edit it to customize your setup."; \
	else \
		echo ".env file already exists."; \
	fi

shell-wordpress: ## Open shell in WordPress container
	docker-compose exec wordpress bash

shell-db: ## Open MySQL shell
	docker-compose exec db mysql -u root -prootpassword wordpress

backup-db: ## Backup database
	@echo "Creating database backup..."
	docker-compose exec db mysqldump -u root -prootpassword wordpress > backup-$(shell date +%Y%m%d-%H%M%S).sql
	@echo "Backup created: backup-$(shell date +%Y%m%d-%H%M%S).sql"

restore-db: ## Restore database from backup (usage: make restore-db FILE=backup.sql)
	@if [ -z "$(FILE)" ]; then \
		echo "Error: Please specify FILE=backup.sql"; \
		exit 1; \
	fi
	@echo "Restoring database from $(FILE)..."
	docker-compose exec -T db mysql -u root -prootpassword wordpress < $(FILE)
	@echo "Database restored."
