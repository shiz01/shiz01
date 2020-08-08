# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	KEYWORDS="~amd64"
	EGIT_BRANCH="master"
	EGIT_REPO_URI="https://github.com/stcarrez/ada-keystore"
else
	SRC_URI="https://github.com/stcarrez/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	#KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Ada Keystore - protect your sensitive data with secure storage."
HOMEPAGE="https://github.com/stcarrez/ada-keystore"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="+gtk"

DEPEND="app-crypt/gnupg
		gtk? ( dev-ada/gtkada )
		( || ( sys-devel/gcc[ada] dev-lang/gnat-gpl ) )
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_configure()
{
	local myconf=( --prefix="${EPREFIX}/usr" --exec-prefix="${EPREFIX}/usr" )

	if use gtk ; then
		myconf+=( --enable-gtk )
	fi

	./configure "${myconf[@]}" || die

}


