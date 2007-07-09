# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Java-based Getting Things Done (GTD) application"
HOMEPAGE="http://thinkingrock.com.au/"
SRC_URI="http://mesh.dl.sourceforge.net/sourceforge/thinkingrock/tr-2.0.epsilon.zip"

LICENSE="CDDL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5.0"
DEPEND="${DEPEND}
	app-arch/unzip"

S=${WORKDIR}/tr-2.0.epsilon

src_install() {
	local installDir=/opt/thinking-rock-2.0epsilon

	insinto /opt
	doins -r "${S}"
	fperms a+rx ${installDir}/bin/thinkingrock ${installDir}/bin/xdg-email ${installDir}/bin/xdg-open
	# Symlink the wrapper script
	dosym ${installDir}/bin/thinkingrock /usr/bin/thinkingrock
	# Symlink the directory and the jar to have them without version number
	dosym ${installDir} /opt/${PN}
	insinto /usr/share/pixmaps
	newins thinkingrock/resource/images/logo.png thinking-rock.png
	insinto /usr/share/applications
	newins "${FILESDIR}"/thinking-rock-2.0.desktop thinking-rock.desktop
}

