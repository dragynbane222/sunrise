# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P="PTLensDB"
DESCRIPTION="PTLens profiles for lens calibration to use with clens"
SRC_URI="mirror://sourceforge/hugin/${MY_P}_${PV//./-}.zip"
HOMEPAGE="http://hugin.sf.net/"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
RDEPEND=""

src_install() {
	dodir /usr/share/ptlens/profiles
	insinto /usr/share/ptlens/profiles
	doins ${WORKDIR}/*
}
