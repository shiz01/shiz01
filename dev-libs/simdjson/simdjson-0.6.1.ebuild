# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake toolchain-funcs

DESCRIPTION="Parsing gigabytes of JSON per second."
HOMEPAGE="https://simdjson.org/"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+exceptions neon sanitize static-libs +threads"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	eapply_user

	append-flags -fPIC
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
	-DSIMDJSON_ENABLE_THREADS=$(usex threads)
	-DSIMDJSON_EXCEPTIONS=$(usex exceptions)
	-DSIMDJSON_BUILD_STATIC=$(usex static-libs)
	-DSIMDJSON_SANITIZE=$(usex sanitize)
	-DSIMDJSON_IMPLEMENTATION_ARM64=$(usex neon)

	)
	cmake_src_configure
}

