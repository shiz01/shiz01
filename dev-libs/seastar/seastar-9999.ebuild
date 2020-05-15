# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="High performance server-side application framework."
HOMEPAGE="http://seastar.io/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/scylladb/${PN}"
else
	SRC_URI="https://github.com/scylladb/${PN}/archive/${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~amd64-linux"
fi

LICENSE="Apache-2.0"
SLOT="0"

IUSE="+apps doc dpdk examples +hwloc numa old-compiller profile +sstring test" #coroutines-ts - don't work

DEPEND="dev-libs/boost
		net-dns/c-ares
		dev-libs/crypto++
		dev-libs/libfmt
		app-arch/lz4
		net-libs/gnutls
		net-misc/lksctp-tools
		dev-libs/protobuf
		dev-cpp/yaml-cpp

		hwloc? ( sys-apps/hwloc )
		dpdk? ( net-libs/dpdk )
		numa? ( sys-process/numact )
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_prepare() {
#	sed -i 's/-fcoroutines-ts/-fcoroutines/' ${S}/CMakeLists.txt # Needed rewrite code to support gcc-10.

	append-flags -fPIC
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=( 
		# It does not work on the gcc-{9.3.0,10.1.0,11.0.9999pre} and clang-10
		#-DSeastar_EXPERIMENTAL_COROUTINES_TS=$(usex coroutines-ts)

		-DSeastar_EXPERIMENTAL_COROUTINES_TS=OFF
		-DSeastar_SSTRING=$(usex sstring)
		-DSeastar_APPS=$(usex apps)
		-DSeastar_DOCS=$(usex doc)
		-DSeastar_DPDK=$(usex dpdk)
		-DSeastar_DEMOS=$(usex examples)
		-DSeastar_HWLOC=$(usex hwloc)
		-DSeastar_NUMA=$(usex numa)
		-DSeastar_HEAP_PROFILING=$(usex profile)
		-DSeastar_ALLOC_FAILURE_INJECTION=$(usex profile)
		-DSeastar_TESTING=$(usex test)
	)

	if use old-compiller; then
		mycmakeargs+=( 
		-DSeastar_CXX_DIALECT="gnu++14" 
		-DSeastar_STD_OPTIONAL_VARIANT_STRINGVIEW=OFF
		)
	else
		mycmakeargs+=( 
		-DSeastar_CXX_DIALECT="gnu++17" 
		-DSeastar_STD_OPTIONAL_VARIANT_STRINGVIEW=ON )
	fi

	cmake-utils_src_configure
}

src_test() {
	make-utils_src_test
}

src_install() {
	cmake-utils_src_install
}


