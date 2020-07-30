# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Cross-platform asynchronous HTTP/WebSocket server C++14 library."
HOMEPAGE="https://stiffstream.com/en/products/restinio.html"
SRC_URI="https://github.com/Stiffstream/${PN}/archive/v.${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/boost"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"


