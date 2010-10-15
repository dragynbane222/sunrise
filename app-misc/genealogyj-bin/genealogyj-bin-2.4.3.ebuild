# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils java-utils-2

DESCRIPTION="A viewer and editor for genealogic data, written in Java"
HOMEPAGE="http://genj.sf.net/"
SRC_URI="mirror://sourceforge/genj/genj_app-${PV}.zip
	skins? ( mirror://sourceforge/genj/genj_lnf-2.0.zip )
	geoview? ( mirror://sourceforge/genj/genj_geo-${PV}.zip )
	mirror://sourceforge/genj/genj_en-${PV}.zip"

S=${WORKDIR}
LANGS="cs de es fi fr hu nl pl pt_BR ru"
for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
	SRC_URI="${SRC_URI} linguas_${X}? ( mirror://sourceforge/genj/genj_${X}-${PV}.zip )"
done

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="${IUSE} geoview skins"

DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jre-1.4"

pkg_setup() {
	if [ -z "${LINGUAS}" ]; then
		ewarn " To install a localized version, set the according LINGUAS variable(s)."
		ewarn " Default: en (is always installed) "
		ewarn " Supported localizations: cs* de es fi* fr hu* nl* pt_BR* pl* ru*"
		ewarn " (* = Help file in English only. Upstream doesn't have a translation.) "
	fi
}

src_compile() {
	einfo "Binary only installation, no compilation needed."
}

src_install() {
	PROGRAM_DIR=/opt/${PN}

	doexe "${FILESDIR}/genealogyj"

	insinto ${PROGRAM_DIR}
	doins -r *.jar gedcom report help contrib doc lib
	use skins && doins -r lnf

	exeinto ${PROGRAM_DIR}
	doexe run.sh

	java-pkg_regjar "${D}/${PROGRAM_DIR}"/*.jar

	# Necessary to be able to run it as a user:
	#fperms a+rx ${PROGRAM_DIR}/run.sh
}

pkg_postinst() {
	einfo
	einfo "This ebuild does not install the GenealogyJ web applet"
	einfo
}
