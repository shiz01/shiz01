# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} pypy3 )
inherit distutils-r1

DESCRIPTION="Simple ORM functionality for SQLite"
HOMEPAGE="https://pypi.org/project/SimpleSQLite/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86 ~amd64-linux ~x86-linux"

DEPEND="
	dev-python/typepy[${PYTHON_USEDEP}]
	dev-python/DataProperty[${PYTHON_USEDEP}]
	dev-python/pathvalidate[${PYTHON_USEDEP}]
	dev-python/sqliteschema[${PYTHON_USEDEP}]
	dev-python/tabledata[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
BDEPEND=""