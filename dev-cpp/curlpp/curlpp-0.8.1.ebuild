# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="An object oriented C++ wrapper for CURL"
HOMEPAGE="https://josephp91.github.io/curlcpp"
SRC_URI="https://github.com/jpbarrette/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

#SRC_URI="https://github.com/JosephP91/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="net-misc/curl"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

