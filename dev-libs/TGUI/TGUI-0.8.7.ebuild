# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION=""
HOMEPAGE="https://github.com/texus/TGUI"
SRC_URI="https://github.com/texus/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-doc -examples +gui-builder -static -test"

DEPEND=">=media-libs/libsfml-2.5"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

#S="${WORKDIR}/${PN}-r${PV}"

src_prepare() {
	eapply_user
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=()
	if ! use gui-builder; then
		mycmakeargs+=( 
				-DTGUI_BUILD_GUI_BUILDER=OFF )
	fi
	if use static; then
		mycmakeargs+=( 
				-DTGUI_SHARED_LIBS=FALSE )
	fi
	if use test; then
		mycmakeargs+=( 
				-DTGUI_BUILD_TESTS=TRUE )
	fi

	if use doc; then
		mycmakeargs+=( 
				-DTGUI_BUILD_DOC=TRUE )
	fi
	if use examples; then
		mycmakeargs+=( 
				-DTGUI_BUILD_EXAMPLES=TRUE )
	fi
	cmake-utils_src_configure
}

multilib_src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	dobin "${FILESDIR}/gui-builder-0.8"

	#dosym ${EPREFIX}/usr/share/tgui-0.8/gui-builder/gui-builder usr/bin/gui-builder
	#dosym usr/share/thui-0.8/gui-builder/gui-builder
	#dosym ${EPREFIX}/usr/share/tgui-0.8/gui-builder/gui-builder ${EPREFIX}/usr/bin/gui-builder
}

