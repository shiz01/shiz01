# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils toolchain-funcs

DESCRIPTION="Parsing gigabytes of JSON per second."
HOMEPAGE="https://simdjson.org/"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+exceptions fuzzing neon sanitize static +threads"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	eapply_user
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
	-DSIMDJSON_ENABLE_THREADS=$(usex threads)
	-DSIMDJSON_EXCEPTIONS=$(usex exceptions)
	-DSIMDJSON_BUILD_STATIC=$(usex static)
	-DSIMDJSON_SANITIZE=$(usex sanitize)
	-DENABLE_FUZZING=$(usex fuzzing)
	-DSIMDJSON_IMPLEMENTATION_ARM64=$(usex neon)

	)
	cmake-utils_src_configure
}

multilib_src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}

