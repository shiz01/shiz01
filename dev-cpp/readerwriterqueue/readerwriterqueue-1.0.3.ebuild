# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="A fast multi-producer, multi-consumer lock-free concurrent queue for C++11."
HOMEPAGE="https://github.com/cameron314/readerwriterqueue"
EGIT_REPO_URI="https://github.com/cameron314/readerwriterqueue"
EGIT_COMMIT="c192906c5d566bb76f9988553039fc012a481c1c"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

LICENSE="BSD-2"
SLOT="0"

DOCS=( LICENSE.md README.md )


