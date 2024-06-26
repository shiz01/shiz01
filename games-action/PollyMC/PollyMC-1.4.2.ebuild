# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Fork of PolyMC that adds Ely.by support and allows you to use offline mode"
HOMEPAGE="https://github.com/fn2006/PollyMC"

# SRC_URI="https://github.com/fn2006/PollyMC/archive/refs/tags/1.4.2.tar.gz"

#SRC_URI="https://github.com/fn2006/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

EGIT_REPO_URI="https://github.com/fn2006/PollyMC"
EGIT_BRANCH="legacy-develop"
EGIT_COMMIT="d2a9dd88db564cf31b600ef2828d7636bffdcb52"


LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="amd64 ~arm64"

IUSE="lto qt6 test"

DEPEND="
	!qt6? ( dev-qt/qtcore:5
		dev-qt/qtnetwork:5
		dev-qt/qtwidgets:5
		dev-qt/qtxml:5
		dev-qt/qtgui:5
	)
	qt6? (
		dev-qt/qtbase:6
		dev-qt/qtbase:6[network]
		dev-qt/qtbase:6[widgets]
		dev-qt/qtbase:6[xml]
		dev-qt/qtbase:6[gui]
	)

	kde-frameworks/extra-cmake-modules
	dev-util/cmake
	sys-libs/zlib
	virtual/jdk
	media-libs/libglvnd
	media-libs/mesa
	media-libs/libpng
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"


src_prepare() {
	eapply_user
	append-flags -fPIC
	cmake_src_prepare
}


src_configure() {
	local mycmakeargs=(
		-DENABLE_LTO=$(usex lto)
		-DNBT_BUILD_SHARED=OFF
		-DNBT_USE_ZLIB=ON
		-DBUILD_TESTING=$(usex test)
		-DCMAKE_INSTALL_PREFIX="/usr"
	)
	use qt6 && mycmakeargs+="-DLauncher_QT_VERSION_MAJOR=6"

	cmake_src_configure
}

