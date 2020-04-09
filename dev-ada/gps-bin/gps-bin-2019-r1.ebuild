# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
ADA_COMPAT=( gnat_201{8,9} )
inherit ada

MYP=${PN}-gpl-${PV}-src

DESCRIPTION="The GNAT Programming Studio"
HOMEPAGE="http://libre.adacore.com/tools/gps/"
SRC_URI=" https://community.download.adacore.com/v1/0cd3e2a668332613b522d9612ffa27ef3eb0815b?filename=gnat-community-2019-20190517-x86_64-linux-bin -> gnat-community-2019-20190517-x86_64-linux-bin"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="gps "

RDEPEND=""

DEPEND="${RDEPEND}"

REQUIRED_USE="${ADA_REQUIRED_USE}"

RESTRICT="test"

pkg_setup() {
	ada_pkg_setup
}

src_prepare() {
	default
	chmod +x ${S}/gnat-community-2019-20190517-x86_64-linux-bin
	sed ${S}/script.qs /opt/gnat ${S}/opt/gnat

}

src_install() {
	default
	${S}/gnat-community-2019-20190517-x86_64-linux-bin --platform minimal --script ${S}/script.qs
}
