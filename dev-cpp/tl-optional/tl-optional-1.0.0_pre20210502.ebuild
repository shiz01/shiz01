# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3 cmake

DESCRIPTION="C++11/14/17 std::optional with functional-style extensions and reference support"
HOMEPAGE="https://github.com/TartanLlama/optional"
EGIT_REPO_URI="https://github.com/TartanLlama/optional"
EGIT_COMMIT="c28fcf74d207fc667c4ed3dbae4c251ea551c8c1"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64 ~arm"
IUSE="test"

src_configure() {
	local mycmakeargs=(
		-DOPTIONAL_BUILD_TESTS=$(usex test)
	)
	#use test && mycmakeargs+=( -DFORCE_SYSTEM_CATCH=ON )
	cmake_src_configure
}

