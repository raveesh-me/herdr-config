.PHONY: help status capture install check

help: ## Show targets
	@grep -E '^[a-z-]+:.*## ' $(MAKEFILE_LIST) | awk -F':.*## ' '{printf "  %-10s %s\n", $$1, $$2}'

status: ## What differs between this repo and ~/.config/herdr-app
	@bin/herdr-sync status

capture: ## Copy live config -> repo (run on a branch, then commit + PR)
	@bin/herdr-sync capture

install: ## Copy repo -> live config (backs up anything it overwrites)
	@bin/herdr-sync install

check: ## herdr-app check every personal mod in this repo
	@set -e; for m in config/mods/*/; do [ -d "$$m" ] || continue; \
	  echo "==> $$m"; herdr-app check "$$HOME/.config/herdr-app/mods/$$(basename $$m)"; done; \
	  echo "mods ok"
