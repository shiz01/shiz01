# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="C++ wrapper around libcURL."
HOMEPAGE="http://www.curlpp.org"
SRC_URI="https://github.com/jpbarrette/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"


LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="net-misc/curl"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

