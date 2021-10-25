ADOC ?= asciidoctor
ADOC_FLAGS += --failure-level WARN \
	-a source-highlighter@=rouge \
	-a icons@=font \
	-a idprefix=@ \
	-a toc@=left \
	-a toclevels@=3 \
	-a docinfo@=shared \
	-a stem@=latexmath

TARGETS = index.html print.html
SRCS := $(shell find . -name \*.adoc -printf '%P\n') docinfo.html

.DELETE_ON_ERROR:

.PHONY: all clean watch
default: index.html
all: $(TARGETS)

index.html: $(SRCS)
	$(ADOC) $(ADOC_FLAGS) index.adoc --out-file $@

print.html: $(SRCS)
	$(ADOC) $(subst toc@=left,toc@=auto,$(ADOC_FLAGS)) -a !last-update-label@ index.adoc --out-file $@

clean:
	rm -rf $(TARGETS)

MAKEFLAGS += --no-print-directory
watch:
	while true; do $(MAKE) -q || $(MAKE); sleep 1; done
