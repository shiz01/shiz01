# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Virtual for Ada Compiler"

SLOT="0"
KEYWORDS="amd64 x86" # arm arm64
IUSE="fsf +gpl"

REQUIRED_USE="|| ( fsf gpl )"

RDEPEND="
	fsf? ( || (
		sys-devel/gcc[ada]
	) )

	gpl? ( || (
		dev-lang/gnat-gpl[ada]
	) )
"
#|| (
#	sys-devel/gcc[ada]
#	dev-lang/gnat-gpl[ada]
#	)
#"
# ??? dev-ada/gnat-suite-bin ???


pkg_postinst() {
	elog
	elog "Select Ada's compiler."
	elog "Currently included in Gentoo are:"
	elog
	elog " * Free Software Foundation:"
	elog "    - sys-devel/gcc[ada] - To build the Ada compiler, you need a working Ada compiler."
	elog "                           Install the compiler from AdaCore, and build it gcc with use flag ada."
	elog
	elog " * AdaCore:"
	elog "    - dev-lang/gnat-gpl  - Ada Compiler by AdaCore, use this if you need a bootstrap Ada compiler."
	elog
}


