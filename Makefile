# Makefile for installing fileviewinfo
# Placed into the public domain by Dan Fandrich <dan@coneharvesters.com>
# See the file COPYING for details of how CC0 applies to this file.
#
# This Makefile relies on some GNU make extensions.

prefix=/usr/local
bindir=$(prefix)/bin
datadir=$(prefix)/share
mandir=$(datadir)/man
SHELL=/bin/sh
NROFFFLAGS=-man -c

VERSION=$(shell ./fv -\? | sed -n '1s/^.*ver. //p')
SOURCES = fv fvi autodescribe automtime fv.1 fvi.1 autodescribe.1 automtime.1
DISTFILES = $(SOURCES) Makefile Makefile-testfiles README.md COPYING \
	.gitignore test-fv-expected test-fvi-expected test-autodescribe-expected \
	test-automtime-expected testfiles/*
DOC_TARGETS = fv.man fv.html fvi.man fvi.html autodescribe.man \
	autodescribe.html automtime.man automtime.html
CLEAN_FILES = $(DOC_TARGETS) test-autodescribe.log test-automtime.log \
	test-fv.log test-fvi.log test-time.tmp

all:
	@echo Use \'make prefix=/usr/local install\' to install fileviewinfo $(VERSION) in the given
	@echo directory root or \'make dist\' to create a distribution archive.
	@echo Use \'make man\' to generate text and HTML versions of the man pages.

clean:
	-rm -f $(CLEAN_FILES)

man: $(DOC_TARGETS)

%.man: %.1
	# This will output a man page with a charset for the current locale
	nroff $(NROFFFLAGS) $^ > $@

%.html: %.man
	# This is the man2html from https://www.nongnu.org/man2html/
	man2html -topm 5 -compress -seealso -cgiurl 'https://linux.die.net/man/$${section}/$${title}' < $^ > $@
	# These are alternate conversion programs
	#txt2html --linkonly < $@ > fv.tmp && mv -f fv.tmp $@ && tidy -m $@
	#groff -man -Thtml < $^ > $@

check: check-autodescribe check-automtime check-fv check-fvi

check-autodescribe:
	$(SHELL) ./autodescribe testfiles/* >test-autodescribe.log
	diff test-autodescribe-expected test-autodescribe.log

check-automtime:
	# Run this in UTC since some output depends on the current time zone and
	# we are comparing to a golden test file
	# Note that some environments will include more accurate times than
	# others, causing some tests to fail. The golden test file was created
	# on a GNU/Linux environment and use the GNU versions of utilities.
	env TZ=UTC $(SHELL) ./automtime testfiles/* >test-automtime.log
	diff test-automtime-expected test-automtime.log

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
	$(SHELL) ./fv $(addprefix testfiles/*., bz2 jffs2 rz shar uue) >test-fv.log
	touch -r test-time.tmp testfiles/type1.bz2
	rm -f test-time.tmp
	diff test-fv-expected test-fv.log

# Only check the file types that have significant processing in fvi.
check-fvi:
	$(SHELL) ./fvi $(addprefix testfiles/*., 3mf 7z amf class gmo po stl tc wacz warc.gz) >test-fvi.log
	diff test-fvi-expected test-fvi.log

install:
	test -d $(bindir) || install -d $(bindir)
	install -m 0755 fv fvi autodescribe automtime $(bindir)
	test -d $(mandir)/man1 || install -d $(mandir)/man1
	install -m 0644 fv.1 fvi.1 autodescribe.1 automtime.1 $(mandir)/man1

dist: $(DISTFILES)
	test ! -e fileviewinfo-$(VERSION)
	mkdir fileviewinfo-$(VERSION)
	cp -p --parents $(DISTFILES) fileviewinfo-$(VERSION)
	tar -cvf - fileviewinfo-$(VERSION) | gzip > fileviewinfo-$(VERSION).tar.gz
	rm -rf fileviewinfo-$(VERSION)

distclean: clean

