# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils git-r3

DESCRIPTION="C++ header only library purposed to create pool of some resources."
HOMEPAGE="https://github.com/elsid/resource_pool"
EGIT_REPO_URI="https://github.com/elsid/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="examples test"

DEPEND="dev-libs/boost"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"


src_prepare() {
	eapply_user

	append-flags -fPIC
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DRESOURCE_POOL_BUILD_EXAMPLES=$(usex examples)
		-DRESOURCE_POOL_BUILD_TESTS=$(usex test)
		-DRESOURCE_POOL_BUILD_BENCHMARKS=OFF
	)

	cmake-utils_src_configure
}

src_test() {
	cmake-utils_src_test
}

src_install() {
	cmake-utils_src_install
}

