# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils gnome2-utils xdg
DESCRIPTION="The downright luxurious Git client,for Windows, Mac & Linux"
HOMEPAGE="https://www.gitkraken.com"
SRC_URI="https://release.gitkraken.com/linux/GitKraken-v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"
KEYWORDS="~amd64"
SLOT="0"
LICENSE="gitkraken-EULA"
RDEPEND="
	dev-libs/expat
	dev-libs/nss
	gnome-base/gconf
	gnome-base/libgnome-keyring
	media-gfx/graphite2
	media-libs/alsa-lib
	media-libs/libpng
	net-print/cups
	net-libs/gnutls
	sys-libs/zlib
	x11-libs/gtk+:3
	x11-libs/libnotify
	x11-libs/libxcb
	x11-libs/libXtst"

DEPEND="${RDEPEND}"

QA_PREBUILT="opt/gitkraken-bin/resources/app.asar.unpacked/node_modules/nodegit/build/Release/nodegit.node
	opt/gitkraken-bin/gitkraken"
QA_PRESTRIPPED="/opt/gitkraken-bin/libffmpeg.so"

S=${WORKDIR}/gitkraken

src_install() {
	dosym libcurl.so.4 /usr/$(get_libdir)/libcurl-gnutls.so.4
	local destdir="/opt/${PN}"
	insinto $destdir
	doins -r locales resources
	# content_shell.pak \
	doins icudtl.dat \
		natives_blob.bin \
		snapshot_blob.bin \
		libffmpeg.so \
		libEGL.so \
		libGLESv2.so \
		libVkICD_mock_icd.so \
		resources.pak \
		v8_context_snapshot.bin
	exeinto $destdir
	doexe gitkraken
	doicon "$FILESDIR"/ico/gitkraken.png
	dosym $destdir/gitkraken /usr/bin/gitkraken
	make_desktop_entry gitkraken Gitkraken "gitkraken" Network
}

pkg_preinst() {
	xdg_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_icon_cache_update
}
