# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="mold: A Modern Linker"
HOMEPAGE="https://github.com/rui314/mold"
SRC_URI="https://github.com/rui314/mold/archive/refs/tags/v0.9.6.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="clang debug lto asan tsan"

DEPEND="dev-libs/xxhash
		dev-libs/openssl
		sys-libs/zlib
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_prepare() {
	eapply_user
	local mfile="${S}/Makefile"
	# fix libdir
	sed -i "s/lib\/mold/$(get_libdir)\/mold/" ${mfile}

	# fix striping
	sed -i '/strip\ \$(DEST)\/bin\/mold/d' ${mfile}
	sed -i "/strip\ \$(DEST)\/$(get_libdir)\/mold\/mold-wrapper.so/d" ${mfile}

	#fix install man
	sed -i '/install\ -m\ 755\ -d\ \$(DEST)\/share\/man\/man1/d' ${mfile}
	sed -i '/install\ -m\ 644\ docs\/mold.1\ \$(DEST)\/share\/man\/man1/d' ${mfile}
	sed -i '/rm\ -f\ \$(DEST)\/share\/man\/man1\/mold.1.gz/d' ${mfile}
	sed -i '/gzip\ -9\ \$(DEST)\/share\/man\/man1\/mold.1/d' ${mfile}

	append-flags -fPIC
}

src_compile() {
	# tbb version in mold not pinned.
	# SYSTEM_TBB=$(usex system-tbb 1 0) 

	local cc_="$(tc-getCC)" cxx_="$(tc-getCXX)" debug_=0 lto_=0 asan_=0 tsan_=0
	if use asan && ! use tsan; then
		asan_=1
		tsan_=0
	elif use tsan && ! use asan; then
		tsan_=1
		asan_=0
	fi

	emake CC="$(usex clang clang ${cc_})" \
		CXX="$(usex clang clang++ ${cxx_})" \
		DEBUG="$(usex debug 1 0)" \
		LTO="$(usex lto 1 0)" \
		ASAN="${asan_}" TSAN="${tsan_}"
}

src_install() {
	doman ${S}/docs/mold.1;
	default
}
