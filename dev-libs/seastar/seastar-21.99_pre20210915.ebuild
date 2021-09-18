# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 check-reqs cmake toolchain-funcs

DESCRIPTION="High performance server-side application framework."
HOMEPAGE="http://seastar.io/"
EGIT_REPO_URI="https://github.com/scylladb/seastar"
EGIT_COMMIT="1da6dbca1ad47532125fcb40a519e0939ed924ef"

KEYWORDS="~amd64 ~arm64 ~amd64-linux"
LICENSE="Apache-2.0"
SLOT="0"

IUSE="+apps doc dpdk examples +hwloc numa profile +sstring test"
RESTRICT="!test? ( test )"

DEPEND="dev-libs/boost
		net-dns/c-ares
		dev-libs/crypto++
		dev-libs/libfmt
		app-arch/lz4
		net-libs/gnutls
		net-misc/lksctp-tools
		dev-libs/protobuf
		dev-cpp/yaml-cpp

		( || ( >=sys-devel/gcc-10 >=sys-devel/clang-11 ) )
		hwloc? ( sys-apps/hwloc )
		dpdk? ( net-libs/dpdk )
		numa? ( sys-process/numact )
"


RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

CHECKREQS_DISK_BUILD="2G"

src_prepare() {
	eapply_user
	append-flags -fPIC
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
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
		-DSeastar_CXX_DIALECT="gnu++20"
		)

	cmake_src_configure
}

