#!/usr/bin/env bash

PHAROWEB_IMAGE=PharoWeb.image
test -f $PHAROWEB_IMAGE || ./getPharoWeb.sh

PHARO_VM="./pharo-ui"
test -f $PHARO_VM || (echo "VM is missing" && exit -1)

weekNumber="2"

if [ $# -eq 1 ]; then
	 weekNumber=$1
fi

echo "Loading Solution of Week $weekNumber"

shift

TINYBLOG_IMAGE="TinyBlogSolutionWeek${weekNumber}"

# disable parameter expansion to forward all arguments unprocessed to the VM
set -f

./pharo "$PHAROWEB_IMAGE" save $TINYBLOG_IMAGE

exec "$PHARO_VM" "${TINYBLOG_IMAGE}.image" eval --save "Metacello new smalltalkhubUser: 'PharoMooc' project: 'TinyBlog'; version: #week${weekNumber}solution; configuration: 'TinyBlog'; load"
