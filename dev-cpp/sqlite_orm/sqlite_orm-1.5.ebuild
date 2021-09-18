# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

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
	if ! use examples ; then
		sed -i "s/add_subdirectory(examples)/#add_subdirectory(examples)/" ${S}/CMakeLists.txt
	fi
	append-flags -fPIC

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DSQLITE_ORM_ENABLE_CXX_17=$(usex c++17)
		-DSqliteOrm_BuildTests=$(usex test)
	)

	cmake_src_configure
}

src_install() {
	DESTDIR=${D} cmake_src_install
	mv "${ED}/usr/lib" "${ED}/usr/$(get_libdir)"

	local work_dir="${ED}/usr/$(get_libdir)/cmake/${PN}"
	local sed_str="s/lib\/cmake\/sqlite_orm/$(get_libdir)\/cmake\/sqlite_orm/"

	sed -i "${sed_str}" "${work_dir}/SqliteOrmConfig.cmake"
	sed -i "${sed_str}" "${work_dir}/SqliteOrmTargets.cmake"
}

