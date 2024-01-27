UID := $(shell id -u)
GID := $(shell id -g)

build: ## Build the docker container
	docker-compose build --build-arg UID=${UID} --build-arg GID=${GID}

up: build ## Run the hasura server
	docker-compose up -d hasura

down: ## Take down everything, including the data.
	docker-compose down -v

shell: build ## Open a shell
	docker-compose run -e UID=${UID} -e GID=${GID} hasura-cli

console: build ## Just run the hasura console
	docker-compose run -e UID=${UID} -e GID=${GID} --entrypoint "hasura-cli --skip-update-check console --no-browser" hasura-cli

help: ## See a list of all available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.* ?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: all $(MAKECMDGOALS)

.DEFAULT_GOAL := help
