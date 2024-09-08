SRC_DIR := $(CURDIR)
DEST_DIR := $(SRC_DIR)/examples

DIRS := $(shell find . -maxdepth 1 -type d ! -name ".*" ! -name "examples")

.PHONY: all clean $(DEST_DIR) $(DIRS)

$(DIRS): %:
	@echo "Building template $@"
	$(MAKE) build-dir DIR=$@

$(DEST_DIR):
	@echo "Creating destination directory $(DEST_DIR)"
	mkdir -p $(DEST_DIR)

all: $(DEST_DIR) $(DIRS) clean

build-dir:
	@echo "Building main.tex in $(DIR)"
	@cd $(DIR) && if [ -f main.tex ]; then \
		pdflatex main.tex; \
		PDF_NAME=$(notdir $(DIR))-example.pdf; \
		mv main.pdf $$PDF_NAME; \
		echo "Copying $$PDF_NAME to $(DEST_DIR)"; \
		mv $$PDF_NAME $(DEST_DIR); \
	else \
		echo "No main.tex found in $(DIR)"; \
	fi

clean:
	@echo "Cleaning up generated files"
	rm -f **/*.aux **/*.log **/*.out