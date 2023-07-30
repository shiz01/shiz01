# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="The C++ Asynchronous Framework (beta)"
HOMEPAGE="https://userver.tech"
EGIT_URI="https://github.com/userver-framework/userver"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="app-crypt/mit-krb5
	dev-cpp/benchmark
	dev-cpp/gtest
	dev-cpp/yaml-cpp
	dev-db/mongodb
	dev-db/postgresql
	dev-db/redis
	dev-libs/crypto++
	dev-libs/hiredis
	dev-libs/jemalloc
	dev-libs/libbson
	dev-libs/libev
	dev-libs/libfmt
	dev-libs/mongo-c-driver
	dev-libs/openssl
	dev-libs/spdlog
	dev-python/jinja
	dev-python/voluptuous
	net-dns/c-ares
	net-misc/curl
	sys-libs/libbacktrace
	sys-libs/zlib"

RDEPEND="${DEPEND}"
BDEPEND=""



src_configure() {
	local mycmakeargs=(
		-DUSERVER_CHECK_PACKAGE_VERSIONS=0
		-DUSERVER_FEATURE_PATCH_LIBPQ=0
		#-DUSERVER_FEATURE_GRPC=0
		-DUSERVER_FEATURE_CLICKHOUSE=0
	)
	cmake_src_configure
}

