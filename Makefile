# stow flags (--target, --verbose) come from .stowrc

# every top-level directory is a package, except the unstowed scripts in stuff/
PACKAGES := $(filter-out stuff/,$(wildcard */))

.PHONY: all check delete submodules

all: submodules
	stow --restow $(PACKAGES)
	@$(MAKE) -s --no-print-directory bat-cache

# bat only sees custom themes after `bat cache --build`; rebuild when one changes
BAT_THEMES := $(wildcard bat/.config/bat/themes/*)
BAT_CACHE  := $(shell bat --cache-dir 2>/dev/null)/themes.bin

.PHONY: bat-cache
bat-cache: $(if $(shell command -v bat),$(BAT_CACHE))

$(BAT_CACHE): $(BAT_THEMES)
	bat cache --build

check:
	stow --no --restow $(PACKAGES)

delete:
	stow --delete $(PACKAGES)

# only initialize missing submodules; never reset ones already checked out
submodules:
	@if git submodule status --recursive | grep -q '^-'; then \
		git submodule update --init --recursive; \
	fi
