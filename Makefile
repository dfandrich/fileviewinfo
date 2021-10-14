# Makefile for installing fileviewinfo
# Placed into the public domain by Dan Fandrich <dan@coneharvesters.com>
# See the file COPYING for details of how CC0 applies to this file.

prefix=/usr
bindir=$(prefix)/bin
datadir=$(prefix)/share
mandir=$(datadir)/man

VERSION=$(shell ./fv -\? | sed -n '1s/^.*ver. //p')
SOURCES = fv fvi autodescribe fv.1 fvi.1 autodescribe.1
DISTFILES = $(SOURCES) Makefile README.md COPYING .gitignore
CLEAN_FILES = fv.man fv.html fvi.man fvi.html autodescribe.man autodescribe.html test-autodescribe.log test-fv.log test-time.tmp

all:
	@echo Use \'make prefix=/usr/local install\' to install fileviewinfo $(VERSION) in the given
	@echo directory root or \'make dist\' to create a distribution archive.
	@echo Use \'make man\' to generate text and HTML versions of the man pages.

clean:
	-rm -f $(CLEAN_FILES)

man: fv.man fv.html fvi.man fvi.html autodescribe.man autodescribe.html

%.man: %.1
	# This will output a man page with a charset for the current locale
	nroff -man -c $^ > $@

%.html: %.man
	# This is the man2html from https://www.nongnu.org/man2html/
	man2html -topm 5 -compress -seealso -cgiurl 'https://linux.die.net/man/$${section}/$${title}' < $^ > $@
	# These are alternate conversion programs
	#txt2html --linkonly < $@ > fv.tmp && mv -f fv.tmp $@ && tidy -m $@
	#groff -man -Thtml < $^ > $@

check: check-autodescribe check-fv

check-autodescribe:
	./autodescribe testfiles/* >test-autodescribe.log
	diff test-autodescribe-expected test-autodescribe.log

# Only check the file types that have significant processing in fv. Trying to
# check all file types isn't done for several reasons:
# - there are too many dependencies that would need to be satisfied to test
#   them all
# - there would likely be many small changes in output in the various programs
#   over time that would mean a test failure would often be a false negative
# - using existing sample files (especially package files) is only possible
#   if their licenses were compatible (exiting files also often quite large
#   which would add some hardship in using this otherwise lean project)
check-fv:
	# fv needs a known time for this file for consistent output. Save the
	# current time in a temp file and restore it at the end of the test.
	touch -r testfiles/type1.bz2 test-time.tmp
	touch -t 202110111213.14 testfiles/type1.bz2
	./fv testfiles/*.{bz2,rz,shar} >test-fv.log
	touch -r test-time.tmp testfiles/type1.bz2
	rm -f test-time.tmp
	diff test-fv-expected test-fv.log

install:
	test -d $(bindir) || install -d $(bindir)
	install -m 0755 fv fvi autodescribe $(bindir)
	test -d $(mandir)/man1 || install -d $(mandir)/man1
	install -m 0644 fv.1 fvi.1 autodescribe.1 $(mandir)/man1

dist: $(DISTFILES)
	test ! -e fileviewinfo-$(VERSION)
	mkdir fileviewinfo-$(VERSION)
	cp -p $(DISTFILES) fileviewinfo-$(VERSION)
	tar -cvf - fileviewinfo-$(VERSION) | gzip > fileviewinfo-$(VERSION).tar.gz
	rm -rf fileviewinfo-$(VERSION)

distclean: clean

