# $Id: Makefile,v 1.1 2003/04/02 07:22:35 dan Exp $
# Makefile for installing fv
#
# $Log: Makefile,v $
# Revision 1.1  2003/04/02 07:22:35  dan
# Initial revision.
#

prefix=/usr

VERSION=1.1
SOURCES = fv fv.1
DISTFILES = $(SOURCES) Makefile fv.spec
CLEAN_FILES = fv.man fv.html

all:
	@echo Use \'make prefix=/usr/local install\' to install fv in the given
	@echo directory root or \'make dist\' to create a distribution archive

clean:
	-rm -f $(CLEAN_FILES)

fv.man: fv.1
	nroff -man $^ > $@

fv.html: fv.man
	#man2html -topm 5 -compress -cgiurl 'http://www.linux.com/develop/man/$${section}/$${title}/' < $^ > $@
	man2html -topm 5 -compress -seealso -cgiurl 'http://batboy.fms.indiana.edu/manpages/r/$${title}.$${section}.html' < $^ > $@
	#txt2html --linkonly < $@ > fv.tmp && mv -f fv.tmp $@
	#-tidy -m $@

install:
	test -d $(prefix)/bin || install -d $(prefix)/bin
	test -d $(prefix)/man/man1 || install -d $(prefix)/man/man1
	install fv $(prefix)/bin
	install -m 644 fv.1 $(prefix)/man/man1

dist:
	test ! -e fv-$(VERSION)
	mkdir fv-$(VERSION)
	cp -p $(DISTFILES) fv-$(VERSION)
	tar --gzip -cvf fv-$(VERSION).tar.gz fv-$(VERSION)
	rm -rf fv-$(VERSION)

distclean: clean

