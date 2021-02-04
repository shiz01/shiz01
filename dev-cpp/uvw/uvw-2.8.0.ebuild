# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Header-only, event based, tiny and easy to use libuv wrapper in modern C++"
HOMEPAGE="https://github.com/skypjack/uvw"
SRC_URI="https://github.com/skypjack/${PN}/archive/v${PV}_libuv_v1.40.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64"
IUSE="asan libcxx +static-libs test ubsan"

#S="${WORKDIR}/uvw-2.8.0_libuv_v1.40" - full path
#S="${WORKDIR}/${PN}-${PV}_libuv_v1.40" - with env path
#S="${WORKDIR}/${PN}-${PV}" - default path

S+="_libuv_v1.40"

DEPEND=">=dev-libs/libuv-1.40
		<dev-libs/libuv-1.41
		dev-libs/openssl
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-0001-system-libuv.patch"
	"${FILESDIR}/${P}-0002-fix-tests.patch" # one test fails due to incorrect dynamic link library path.
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
		-DUSE_ASAN=$(usex asan)
		-DUSE_UBSAN=$(usex ubsan)
		-DBUILD_TESTING=$(usex test)
	)
	use test && {
		mycmakeargs+=( -DFIND_GTEST_PACKAGE=$(usex test) )
	}

	cmake_src_configure
}


