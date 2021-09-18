# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="C++ header only library purposed to create pool of some resources."
HOMEPAGE="https://github.com/elsid/resource_pool"
EGIT_REPO_URI="https://github.com/elsid/${PN}.git"
EGIT_COMMIT="3ea1f95fecc9ce28e66bbbc2a36c1e0142551ab6"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~arm ~x86"
IUSE="examples test"

DEPEND="dev-libs/boost"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_prepare() {
	eapply_user

	append-flags -fPIC
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DRESOURCE_POOL_BUILD_EXAMPLES=$(usex examples)
		-DRESOURCE_POOL_BUILD_TESTS=$(usex test)
		-DRESOURCE_POOL_BUILD_BENCHMARKS=OFF
	)

	cmake_src_configure
}

