#!/usr/bin/env bash

PHAROWEB_IMAGE=PharoWeb.image
test -f $PHAROWEB_IMAGE || ./getPharoWeb.sh

PHARO_VM="./pharo-ui"
test -f $PHARO_VM || (echo "VM is missing" && exit -1)

chapterNumber="2"

if [ $# -eq 1 ]; then
	 chapterNumber=$1
fi

echo "Loading Solution of Chapter $chapterNumber"

shift

TINYBLOG_IMAGE="TinyBlogSolutionForChapter${chapterNumber}"

# disable parameter expansion to forward all arguments unprocessed to the VM
set -f

./pharo-ui "$PHAROWEB_IMAGE" eval "(Smalltalk saveAs: '$TINYBLOG_IMAGE') ifFalse: [ Smalltalk snapshot: false andQuit: true ]"

exec "$PHARO_VM" "${TINYBLOG_IMAGE}.image" eval "Metacello new smalltalkhubUser: 'PharoMooc' project: 'TinyBlog'; version: #chapter${chapterNumber}solution; configuration: 'TinyBlog'; load. DisplayScreen hostWindowSize: 2000@1300. Smalltalk snapshot: true andQuit: true"
