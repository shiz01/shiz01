# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="mstch is a complete implementation of {{mustache}} templates using modern C++"
HOMEPAGE="https://github.com/no1msd/mstch"
SRC_URI="https://github.com/no1msd/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64 ~arm"
IUSE=""

DEPEND="dev-libs/boost"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_prepare() {
	eapply_user
	sed -i "s/DESTINATION lib/DESTINATION $(get_libdir)/" ${S}/src/CMakeLists.txt
	append-flags -fPIC
	cmake_src_prepare
}


src_configure() {
	local mycmakeargs=(
		-DWITH_UNIT_TESTS=OFF # More depends for tests...
		-DWITH_BENCHMARK=OFF
	)

	cmake_src_configure
}


