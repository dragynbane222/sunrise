# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs

DESCRIPTION="A system-wide notification wrapper for notify-send"
HOMEPAGE="http://github.com/mgorny/sw-notify-send/"
SRC_URI="http://github.com/downloads/mgorny/${PN}/${P}.c.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-process/procps"
RDEPEND="${DEPEND}"

# The lack of x11-libs/libnotify RDEPEND is intentional. The tool supports
# calling 'notify-send' from within a chroot running libnotify-enabled system
# where the host system is libnotify-free. Not to mention that running
# a libnotify notification daemon implies having libnotify installed.

src_compile() {
	tc-export CC
	emake LDLIBS=-lproc ${P} || die
}

src_install() {
	newbin ${P} ${PN} || die
}
