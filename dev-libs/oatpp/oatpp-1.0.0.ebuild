# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Modern Web Framework for C++."
HOMEPAGE="https://github.com/oatpp/oatpp"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="no-thread_local shared test"
RESTRICT="!test? ( test )"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	eapply_user
	append-flags -fPIC
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=$(usex shared)
		-DOATPP_BUILD_TESTS=$(usex test)
		-DOATPP_COMPAT_BUILD_NO_THREAD_LOCAL=$(usex no-thread_local)
		)

	cmake_src_configure
}


