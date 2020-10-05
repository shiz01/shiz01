# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils git-r3

DESCRIPTION="A type safe SQL template library for C++"
HOMEPAGE="https://github.com/rbock/sqlpp11"
EGIT_REPO_URI="https://github.com/rbock/${PN}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="dev-cpp/date
		dev-libs/boost"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_prepare() {
	eapply_user

	append-flags -fPIC
	cmake-utils_src_prepare

}

src_configure() {
	local mycmakeargs=(
		-DENABLE_TESTS=$(usex test)
	)
	cmake-utils_src_configure

}

