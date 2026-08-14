FONTS_DIR ?= $(or $(XDG_DATA_HOME),$(HOME)/.local/share)/fonts
FONTS := $(patsubst %,IosevkaCustomNerdFont-%.ttf,Regular Italic Bold BoldItalic)
INSTALLED := $(addprefix $(FONTS_DIR)/IosevkaCustomNerdFont/,$(FONTS))

.PHONY: all install clean
all: out/.build-stamp

out/.build-stamp: build.sh private-build-plans.toml
	./build.sh
	@touch $@

install: $(INSTALLED)

$(INSTALLED) &: out/.build-stamp
	./install.sh "$(FONTS_DIR)"

clean:
	rm -rf out
