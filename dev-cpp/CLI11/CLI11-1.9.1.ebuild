# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="CLI11 is a command line parser for C++11 and beyond..."
HOMEPAGE="https://github.com/CLIUtils/CLI11"
SRC_URI="https://github.com/CLIUtils/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CLI11"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

src_configure() {
	local mycmakeargs=(
		-DCLI11_BUILD_DOCS=$(usex doc)
		-DCLI11_BUILD_TESTS=$(usex test)
	)

	cmake_src_configure
}

