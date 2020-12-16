# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# TODO: unbound depends (lz4, gtest, cityhash).

EAPI=7

inherit cmake-utils

DESCRIPTION="C++ client library for ClickHouse"
HOMEPAGE="https://github.com/ClickHouse/clickhouse-cpp"
SRC_URI="https://github.com/ClickHouse/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/0001-fix-include-header-file.patch )

src_prepare() {
	eapply_user
	sed -i "s/DESTINATION\ lib/DESTINATION\ $(get_libdir)/" ${S}/clickhouse/CMakeLists.txt
	append-flags -fPIC
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
	-DBUILD_BENCHMARK=OFF
	-DBUILD_TESTS=$(usex test)
	)

	cmake-utils_src_configure
}

