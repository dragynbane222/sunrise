# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils subversion autotools

ESVN_REPO_URI="https://libwiimote.svn.sourceforge.net/svnroot/${PN}/branches/ant"
ESVN_PROJECT="libwiimote"

DESCRIPTION="Library to connect to the Nintendo Wii remote (svn snapshot)"
HOMEPAGE="http://libwiimote.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="examples force tilt"

RDEPEND="net-wireless/bluez-libs"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

src_unpack() {
	subversion_src_unpack
	epatch "${FILESDIR}/${P}-ldflags.patch"
	eautoreconf
}

src_compile() {
	econf \
		$(use_enable force) \
		$(use_enable tilt)

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README TODO || die "dodoc failed"

	if use examples; then
		docinto examples
		dodoc test/test?.c || die "dodoc examples failed"
	fi
}
