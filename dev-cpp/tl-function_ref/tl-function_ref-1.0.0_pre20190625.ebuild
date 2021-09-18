# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3 cmake

DESCRIPTION="A lightweight, non-owning reference to a callable."
HOMEPAGE="https://github.com/TartanLlama/function_ref"
EGIT_REPO_URI="https://github.com/TartanLlama/function_ref"
EGIT_COMMIT="556c2c3fbfc144971c01ba6d177aaab48cab6870"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64 ~arm"
IUSE="test"

PATCHES=(
	"${FILESDIR}/${P}-0001-fix-build-remove-fetch-content.patch"
)

src_prepare() {
	eapply_user
	append-flags -fPIC
	cp ${FILESDIR}/${P}-add-tl.cmake ${S}/add-tl.cmake -v
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DFUNCTION_REF_ENABLE_TESTS=$(usex test)
	)
	#use test && mycmakeargs+=( -DFORCE_SYSTEM_CATCH=ON )
	cmake_src_configure
}

