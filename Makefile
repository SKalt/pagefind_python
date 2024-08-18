.PHONY: all cog
all:
	@echo "Please specify a target to build"

cog:
	./scripts/ci/cog/update.sh
cog-check:
	./scripts/ci/cog/check.sh
