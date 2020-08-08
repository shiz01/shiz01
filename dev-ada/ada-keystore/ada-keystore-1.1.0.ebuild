# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnuconfig

#multiprocessing

DESCRIPTION="Ada Keystore - protect your sensitive data with secure storage."
HOMEPAGE="https://github.com/stcarrez/ada-keystore"
SRC_URI="https://github.com/stcarrez/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk"

DEPEND="app-crypt/gnupg"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}
		sys-devel/gcc[ada] || ( dev-lang/gnat-gpl:7.3.1 || dev-lang/gnat-gpl:8.3.1 )
"

src_configure()
{
	local myconf=()

	if use gtk ; then
		myconf+=( --enable-gtk )
	fi

	echo ./configure "${myconf[@]}"
	"${S}"/configure "${myconf[@]}" || die

}


