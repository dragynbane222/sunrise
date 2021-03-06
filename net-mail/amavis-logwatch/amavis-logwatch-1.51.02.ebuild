# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="A log analyzer for amavisd-new"
HOMEPAGE="http://logreporters.sourceforge.net/"
SRC_URI="mirror://sourceforge/logreporters/${P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="logwatch"

RDEPEND="dev-lang/perl"

src_prepare() {
	epatch "${FILESDIR}/default_config_location.patch"
}

src_compile() {
	# The default make target just outputs instructions. We don't want
	# the user to see these, so we avoid emake.
	:
}

src_install() {
	# There are two different "versions" of the package in the
	# tarball: a standalone executable and a logwatch filter. The
	# standalone is always installed. However, the logwatch filter is
	# only installed with USE="logwatch".
	dodoc Bugs Changes README
	doman ${PN}.1
	dobin ${PN}
	insinto /etc
	doins ${PN}.conf

	if use logwatch; then
		# Remove the taint mode (-T) switch from the header of the
		# standalone executable, and save the result as our logwatch
		# filter.
		sed 's~^#!/usr/bin/perl -T$~#!/usr/bin/perl~' ${PN} > amavis \
			|| die "failed to remove the perl taint switch"

		insinto /etc/logwatch/scripts/services
		doins amavis

		insinto /etc/logwatch/conf/services
		newins ${PN}.conf amavis.conf
	fi
}
