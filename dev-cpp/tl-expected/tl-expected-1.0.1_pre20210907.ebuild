# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3 cmake

DESCRIPTION="C++11/14/17 std::expected with functional-style extensions"
HOMEPAGE="https://github.com/TartanLlama/expected"
EGIT_REPO_URI="https://github.com/TartanLlama/expected"
EGIT_COMMIT="96d547c03d2feab8db64c53c3744a9b4a7c8f2c5"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64 ~arm"
IUSE="test"

src_configure() {
	local mycmakeargs=(
		-DEXPECTED_BUILD_TESTS=$(usex test)
	)
	#use test && mycmakeargs+=( -DFORCE_SYSTEM_CATCH=ON )
	cmake_src_configure
}

