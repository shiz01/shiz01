# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
inherit cmake-utils flag-o-matic llvm

DESCRIPTION="Portable Computing Language (an implementation of OpenCL)"
HOMEPAGE="http://portablecl.org"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/pocl/${PN}"
else
	SRC_URI="https://github.com/pocl/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="cuda debug"

DEPEND=">=sys-devel/llvm-6.0
		<=sys-devel/llvm-10.0
		sys-devel/clang:=
		dev-libs/libltdl
		sys-apps/hwloc[cuda?]
		debug? ( dev-util/lttng-ust )
		dev-libs/ocl-icd"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

PATCHES=("${FILESDIR}/vendor_opencl_libs_location.epatch"
)

LLVM_MAX_SLOT=9

pkg_setup() {
	llvm_pkg_setup
}

src_prepare() {
	append-flags -fPIC
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_CUDA=$(usex cuda)
	)

	cmake-utils_src_configure
}

