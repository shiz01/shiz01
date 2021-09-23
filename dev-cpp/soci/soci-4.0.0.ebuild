# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="The C++ Database Access Library"
HOMEPAGE="http://soci.sourceforge.net/"
SRC_URI="https://github.com/SOCI/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=Boost-1.0
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="mysql odbc sqlite postgres profile test"
RESTRICT="!test? ( test )"

DEPEND="dev-libs/boost
		mysql? ( virtual/mysql )
		odbc? ( dev-db/unixODBC )
		sqlite? ( dev-db/sqlite )
		postgres? ( dev-db/postgresql )
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"



src_prepare() {
	eapply_user

	append-flags "-fPIC"
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
			-DSOCI_SHARED=ON
			-DSOCI_CXX11=ON
			-DSOCI_STATIC=OFF # tests is fail
			-DSOCI_ASAN=$(usex profile)
			-DSOCI_TESTS=$(usex test)
	)
	cmake_src_configure
}
src_install() {
	DESTDIR=${D} cmake_src_install

	mkdir -p "${ED}/usr/$(get_libdir)/cmake"
	mv "${ED}/usr/cmake/SOCI.cmake" "${ED}/usr/$(get_libdir)/cmake/SOCI.cmake"
	mv "${ED}/usr/cmake/SOCI-gentoo.cmake" "${ED}/usr/$(get_libdir)/cmake/SOCI-gentoo.cmake"
	rm -rf "${ED}/usr/cmake/"
}

