# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit check-reqs cmake-utils toolchain-funcs llvm

DESCRIPTION="TrinityCore Open Source MMO Framework."
HOMEPAGE="https://www.trinitycore.org/"
SRC_URI="https://github.com/${PN}/${PN}/archive/TDB${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="335a"
KEYWORDS="amd64 x86"

IUSE="cpu_flags_x86_sse2 debug +doc +pch-scripts +pch-servers +servers strict-db test +tools"
RESTRICT="!test? ( test )"
REQUIRED_USE="cpu_flags_x86_sse2"

DEPEND="dev-libs/boost
		dev-db/mysql-connector-c
		sys-libs/zlib
		dev-libs/openssl
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

CHECKREQS_DISK_BUILD="6800M"
CHECKREQS_DISK_USR="1400M"


S="${WORKDIR}/${PN}-TDB${PV}"

src_prepare() {
	eapply_user

	if $(tc-is-clang) ; then
		if (( $(clang-major-version) > 7 )) ; then
			llvm_pkg_setup
			append-flags -stdlib=libstdc++ # libc++ not supported.
		else
			die "Error, clang version below 7 does not support."
		fi
	fi
	append-flags -fPIC
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr/lib/${PN}/${SLOT}"
		-DCONF_DIR="${EPREFIX}/etc/${PN}/${SLOT}"
		-DSERVERS=$(usex servers)
		-DTOOLS=$(usex tools)
		-DUSE_SCRIPTPCH=$(usex pch-scripts)
		-DUSE_COREPCH=$(usex pch-servers)
		-DWITH_COREDEBUG=$(usex debug)
		-DWITH_STRICT_DATABASE_TYPE_CHECKS=$(usex strict-db)
	)
	cmake-utils_src_configure
}

src_install() {
	DESTDIR=${D} cmake-utils_src_install

	dodoc AUTHORS CONTRIBUTING.md COPYING README.md doc/{CharacterDBCleanup.txt,GPL-2.0.txt,HowToScript.txt,LoggingHOWTO.txt}
	newdoc "${FILESDIR}/${P}-git_commit" git-commit

	mv "${ED}/etc/${PN}/${SLOT}/authserver.conf.dist" "${ED}/etc/${PN}/${SLOT}/authserver.conf"
	mv "${ED}/etc/${PN}/${SLOT}/worldserver.conf.dist" "${ED}/etc/${PN}/${SLOT}/worldserver.conf"
}



