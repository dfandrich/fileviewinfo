# File View Info

fv and fvi are programs that display the contents of archives and metadata
about files, respectively.

fv is a wrapper around the file list functions of most common (and uncommon)
kinds of archivers and packagers available on *NIX systems. It provides a fast,
easy way to look inside archives without having to remember the arcane options
required by many archiving programs.

fvi is a wrapper around many file metadata display programs available on *NIX
systems. It provides a quick way to display metadata about a file without
without having to remember which program is the right one to use for each type.

Want to see what files are in a bzip2-compressed tarball? You could run `tar
tvjf file.tar.bz2` or you could run `fv file.tar.bz2`. Want to see the expiry
date of an X.509 PEM certificate?  You could use `openssl x509 -text -in
cert.pem` or you could use `fvi cert.pem`.

Read their respective man pages for more information about each program,
including a list of the hundreds of file types supported by each. Most file
types can only be handled using an external program. If you don't have the
right one installed, you'll see a "command not found" (or similar) error
message.  View the fv or fvi source code for a pointer to the package you'll
need to install to handle that file type.

## Installation

The programs are written in portable Bourne shell and do not require
compilation.  Install them by running this command as root:

    make install

## Author

Daniel Fandrich <dan@coneharvesters.com>

The fileviewinfo package is placed into the public domain by Daniel Fandrich.
See the file [COPYING](COPYING) for details of how CC0 applies to this file.
