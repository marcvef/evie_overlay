# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION=""
HOMEPAGE="https://www.zotero.org"
MY_PN="Zotero"
MY_P="${MY_PN}-${PV}"
MY_ARCH="linux-x86_64"
SRC_URI="https://download.zotero.org/client/release/${PV}/${MY_P}_${MY_ARCH}.tar.bz2"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}_${MY_ARCH}"

src_install() {
	local dest="/opt/${PN}"

	insinto "${dest}"
	doins -r ./

	exeinto "${dest}"
	doexe zotero-bin zotero


	make_desktop_entry "${dest}/zotero" "${MY_PN} ${PV}" "${dest}/chrome/icons/default/default48.png"
}
