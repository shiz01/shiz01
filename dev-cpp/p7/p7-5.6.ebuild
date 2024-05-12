# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="P7 is cross-platform library for high-speed sending telemetry and logs"
HOMEPAGE="https://baical.net/p7.html"
SRC_URI="https://baical.net/files/libP7Client_v${PV}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

IUSE="examples +shared test"

src_unpack() {
	mkdir -p ${S}
	pushd ${S}
	unpack ${A}
	popd
}

src_prepare() {
	eapply_user
	sed -i "s/DESTINATION\ lib/DESTINATION\ $(get_libdir)/" ${S}/Sources/CMakeLists.txt
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DP7_TESTS_BUILD=$(usex test)
		-DP7_EXAMPLES_BUILD=$(usex examples)
		-DP7_BUILD_SHARED=$(usex shared)
	)

	cmake_src_configure
}

src_install(){
	cmake_src_install
	dodoc ${S}/Documentation/*
	use examples && dodoc -r ${S}/Examples

	local incdir="/usr/include/${PN}"
	dodir ${incdir};
	insinto ${incdir};
	doins ${S}/Headers/*.h
}
