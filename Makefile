.PHONY: compile test clean clean-elc clean-deps

EMACS = emacs
FLAGS =
CASK = cask
SRCS = flycheck-checkbashisms.el
OBJECTS = $(SRCS:.el=.elc)
BATCH = $(EMACS) -Q --batch $(FLAGS)

VERSION := $(shell EMACS=$(EMACS) $(CASK) version)
PKGDIR := $(shell EMACS=$(EMACS) $(CASK) package-directory)

compile: $(OBJECTS)

# Testing
test:
	$(CASK) exec $(BATCH) \
		-l flycheck-checkbashisms.el \
		-l test/flycheck-checkbashisms-test.el \
		-f ert-run-tests-batch-and-exit

$(PKGDIR) : Cask
			$(CASK) install
			touch $(PKGDIR)

%.elc :	%.el $(PKGDIR)
		$(CASK) exec $(BATCH) -f batch-byte-compile $<

# Cleanup
clean-elc:
	rm -rf $(OBJECTS)

clean-dist: ;

clean-deps:
	rm -rf .cask/

clean: clean-elc clean-dist clean-deps
