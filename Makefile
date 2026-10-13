# Manager Library - Infrastructure Makefile
# Commands for local development environment

.PHONY: help up down restart logs clean ps status shell-pg shell-pgadmin

help: ## Show this help
	@echo 'Manager Library Infrastructure Commands'
	@echo ''
	@echo 'Usage:'
	@echo '  make <target>'
	@echo ''
	@echo 'Targets:'
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

up: ## Start all services in detached mode
	docker-compose up -d

down: ## Stop and remove all containers, networks, and volumes
	docker-compose down

restart: down up ## Restart all services

logs: ## Show logs from all services
	docker-compose logs -f

logs-postgres: ## Show PostgreSQL logs
	docker-compose logs -f postgres

logs-pgadmin: ## Show pgAdmin logs
	docker-compose logs -f pgadmin

clean: ## Stop services and remove volumes (WARNING: deletes all data!)
	docker-compose down -v

ps: ## Show status of all services
	docker-compose ps

status: ps ## Alias for ps

shell-pg: ## Open PostgreSQL shell
	docker-compose exec postgres psql -U manager_library -d manager_library

shell-pgadmin: ## Open pgAdmin in browser (if available)
	@echo "pgAdmin available at: http://localhost:5050"
	@echo "Email: admin@library.local"
	@echo "Password: check .env file"

init-env: ## Copy .env.example to .env if it doesn't exist
	@if [ ! -f .env ]; then \
		cp .env.example .env; \
		echo "Created .env file from .env.example"; \
		echo "Please edit .env with your actual values"; \
	else \
		echo ".env already exists"; \
	fi

check-ports: ## Check if required ports are available
	@echo "Checking ports..."
	@if lsof -Pi :5432 -sTCP:LISTEN -t >/dev/null ; then echo "Port 5432 (PostgreSQL) is in use"; fi
	@if lsof -Pi :5050 -sTCP:LISTEN -t >/dev/null ; then echo "Port 5050 (pgAdmin) is in use"; fi
	@echo "Port check complete"

version: ## Show Docker and Docker Compose versions
	@echo "Docker version:"
	@docker --version
	@echo ""
	@echo "Docker Compose version:"
	@docker-compose --version

health: ## Check health of all services
	@echo "Checking service health..."
	@docker-compose ps --services | while read service; do \
		status=$$(docker-compose ps $$service | tail -1 | awk '{print $$4}'); \
		echo "$$service: $$status"; \
	done

# Development shortcuts
dev: init-env up ## Initialize environment and start services
	@echo "Services started. Use 'make logs' to view logs"

reset: down clean up ## Reset everything and restart (deletes all data!)
	@echo "Infrastructure reset complete. All data has been deleted."

info: ## Show connection information
	@echo "=== Manager Library Infrastructure ==="
	@echo "PostgreSQL:"
	@echo "  Host: localhost:5432"
	@echo "  Database: manager_library"
	@echo "  User: manager_library"
	@echo "  Password: (check .env file)"
	@echo ""
	@echo "pgAdmin (optional):"
	@echo "  URL: http://localhost:5050"
	@echo "  Email: admin@library.local"
	@echo "  Password: (check .env file)"
	@echo ""
	@echo "Commands:"
	@echo "  make dev    - Start development environment"
	@echo "  make down   - Stop services"
	@echo "  make clean  - Stop and delete all data"
	@echo "  make shell-pg - Open PostgreSQL shell"