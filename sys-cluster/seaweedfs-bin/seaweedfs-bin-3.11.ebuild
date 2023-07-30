# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs systemd

abi_uri() {
	local os=linux
	local arch="\nUNSUPPORTED\n"
	case $(tc-arch) in
		arm)
			arch="arm"
			;;
		arm64)
			arch="arm64"
			;;
		x86_64 | amd64)
			arch="amd64"
			;;
		*)
			;;
	esac
	local uri="https://github.com/chrislusf/seaweedfs/releases/download/${PV}/${os}_${arch}_full.tar.gz -> ${P}_${os}_${arch}.tar.gz"
	echo "${uri}";
}
SRC_URI="$(abi_uri)"
DESCRIPTION="SeaweedFS is a fast distributed storage system for objects"
HOMEPAGE="https://github.com/chrislusf/seaweedfs"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"
RESTRICT+=" test "

DEPEND="!sys-cluster/seaweedfs"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	dobin ${S}/weed;
	keepdir /etc/seaweedfs /var/log/seaweedfs /var/lib/seaweedfs
	newinitd "${FILESDIR}"/seaweedfs.initd seaweedfs
	newconfd "${FILESDIR}"/seaweedfs.confd seaweedfs
	systemd_dounit "${FILESDIR}"/seaweedfs.service
	insinto /etc/seaweedfs
	newins "${FILESDIR}"/seaweedfs.config config
}

