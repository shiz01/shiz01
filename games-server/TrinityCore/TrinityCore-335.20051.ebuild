# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils toolchain-funcs llvm

DESCRIPTION="TrinityCore Open Source MMO Framework."
HOMEPAGE="https://www.trinitycore.org/"
SRC_URI="https://github.com/${PN}/${PN}/archive/TDB${PV}.tar.gz"

LICENSE="GPL-2.0"
SLOT="335a"
KEYWORDS="~amd64 ~x86"

IUSE="+clang cpu_flags_x86_sse2 debug +doc +pch-scripts +pch-servers +servers -strict-db -no-support test +tools"
RESTRICT="!test? ( test )"
REQUIRED_USE="cpu_flags_x86_sse2"

DEPEND="dev-libs/boost
		dev-db/mysql-connector-c
		sys-libs/zlib
"
RDEPEND="
		${DEPEND}"
BDEPEND="${DEPEND}
		clang? ( >=sys-devel/clang-7 )"

CHECKREQS_DISK_BUILD="1400M"

S="${WORKDIR}/${PN}-TDB${PV}"

src_prepare() {
	eapply_user
	llvm_pkg_setup
	append-flags -fPIC

	if use clang ; then
		CC=clang
		CXX=clang++
	fi
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
		-DWITHOUT_GIT=$(usex no-support)
	)
	if use clang ; then
		mycmakeargs+=(  
			-DCMAKE_C_COMPILER=clang
			-DCMAKE_CXX_COMPILER=clang++
		)
	fi
	cmake-utils_src_configure
}

src_install() {
	DESTDIR=${D} cmake-utils_src_install

	dodoc AUTHORS CONTRIBUTING.md COPYING README.md doc/{CharacterDBCleanup.txt,GPL-2.0.txt,HowToScript.txt,LoggingHOWTO.txt}
	use no-support || newdoc "${FILESDIR}/TrinityCore-335.20051-git_commit" git-commit

	#mv "${ED}/usr/lib/${PN}/${SLOT}"/etc/authserver.conf.dist "${ED}/usr/lib/${PN}/${SLOT}"/etc/authserver.conf
	#mv "${ED}/usr/lib/${PN}/${SLOT}"/etc/worldserver.conf.dist "${ED}/usr/lib/${PN}/${SLOT}"/etc/worldserver.conf
	#dodir "/etc/${PN}/${SLOT}"
	#dosym "${EPREFIX}/usr/lib/${PN}/${SLOT}/etc/authserver.conf" "/etc/${PN}/${SLOT}/authserver"
	#dosym "${EPREFIX}/usr/lib/${PN}/${SLOT}/etc/worldserver.conf" "/etc/${PN}/${SLOT}/worldserver"

}



