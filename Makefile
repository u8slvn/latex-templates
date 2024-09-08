SRC_DIR := $(CURDIR)
DEST_DIR := $(SRC_DIR)/examples

DIRS := $(shell find . -maxdepth 1 -type d ! -name ".*" ! -name "examples")

.PHONY: all compile-all $(DEST_DIR) $(DIRS)

$(DIRS): %:
	@echo "Building template $@"
	$(MAKE) compile DIR=$@

$(DEST_DIR):
	@echo "Creating destination directory $(DEST_DIR)"
	mkdir -p $(DEST_DIR)

all: $(DEST_DIR) compile-all

compile-all: $(DIRS)
	@for dir in $(DIRS); do \
		$(MAKE) compile DIR=$$dir; \
	done
	@find . -type f \( -name "*.log" -o -name "*.out" -o -name "*.aux" -o -name "*.toc" \) -exec rm -f {} +

compile:
	@echo "Compiling main.tex in $(DIR)"
	@cd $(DIR) && if [ -f main.tex ]; then \
		pdflatex main.tex; \
		PDF_NAME=$(notdir $(DIR))-example.pdf; \
		mv main.pdf $$PDF_NAME; \
		echo "Copying $$PDF_NAME to $(DEST_DIR)"; \
		mv $$PDF_NAME $(DEST_DIR); \
	else \
		echo "No main.tex found in $(DIR)"; \
	fi
