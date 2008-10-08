# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

JAVA_PKG_IUSE="doc source"

ESVN_REPO_URI="https://svn.tigase.org/reps/tigase-server/trunk"

inherit subversion java-pkg-2 eutils

DESCRIPTION="Tigase XMPP server"
HOMEPAGE="http://www.tigase.org"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-java/ant-1.7
	>=dev-java/tigase-xmltools-3.0
	>=dev-java/tigase-utils-3.1
	>=virtual/jdk-1.6.0"

RDEPEND=">=dev-java/tigase-xmltools-3.0
	>=dev-java/tigase-utils-3.1
	>=virtual/jre-1.6.0"

src_unpack() {
	subversion_src_unpack
	cd "${S}"
	ant clean-all

	EPATCH_OPTIONS="--ignore-whitespace"

	#Edit classpaths for ant to fit gentoo way
	epatch "${FILESDIR}/classpaths.patch"

	sed -i -e "s:libs=libs:xmltoolsjar=$(java-pkg_getjar tigase-xmltools tigase-xmltools.jar)\nutilsjar=$(java-pkg_getjar tigase-utils tigase-utils.jar):" build.properties || die "Failed to patch build properties with correct jar locations"

	#Make default config more gentoo'ish
	epatch "${FILESDIR}/default_config.patch"
}

src_compile() {
	ant jar || die "Compile failed"
	if use doc; then
		ant docs || die "Docs failed"
	fi
}

src_install() {
	java-pkg_dojar jars/*.jar

	use doc && java-pkg_dojavadoc docs-tigase-server/api
	use source && java-pkg_dosrc src/main/java/

	newconfd "${FILESDIR}/conf_d_tigase" tigase
	newinitd "${FILESDIR}/init_d_tigase" tigase

	insinto /var/lib/tigase/certificates
	insopts -m0600
	doins certs/*

	dodir /var/log/tigase
	touch "${D}/var/log/tigase/tigase.log"
}

pkg_preinst() {
	enewgroup tigase
	enewuser tigase -1 -1 /dev/null tigase

	fowners -R tigase:tigase /var/lib/tigase
	fowners -R tigase:tigase /var/log/tigase
}

pkg_postinst() {
	sed -i -e "s|CLASSPATH=.*|&:$(java-pkg_getjar tigase-xmltools tigase-xmltools.jar):$(java-pkg_getjar tigase-utils tigase-utils.jar):$(java-pkg_getjar tigase-server tigase-server.jar)|" /etc/conf.d/tigase || die "Failed to configure conf.d file"
	elog "Remember to change config file and conf.d file to your needs."
	elog "Config file is default generated by server is not present."
	elog ""
}
