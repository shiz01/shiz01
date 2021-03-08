# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Cross-platform, efficient, and asynchronous HTTP/WebSocket server C++14 library."
HOMEPAGE="https://stiffstream.com/en/products/restinio.html"
SRC_URI="https://github.com/Stiffstream/${PN}/archive/v.${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-v.${PV}/dev"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64"
IUSE="+sobjectizer"

DEPEND="net-libs/http-parser
		dev-libs/libfmt
		dev-libs/openssl
		dev-libs/libpcre
		dev-libs/libpcre2
		sys-libs/zlib
		dev-libs/boost
		sobjectizer? ( dev-cpp/sobjectizer )
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
	-DRESTINIO_FIND_DEPS=ON
	-DRESTINIO_SOBJECTIZER_ENABLED=$(usex sobjectizer)
	-DRESTINIO_USE_EXTERNAL_SOBJECTIZER=$(usex sobjectizer)
	-DRESTINIO_USE_EXTERNAL_HTTP_PARSER=ON
	-DRESTINIO_INSTALL_BENCHES=OFF
	-DRESTINIO_BENCH=OFF
	-DRESTINIO_SAMPLE=OFF
	-DRESTINIO_TEST=OFF
	)

	cmake_src_configure
}

