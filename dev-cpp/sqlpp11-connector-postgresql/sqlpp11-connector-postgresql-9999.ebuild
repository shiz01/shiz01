# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="PostgreSQL connector for sqlpp11 library"
HOMEPAGE="https://github.com/matthijs/sqlpp11-connector-postgresql"
EGIT_REPO_URI="https://github.com/matthijs/${PN}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="dev-cpp/date
		dev-cpp/sqlpp11
		dev-db/postgresql"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_prepare() {
	eapply_user

	append-flags -fPIC
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_TESTS=$(usex test)
	)
	cmake_src_configure

}

