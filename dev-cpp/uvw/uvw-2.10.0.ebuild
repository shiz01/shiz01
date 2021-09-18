# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

libuv_ver="_libuv_v1.42"

DESCRIPTION="Header-only, event based, tiny and easy to use libuv wrapper in modern C++"
HOMEPAGE="https://github.com/skypjack/uvw"
SRC_URI="https://github.com/skypjack/${PN}/archive/v${PV}${libuv_ver}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64"
IUSE="asan libcxx static-libs test ubsan"

S+="${libuv_ver}"

DEPEND=">=dev-libs/libuv-1.42
		<dev-libs/libuv-1.43
		dev-libs/openssl
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

PATCHES=(
	#"${FILESDIR}/${P}-0001-system-libuv.patch"
	#"${FILESDIR}/${P}-0002-fix-tests.patch" # one test fails due to incorrect dynamic link library path.
)


src_prepare() {
	eapply_user
	append-flags -fPIC
	cmake_src_prepare
}

src_configure() {

	local mycmakeargs=( 
		-DUSE_LIBCPP=$(usex libcxx)
		-DBUILD_UVW_LIBS=$(usex static-libs)
		-DBUILD_DOCS=OFF # more bugs
		-DFETCH_LIBUV=OFF # use system libuv
		-DUSE_ASAN=$(usex asan)
		-DUSE_UBSAN=$(usex ubsan)
		-DBUILD_TESTING=$(usex test)
	)
	use test && {
		mycmakeargs+=( -DFIND_GTEST_PACKAGE=$(usex test) )
	}

	cmake_src_configure
}


