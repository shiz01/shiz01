# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="An open-source C++ library developed and used at Facebook."
HOMEPAGE="https://github.com/facebook/folly"
SRC_URI="https://github.com/facebook/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+shared" # python"
#REQUIRED_USE="python? ( shared )"

DEPEND="dev-libs/double-conversion
		dev-libs/libevent
		dev-libs/openssl
		dev-cpp/gflags
		dev-cpp/glog
		dev-libs/boost[context,threads]
		app-arch/lz4
		app-arch/snappy
		sys-libs/zlib
		app-arch/xz-utils
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"


src_prepare() {
	eapply_user
	sed -i "s/0.58.0-dev/0.58.0/" "${S}/CMakeLists.txt"
	sed -i "s/INSTALL_DIR\ lib/INSTALL_DIR\ $(get_libdir)/" "${S}/CMakeLists.txt"

	append-flags -fPIC
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=$(usex shared)
#		-DPYTHON_EXTENSIONS=$(usex python)
	)
	cmake_src_configure
}

