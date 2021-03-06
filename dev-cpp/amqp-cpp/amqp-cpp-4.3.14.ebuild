# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

big_name="AMQP-CPP"
small_cmake_name="amqpcpp"

DESCRIPTION="C++ library for asynchronous non-blocking communication with RabbitMQ"
HOMEPAGE="https://github.com/CopernicaMarketingSoftware/AMQP-CPP"
SRC_URI="https://github.com/CopernicaMarketingSoftware/${big_name}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="examples linux_tcp +shared"

S="${WORKDIR}/${big_name}-${PV}"

src_prepare() {
	eapply_user
	sed -i "s/DESTINATION\ lib/DESTINATION\ $(get_libdir)/" ${S}/CMakeLists.txt
	sed -i "s/DESTINATION\ cmake/DESTINATION\ $(get_libdir)\/cmake\/${small_cmake_name}/" ${S}/CMakeLists.txt
	append-flags -fPIC
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-D${big_name}_BUILD_EXAMPLES=$(usex examples)
		-D${big_name}_BUILD_SHARED=$(usex shared)
		-D${big_name}_LINUX_TCP=$(usex linux_tcp)
	)
	cmake_src_configure
}

