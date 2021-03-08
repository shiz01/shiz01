# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A type safe SQL template library for C++"
HOMEPAGE="https://github.com/rbock/sqlpp11"
SRC_URI="https://github.com/rbock/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="dev-cpp/date
		dev-libs/boost"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"


src_prepare() {
	eapply_user

	declare -a list=(
		"add_subdirectory(tests)"
		"add_subdirectory(test_types)"
		"add_subdirectory(test_serializer)"
		"add_subdirectory(test_static_asserts)"
		"add_subdirectory(test_constraints)"
		"add_subdirectory(test_scripts)"
		"add_subdirectory(dependencies)"
	)

	for i in ${list[@]};
	do
		sed -i "s/${i}/#${i}/" ${S}/CMakeLists.txt
	done

	append-flags -fPIC
	cmake_src_prepare

}

src_configure() {
	local mycmakeargs=( 
		-DENABLE_TESTS=$(usex test)
	)
	cmake_src_configure

}
