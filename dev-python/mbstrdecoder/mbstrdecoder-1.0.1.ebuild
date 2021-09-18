# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{6..9} pypy3 )
inherit distutils-r1

DESCRIPTION="mbstrdecoder is a Python library for multi-byte character string decoder."
HOMEPAGE="https://github.com/thombashi/mbstrdecoder"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
dev-python/chardet[${PYTHON_USEDEP}]
dev-python/packaging[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"


