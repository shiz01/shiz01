# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit check-reqs cmake-utils toolchain-funcs

DESCRIPTION="High performance server-side application framework."
HOMEPAGE="http://seastar.io/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	KEYWORDS=""
	EGIT_BRANCH="master"
	EGIT_REPO_URI="https://github.com/scylladb/${PN}"
else
	SRC_URI="https://github.com/scylladb/${PN}/archive/${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~amd64-linux"
fi

LICENSE="Apache-2.0"
SLOT="0"

# coroutines is removed.
IUSE="+apps +c++17 -c++2a doc dpdk examples +hwloc numa profile +sstring test"

RESTRICT="!test? ( test )"

REQUIRED_USE="^^ ( c++17 c++2a )"
#	coroutines? ( c++2a !c++17 )"

DEPEND="dev-libs/boost
		net-dns/c-ares
		dev-libs/crypto++
		dev-libs/libfmt
		app-arch/lz4
		net-libs/gnutls
		net-misc/lksctp-tools
		dev-libs/protobuf
		dev-cpp/yaml-cpp

		c++17? ( || ( >=sys-devel/gcc-8.2 >=sys-devel/clang-7 ) )
		c++2a? ( || ( >=sys-devel/gcc-10 >=sys-devel/clang-10 ) )
		hwloc? ( sys-apps/hwloc )
		dpdk? ( net-libs/dpdk )
		numa? ( sys-process/numact )
"


RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

CHECKREQS_DISK_BUILD="2G"

src_prepare() {
	eapply_user

	if $(tc-is-clang); then
		die "Error, clang does not support concept.";
	fi

# REMOVED.
#	if use coroutines ; then
#	
#		if $(tc-is-clang) ; then
#			if [[ $(($(clang-major-version))) < 10 ]] ; then
#				die "Error, clang version below 10 does not support coroutines"
#			fi
#		fi
#
#		if $(tc-is-gcc) ; then
#			if [[ $(($(gcc-major-version))) < 10 ]]; then 
#				die "Error, gcc version below 10 does not support coroutines"
#			else
#				sed -i 's/-fcoroutines-ts/-fcoroutines/' ${S}/CMakeLists.txt
#			fi
#		fi
#	fi

	append-flags -fPIC
	cmake-utils_src_prepare
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
	)

	if use c++17 && ! use c++2a ; then 
		mycmakeargs+=( 
		-DSeastar_CXX_DIALECT="gnu++17"
#		-DSeastar_EXPERIMENTAL_COROUTINES_TS=OFF	removed.
		)
	elif use c++2a && ! use c++17 ; then 
		mycmakeargs+=( 
		-DSeastar_CXX_DIALECT="gnu++2a"
#		-DSeastar_EXPERIMENTAL_COROUTINES_TS=$(usex coroutines) removed.
		)
	fi

	cmake-utils_src_configure
}

