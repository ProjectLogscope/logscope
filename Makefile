SHELL := /bin/bash

# Read the directories from go.work file
GO_WORK_FILE := go.work
GO_DIRS := $(shell grep -oE '^\s*\./\S+' $(GO_WORK_FILE) | sed 's/^\s*\.//')

.PHONY: all
all: tidy vendor compose-build

.PHONY: tidy
tidy:
	@for dir in $(GO_DIRS); do \
		echo "Running 'go mod tidy' in $$dir"; \
		(cd $$dir && go mod tidy); \
	done

.PHONY: vendor
vendor:
	@for dir in $(GO_DIRS); do \
		echo "Running 'go mod vendor' in $$dir"; \
		(cd $$dir && go mod vendor); \
	done

.PHONY: prune
prune:
	@for dir in $(GO_DIRS); do \
		echo "Running 'rm -rf ./vendor' in $$dir"; \
		(cd $$dir && rm -rf ./vendor); \
	done

.PHONY: build
build:
	@for dir in $(GO_DIRS); do \
		echo "Running 'make build' in $$dir"; \
		(cd $$dir && make build); \
	done

.PHONY: run
run:
	@for dir in $(GO_DIRS); do \
		echo "Running 'make run' in $$dir"; \
		(cd $$dir && make run); \
	done

.PHONY: clean
clean:
	@for dir in $(GO_DIRS); do \
		echo "Running 'make clean' in $$dir"; \
		(cd $$dir && make clean); \
	done

.PHONY: compose-up
compose-up:
	@docker compose \
	--file ./compose.yaml \
	up \
	--detach \
	--force-recreate \
	--remove-orphans \
	--timestamps

.PHONY: compose-build
compose-build:
	@docker compose \
	--file ./compose.yaml \
	up \
	--detach \
	--build \
	--force-recreate \
	--remove-orphans \
	--timestamps

.PHONY: compose-down
compose-down:
	@docker compose \
	--file ./compose.yaml \
	down \
	--remove-orphans

.PHONY: compose-delete
compose-delete:
	@docker compose \
	--file ./compose.yaml \
	down \
	--remove-orphans \
	--volumes
