# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} pypy3 )
inherit distutils-r1

DESCRIPTION="tcconfig is a tc command wrapper. Make it easy to set up traffic control"
HOMEPAGE="https://pypi.org/project/tcconfig"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86 ~amd64-linux ~x86-linux"

DEPEND="
	dev-python/voluptuous[${PYTHON_USEDEP}]
	dev-python/aiocontextvars[${PYTHON_USEDEP}]
	dev-python/pyroute2[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]
	dev-python/loguru[${PYTHON_USEDEP}]
	dev-python/docker-py[${PYTHON_USEDEP}]
	dev-python/path-py[${PYTHON_USEDEP}]
	dev-python/typepy[${PYTHON_USEDEP}]
	dev-python/DataProperty[${PYTHON_USEDEP}]
	dev-python/humanreadable[${PYTHON_USEDEP}]
	dev-python/msgfy[${PYTHON_USEDEP}]
	dev-python/SimpleSQLite[${PYTHON_USEDEP}]
	dev-python/subprocrunner[${PYTHON_USEDEP}]
	dev-python/contextvars[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"


