# Initial spec file created by autospec ver. 0.8 with rpm 2.4 compatibility
Summary: File viewer, an archive directory lister
Name: fv
%define version 1.1
Version: %{version}
Release: 1
Group: Utilities/Archiving
Copyright: public domain
Source: http://www.npsnet.com/danf/software/pub/fv-%{version}.tar.gz
BuildRoot: /tmp/fv-root
# Following are optional fields
URL: http://www.npsnet.com/danf/software/
Vendor: Dan Fandrich <dan@coneharvesters.com>
#Distribution: Red Hat Contrib-Net
#Patch: fv-%{version}.patch
Prefix: /usr
BuildArchitectures: noarch
#Requires: 
#Obsoletes: 

%description
fv is a wrapper around the file list functions of most common kinds of
archivers and packagers available on *NIX systems. It provides a fast,
easy way to look inside archives without having to remember the arcane
options required by many archiving programs.

%prep
%setup
#%patch

%install
make install prefix="$RPM_BUILD_ROOT"/usr

#%clean
#[ "$RPM_BUILD_ROOT" != "/" ] && rm -rf "$RPM_BUILD_ROOT"

%files
%attr(-,root,root) /usr/bin/fv
%attr(-,root,root) %doc /usr/man/man1/fv.1*

%changelog
* Tue Apr 01 2003 Dan Fandrich <dan@ponderosa>
- Initial spec file created by autospec ver. 0.8 with rpm 2.4 compatibility
