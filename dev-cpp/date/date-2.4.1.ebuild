# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="A date and time library based on the C++11/14/17 <chrono> header"
HOMEPAGE="https://github.com/HowardHinnant/date"
SRC_URI="https://github.com/HowardHinnant/${PN}/archive/v2.4.1.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~arm64 ~x86"

LICENSE="MIT"
SLOT="0"

IUSE="test"
RESTRICT="!test? ( test )"

DEPEND=""

RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_prepare() {
	append-flags -fPIC
	cmake-utils_src_prepare
}

src_configure() {
	cmake-utils_src_configure
}

src_test() {
	make-utils_src_test
}

src_install() {
	cmake-utils_src_install
}


