# stow flags (--target, --verbose) come from .stowrc

# every top-level directory is a package, except the unstowed junk in old/
PACKAGES := $(filter-out old/,$(wildcard */))

.PHONY: all check delete submodules

all: submodules
	stow --restow $(PACKAGES)

check:
	stow --no --restow $(PACKAGES)

delete:
	stow --delete $(PACKAGES)

# only initialize missing submodules; never reset ones already checked out
submodules:
	@if git submodule status --recursive | grep -q '^-'; then \
		git submodule update --init --recursive; \
	fi
