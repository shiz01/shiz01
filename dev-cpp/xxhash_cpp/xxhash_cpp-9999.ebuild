# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Port of the xxhash library to C++17."
HOMEPAGE="https://github.com/RedSpah/xxhash_cpp"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	KEYWORDS=""
	EGIT_BRANCH="master"
	EGIT_REPO_URI="https://github.com/RedSpah/xxhash_cpp"
fi

LICENSE="BSD-2"
SLOT="0"
IUSE="test"

DEPEND=">=dev-libs/xxhash-0.7.3"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"


src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
	)
	cmake-utils_src_configure
}

