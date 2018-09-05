EAPI=6

PYTHON_COMPAT=( python3_{4,5,6,7} pypy{,3} )

inherit distutils-r1

DESCRIPTION="Simple system init daemon for Docker-like environments"
HOMEPAGE="https://github.com/garywiz/chaperone https://pypi.org/project/chaperone/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x64-cygwin ~amd64-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x64-solaris"

RDEPEND="
dev-python/setproctitle
dev-python/aiocron
"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
