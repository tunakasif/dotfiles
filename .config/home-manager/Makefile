.PHONY: stash pop update build all

OS := $(shell uname -s)

ifeq ($(OS), Linux)
    CMD = home-manager switch --flake .
else ifeq ($(OS), Darwin)
    CMD = sudo darwin-rebuild switch --flake .
else
    CMD = @echo "OS not supported"
endif

all: stash update build pop

build:
	$(CMD)

update:
	@{ \
		nix flake update; \
		recipe_status=$$?; \
		if [ $$recipe_status -ne 0 ]; then \
			echo "Recipe failed."; \
			exit $$recipe_status; \
		else \
			echo "Recipe succeeded."; \
			if [ -n "$$(git diff --name-only flake.lock)" ]; then \
				git add flake.lock; \
				git commit -m "chore: update flake.lock"; \
			else \
				echo "No changes detected in flake.lock, skipping commit."; \
			fi; \
		fi; \
	}

stash:
	@echo "Stashing changes..."
	@git stash push -m "Pre-nix stash" || { echo "Failed to stash"; exit 1; }

pop:
	@echo "Popping stash..."
	@git stash pop || { echo "Failed to pop stash"; exit 1; }

