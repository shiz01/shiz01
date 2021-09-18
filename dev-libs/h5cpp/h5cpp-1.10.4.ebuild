# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

PV_SUFFIX="6"

DESCRIPTION="C++17 templates between stl::vector, armadillo, eigen3, other, and HDF5 datasets"
HOMEPAGE="http://h5cpp.org/"
SRC_URI="https://github.com/steven-varga/${PN}/archive/v${PV}-${PV_SUFFIX}.tar.gz -> ${P}-${PV_SUFFIX}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+bridge +examples +mpi test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-libs/libfmt
	sci-libs/hdf5
	sys-libs/zlib
	mpi? ( virtual/mpi )
	bridge? (
		sci-libs/itpp
		dev-cpp/blitz
		dev-libs/boost
		sci-libs/armadillo
		dev-cpp/eigen
		sci-libs/dlib
	)
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}
	test? ( dev-cpp/gtest )
"

S="${S}-${PV_SUFFIX}"

src_configure() {
	local mycmakeargs=(
		-DH5CPP_BUILD_TESTS=$(usex test)
	)

	cmake_src_configure
}

src_install() {
	DESTDIR=${D} cmake_src_install

	if ! use examples ; then
		rm -rf "${ED}/usr/share/h5cpp"
	fi

}


