# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="A C++ library of Concurrent Data Structures."
HOMEPAGE="https://github.com/khizmax/libcds"
SRC_URI="https://github.com/khizmax/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSL-1.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE="asan boost coverage tsan test unit_test strees_test"
RESTRICT="!test? ( test )"
REQUIRED_USE="
	unit_test? ( test )
	strees_test? ( test )
"

DEPEND="boost? ( dev-libs/boost )"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"


src_configure() {
	local mycmakeargs=(
		-DWITH_BOOST_ATOMIC=$(usex boost)
		-DWITH_ASAN=$(usex asan)
		-DWITH_TSAN=$(usex tsan)
		-DWITH_TESTS=$(usex test)
		-DWITH_TESTS_COVERAGE=$(usex coverage)
		-DENABLE_UNIT_TEST=$(usex unit_test)
		-DENABLE_STRESS_TEST=$(usex strees_test)
	)

	cmake-utils_src_configure
}



