EAPI="5"

inherit eutils rpm

DESCRIPTION="A Webmin module for managing multiple virtual hosts"
HOMEPAGE="https://www.virtualmin.com/"
SRC_URI="http://download.webmin.com/download/virtualmin/wbm-virtual-server-${PV}.gpl-1.noarch.rpm"

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

src_unpack(){
	mkdir -p "${S}"
	rpm_src_unpack "${A}"
}

src_compile() {
	mkdir -p "${WORKDIR}/usr/bin"
	$(tc-getCC) ${CFLAGS} ${CPPFLAGS} ${LDFLAGS} \
		-o "${WORKDIR}/usr/bin/procmail-wrapper" \
		"${WORKDIR}/usr/libexec/webmin/virtual-server/procmail-wrapper.c" \
		|| die
}

src_prepare() {
	find "${WORKDIR}" -type f -iname '*.pl' -print0 | xargs -0 chmod 0744
	find "${WORKDIR}" -type f -iname '*.cgi' -print0 | xargs -0 chmod 0744
	mkdir -p "${WORKDIR}/etc"
	cat <<EOF >"${WORKDIR}/etc/virtualmin-license"
SerialNumber=GPL
LicenseKey=GPL
EOF
	chmod u+s "${WORKDIR}/usr/bin/procmail-wrapper"
	chmod g+s "${WORKDIR}/usr/bin/procmail-wrapper"
}

src_install() {
	mv "${WORKDIR}/usr" "${D}"
	mv "${WORKDIR}/etc" "${D}"
}

pkg_postinst() {
	ewarn "If you have already purchased a license from virtualmin.com,"
	ewarn "please modify the /etc/virtualmin-license file accordingly."
}

