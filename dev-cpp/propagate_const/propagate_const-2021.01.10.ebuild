# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="A const-propagating member-pointer-wrapper for the C++ standard library."
HOMEPAGE="https://github.com/jbcoe/propagate_const"
EGIT_REPO_URI="https://github.com/jbcoe/propagate_const"
EGIT_COMMIT="672cdbcd27028f8985dc7a559a085e530ac4656b"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="test"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
	)
	cmake_src_configure
}

