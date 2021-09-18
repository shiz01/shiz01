# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

DESCRIPTION="Standard front-end for writing C++ programs that use PostgreSQL"
SRC_URI="https://github.com/jtv/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
HOMEPAGE="http://pqxx.org/development/libpqxx/"
LICENSE="BSD"
SLOT="0"
IUSE="doc static-libs test"
RESTRICT="!test? ( test )"

RDEPEND="dev-db/postgresql:="
DEPEND="${RDEPEND}
	doc? (
		app-doc/doxygen
		app-text/xmlto
	)
"

DOCS=( AUTHORS NEWS README{.md,-UPGRADE} )

src_prepare() {
	append-flags -fPIC
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=( 
		-DBUILD_DOC=$(usex doc)
		-DBUILD_TEST=$(usex test)
	)
	cmake_src_configure
}

src_test() {
	local build_dirs="${S}/../"
	local test_runner;

	for i in $(ls ${build_dirs})
	do
		if [[ -f "${S}/../${i}/test/runner" ]]; then
			test_runner="${S}/../${i}/test/runner"
		fi
	done

	einfo "The tests need a running PostgreSQL server and an existing database."
	einfo "Test requires PGDATABASE and PGUSER to be set at a minimum. Optionally,"
	einfo "set PGPORT and PGHOST. Define them at the command line or in:"
	einfo "    ${EROOT}/etc/libpqxx_test_env"

	if [[ -z $PGDATABASE || -z $PGUSER ]] ; then
		if [[ -f ${EROOT}/etc/libpqxx_test_env ]] ; then
			source "${EROOT}/etc/libpqxx_test_env"
			[[ -n $PGDATABASE ]] && export PGDATABASE
			[[ -n $PGHOST ]] && export PGHOST
			[[ -n $PGPORT ]] && export PGPORT
			[[ -n $PGUSER ]] && export PGUSER
		fi
	fi

	if [[ -n $PGDATABASE && -n $PGUSER ]] ; then
		local server_version
		server_version=$( PGDATABASE=${PGDATABASE} PGUSER=${PGUSER} psql -Aqtc 'SELECT version();')
		server_version=$( psql -Aqtc 'SELECT version();' 2> /dev/null)
		einfo "server_version=${server_version}"
		if [[ -n ${server_version} ]] ; then
			${test_runner} || eerror "ERROR TESTS!"
		else
			eerror "Is the server running?"
			eerror "Verify role and database exist, and are permitted in pg_hba.conf for:"
			eerror "    Role: ${PGUSER}"
			eerror "    Database: ${PGDATABASE}"
			die "Couldn't connect to server."
		fi
	else
		eerror "PGDATABASE and PGUSER must be set to perform tests."
		eerror "Skipping tests."
	fi
}

src_install() {
	use doc && HTML_DOCS=( doc/html/. )
	cmake_src_install

	if ! use static-libs; then
		find "${D}" -name '*.la' -delete || die
	fi
}
