#!/bin/sh

ARC_DIR=src-dojo/
DOJO_SRC=dojo-release-1.8.3-src

function _rm {
	if [ -d "$1" ] ; then
		rm -rf "$1"
	fi
}

function help {
	echo "Script to add dojo from src archive into bolerplate project"
	echo "Usage:"
	echo "$0 [command]|<file-name-pattern>"
	echo ""
	echo "<file-name-pattern> - pattern of dojo archive file name to be looked into src-dojo"
	echo ""
	echo "Commands:"
	echo "   clean - remove generated dojo folders"
	echo "   help  - show this help"
	echo ""
	echo "Files from dojo src archive are extracted into src folder as folders 'dojo', dijit', 'dojox', 'util'."
}

function clean {
	_rm "src/dojo"
	_rm "src/dijit"
	_rm "src/dojox"
	_rm "src/util"
}

function configure {
	echo 'parameter: ' $1
        TARGETS=`ls ${ARC_DIR}`
	echo ${TARGETS}
	for f in ${TARGETS}
	do
		if [[ "$f" =~ "$1" ]] ; then
			TARGET=$f
			#echo "MATCHING: " $f
		fi
	done

	if [ -z ${TARGET} ] ; then
		echo "no matching dojo src archive found"
		exit 1
	fi
	echo '-- CONFIGURATION environment from file: ' ${TARGET}

	if [[ "${TARGET}" =~ ".tar.gz" ]] ; then
		echo matched
		TARGET_BASE=${TARGET%.tar.gz}
	fi
	echo '-- removing old dojo and tmp dirs --'
	clean ${TARGET_BASE}

	echo '-- extracting Dojo from archive into tmp dir --'
	tar xfz ${ARC_DIR}${TARGET} -C ${ARC_DIR}

	echo '-- folders structure configuration --'

	mv ${ARC_DIR}${TARGET_BASE}/dojo src
	mv ${ARC_DIR}${TARGET_BASE}/dijit src
	mv ${ARC_DIR}${TARGET_BASE}/dojox src
	mv ${ARC_DIR}${TARGET_BASE}/util src

	echo '-- removing temporary dirs --'
	rm -rf ${ARC_DIR}${TARGET_BASE}
}

case $1 in
	"clean")
		clean
		;;
	"help")
		help
		;;
	*)
		configure $1
esac
