#!/usr/bin/env bash

test -f PharoWeb-50.zip || wget http://mooc.pharo.org/image/PharoWeb-50.zip
rm -fr PharoWeb.{image,changes}
unzip PharoWeb-50.zip
