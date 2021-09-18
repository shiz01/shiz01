# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{6..9} pypy3 )
inherit distutils-r1

DESCRIPTION="A Python library to dump table schema of a SQLite database file."
HOMEPAGE="https://pypi.org/project/sqliteschema/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86 ~amd64-linux ~x86-linux"

DEPEND="
	dev-python/typepy[${PYTHON_USEDEP}]
	dev-python/mbstrdecoder[${PYTHON_USEDEP}]
	dev-python/tabledata[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
BDEPEND=""

