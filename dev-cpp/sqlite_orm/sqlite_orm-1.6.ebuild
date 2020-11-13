# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="SQLite ORM light header only library for modern C++"
HOMEPAGE="https://github.com/fnc12/sqlite_orm"
SRC_URI="https://github.com/fnc12/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+c++17 examples test"
RESTRICT="!test? ( test )"

DEPEND="dev-db/sqlite"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_prepare() {
	eapply_user

	if ! use examples; then
		sed -i "s/add_subdirectory(examples)/#add_subdirectory(examples)/" ${S}/CMakeLists.txt
	fi
	if ! use test; then
		sed -i "s/add_subdirectory(dependencies)/#add_subdirectory(dependencies)/" ${S}/CMakeLists.txt
		sed -i "s/include(CTest)/#include(CTest)/" ${S}/CMakeLists.txt
		sed -i "s/add_subdirectory(tests)/#add_subdirectory(tests)/" ${S}/CMakeLists.txt
	fi

	append-flags -fPIC
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DSQLITE_ORM_ENABLE_CXX_17=$(usex c++17)
		)

	cmake-utils_src_configure
}

