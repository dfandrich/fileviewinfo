# Makefile for installing fv

prefix=/usr
bindir=$(prefix)/bin
datadir=$(prefix)/share
mandir=$(datadir)/man

VERSION=$(shell ./fv -\? | sed -n '1s/^.*ver. //p')
SOURCES = fv fvi fv.1 fvi.1
DISTFILES = $(SOURCES) Makefile
CLEAN_FILES = fv.man fv.html fvi.man fvi.html

all:
	@echo Use \'make prefix=/usr/local install\' to install fv $(VERSION) in the given
	@echo directory root or \'make dist\' to create a distribution archive.
	@echo Use \'make man\' to generate text and HTML versions of the man pages.

clean:
	-rm -f $(CLEAN_FILES)

man: fv.man fv.html fvi.man fvi.html

%.man: %.1
	# This will output a man page with a charset for the current locale
	nroff -man -c $^ > $@

%.html: %.man
	# This is the man2html from https://www.nongnu.org/man2html/
	man2html -topm 5 -compress -seealso -cgiurl 'https://www.linux.org/docs/man$${section}/$${title}.html' < $^ > $@
	# These are alternate conversion programs
	#txt2html --linkonly < $@ > fv.tmp && mv -f fv.tmp $@ && tidy -m $@
	#groff -man -Thtml < $^ > $@

install:
	test -d $(bindir) || install -d $(bindir)
	install -m 0755 fv fvi $(bindir)
	test -d $(mandir)/man1 || install -d $(mandir)/man1
	install -m 0644 fv.1 fvi.1 $(mandir)/man1

dist: $(DISTFILES)
	test ! -e fv-$(VERSION)
	mkdir fv-$(VERSION)
	cp -p $(DISTFILES) fv-$(VERSION)
	tar --gzip -cvf fv-$(VERSION).tar.gz fv-$(VERSION)
	rm -rf fv-$(VERSION)

distclean: clean

