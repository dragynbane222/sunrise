# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit eutils qt3

DESCRIPTION="BSCommander is a Qt based file manager"
HOMEPAGE="http://www.beesoft.org/index.php?id=bsc"
SRC_URI="http://www.beesoft.org/download/${PN}_${PV}_src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND=">=x11-libs/qt-3.3:3
	x11-libs/libX11
	x11-libs/libXext"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_compile() {
	eqmake3 bsc.pro -o Makefile
	emake || die "make failed"
}

src_install() {
	dobin ${PN} || die "dobin failed"

	insinto /usr/share/${PN}/images
	doins images/* || die "doins failed"

	insinto /usr/share/${PN}/lang
	doins *.qm || die "doins failed"

	newicon BeesoftCommander.png ${PN}.png
	make_desktop_entry ${PN} BSCommander ${PN}.png "FileManager;Utility;Qt"

	dodoc ChangeLog.txt
}
