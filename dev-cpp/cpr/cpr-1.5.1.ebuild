# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="C++ Requests: Curl for People, a spiritual port of Python Requests."
HOMEPAGE="https://whoshuu.github.io/cpr"
SRC_URI="https://github.com/whoshuu/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test +ssl winssl"

DEPEND="net-misc/curl
		ssl? (
			!libressl? ( dev-libs/openssl:0= )
			libressl? ( dev-libs/libressl:0= )
) "

RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}
		test? ( dev-cpp/gtest )
"

src_prepare() {
	eapply_user
	append-flags -fPIC
	cmake-utils_src_prepare
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

	cmake-utils_src_configure
}

src_install() {

	DESTDIR=${D} cmake-utils_src_install
	mkdir -p "${ED}/usr/$(get_libdir)/cmake"
	cp "${WORKDIR}/${P}/cpr-config.cmake" "${ED}/usr/$(get_libdir)/cmake/"

}

