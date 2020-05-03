# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

# multilib-minimal

DESCRIPTION="Mongo CXX driver"
HOMEPAGE="http://mongocxx.org/"
SRC_URI="https://github.com/mongodb/${PN}/archive/r${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="3/5"
KEYWORDS="~amd64 ~x86"
IUSE="-static-libs"

DEPEND=">=dev-libs/mongo-c-driver-1.15.0
		dev-libs/boost
"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-r${PV}"

src_prepare() {
	eapply_user
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
	-DBSONCXX_POLY_USE_BOOST=1
	-DCMAKE_BUILD_TYPE=Release
	-DBUILD_VERSION="${PV}"
	-DENABLE_UNINSTALL=OFF
	)
	if use static-libs; then
		mycmakeargs+=( 
				-DBUILD_SHARED_AND_STATIC_LIBS=ON
		)
	fi

	cmake-utils_src_configure
}

multilib_src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}
