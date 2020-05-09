# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="C/C++ library for manipulating the LAS LiDAR format common in GIS"
HOMEPAGE="https://github.com/libLAS/libLAS/"


if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/libLAS/libLAS/"
else
	SRC_URI="https://github.com/libLAS/libLAS/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64"
fi


SLOT="0"
LICENSE="BSD"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86"
IUSE="gdal"

DEPEND="
	dev-libs/boost:=
	sci-geosciences/laszip
	sci-libs/libgeotiff:=
	gdal? ( sci-libs/gdal:= )
"
RDEPEND="${DEPEND}"

# tests known to fail due to LD_LIBRARY_PATH issue
RESTRICT="test"

src_prepare() {
	use gdal && has_version ">=sci-libs/gdal-2.5.0" && PATCHES+=(
		"${FILESDIR}"/${P}-gdal-2.5.0.patch # bug 707706
	)
	cmake_src_prepare

	# add missing linkage
	sed -e 's:${LAS2COL} ${LIBLAS_C_LIB_NAME}:& ${CMAKE_THREAD_LIBS_INIT}:' \
		-i "${S}/apps/CMakeLists.txt" || die
}

src_configure() {
	local mycmakeargs=(
		-DLIBLAS_LIB_SUBDIR=$(get_libdir)
		-DWITH_GDAL=$(usex gdal)
	)
	cmake_src_configure
}
