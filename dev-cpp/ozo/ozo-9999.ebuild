# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="OZO is a C++17 header-only library for asyncronous communication with PostgreSQL"
HOMEPAGE="https://github.com/yandex/ozo"
EGIT_REPO_URI="https://github.com/yandex/${PN}"

LICENSE="POSTGRESQL"
SLOT="0"
KEYWORDS=""

IUSE="examples test"
RESTRICT="!test? ( test )"

DEPEND="dev-libs/boost
		dev-cpp/resource_pool"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"


src_prepare() {
	eapply_user

	use examples && append-flags "-Wno-error=pedantic"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DOZO_BUILD_TESTS=$(usex test)
		-DOZO_BUILD_EXAMPLES=$(usex examples)
	)

	cmake_src_configure
}



