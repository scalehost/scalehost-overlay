# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MODULE_AUTHOR=NALOBIN
MODULE_VERSION=2.99010
inherit perl-module

DESCRIPTION="Get Whois information of domains and IP addresses"

SLOT="0"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	virtual/perl-File-Spec
	virtual/perl-IO
	virtual/perl-Carp
	virtual/perl-Exporter
	virtual/perl-Data-Dumper
	virtual/perl-IO-Socket-IP
	dev-perl/libwww-perl
	dev-perl/Net-IDN-Encode
	dev-perl/Regexp-IPv6
"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"

SRC_TEST="do parallel"
