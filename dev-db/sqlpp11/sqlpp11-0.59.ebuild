# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="A type safe SQL template library for C++"
HOMEPAGE="https://github.com/rbock/sqlpp11"
SRC_URI="https://github.com/rbock/${PN}/archive/${PN}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="" # none, this is header-only library
RDEPEND=""
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DENABLE_TESTS=$(usex test)
	)
	cmake-utils_src_configure
}

