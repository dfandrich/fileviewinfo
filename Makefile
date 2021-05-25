# Makefile for installing fv

prefix=/usr

VERSION=$(shell ./fv -\? | sed -n '1s/^.*ver. //p')
SOURCES = fv fvi fv.1
DISTFILES = $(SOURCES) Makefile fv.spec
CLEAN_FILES = fv.man fv.html

all:
	@echo Use \'make prefix=/usr/local install\' to install fv $(VERSION) in the given
	@echo directory root or \'make dist\' to create a distribution archive

clean:
	-rm -f $(CLEAN_FILES)

%.man: %.1
	# This will output a man page with a charset for the current locale
	nroff -man -c $^ > $@

fv.html: fv.man
	# This is the man2html from https://www.nongnu.org/man2html/
	man2html -topm 5 -compress -seealso -cgiurl 'https://www.linux.org/docs/man$${section}/$${title}.html' < $^ > $@
	# These are alternate conversion programs
	#txt2html --linkonly < $@ > fv.tmp && mv -f fv.tmp $@ && tidy -m $@
	#groff -man -Thtml < $^ > $@

install:
	test -d $(prefix)/bin || install -d $(prefix)/bin
	test -d $(prefix)/man/man1 || install -d $(prefix)/man/man1
	install fv $(prefix)/bin
	install -m 644 fv.1 $(prefix)/man/man1

dist: $(DISTFILES)
	test ! -e fv-$(VERSION)
	mkdir fv-$(VERSION)
	cp -p $(DISTFILES) fv-$(VERSION)
	tar --gzip -cvf fv-$(VERSION).tar.gz fv-$(VERSION)
	rm -rf fv-$(VERSION)

distclean: clean

