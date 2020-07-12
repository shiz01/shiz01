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

#src_prepare() {
#	eapply_user
#
#	local str="s/lib/$(get_libdir)/"
#
#	sed -i "${str}" ${S}/CMakeLists.txt
#
#	if ! use test; then
#		sed -i 's/add_subdirectory(test)/#add_subdirectory(test)/' ${S}/CMakeLists.txt
#	fi
#
#	append-flags -fPIC
#	DESTDIR=${D} cmake-utils_src_prepare
#}
#
#src_install() {
#	DESTDIR=${D} cmake-utils_src_install
#}
