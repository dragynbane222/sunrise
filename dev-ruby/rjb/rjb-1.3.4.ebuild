# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_EXTRADOC="readme.txt ChangeLog"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

inherit java-pkg-2 ruby-ng ruby-fakegem

DESCRIPTION="Rjb is a Ruby-Java software bridge"
HOMEPAGE="http://rjb.rubyforge.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND=">=virtual/jdk-1.5"
RDEPEND=">=virtual/jre-1.5"

pkg_setup() {
	ruby-ng_pkg_setup
	java-pkg-2_pkg_setup
}

each_ruby_prepare() {
	# force compilation of class file for our JVM
	rm -rf data
}

each_ruby_configure() {
	${RUBY} -C ext extconf.rb || die "extconf.rb failed"
}

each_ruby_compile() {
	emake -C ext CFLAGS="${CFLAGS} -fPIC" archflags="${LDFLAGS}" || die "emake failed"
}

each_ruby_install() {
	each_fakegem_install

	# currently no elegant way to do this (bug #352765)
	ruby_fakegem_newins ext/rjbcore.so lib/rjbcore.so

	ruby_fakegem_doins -r data

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r samples || die "installing samples failed"
	fi
}
