# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit autotools eutils toolchain-funcs

MY_P="SambaScanner-${PV}"
DESCRIPTION="a tool to search a whole samba network for files"
HOMEPAGE="http://www.johannes-bauer.com/software/sambascanner/"
SRC_URI="http://www.johannes-bauer.com/software/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug linguas_de"

RDEPEND=">=net-fs/samba-3"
DEPEND="${RDEPEND}
	sys-devel/gettext"

S=${WORKDIR}/${MY_P}

src_prepare() {
	if use debug; then
		#prevent configure from completely replacing our CFLAGS
		sed -i \
			-e 's:CFLAGS="-O0 -g -pthread":CFLAGS="${CFLAGS} -g -pthread":' \
			configure.ac || die
		eautoreconf
	fi
}

src_configure() {
	econf CFLAGS="${CFLAGS} -pthread" $(use_enable debug)
}

src_compile() {
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	# sambascanner's make install is broken
	dobin src/sambascanner bin/sambaretrieve src/smblister || die
	insinto /usr/share/${PN}/
	doins -r db || die
	use linguas_de && domo i18n/de.mo
	dodoc AUTHORS ChangeLog README sambascannerrc-example db/db.conf.sample || die
}
