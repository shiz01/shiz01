# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake-utils

DESCRIPTION="Modern C++ Apache Kafka client library (wrapper for librdkafka)"
HOMEPAGE="https://github.com/mfontanini/cppkafka"
SRC_URI="https://github.com/mfontanini/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+boost examples lz4 sasl ssl static test zstd"
RESTRICT="!test? ( test )"

DEPEND=">=dev-libs/librdkafka-0.9.4
		>=dev-libs/boost-1.55
		lz4? ( dev-libs/librdkafka[lz4] )
		sasl? ( dev-libs/librdkafka[sasl] )
		ssl? ( dev-libs/librdkafka[ssl] )
		static? ( dev-libs/boost[static-libs] dev-libs/librdkafka[static-libs] )
		zstd? ( dev-libs/librdkafka[zstd] )
"

RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
	-DCPPKAFKA_BUILD_SHARED=ON
	-DCPPKAFKA_DISABLE_TESTS=$(usex !test)
	-DCPPKAFKA_DISABLE_EXAMPLES=$(usex !examples)
	-DCPPKAFKA_BOOST_STATIC_LIBS=$(usex static)
	-DCPPKAFKA_BOOST_USE_MULTITHREADED=$(usex boost)
	-DCPPKAFKA_RDKAFKA_STATIC_LIB=$(usex static)

	)

	cmake-utils_src_configure
}

src_install() {
	DESTDIR=${D} cmake-utils_src_install
	mv "${ED}/usr/lib" "${ED}/usr/$(get_libdir)"
}

