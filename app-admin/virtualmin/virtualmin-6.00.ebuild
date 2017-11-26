EAPI="5"

inherit eutils rpm

DESCRIPTION="A Webmin module for managing multiple virtual hosts"
HOMEPAGE="https://www.virtualmin.com/"
SRC_URI="http://download.webmin.com/download/virtualmin/virtual-server-${PV}.gpl.wbm.gz -> ${P}.tar.gz"
S="${WORKDIR}/virtual-server"


LICENSE="BSD GPL-2"
SLOT="0"

KEYWORDS="amd64 x86 arm arm64"

RDEPEND="
	app-admin/webmin
	dev-perl/SMTP-Server
	dev-perl/Net-Whois-Raw
	www-servers/apache
	mail-mta/postfix
	net-mail/dovecot
	mail-filter/spamassassin
	mail-filter/amavisd-new
	mail-filter/procmail
	app-admin/webalizer
	www-misc/awstats
	app-antivirus/clamav
	app-admin/logrotate
	net-dns/bind
	dev-db/mariadb
"
DEPEND="
${RDEPEND}
"

src_compile() {
	$(tc-getCC) ${CFLAGS} ${CPPFLAGS} ${LDFLAGS} \
		-o "${D}/usr/bin/procmail-wrapper" \
		"${S}/procmail-wrapper.c" \
		|| die
	chmod u+sx "${D}/usr/bin/procmail-wrapper"
	chmod g+sx "${D}/usr/bin/procmail-wrapper"
}

src_prepare() {
	mkdir -p "${D}/usr/bin"
	mkdir -p "${D}/etc/webmin/virtual-server"
	mkdir -p "${D}/usr/libexec/webmin"
	find "${S}" -type f -iname '*.pl' -print0 | xargs -0 chmod 0744
	find "${S}" -type f -iname '*.cgi' -print0 | xargs -0 chmod 0744
	cat <<EOF >"${D}/etc/virtualmin-license"
SerialNumber=GPL
LicenseKey=GPL
EOF
}

src_install() {
	cp -a "${S}" "${D}/usr/libexec/webmin/"
	cp -a "${D}/usr/libexec/webmin/virtual-server/config" "${D}/etc/webmin/virtual-server/config"
}

pkg_postinst() {
	rm -f -- "${ROOT}etc/webmin/module.infos.cache"
	grep -E '^(root: .* virtual-server)' ${ROOT}etc/webmin/webmin.acl >/dev/null || sed -E -i 's|^(root: .*)$|\1 virtual-server|g' ${ROOT}etc/webmin/webmin.acl
	ewarn "If you have already purchased a license from virtualmin.com,"
	ewarn "please modify the /etc/virtualmin-license file accordingly."
}

