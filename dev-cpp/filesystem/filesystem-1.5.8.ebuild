# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="An implementation of C++17 std::filesystem for C++11/C++14/C++17/C++20"
HOMEPAGE="https://github.com/gulrak/filesystem"
SRC_URI="https://github.com/gulrak/filesystem/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

LICENSE="MIT"
SLOT="0"
IUSE="examples test"
RESTRICT="!test? ( test )"


src_configure() {
	local mycmakeargs=(
		-DGHC_FILESYSTEM_BUILD_TESTING=$(usex test)
		-DGHC_FILESYSTEM_BUILD_EXAMPLES=$(usex examples)
	)

	cmake_src_configure
}

