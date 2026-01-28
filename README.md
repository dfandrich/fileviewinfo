# File View Info

File View Info is a project for extracting metadata about structured files.
It consists of the programs fv, fvi, autodescribe and automtime which display a
list of contents of archives, metadata about files, file descriptions
and file modification times, respectively.

**fv** is a wrapper around the file list functions of most common (and
uncommon) kinds of archivers and packagers available on *NIX systems. It
provides a fast, easy way to look inside archives without having to remember
the arcane options required by many archiving programs.

**fvi** is a wrapper around many file metadata display programs available on
*NIX systems. It provides a quick way to display metadata about a file without
without having to remember which program is the right one to use for each type.

**autodescribe** extracts file titles or descriptions embedded in many types of
structured files. It can be used to build a descriptive index of files or to
help search for specific files.

**automtime** extracts file modification times embedded in many types of
structured files (separate from the modification times stored in the
filesystem). It can be used to update the filesystem modification time to match
that of the file contents.

Want to see what files are in a bzip2-compressed tarball? You could run `tar
tvjf file.tar.bz2` or you could run `fv file.tar.bz2`. Want to see the expiry
date of an X.509 PEM certificate?  You could use `openssl x509 -text -in
cert.pem` or you could use `fvi cert.pem`. Want to see what an oddly-named PDF
is all about? You could run `pdfinfo P003141F.pdf" | grep "^Title:"` or you
could run `autodescribe W0005833X.pdf`. Want your downloaded files to be listed
in your file browser in order of original modification times and not time of
download?  Just run `automtime -m *` and see.

Read their respective man pages for more information about each program,
including a list of the hundreds of supported file types. Most file types can
only be handled using an external program. If you don't have the right one
installed, you'll see a "command not found" (or similar) error message.  View
the source code for pointers to the package you'll need to install to handle
that file type.

## Installation

The latest release is available for download from
https://github.com/dfandrich/fileviewinfo/releases/latest

The programs are written in portable Bourne shell and do not require
compilation, but a makefile is included for easier installation. The makefile
relies on some GNUisms, however, and requires the use of GNU make (sometimes
called "gmake").  Most file formats also require an external helper program to
parse each file type. Systems without GNU date installed will use a fallback
date parsing utility that requires the Python dateutil and pytz modules.

Install the scripts and documentation by running this command as root:

    make install

You can execute a simple regression test suite with:

    env LC_ALL=C make check -k

Any differences between the expected and generated output will be displayed.
If a needed external program is missing, the test will fail. Some test runs
show "Not a known file type" or "No comment found" which is normal, since not
all file types are supported by all programs being tested.  The test suite is
sensitive to the locale and will fail in some non-English locales due to some
language-specific output, hence the LC_ALL setting above. The programs
themselves should run fine in any locale, however.

## Development

The project home is at https://github.com/dfandrich/fileviewinfo/  Report bugs
or issues there, or submit pull requests to support new file types.

[![Download](https://img.shields.io/github/v/release/dfandrich/fileviewinfo?sort=semver)](https://github.com/dfandrich/fileviewinfo/releases/latest)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/license/mit/)
[![Github Actions Build Status](https://github.com/dfandrich/fileviewinfo/actions/workflows/ci.yml/badge.svg?branch=master)](https://github.com/dfandrich/fileviewinfo/actions?query=workflow%3A%22CI%22)

## Author

Copyright © 2003–2025 Dan Fandrich <dan@coneharvesters.com>
Licensed under the MIT license (see the file [LICENSE](LICENSE) for details)
with the exception of the files in testfiles/ which are hereby dedicated to the
public domain (in jurisdictions where such a dedication is not possible, the
MIT license applies).
