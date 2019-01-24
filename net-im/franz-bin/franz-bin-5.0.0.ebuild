# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker
MY_PN=${PN/-bin/}

DESCRIPTION="Franz is a free messaging app"
HOMEPAGE="http://meetfranz.com"
#SRC_URI="https://github.com/meetfranz/franz/releases/download/v5.0.0-beta.19/franz-5.0.0-beta.19.tar.gz"
#SRC_URI="https://github.com/meetfranz/franz/releases/download/v${PV}-beta.19/franz-${PV}-beta.19.tar.gz -> ${P}.tar.gz"
SRC_URI="https://github.com/meetfranz/franz/releases/download/v${PV}-beta.19/franz_${PV}-beta.19_amd64.deb"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

QA_PREBUILT="
	opt/Franz/franz
	opt/Franz/libffmpeg.so
	opt/Franz/libnode.so
"

S=${WORKDIR}

src_unpack() {
	unpack_deb ${A}
}
src_prepare() {
	default
	sed -i -e "s:/opt/Franz/franz:franz:g" usr/share/applications/${MY_PN}.desktop || die
}

src_install() {
	insinto /opt/${MY_PN}/bin
	doins -r opt/Franz/.
	insinto /opt/${MY_PN}/usr
	doins -r usr/.
	fperms +x /opt/${MY_PN}/bin/${MY_PN}
	dosym /opt/${MY_PN}/bin/franz /usr/bin/${MY_PN}
	dosym /opt/${MY_PN}/usr/share/applications/${MY_PN}.desktop /usr/share/applications/${MY_PN}.desktop
	dosym /opt/${MY_PN}/usr/share/icons/hicolor/256x256/apps/${MY_PN}.png /usr/share/pixmaps/${MY_PN}.png
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
