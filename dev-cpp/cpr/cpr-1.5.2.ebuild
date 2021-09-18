# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C++ Requests: Curl for People, a spiritual port of Python Requests."
HOMEPAGE="https://whoshuu.github.io/cpr"
SRC_URI="https://github.com/whoshuu/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="test +ssl winssl"

DEPEND="net-misc/curl
		ssl? ( dev-libs/openssl:0= )
"

RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}
		test? ( dev-cpp/gtest )
"

PATCHES=("${FILESDIR}/0001-Fix-build-on-Gentoo.patch")


src_prepare() {
	eapply_user
	append-flags -fPIC
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUSE_SYSTEM_CURL=ON
		-DUSE_OPENSSL=$(usex ssl)
		-DBUILD_CPR_TESTS=$(usex test)
		-DBUILD_CPR_TESTS_SSL=$(usex test)
		-DUSE_SYSTEM_GTEST=$(usex test)
		-DGENERATE_COVERAGE=OFF
		-DUSE_WINSSL=$(usex winssl)
	)

	cmake_src_configure
}

src_install() {
	DESTDIR=${D} cmake_src_install
	mkdir -p "${ED}/usr/$(get_libdir)/cmake"
	cp "${WORKDIR}/${P}/cpr-config.cmake" "${ED}/usr/$(get_libdir)/cmake/"
}

