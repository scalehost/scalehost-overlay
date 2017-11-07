# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MODULE_AUTHOR=MACGYVER
MODULE_VERSION=1.1
inherit perl-module

DESCRIPTION="A native Perl SMTP Server implementation for Perl"

SLOT="0"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	virtual/perl-File-Spec
	virtual/perl-IO
"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"

SRC_TEST="do parallel"

