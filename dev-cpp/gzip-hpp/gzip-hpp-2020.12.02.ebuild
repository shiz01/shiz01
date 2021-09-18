# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Gzip header-only C++ library."
HOMEPAGE="https://github.com/mapbox/gzip-hpp"
EGIT_REPO_URI="https://github.com/mapbox/gzip-hpp"
EGIT_COMMIT="7546b35aba5917154a0e9ae43f804b57d22bb966"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

src_prepare() {
	eapply_user;
	rm -rf "${S}/Makefile";
	cp -r "${S}/include/gzip" "${S}/include/${PN}";
}

src_install() {
	doheader -r "${S}/include/${PN}";
}

