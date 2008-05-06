# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit perl-module

DESCRIPTION="ack is a tool like grep, aimed at programmers with large trees of
heterogeneous source code"
HOMEPAGE="http://www.petdance.com/ack/"
SRC_URI="mirror://cpan/authors/id/P/PE/PETDANCE/${P}.tar.gz"


IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86"

DEPEND=">=dev-perl/File-Next-1.02
	dev-lang/perl"
