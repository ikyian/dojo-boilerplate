#!/bin/sh

ARC_DIR=src-dojo/
DOJO_SRC=dojo-release-1.8.3-src
DOJO_DOWNLOADS_URL=http://download.dojotoolkit.org/release-1.8.3/
DOJO_DISTR=dojo-release-1.8.3-src.tar.gz

function _rm {
	if [ -d "$1" ] ; then
		rm -rf "$1"
	fi
}

function _help {
	echo "Script to add dojo from src archive into bolerplate project"
	echo "Usage:"
	echo "$0 [command]|<file-name-pattern>"
	echo ""
	echo "<file-name-pattern> - pattern of dojo archive file name to be looked into src-dojo"
	echo ""
	echo "Commands:"
	echo "   download - download dojo src distribution in src-dojo dir"
	echo "   init - download dojo src distribution if needed and unpack in proper places"
	echo "   clean - remove generated dojo folders"
	echo "   help  - show this help"
	echo ""
	echo "Files from dojo src archive are extracted into src folder as folders 'dojo', dijit', 'dojox', 'util'."
	exit 0
}

function _clean {
	_rm "src/dojo"
	_rm "src/dijit"
	_rm "src/dojox"
	_rm "src/util"
}

function _download {
	echo "-- downloading dojo src distribution --"
	if [[ -f "${ARC_DIR}${DOJO_DISTR}" ]] ; then
		echo "-- exists already downloaded file ${DOJO_DISTR}"
	else
		wget ${DOJO_DOWNLOADS_URL}${DOJO_DISTR} -O ${ARC_DIR}${DOJO_DISTR}
		echo "-- dojo src distribution downloaded --"
	fi
}

function _configure {
	if [[ -z "$1" ]] ; then
		_help
	fi
#	echo 'parameter: ' $1
        TARGETS=`ls ${ARC_DIR}`
#	echo ${TARGETS}
	for f in ${TARGETS}
	do
		if [[ "$f" =~ "$1" ]] ; then
			TARGET=$f
			#echo "MATCHING: " $f
		fi
	done

	if [ -z ${TARGET} ] ; then
		echo "-- no matching dojo src archive found"
		exit 1
	fi
	echo '-- CONFIGURATION environment from file: ' ${TARGET}

	if [[ "${TARGET}" =~ ".tar.gz" ]] ; then
		#echo matched
		TARGET_BASE=${TARGET%.tar.gz}
	fi
	echo '-- removing old dojo and tmp dirs --'
	_clean ${TARGET_BASE}

	echo '-- extracting Dojo from archive into tmp dir --'
	tar xfz ${ARC_DIR}${TARGET} -C ${ARC_DIR}

	echo '-- folders structure configuration --'

	mv ${ARC_DIR}${TARGET_BASE}/dojo src
	mv ${ARC_DIR}${TARGET_BASE}/dijit src
	mv ${ARC_DIR}${TARGET_BASE}/dojox src
	mv ${ARC_DIR}${TARGET_BASE}/util src

	echo '-- removing temporary dirs --'
	rm -rf ${ARC_DIR}${TARGET_BASE}
	echo '-- configuration finished --'
}

function _init {
	_download
	_configure ${DOJO_DISTR}
}

case $1 in
	"clean")
		_clean
		;;
	"download")
		_download
		;;
	"init")
		_init
		;;
	"help")
		_help
		;;
	*)
		_configure $1
		;;
esac
