# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="A userspace filesystem to mount your iPod into a
directory for easy browsing"
HOMEPAGE="http://sourceforge.net/projects/fusepod"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-fs/fuse
	media-libs/libgpod
	media-libs/taglib"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-additional-headers.patch"
	epatch "${FILESDIR}/${P}-64bit-fixes.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README THANKS TODO
}
