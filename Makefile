# $Id: Makefile,v 1.5 2011/06/21 00:25:38 dan Exp $
# Makefile for installing fv
#
# $Log: Makefile,v $
# Revision 1.5  2011/06/21 00:25:38  dan
# Added fvi
#
# Revision 1.4  2008/07/08 18:34:19  dan
# Changed man page link base URL
#
# Revision 1.3  2005/12/22 06:33:53  dan
# Makefile now gets the version number from fv itself.
#
# Revision 1.2  2005/02/03 05:46:51  dan
# Make dependencies for dist target. Bumped version to 1.2
#
# Revision 1.1  2003/04/02 07:22:35  dan
# Initial revision.
#

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
	nroff -man $^ > $@

fv.html: fv.man
	#man2html -topm 5 -compress -cgiurl 'http://www.linux.com/develop/man/$${section}/$${title}/' < $^ > $@
	man2html -topm 5 -compress -seealso -cgiurl 'http://www.mediacollege.com/cgi-bin/man/page.cgi?topic=$${title}' < $^ > $@
	#txt2html --linkonly < $@ > fv.tmp && mv -f fv.tmp $@
	#-tidy -m $@

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

