# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="OZO is a C++17 header-only library for asyncronous communication with PostgreSQL"
HOMEPAGE="https://github.com/yandex/ozo"
SRC_URI="https://github.com/yandex/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="POSTGRESQL"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~amd64-linux"

IUSE="examples test"
RESTRICT="!test? ( test )"

DEPEND="dev-libs/boost
		dev-cpp/resource_pool
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"


src_prepare() {
	eapply_user

	use examples && append-flags "-Wno-error=pedantic"

	cmake-utils_src_prepare
}



src_configure() {
	local mycmakeargs=(
		-DOZO_BUILD_TESTS=$(usex test)
		-DOZO_BUILD_EXAMPLES=$(usex examples)
	)

	cmake-utils_src_configure
}



