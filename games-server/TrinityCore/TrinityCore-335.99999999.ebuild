# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit check-reqs cmake toolchain-funcs llvm

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	KEYWORDS=""
	EGIT_BRANCH="master"
	EGIT_REPO_URI="https://github.com/${PN}/${PN}"
else
	SRC_URI="https://github.com/${PN}/${PN}/archive/TDB${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-TDB${PV}"
fi


DESCRIPTION="TrinityCore Open Source MMO Framework."
HOMEPAGE="https://www.trinitycore.org/"

LICENSE="GPL-2"
SLOT="335a"

IUSE="+conf cpu_flags_x86_sse2 debug detal-metrics +doc ld-gold +pch-scripts +pch-servers +servers strict-db test +tools whout-metrics"
RESTRICT="!test? ( test )"
REQUIRED_USE="cpu_flags_x86_sse2"

DEPEND="dev-libs/boost
		dev-db/mysql-connector-c
		sys-libs/zlib
		dev-libs/openssl
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

CHECKREQS_DISK_BUILD="11G"
CHECKREQS_DISK_USR="1400M"

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
	cmake_src_prepare
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
		-DCOPY_CONF=$(usex conf)
		-DWITH_STRICT_DATABASE_TYPE_CHECKS=$(usex strict-db)
		-DWITH_DETAILED_METRICS=$(usex detal-metrics)
		-DWITHOUT_METRICS=$(usex whout-metrics)
		-DBUILD_TESTING=$(usex test)
		-DUSE_LD_GOLD=$(usex ld-gold)
	)
	cmake_src_configure
}

src_install() {
	DESTDIR=${D} cmake_src_install

	dodoc AUTHORS CONTRIBUTING.md COPYING README.md doc/{CharacterDBCleanup.txt,GPL-2.0.txt,HowToScript.txt,LoggingHOWTO.txt}

	if [[ ${PV} != *9999* ]]; then
		newdoc "${FILESDIR}/${P}-git_commit" git-commit
	fi
}


