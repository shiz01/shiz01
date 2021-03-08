# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A date and time library based on the C++11/14/17 <chrono> header"
HOMEPAGE="https://github.com/HowardHinnant/date"
SRC_URI="https://github.com/HowardHinnant/${PN}/archive/v2.4.1.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~arm64 ~x86"

LICENSE="MIT"
SLOT="0/2"

IUSE="test"
RESTRICT="!test? ( test )"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}
		net-misc/curl"

src_prepare() {
	eapply_user

	append-flags -fPIC
	cmake_src_prepare
}

