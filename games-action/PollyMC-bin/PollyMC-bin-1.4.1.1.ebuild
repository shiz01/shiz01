# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

_short_name="PollyMC"
DESCRIPTION="Fork of PolyMC that adds Ely.by support and allows you to use offline mode"
HOMEPAGE="https://github.com/fn2006/PollyMC"
SRC_URI="https://github.com/fn2006/${_short_name}/releases/download/${PV}/${_short_name}-Linux-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtchooser
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	dev-qt/qtgui:5
	kde-frameworks/extra-cmake-modules
	dev-util/cmake
	sys-libs/zlib
	virtual/jdk
	media-libs/libglvnd
	media-libs/mesa
	media-libs/libpng
"

src_unpack() {
	unpack ${A};
	mkdir -p "${S}/${P}"
}

#src_prepare() {
#	eapply_user
#}

src_configure() {
	:
}
src_compile() {
	:
}
src_test() {
	:
	elog "Not supported for binary package."
}

src_install() {
	mkdir ${ED}/usr -vp
	cp -rv ${WORKDIR}/bin ${ED}/usr/bin
	cp -rv ${WORKDIR}/share ${ED}/usr/share
}
