# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake-utils flag-o-matic llvm

DESCRIPTION="Portable Computing Language (an implementation of OpenCL)"
HOMEPAGE="http://portablecl.org"
SRC_URI="https://github.com/pocl/pocl/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cuda debug"

DEPEND=">=sys-devel/llvm-7.0
		<=sys-devel/llvm-11.0
		sys-devel/clang:=
		sys-apps/hwloc[cuda?]
		debug? ( dev-util/lttng-ust )
		dev-libs/ocl-icd"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}
	virtual/pkgconfig"

PATCHES=("${FILESDIR}/vendor_opencl_libs_location.epatch"
)

LLVM_MAX_SLOT=10

pkg_setup() {
	llvm_pkg_setup
}

src_prepare() {
	eapply_user

	append-flags -fPIC
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_CUDA=$(usex cuda)
	)

	cmake-utils_src_configure
}

