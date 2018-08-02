#!/usr/bin/env bash

PHARO_VM="./pharo"
test -f $PHARO_VM || PHARO_VM="../pharo"

PHAROWEB_IMAGE=PharoWeb.image
test -f $PHAROWEB_IMAGE || ./getPharoWeb.sh

weekNumber="2"

if [ $# -eq 1 ]; then
	 weekNumber=$1
fi

echo "Loading Solution of Week $weekNumber"

shift

TINYBLOG_IMAGE="TinyBlogSolutionWeek${weekNumber}"

# disable parameter expansion to forward all arguments unprocessed to the VM
set -f

"$PHARO_VM" "$PHAROWEB_IMAGE" save $TINYBLOG_IMAGE

exec "$PHARO_VM" "${TINYBLOG_IMAGE}.image" eval --save "Metacello new smalltalkhubUser: 'PharoMooc' project: 'TinyBlog'; version: #week${weekNumber}solution; configuration: 'TinyBlog'; load"
