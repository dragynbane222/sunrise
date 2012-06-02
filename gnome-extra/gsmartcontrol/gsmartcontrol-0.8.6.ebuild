# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools eutils gnome2

DESCRIPTION="Graphical user interface for smartctl"
HOMEPAGE="http://gsmartcontrol.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-cpp/gtkmm:2.4
	dev-libs/libpcre
	sys-apps/smartmontools"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

G2CONF="--docdir=/usr/share/doc/${P}"

src_prepare() {
	gnome2_src_prepare
	epatch \
		"${FILESDIR}"/${PV}-fixdocs.patch \
		"${FILESDIR}"/${PV}-gcc47.patch \
		"${FILESDIR}"/${PV}-glib-2.31-mutex.patch
	eautoreconf
}
