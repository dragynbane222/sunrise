# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils

DESCRIPTION="Multiple GNOME terminals in one window"
HOMEPAGE="http://www.tenshu.net/terminator/"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${PN}_${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome libnotify"

RDEPEND="gnome? ( dev-python/gnome-python )
	libnotify? ( dev-python/notify-python )
	>=x11-libs/vte-0.16[python]"

S=${WORKDIR}/${PV}

src_prepare() {
	epatch "${FILESDIR}"/${P}-without-icon-cache.patch
	use libnotify || epatch "${FILESDIR}"/${PV}-libnotify.patch
	distutils_src_prepare
}
