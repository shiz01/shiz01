# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake-utils

# multilib-minimal

DESCRIPTION="Mongo CXX driver"
HOMEPAGE="http://mongocxx.org/"
SRC_URI="https://github.com/mongodb/${PN}/archive/r${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

DEPEND=">=dev-libs/mongo-c-driver-1.15.0
		dev-libs/boost
"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-r${PV}"

src_configure() {
	local mycmakeargs=(
	-DBUILD_SHARED_AND_STATIC_LIBS=$(usex static-libs)
	-DBSONCXX_POLY_USE_BOOST=1
	-DBUILD_VERSION="${PV}"
	-DENABLE_UNINSTALL=OFF
	)

	cmake-utils_src_configure
}

