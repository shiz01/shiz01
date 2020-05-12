# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Parsing gigabytes of JSON per second."
HOMEPAGE="https://simdjson.org/"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+exceptions -sanitize -static +threads"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	eapply_user
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
	)
	if ! use exceptions; then
		mycmakeargs+=( 
			-DSIMDJSON_EXCEPTIONS=OFF )
	fi
	if use static; then
		mycmakeargs+=( 
				-DSIMDJSON_BUILD_STATIC=ON )
	fi
	if use sanitize; then
		mycmakeargs+=( 
		-DSIMDJSON_SANITIZE=ON )
	fi

# -DSIMDJSON_IMPLEMENTATION_ARM64=OFF

	cmake-utils_src_configure
}

multilib_src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}

