# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A transparent application input fuzzer."
HOMEPAGE="http://sam.zoy.org/zzuf/"
SRC_URI="http://sam.zoy.org/zzuf/${P}.tar.gz"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	sed -i -e '/^SUBDIRS/ s/test//' "${S}"/Makefile.in || die "sed failed."
}

src_test() {
	cd test
	emake || die "emake failed."
	sh ./testsuite.sh || die "testsuite failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
