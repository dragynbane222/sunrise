# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="Utilities for Gentoo repository and overlay development"
HOMEPAGE="http://gentooexperimental.org/~shillelagh/"
SRC_URI="http://dev.gentooexperimental.org/~tommy/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-util/subversion
	>=sys-apps/portage-2.1"

src_install() {
	dobin sunrise-commit echangelog-tng || die "dobin failed"
	doman sunrise-commit.1 || die "doman failed"
}