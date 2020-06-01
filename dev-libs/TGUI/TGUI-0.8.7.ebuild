# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="An easy to use cross-platform c++ GUI for SFML"
HOMEPAGE="https://github.com/texus/TGUI"
SRC_URI="https://github.com/texus/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples static test"

DEPEND=">=media-libs/libsfml-2.5"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_prepare() {
	eapply_user

	append-flags -fPIC
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=( 
		-DTGUI_BUILD_GUI_BUILDER=OFF
		-DTGUI_BUILD_DOC=$(usex doc)
		-DTGUI_BUILD_EXAMPLES=$(usex examples)
		-DTGUI_SHARED_LIBS=$(usex !static)
)
	#use test && mycmakeargs+=( -DCMAKE_BUILD_TYPE=DEBUG )

	cmake-utils_src_configure
}

