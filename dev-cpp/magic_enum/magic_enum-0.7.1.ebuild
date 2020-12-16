# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Static reflection for enums (to string, from string, iteration) for modern C++"
HOMEPAGE="https://github.com/Neargye/magic_enum"
SRC_URI="https://github.com/Neargye/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="examples test"
RESTRICT="!test? ( test )"

src_prepare() {
	eapply_user
	sed -i "s/DESTINATION\ lib/DESTINATION\ $(get_libdir)/" ${S}/CMakeLists.txt
	append-flags -fPIC
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=( 
		-DMAGIC_ENUM_OPT_BUILD_EXAMPLES=$(usex examples)
		-DMAGIC_ENUM_OPT_BUILD_TESTS=$(usex test)
		)

	cmake-utils_src_configure
}

