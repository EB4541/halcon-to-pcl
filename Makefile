ADOC ?= asciidoctor
ADOC_FLAGS += --failure-level WARN -a source-highlighter@=rouge -a idprefix=@ -a toc@=left -a toclevels@=3 -a docinfo@=shared -a stem@=latexmath

TARGETS = index.html
SRCS := $(shell find . -name \*.adoc -printf '%P\n') docinfo.html

.DELETE_ON_ERROR:

.PHONY: all clean watch
all: $(TARGETS)

index.html: $(SRCS)
	$(ADOC) $(ADOC_FLAGS) index.adoc --out-file $@

clean:
	rm -rf $(TARGETS)

MAKEFLAGS += --no-print-directory
watch:
	while true; do $(MAKE) -q || $(MAKE); sleep 1; done
