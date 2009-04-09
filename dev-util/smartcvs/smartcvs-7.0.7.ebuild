# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_PV=${PV//./_}
MY_P=smartcvs-generic-${MY_PV}

DESCRIPTION="SmartCVS"
HOMEPAGE="http://www.syntevo.com/smartcvs/"
SRC_URI="${MY_P}.tar.gz"
SLOT="0"
LICENSE="smartcvs"
KEYWORDS="~amd64 ~x86"

IUSE=""

RESTRICT="fetch"

RDEPEND=">=virtual/jre-1.4.1"

S="${WORKDIR}/${PN}-${MY_PV}"

src_install() {
	insinto /opt/smartcvs
	doins -r *
	fperms +x /opt/smartcvs/bin/smartcvs.sh
	dosym /opt/smartcvs/bin/smartcvs.sh /usr/bin/

	for X in 32 48 64 128
	do
		insinto /usr/share/icons/hicolor/${X}x${X}/apps
		newins "${S}/bin/${PN}-${X}x${X}.png" "${PN}.png"
	done

	make_desktop_entry ${PN}.sh "SmartCVS" ${PN}.png "Development;RevisionControl"
}

pkg_nofetch() {
	einfo "Please download ${MY_P}.tar.gz from:"
	einfo "http://www.syntevo.com/smartcvs/download.html?file=smartcvs%2Fsmartcvs-generic-${MY_PV}.tar.gz"
	einfo "and move/copy to ${DISTDIR}"
}


