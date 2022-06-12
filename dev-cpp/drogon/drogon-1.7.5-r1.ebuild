# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3
DESCRIPTION="Drogon: A C++14/17/20 based HTTP web application framework."
HOMEPAGE="https://github.com/drogonframework/drogon"
EGIT_TAG="v${PV}"
EGIT_REPO_URI="https://github.com/drogonframework/${PN}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"
IUSE="+brotli +ctl c++20 doc examples mysql orm postgres pq_batch redis +shared sqlite ssl test"

RDEPEND="
	dev-libs/boost
	>=sys-libs/zlib-1.2.11
	net-dns/c-ares
	>=dev-libs/jsoncpp-1.9.4

	ssl? ( >=dev-libs/openssl-1.1.1j )
	brotli? ( >=app-arch/brotli-1.0.9 )

	redis? ( >=dev-libs/hiredis-1.0.0 )
	mysql? ( virtual/mysql )
	sqlite? ( >=dev-db/sqlite-3.34.1 )
	postgres? ( >=dev-db/postgresql-13.2 )

	elibc_Darwin? ( sys-libs/native-uuid )
	elibc_SunOS? ( sys-libs/libuuid )
	!elibc_Darwin? ( !elibc_SunOS? (
		sys-apps/util-linux
	) )
	!dev-cpp/trantor
"
DEPEND="${RDEPEND}
	test? ( >=dev-cpp/gtest-1.10.0 )
"
BDEPEND="doc? ( app-doc/doxygen )"

DOCS=( CONTRIBUTING.md ChangeLog.md README.md README.zh-CN.md README.zh-TW.md )

src_prepare() {
	eapply_user
	append-flags -fPIC
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_BROTLI=$(usex brotli)
		-DBUILD_DROGON_SHARED=$(usex shared)
		-DBUILD_CTL=$(usex ctl)
		-DBUILD_TESTING=$(usex test)
		-DBUILD_EXAMPLES=$(usex examples)
		-DBUILD_DOC=$(usex doc)
		-DBUILD_ORM=$(usex orm)
		-DBUILD_POSTGRESQL=$(usex postgres)
		-DLIBPQ_BATCH_MODE=$(usex pq_batch)
		-DBUILD_MYSQL=$(usex mysql)
		-DBUILD_SQLITE=$(usex sqlite)
		-DBUILD_REDIS=$(usex redis)
		$(cmake_use_find_package ssl OpenSSL)
	)

	use doc && HTML_DOCS=( "${BUILD_DIR}/docs/drogon/html/." )
	use c++20 && {
		mycmakeargs+=( -DCMAKE_CXX_STANDARD=20 )
	}
	cmake_src_configure
}

src_install() {
	docompress -x /usr/share/doc/${PF}/examples
	cmake_src_install
}

