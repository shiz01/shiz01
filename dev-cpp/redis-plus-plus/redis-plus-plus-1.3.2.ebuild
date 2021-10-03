# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Redis client written in C++"
HOMEPAGE="https://github.com/sewenew/redis-plus-plus"
SRC_URI="https://github.com/sewenew/redis-plus-plus/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

IUSE="+boost +libuv +ssl +static-libs +shared test"

DEPEND="dev-libs/hiredis
	ssl? ( dev-libs/openssl )
	libuv? ( dev-libs/libuv )
	boost? ( dev-libs/boost )
"

RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_prepare() {
	eapply_user

	sed -i "s/DESTINATION\ lib/DESTINATION\ $(get_libdir)/" ${S}/CMakeLists.txt
	sed -i "s/lib\/pkgconfig/$(get_libdir)\/pkgconfig/" ${S}/CMakeLists.txt

	append-flags -fPIC
	cmake_src_prepare
}


src_configure() {
	local mycmakeargs=(
		-DREDIS_PLUS_PLUS_USE_TLS=$(usex ssl)
		-DREDIS_PLUS_PLUS_BUILD_STATIC=$(usex static-libs)
		-DREDIS_PLUS_PLUS_BUILD_SHARED=$(usex shared)
		-DREDIS_PLUS_PLUS_BUILD_TEST=$(usex test)
	)
	if use boost; then
		mycmakeargs+=( -DREDIS_PLUS_PLUS_ASYNC_FUTURE=boost );
	fi
	if use libuv; then
		mycmakeargs+=( -DREDIS_PLUS_PLUS_BUILD_ASYNC=libuv );
	fi

	cmake_src_configure
}

