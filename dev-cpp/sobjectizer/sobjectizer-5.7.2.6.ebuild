# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C++ Actor framework"
HOMEPAGE="https://stiffstream.com/en/products/sobjectizer.html"
SRC_URI="https://github.com/Stiffstream/${PN}/archive/v.${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-v.${PV}/dev"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples static-libs test"
RESTRICT="!test? ( test )"


src_prepare() {
	eapply_user
	local cmakefile="${S}/so_5/CMakeLists.txt"
	local libdir="$(get_libdir)"
	sed -i "s/__extLibrary\}\ DESTINATION\ lib/__extLibrary\}\ DESTINATION\ \$\{CMAKE_INSTALL_LIBDIR\}/" ${cmakefile}
	sed -i "s/lib\/cmake\/sobjectizer/\${\CMAKE_INSTALL_LIBDIR\}\/cmake\/sobjectizer/" ${cmakefile}
	sed -i "s/LIBRARY\ DESTINATION\ lib/LIBRARY\ DESTINATION\ \$\{CMAKE_INSTALL_LIBDIR\}/" ${cmakefile}
	sed -i "s/ARCHIVE\ DESTINATION\ lib/ARCHIVE\ DESTINATION\ \$\{CMAKE_INSTALL_LIBDIR\}/" ${cmakefile}
	append-flags -fPIC
	cmake_src_prepare
}


src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTS=$(usex test)
		-DBUILD_EXAMPLES=$(usex examples)
		-DSOBJECTIZER_BUILD_STATIC=$(usex static-libs)
		-DSOBJECTIZER_BUILD_SHARED=ON
	)
	cmake_src_configure
}

#src_install() {
#	DESTDIR=${D} cmake_src_install
#	mv "${ED}/usr/lib" "${ED}/usr/$(get_libdir)"
#
#	local path_to_patch="${ED}/usr/$(get_libdir)/cmake/${PN}"
#	local str="s/usr\/lib/usr\/$(get_libdir)/"
#
#	sed -i "${str}" "${path_to_patch}/sobjectizer-targets.cmake"
#	sed -i "${str}" "${path_to_patch}/sobjectizer-config.cmake"
#	sed -i "s/lib\/libso/$(get_libdir)\/libso/" "${path_to_patch}/sobjectizer-targets-gentoo.cmake"
#
#}
#
